#!/bin/bash

# ============================================
# MARKET INTELLIGENCE AI SYSTEM
# Setup Script
# ============================================
# Este script configura el entorno para el sistema
# ============================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

# Función para verificar comandos
check_command() {
    if command -v $1 &> /dev/null; then
        print_success "$1 está instalado (versión: $($1 --version 2>&1 | head -n1))"
        return 0
    else
        print_error "$1 no está instalado"
        return 1
    fi
}

# Función para crear directorio si no existe
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_success "Directorio creado: $1"
    else
        print_info "Directorio ya existe: $1"
    fi
}

# Función para verificar archivo
check_file() {
    if [ -f "$1" ]; then
        print_success "Archivo encontrado: $1"
        return 0
    else
        print_error "Archivo no encontrado: $1"
        return 1
    fi
}

# Inicio del script
print_header "🚀 Market Intelligence AI System - Setup"

print_info "Iniciando configuración del entorno..."
echo ""

# ============================================
# VERIFICAR DEPENDENCIAS
# ============================================
print_header "📋 Verificando Dependencias"

# Verificar Node.js
if check_command "node"; then
    NODE_VERSION=$(node -v)
    print_info "Versión de Node.js: $NODE_VERSION"

    # Verificar versión mínima
    if [[ $(echo "$NODE_VERSION" | cut -d'v' -f2 | cut -d'.' -f1) -lt 18 ]]; then
        print_error "Node.js versión 18+ es requerida. Versión actual: $NODE_VERSION"
        exit 1
    fi
else
    print_error "Node.js no está instalado. Por favor instala Node.js 18+"
    print_info "Descarga desde: https://nodejs.org/"
    exit 1
fi

# Verificar npm
if check_command "npm"; then
    NPM_VERSION=$(npm -v)
    print_info "Versión de npm: $NPM_VERSION"
else
    print_error "npm no está instalado"
    exit 1
fi

# Verificar Git (opcional pero recomendado)
if check_command "git"; then
    GIT_VERSION=$(git --version)
    print_info "Versión de Git: $GIT_VERSION"
else
    print_warning "Git no está instalado (opcional pero recomendado)"
    print_info "Descarga desde: https://git-scm.com/"
fi

# ============================================
# CREAR DIRECTORIOS NECESARIOS
# ============================================
print_header "📁 Creando Directorios"

create_directory "logs"
create_directory "temp"
create_directory "backups"
create_directory "config"

# ============================================
# VERIFICAR ARCHIVO .env
# ============================================
print_header "🔐 Verificando Configuración"

if [ -f "config/.env" ]; then
    print_success "Archivo .env encontrado"

    # Verificar variables críticas
    print_info "Verificando variables críticas..."

    if grep -q "SUPABASE_URL=" config/.env && ! grep -q "SUPABASE_URL=your-" config/.env; then
        print_success "SUPABASE_URL configurado"
    else
        print_warning "SUPABASE_URL no configurado o es el valor por defecto"
    fi

    if grep -q "SUPABASE_KEY=" config/.env && ! grep -q "SUPABASE_KEY=eyJ" config/.env; then
        print_success "SUPABASE_KEY configurado"
    else
        print_warning "SUPABASE_KEY no configurado o es el valor por defecto"
    fi

    if grep -q "GROQ_API_KEY=" config/.env && ! grep -q "GROQ_API_KEY=gsk_" config/.env; then
        print_success "GROQ_API_KEY configurado"
    else
        print_warning "GROQ_API_KEY no configurado o es el valor por defecto"
    fi

    if grep -q "RESEND_API_KEY=" config/.env && ! grep -q "RESEND_API_KEY=re_" config/.env; then
        print_success "RESEND_API_KEY configurado"
    else
        print_warning "RESEND_API_KEY no configurado o es el valor por defecto"
    fi

else
    print_warning "Archivo .env no encontrado"

    if [ -f "config/.env.example" ]; then
        print_info "Creando archivo .env desde ejemplo..."
        cp config/.env.example config/.env
        print_success "Archivo .env creado"
        print_warning "⚠️  Por favor edita config/.env con tus credenciales"
    else
        print_error "Archivo .env.example no encontrado"
        print_info "Por favor crea config/.env con tus credenciales"
    fi
fi

# ============================================
# VERIFICAR ARCHIVO DE WORKFLOW
# ============================================
print_header "📊 Verificando Workflow"

WORKFLOW_FILE="workflows/market_intelligence_complete.json"

if [ -f "$WORKFLOW_FILE" ]; then
    print_success "Archivo de workflow encontrado: $WORKFLOW_FILE"

    # Verificar que el archivo sea JSON válido
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool "$WORKFLOW_FILE" > /dev/null 2>&1; then
            print_success "Archivo JSON válido"
        else
            print_error "Archivo JSON inválido"
        fi
    else
        print_info "No se puede validar JSON (python3 no disponible)"
    fi
else
    print_error "Archivo de workflow no encontrado: $WORKFLOW_FILE"
    print_info "Por favor asegúrate de que el archivo esté en la ubicación correcta"
fi

# ============================================
# VERIFICAR DEPENDENCIAS DE NODE
# ============================================
print_header "📦 Verificando Dependencias de Node"

