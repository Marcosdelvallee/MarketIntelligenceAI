#!/bin/bash

# ============================================
# MARKET INTELLIGENCE AI SYSTEM
# Start Script
# ============================================
# Este script inicia n8n con las variables de entorno configuradas
# ============================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" &> /dev/null
}

# Función para verificar si un puerto está en uso
port_in_use() {
    if command_exists lsof; then
        lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1
        return $?
    elif command_exists netstat; then
        netstat -tuln | grep ":$1 " >/dev/null 2>&1
        return $?
    else
        return 1
    fi
}

# Función para obtener PID de proceso en puerto
get_pid_on_port() {
    if command_exists lsof; then
        lsof -ti :$1
    elif command_exists netstat; then
        netstat -tuln | grep ":$1 " | awk '{print $7}' | cut -d'/' -f1
    else
        echo ""
    fi
}

# Función para cargar variables de entorno
load_env_file() {
    local env_file="$1"

    if [ ! -f "$env_file" ]; then
        print_error "Archivo $env_file no encontrado"
        return 1
    fi

    print_info "Cargando variables de entorno desde $env_file..."

    # Leer el archivo línea por línea y exportar variables
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Ignorar líneas vacías y comentarios
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi

        # Exportar variable
        export "$line"
    done < "$env_file"

    print_success "Variables de entorno cargadas"
    return 0
}