if [ -f "package.json" ]; then
    print_info "Archivo package.json encontrado"

    if [ -d "node_modules" ]; then
        print_success "Dependencias ya instaladas"
    else
        print_info "Instalando dependencias..."
        if npm install; then
            print_success "Dependencias instaladas correctamente"
        else
            print_error "Error al instalar dependencias"
            exit 1
        fi
    fi
else
    print_info "No se encontró package.json (opcional para este proyecto)"
fi

# ============================================
# VERIFICAR INSTALACIÓN DE n8n
# ============================================
print_header "🤖 Verificando n8n"

if command -v n8n &> /dev/null; then
    N8N_VERSION=$(n8n --version)
    print_success "n8n está instalado (versión: $N8N_VERSION)"
else
    print_warning "n8n no está instalado globalmente"
    print_info "Para instalar n8n globalmente:"
    print_info "  npm install n8n -g"
    print_info "  o"
    print_info "  yarn global add n8n"
fi

# ============================================
# CREAR ARCHIVOS DE LOGS
# ============================================
print_header "📝 Creando Archivos de Logs"

LOG_FILE="logs/setup.log"
touch "$LOG_FILE"
print_success "Archivo de logs creado: $LOG_FILE"

# Escribir información de setup al log
echo "========================================" >> "$LOG_FILE"
echo "Market Intelligence AI System - Setup" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "Fecha: $(date)" >> "$LOG_FILE"
echo "Node.js: $(node -v)" >> "$LOG_FILE"
echo "npm: $(npm -v)" >> "$LOG_FILE"
echo "Git: $(git --version 2>&1 || echo 'No instalado')" >> "$LOG_FILE"
echo "n8n: $(n8n --version 2>&1 || echo 'No instalado')" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# ============================================
# VERIFICAR CONEXIONES A SERVICIOS EXTERNOS
# ============================================
print_header "🌐 Verificando Conexiones a Servicios"

# Verificar conexión a internet
if command -v curl &> /dev/null; then
    if curl -s --head https://www.google.com > /dev/null 2>&1; then
        print_success "Conexión a internet disponible"
    else
        print_warning "No se puede verificar conexión a internet"
    fi
else
    print_warning "curl no está disponible para verificar conexión"
fi

# ============================================
# RESUMEN DE CONFIGURACIÓN
# ============================================
print_header "📋 Resumen de Configuración"

echo ""
print_info "Directorios creados:"
echo "  - logs/"
echo "  - temp/"
echo "  - backups/"
echo "  - config/"
echo ""

print_info "Archivos verificados:"
echo "  - config/.env"
echo "  - workflows/market_intelligence_complete.json"
echo ""

print_info "Dependencias:"
echo "  - Node.js: $(node -v)"
echo "  - npm: $(npm -v)"
echo "  - Git: $(git --version 2>&1 || echo 'No instalado')"
echo "  - n8n: $(n8n --version 2>&1 || echo 'No instalado')"
echo ""

# ============================================
# SIGUIENTES PASOS
# ============================================
print_header "🎯 Siguientes Pasos"

echo ""
print_info "1. Configurar variables de entorno:"
echo "   - Edita config/.env con tus credenciales"
echo "   - Reemplaza los valores de ejemplo"
echo ""

print_info "2. Obtener credenciales necesarias:"
echo "   - Supabase: https://supabase.com"
echo "   - Groq: https://groq.com"
echo "   - Resend: https://resend.com"
echo "   - Slack: https://slack.com (opcional)"
echo ""

print_info "3. Iniciar n8n:"
echo "   - Ejecuta: bash scripts/start.sh"
echo "   - O manualmente: n8n start"
echo ""

print_info "4. Importar el workflow:"
echo "   - Abre http://localhost:5678 en tu navegador"
echo "   - Importa workflows/market_intelligence_complete.json"
echo "   - Configura las credenciales en cada nodo"
echo ""

print_info "5. Ejecutar el sistema:"
echo "   - Haz clic en 'Execute Workflow'"
echo "   - Verifica los resultados en Supabase"
echo "   - Confirma que recibiste el email"
echo ""

print_info "6. Configurar automatización:"
echo "   - Agrega un Schedule Trigger"
echo "   - Configura la frecuencia deseada"
echo "   - Activa el workflow"
echo ""

# ============================================
# ADVERTENCIAS
# ============================================
print_header "⚠️  Advertencias Importantes"

echo ""
print_warning "1. NUNCA commits el archivo config/.env al repositorio"
print_warning "2. Mantén tus API keys seguras y privadas"
print_warning "3. Usa contraseñas fuertes para n8n"
print_warning "4. Verifica que tu dominio de email esté verificado en Resend"
print_warning "5. Configura Row Level Security en Supabase"
echo ""

# ============================================
# FINALIZACIÓN
# ============================================
print_header "✅ Configuración Completada"

echo ""
print_success "El entorno está listo para usar Market Intelligence AI System"
echo ""
print_info "Para comenzar, ejecuta:"
echo "  bash scripts/start.sh"
echo ""
print_info "Para más información, consulta:"
echo "  - README.md"
echo "  - docs/setup-guide.md"
echo "  - docs/architecture.md"
echo ""

# Escribir finalización al log
echo "Setup completado exitosamente: $(date)" >> "$LOG_FILE"

exit 0