# Función para verificar variables críticas
check_critical_variables() {
    local missing_vars=()

    if [ -z "$SUPABASE_URL" ] || [[ "$SUPABASE_URL" == *"your-"* ]]; then
        missing_vars+=("SUPABASE_URL")
    fi

    if [ -z "$SUPABASE_KEY" ] || [[ "$SUPABASE_KEY" == *"eyJ"* ]]; then
        missing_vars+=("SUPABASE_KEY")
    fi

    if [ -z "$GROQ_API_KEY" ] || [[ "$GROQ_API_KEY" == *"gsk_"* ]]; then
        missing_vars+=("GROQ_API_KEY")
    fi

    if [ -z "$RESEND_API_KEY" ] || [[ "$RESEND_API_KEY" == *"re_"* ]]; then
        missing_vars+=("RESEND_API_KEY")
    fi

    if [ ${#missing_vars[@]} -gt 0 ]; then
        print_warning "Faltan o no están configuradas las siguientes variables críticas:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        print_warning "Por favor edita config/.env con tus credenciales"
        return 1
    fi

    return 0
}

# Función para crear directorios necesarios
create_directories() {
    local dirs=("logs" "temp" "backups")

    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            print_info "Directorio creado: $dir"
        fi
    done
}

# Función para verificar n8n instalado
check_n8n_installed() {
    if command_exists n8n; then
        local version=$(n8n --version 2>&1)
        print_success "n8n está instalado (versión: $version)"
        return 0
    else
        print_error "n8n no está instalado"
        print_info "Para instalar n8n:"
        print_info "  npm install n8n -g"
        print_info "  o"
        print_info "  yarn global add n8n"
        return 1
    fi
}

# Función para verificar puerto disponible
check_port_available() {
    local port=${1:-5678}

    if port_in_use $port; then
        local pid=$(get_pid_on_port $port)
        print_warning "El puerto $port ya está en uso por el proceso $pid"
        print_info "Puedes:"
        print_info "  1. Matar el proceso: kill $pid"
        print_info "  2. Usar otro puerto: export N8N_PORT=otro_puerto"
        return 1
    fi

    return 0
}

# Función para iniciar n8n
start_n8n() {
    local port=${N8N_PORT:-5678}
    local protocol=${N8N_PROTOCOL:-http}
    local host=${N8N_HOST:-localhost}

    print_header "🚀 Iniciando n8n"

    # Configurar variables de entorno para n8n
    export N8N_PORT="$port"
    export N8N_PROTOCOL="$protocol"
    export N8N_HOST="$host"

    # Configurar autenticación básica si está activada
    if [ "$N8N_BASIC_AUTH_ACTIVE" = "true" ]; then
        export N8N_BASIC_AUTH_USER="${N8N_BASIC_AUTH_USER:-admin}"
        export N8N_BASIC_AUTH_PASSWORD="${N8N_BASIC_AUTH_PASSWORD:-password}"
        print_info "Autenticación básica activada"
        print_info "  Usuario: $N8N_BASIC_AUTH_USER"
    fi

    # Mostrar información de conexión
    print_info "n8n estará disponible en:"
    echo "  URL: $protocol://$host:$port"
    echo ""

    # Crear archivo de log
    local log_file="logs/n8n.log"
    touch "$log_file"

    print_info "Logs se guardarán en: $log_file"
    print_info "Para ver logs en tiempo real: tail -f $log_file"
    echo ""

    print_warning "⚠️  Presiona Ctrl+C para detener n8n"
    echo ""

    # Iniciar n8n en background con logs
    print_info "Iniciando n8n..."

    # Guardar PID del script actual
    echo $$ > logs/start_script.pid

    # Iniciar n8n
    n8n start > "$log_file" 2>&1 &
    N8N_PID=$!

    # Guardar PID de n8n
    echo $N8N_PID > logs/n8n.pid

    print_success "n8n iniciado con PID: $N8N_PID"
    echo ""

    # Esperar un momento y verificar que n8n esté corriendo
    sleep 3

    if ps -p $N8N_PID > /dev/null 2>&1; then
        print_success "n8n está corriendo correctamente"
        echo ""
        print_info "🎯 Abre tu navegador en: $protocol://$host:$port"
        echo ""
        print_info "Comandos útiles:"
        echo "  Ver logs: tail -f $log_file"
        echo "  Detener n8n: kill $N8N_PID"
        echo "  Verificar estado: ps -p $N8N_PID"
        echo ""

        # Mantener el script corriendo
        print_info "Script de inicio corriendo. Presiona Ctrl+C para detener."

        # Monitorear el proceso de n8n
        while ps -p $N8N_PID > /dev/null 2>&1; do
            sleep 1
        done

        print_warning "n8n se ha detenido"

    else
        print_error "n8n no pudo iniciarse"
        print_info "Revisa $log_file para más detalles"
        print_info "Últimas líneas del log:"
        tail -n 20 "$log_file"
        exit 1
    fi
}

# Función para detener n8n
stop_n8n() {
    print_header "🛑 Deteniendo n8n"

    if [ -f "logs/n8n.pid" ]; then
        local pid=$(cat logs/n8n.pid)

        if ps -p $pid > /dev/null 2>&1; then
            print_info "Deteniendo n8n (PID: $pid)..."
            kill $pid

            # Esperar a que el proceso termine
            local count=0
            while ps -p $pid > /dev/null 2>&1 && [ $count -lt 10 ]; do
                sleep 1
                count=$((count + 1))
            done

            if ps -p $pid > /dev/null 2>&1; then
                print_warning "Forzando detención de n8n..."
                kill -9 $pid
            fi

            print_success "n8n detenido"
        else
            print_warning "n8n no está corriendo (PID: $pid)"
        fi

        rm -f logs/n8n.pid
    else
        print_warning "No se encontró archivo de PID"
    fi

    exit 0
}

# Función para mostrar estado
show_status() {
    print_header "📊 Estado del Sistema"

    # Verificar si n8n está corriendo
    if [ -f "logs/n8n.pid" ]; then
        local pid=$(cat logs/n8n.pid)

        if ps -p $pid > /dev/null 2>&1; then
            print_success "n8n está corriendo (PID: $pid)"

            # Mostrar información del proceso
            if command_exists ps; then
                echo ""
                print_info "Información del proceso:"
                ps -p $pid -o pid,ppid,cmd,etime,pcpu,pmem
            fi
        else
            print_warning "n8n no está corriendo (PID guardado: $pid)"
        fi
    else
        print_warning "n8n no está corriendo (sin PID guardado)"
    fi

    # Verificar puerto
    local port=${N8N_PORT:-5678}
    if port_in_use $port; then
        print_success "Puerto $port está en uso"
    else
        print_warning "Puerto $port no está en uso"
    fi

    # Mostrar información de configuración
    echo ""
    print_info "Configuración:"
    echo "  Puerto: $port"
    echo "  Protocolo: ${N8N_PROTOCOL:-http}"
    echo "  Host: ${N8N_HOST:-localhost}"

    # Mostrar últimos logs
    if [ -f "logs/n8n.log" ]; then
        echo ""
        print_info "Últimas líneas del log:"
        tail -n 10 logs/n8n.log
    fi
}

# Función para mostrar ayuda
show_help() {
    print_header "❓ Ayuda - Market Intelligence AI System"

    echo ""
    echo "Uso: $0 [OPCIÓN]"
    echo ""
    echo "Opciones:"
    echo "  start     Inicia n8n (default)"
    echo "  stop      Detiene n8n"
    echo "  restart   Reinicia n8n"
    echo "  status    Muestra el estado del sistema"
    echo "  help      Muestra esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0              # Inicia n8n"
    echo "  $0 start        # Inicia n8n"
    echo "  $0 stop         # Detiene n8n"
    echo "  $0 restart      # Reinicia n8n"
    echo "  $0 status       # Muestra estado"
    echo ""
    echo "Variables de entorno:"
    echo "  N8N_PORT        Puerto para n8n (default: 5678)"
    echo "  N8N_PROTOCOL    Protocolo para n8n (default: http)"
    echo "  N8N_HOST        Host para n8n (default: localhost)"
    echo ""
}

# ============================================
# FUNCIÓN PRINCIPAL
# ============================================

main() {
    local command="${1:-start}"

    case "$command" in
        start)
            # Verificar archivo .env
            if [ -f "config/.env" ]; then
                load_env_file "config/.env"
            else
                print_warning "Archivo config/.env no encontrado"
                print_info "Usando variables de entorno del sistema"
            fi

            # Verificar variables críticas
            if ! check_critical_variables; then
                print_warning "Continuando con variables de ejemplo (el sistema puede no funcionar correctamente)"
                read -p "¿Deseas continuar? (y/N): " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    print_info "Cancelado. Por favor configura config/.env primero"
                    exit 1
                fi
            fi

            # Crear directorios necesarios
            create_directories

            # Verificar n8n instalado
            if ! check_n8n_installed; then
                exit 1
            fi

            # Verificar puerto disponible
            local port=${N8N_PORT:-5678}
            if ! check_port_available $port; then
                read -p "¿Deseas intentar usar otro puerto? (y/N): " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    read -p "Ingresa el puerto: " port
                    export N8N_PORT=$port
                else
                    exit 1
                fi
            fi

            # Iniciar n8n
            start_n8n
            ;;

        stop)
            stop_n8n
            ;;

        restart)
            stop_n8n
            sleep 2
            exec "$0" start
            ;;

        status)
            # Cargar variables de entorno para mostrar configuración
            if [ -f "config/.env" ]; then
                load_env_file "config/.env"
            fi
            show_status
            ;;

        help|--help|-h)
            show_help
            ;;

        *)
            print_error "Opción no reconocida: $command"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Capturar señales para limpieza
trap 'echo ""; print_warning "Interrumpido por el usuario"; stop_n8n; exit 0' INT TERM

# Ejecutar función principal
main "$@"