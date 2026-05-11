# 📖 Guía de Configuración Detallada

## 🎯 Introducción

Esta guía te llevará paso a paso a través de la configuración completa del **Market Intelligence AI System**. Sigue cada sección cuidadosamente para asegurar una instalación exitosa.

## 📋 Requisitos Previos

### Software Necesario

#### 1. Node.js y npm

**Verificar instalación:**
```bash
node --version  # Debe ser 18.0.0 o superior
npm --version   # Debe ser 9.0.0 o superior
```

**Si no está instalado:**

**Windows:**
1. Descarga desde https://nodejs.org/
2. Ejecuta el instalador
3. Reinicia tu terminal

**macOS:**
```bash
brew install node
```

**Linux (Ubuntu/Debian):**
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### 2. Git

**Verificar instalación:**
```bash
git --version
```

**Si no está instalado:**

**Windows:**
1. Descarga desde https://git-scm.com/
2. Ejecuta el instalador

**macOS:**
```bash
brew install git
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install git
```

#### 3. Editor de Código

**Recomendado:** Visual Studio Code

**Instalación:**
- Descarga desde https://code.visualstudio.com/
- Instala extensiones recomendadas:
  - ESLint
  - Prettier
  - GitLens

### Hardware Recomendado

- **CPU:** 2+ cores (4+ recomendado)
- **RAM:** 4GB mínimo (8GB recomendado)
- **Almacenamiento:** 10GB libres
- **Internet:** Conexión estable

## 🔧 Paso 1: Configuración de Supabase

### 1.1 Crear Cuenta en Supabase

1. Ve a https://supabase.com
2. Haz clic en "Start your project"
3. Regístrate con GitHub, Google, o email
4. Verifica tu email si es necesario

### 1.2 Crear Nuevo Proyecto

1. Después de iniciar sesión, haz clic en "New Project"
2. Completa el formulario:
   - **Name:** `market-intelligence`
   - **Database Password:** Genera una contraseña segura (guárdala)
   - **Region:** Elige la región más cercana a ti
3. Haz clic en "Create new project"
4. Espera a que el proyecto se cree (2-3 minutos)

### 1.3 Obtener Credenciales

1. Ve a **Settings** → **API**
2. Copia las siguientes credenciales:

**Project URL:**
```
https://xxxxxxxxxxxxx.supabase.co
```

**anon public key:**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**service_role key (GUARDAR SECRETA):**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

⚠️ **IMPORTANTE:** Nunca compartas la `service_role key`. Solo usa la `anon public key` en tu aplicación.

### 1.4 Crear Tablas en la Base de Datos

1. Ve a **SQL Editor** en el panel izquierdo
2. Haz clic en "New query"
3. Copia y pega el siguiente SQL:

```sql
-- ============================================
-- TABLA: competitor_products
-- ============================================
CREATE TABLE competitor_products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category TEXT,
  competitor_id TEXT NOT NULL,
  url TEXT,
  scraped_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para optimización
CREATE INDEX idx_products_competitor_id ON competitor_products(competitor_id);
CREATE INDEX idx_products_scraped_at ON competitor_products(scraped_at);
CREATE INDEX idx_products_category ON competitor_products(category);
CREATE INDEX idx_products_competitor_date ON competitor_products(competitor_id, scraped_at DESC);

-- ============================================
-- TABLA: alerts
-- ============================================
CREATE TABLE alerts (
  id SERIAL PRIMARY KEY,
  priority TEXT NOT NULL CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  message TEXT NOT NULL,
  analysis_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para optimización
CREATE INDEX idx_alerts_priority ON alerts(priority);
CREATE INDEX idx_alerts_analysis_date ON alerts(analysis_date);
CREATE INDEX idx_alerts_priority_date ON alerts(priority, analysis_date DESC);

-- ============================================
-- TABLA: daily_reports
-- ============================================
CREATE TABLE daily_reports (
  id SERIAL PRIMARY KEY,
  summary TEXT,
  trends JSONB,
  opportunities JSONB,
  threats JSONB,
  recommendations JSONB,
  price_changes JSONB,
  alerts JSONB,
  report_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para optimización
CREATE INDEX idx_reports_report_date ON daily_reports(report_date DESC);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Habilitar RLS en todas las tablas
ALTER TABLE competitor_products ENABLE ROW LEVEL SECURITY;
ALTER TABLE alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_reports ENABLE ROW LEVEL SECURITY;

-- Políticas para competitor_products
CREATE POLICY "Enable read access for all users" 
ON competitor_products FOR SELECT USING (true);

CREATE POLICY "Enable insert for system" 
ON competitor_products FOR INSERT WITH CHECK (true);

-- Políticas para alerts
CREATE POLICY "Enable read access for all users" 
ON alerts FOR SELECT USING (true);

CREATE POLICY "Enable insert for system" 
ON alerts FOR INSERT WITH CHECK (true);

-- Políticas para daily_reports
CREATE POLICY "Enable read access for all users" 
ON daily_reports FOR SELECT USING (true);

CREATE POLICY "Enable insert for system" 
ON daily_reports FOR INSERT WITH CHECK (true);

-- ============================================
-- FUNCIONES ÚTILES
-- ============================================

-- Función para obtener productos recientes
CREATE OR REPLACE FUNCTION get_recent_products(limit_count INTEGER DEFAULT 100)
RETURNS TABLE (
  id INTEGER,
  name TEXT,
  price DECIMAL,
  category TEXT,
  competitor_id TEXT,
  url TEXT,
  scraped_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    cp.id,
    cp.name,
    cp.price,
    cp.category,
    cp.competitor_id,
    cp.url,
    cp.scraped_at
  FROM competitor_products cp
  ORDER BY cp.scraped_at DESC
  LIMIT limit_count;
END;
$$ LANGUAGE plpgsql;

-- Función para obtener alertas recientes
CREATE OR REPLACE FUNCTION get_recent_alerts(limit_count INTEGER DEFAULT 50)
RETURNS TABLE (
  id INTEGER,
  priority TEXT,
  message TEXT,
  analysis_date TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    a.id,
    a.priority,
    a.message,
    a.analysis_date
  FROM alerts a
  ORDER BY a.analysis_date DESC
  LIMIT limit_count;
END;
$$ LANGUAGE plpgsql;

-- Función para limpiar datos antiguos
CREATE OR REPLACE FUNCTION cleanup_old_data(days_to_keep INTEGER DEFAULT 30)
RETURNS INTEGER AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM competitor_products 
  WHERE scraped_at < NOW() - INTERVAL '1 day' * days_to_keep;
  
  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  
  RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;
```

4. Haz clic en "Run" para ejecutar el SQL
5. Verifica que no haya errores

### 1.5 Verificar Tablas Creadas

1. Ve a **Table Editor** en el panel izquierdo
2. Deberías ver las tres tablas:
   - `competitor_products`
   - `alerts`
   - `daily_reports`

## 🤖 Paso 2: Configuración de Groq

### 2.1 Crear Cuenta en Groq

1. Ve a https://groq.com
2. Haz clic en "Sign Up"
3. Regístrate con GitHub, Google, o email
4. Verifica tu email si es necesario

### 2.2 Obtener API Key

1. Después de iniciar sesión, ve a **Console** → **API Keys**
2. Haz clic en "Create API Key"
3. Dale un nombre a tu key (ej: `market-intelligence`)
4. Copia la API Key generada:

```
gsk_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

⚠️ **IMPORTANTE:** Guarda esta key de forma segura. No la compartas públicamente.

### 2.3 Verificar Modelo Disponible

1. Ve a **Console** → **Models**
2. Verifica que el modelo `llama-3.3-70b-versatile` esté disponible
3. Este es el modelo recomendado para este proyecto

### 2.4 Probar la API (Opcional)

```bash
# Instalar curl si no está instalado
# Windows: Ya viene instalado
# macOS: brew install curl
# Linux: sudo apt-get install curl

# Probar la API
curl -X POST https://api.groq.com/openai/v1/chat/completions \
  -H "Authorization: Bearer TU_GROQ_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama-3.3-70b-versatile",
    "messages": [
      {
        "role": "user",
        "content": "Hello, how are you?"
      }
    ],
    "max_tokens": 50
  }'
```

## 📧 Paso 3: Configuración de Resend

### 3.1 Crear Cuenta en Resend

1. Ve a https://resend.com
2. Haz clic en "Sign Up"
3. Regístra con GitHub, Google, o email
4. Verifica tu email

### 3.2 Obtener API Key

1. Después de iniciar sesión, ve a **API Keys**
2. Haz clic en "Create API Key"
3. Copia la API Key generada:

```
re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 3.3 Configurar Dominio de Email

#### Opción A: Usar Dominio Propio (Recomendado para Producción)

1. Ve a **Domains** en el panel izquierdo
2. Haz clic en "Add Domain"
3. Ingresa tu dominio (ej: `tuempresa.com`)
4. Haz clic en "Add Domain"

5. **Configurar Registros DNS:**

Ve a tu proveedor de DNS (ej: GoDaddy, Namecheap, Cloudflare) y agrega estos registros:

**Registro TXT:**
```
Nombre: resend._domainkey
Tipo: TXT
Valor: v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQD...
```

**Registro CNAME:**
```
Nombre: resend._domainkey
Tipo: CNAME
Valor: dkim._domainkey.resend.com
```

6. Espera 5-10 minutos para que los registros DNS se propaguen
7. Vuelve a Resend y haz clic en "Verify Domain"

#### Opción B: Usar Dominio de Resend (Más Rápido para Testing)

1. No necesitas configurar DNS
2. Usa `onboarding@resend.dev` como remitente
3. Listo para usar inmediatamente

### 3.4 Probar Envío de Email

```bash
curl -X POST https://api.resend.com/emails \
  -H "Authorization: Bearer TU_RESEND_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "from": "onboarding@resend.dev",
    "to": ["tu-email@ejemplo.com"],
    "subject": "Test Email from Market Intelligence",
    "html": "<h1>Test Email</h1><p>This is a test email from Market Intelligence AI System.</p>"
  }'
```

## 💬 Paso 4: Configuración de Slack (Opcional)

### 4.1 Crear Workspace en Slack

1. Ve a https://slack.com
2. Haz clic en "Create a new workspace"
3. Sigue las instrucciones para crear tu workspace

### 4.2 Crear App de Slack

1. Ve a https://api.slack.com/apps
2. Haz clic en "Create New App"
3. Selecciona "From scratch"
4. Completa el formulario:
   - **App Name:** `Market Intelligence Bot`
   - **Pick a workspace:** Selecciona tu workspace
5. Haz clic en "Create App"

### 4.3 Configurar Incoming Webhooks

1. En el panel izquierdo, ve a **Incoming Webhooks**
2. Activa el switch "Activate Incoming Webhooks"
3. Haz clic en "Add New Webhook to Workspace"
4. Selecciona el canal donde quieres recibir alertas (ej: `#market-intelligence`)
5. Haz clic en "Allow"
6. Copia la Webhook URL:

```
https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXX
```

### 4.4 Probar Webhook

```bash
curl -X POST TU_SLACK_WEBHOOK_URL \
  -H "Content-Type: application/json" \
  -d '{
    "text": "🚨 Test Alert from Market Intelligence AI System",
    "username": "Market Intelligence Bot",
    "icon_emoji": ":robot_face:"
  }'
```

## 📦 Paso 5: Instalación de n8n

### 5.1 Instalar n8n Globalmente

```bash
# Usar npm
npm install n8n -g

# O usar yarn
yarn global add n8n

# Verificar instalación
n8n --version
```

### 5.2 Configurar Variables de Entorno para n8n

**Windows (PowerShell):**
```powershell
$env:N8N_PORT="5678"
$env:N8N_PROTOCOL="http"
$env:N8N_HOST="localhost"
$env:N8N_BASIC_AUTH_ACTIVE="true"
$env:N8N_BASIC_AUTH_USER="admin"
$env:N8N_BASIC_AUTH_PASSWORD="tu_contraseña_segura"
```

**macOS/Linux:**
```bash
export N8N_PORT=5678
export N8N_PROTOCOL=http
export N8N_HOST=localhost
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER=admin
export N8N_BASIC_AUTH_PASSWORD=tu_contraseña_segura
```

### 5.3 Iniciar n8n

```bash
n8n start
```

n8n estará disponible en: **http://localhost:5678**

### 5.4 Configurar n8n

1. Abre http://localhost:5678 en tu navegador
2. Crea una cuenta de administrador
3. Configura las credenciales predeterminadas

## 🚀 Paso 6: Configuración del Proyecto

### 6.1 Clonar el Repositorio

```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/MarketIntelligenceAI-Project.git
cd MarketIntelligenceAI-Project
```

### 6.2 Crear Archivo .env

```bash
# Copiar el archivo de ejemplo
cp config/.env.example config/.env
```

### 6.3 Editar Archivo .env

Abre `config/.env` con tu editor de texto y completa las credenciales:

```env
# ============================================
# SUPABASE CONFIGURATION
# ============================================
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# ============================================
# GROQ AI CONFIGURATION
# ============================================
GROQ_API_KEY=gsk_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# ============================================
# RESEND EMAIL CONFIGURATION
# ============================================
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# ============================================
# SLACK CONFIGURATION (OPTIONAL)
# ============================================
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...

# ============================================
# EMAIL CONFIGURATION
# ============================================
EMAIL_FROM=onboarding@resend.dev
EMAIL_TO=tu-email@empresa.com

# ============================================
# N8N CONFIGURATION
# ============================================
N8N_PORT=5678
N8N_PROTOCOL=http
N8N_HOST=localhost

# ============================================
# WORKFLOW CONFIGURATION
# ============================================
WORKFLOW_SCHEDULE=0 9 * * *
```

⚠️ **IMPORTANTE:** Reemplaza los valores de ejemplo con tus credenciales reales.

### 6.4 Ejecutar Script de Setup

```bash
# Dar permisos de ejecución (macOS/Linux)
chmod +x scripts/setup.sh

# Ejecutar el script
bash scripts/setup.sh
```

El script verificará:
- ✅ Node.js instalado
- ✅ npm instalado
- ✅ Archivo .env configurado
- ✅ Workflow JSON presente
- ✅ Directorios necesarios creados

## 🎯 Paso 7: Importar el Workflow en n8n

### 7.1 Abrir n8n

1. Abre tu navegador y ve a http://localhost:5678
2. Inicia sesión con tus credenciales

### 7.2 Importar el Workflow

1. Haz clic en **"Import from File"** en la esquina superior derecha
2. Navega a `workflows/market_intelligence_complete.json`
3. Selecciona el archivo y haz clic en "Import"
4. El workflow se cargará en el editor de n8n

### 7.3 Configurar Credenciales en los Nodos

#### Nodo: Competitor 1 Scraper (HTTP Request)

1. Haz clic en el nodo "Competitor 1 Scraper"
2. Configura:
   - **Method:** GET
   - **URL:** `https://fakestoreapi.com/products`
   - **Authentication:** None

#### Nodo: Competitor 2 Scraper (HTTP Request)

1. Haz clic en el nodo "Competitor 2 Scraper"
2. Configura:
   - **Method:** GET
   - **URL:** `https://dummyjson.com/products`
   - **Authentication:** None

#### Nodo: Save to Supabase (HTTP Request)

1. Haz clic en el nodo "Save to Supabase"
2. Configura:
   - **Method:** POST
   - **URL:** `{{$env.SUPABASE_URL}}/rest/v1/competitor_products`
   - **Authentication:**
     - Type: Generic Credential Type
     - Name: Supabase
     - Auth: Header Auth
     - Property: apikey
     - Value: `{{$env.SUPABASE_KEY}}`
   - **Headers:**
     - Content-Type: application/json
     - Authorization: Bearer `{{$env.SUPABASE_KEY}}`
   - **Body:** JSON
     ```json
     {{$json}}
     ```

#### Nodo: Groq Analysis (HTTP Request)

1. Haz clic en el nodo "Groq Analysis"
2. Configura:
   - **Method:** POST
   - **URL:** `https://api.groq.com/openai/v1/chat/completions`
   - **Authentication:**
     - Type: Generic Credential Type
     - Name: Groq
     - Auth: Header Auth
     - Property: Authorization
     - Value: Bearer `{{$env.GROQ_API_KEY}}`
   - **Headers:**
     - Content-Type: application/json
   - **Body:** JSON
     ```json
     {
       "model": "llama-3.3-70b-versatile",
       "messages": [
         {
           "role": "system",
           "content": "Eres un experto en inteligencia de mercado y análisis competitivo."
         },
         {
           "role": "user",
           "content": "Analiza los siguientes datos de competidores y genera un reporte estratégico completo con tendencias, oportunidades, amenazas y recomendaciones. Datos: {{JSON.stringify($input.all())}}"
         }
       ],
       "temperature": 0.7,
       "max_tokens": 2000
     }
     ```

#### Nodo: Send Email Alert (HTTP Request)

1. Haz clic en el nodo "Send Email Alert"
2. Configura:
   - **Method:** POST
   - **URL:** `https://api.resend.com/emails`
   - **Authentication:**
     - Type: Generic Credential Type
     - Name: Resend
     - Auth: Header Auth
     - Property: Authorization
     - Value: Bearer `{{$env.RESEND_API_KEY}}`
   - **Headers:**
     - Content-Type: application/json
   - **Body:** JSON
     ```json
     {
       "from": "{{$env.EMAIL_FROM}}",
       "to": ["{{$env.EMAIL_TO}}"],
       "subject": "🚨 Market Intelligence Alert - {{$json.priority}} Priority",
       "html": "{{$json.message}}"
     }
     ```

#### Nodo: Send Slack Alert (HTTP Request)

1. Haz clic en el nodo "Send Slack Alert"
2. Configura:
   - **Method:** POST
   - **URL:** `{{$env.SLACK_WEBHOOK_URL}}`
   - **Headers:**
     - Content-Type: application/json
   - **Body:** JSON
     ```json
     {
       "text": "🚨 CRITICAL ALERT: {{$json.message}}",
       "username": "Market Intelligence Bot",
       "icon_emoji": ":robot_face:"
     }
     ```

### 7.4 Guardar el Workflow

1. Haz clic en **"Save"** en la esquina superior derecha
2. Dale un nombre al workflow (ej: "Market Intelligence - Complete Workflow")
3. Haz clic en "Save"

## 🧪 Paso 8: Probar el Sistema

### 8.1 Ejecución Manual

1. Haz clic en **"Execute Workflow"** en la esquina superior derecha
2. Observa la ejecución en tiempo real
3. Cada nodo se ejecutará secuencialmente

### 8.2 Verificar Resultados

#### Verificar en Supabase

1. Ve a tu proyecto de Supabase
2. Abre **Table Editor**
3. Revisa la tabla `competitor_products`:
   - Deberías ver productos de ambos competidores
   - Verifica que los campos estén completos

4. Revisa la tabla `alerts`:
   - Deberías ver al menos una alerta
   - Verifica que el priority sea correcto

#### Verificar Email

1. Revisa tu bandeja de entrada
2. Deberías recibir un email con:
   - Asunto: "🚨 Market Intelligence Alert - [PRIORITY] Priority"
   - Contenido HTML con el análisis completo

#### Verificar Slack (si está configurado)

1. Abre tu canal de Slack
2. Deberías ver un mensaje del bot
3. Verifica que el mensaje contenga la alerta

### 8.3 Revisar Logs de n8n

```bash
# Ver logs en tiempo real
tail -f logs/n8n.log

# Buscar errores
grep "ERROR" logs/n8n.log

# Ver últimas líneas
tail -n 50 logs/n8n.log
```

## ⏰ Paso 9: Configurar Automatización

### 9.1 Agregar Trigger Programado

1. En el editor de n8n, haz clic en el **"+"** al inicio del workflow
2. Busca y selecciona **"Schedule Trigger"**
3. Configura el trigger:
   - **Mode:** Cron
   - **Cron Expression:** `0 9 * * *` (9:00 AM diariamente)
   - **Timezone:** Tu zona horaria

### 9.2 Conectar el Trigger

1. Arrastra una línea desde el Schedule Trigger al primer nodo
2. Asegúrate de que la conexión esté correcta

### 9.3 Activar el Workflow

1. Haz clic en **"Activate"** en la esquina superior derecha
2. El workflow se ejecutará automáticamente según el schedule
3. Verifica que el estado sea "Active"

### 9.4 Frecuencias Recomendadas

**Diariamente a las 9:00 AM:**
```
0 9 * * *
```

**Semanalmente los lunes a las 9:00 AM:**
```
0 9 * * 1
```

**Cada 6 horas:**
```
0 */6 * * *
```

**Cada hora:**
```
0 * * * *
```

**Personalizado (cada 2 horas):**
```
0 */2 * * *
```

## 🔧 Paso 10: Personalización Avanzada

### 10.1 Agregar Nuevos Competidores

1. Agrega un nuevo nodo "HTTP Request"
2. Configura la URL del nuevo competidor
3. Conecta al nodo "Data Processing"
4. Actualiza el código de Data Processing para detectar el nuevo competitor_id

### 10.2 Modificar Reglas de Alerta

Edita el nodo "Alert Logic" y modifica la lógica de priorización:

```javascript
// Ejemplo: Hacer más estrictas las reglas
if (analysisData.trends && analysisData.trends.length > 5) {
  priority = 'critical';
} else if (analysisData.threats && analysisData.threats.length > 2) {
  priority = 'high';
} else if (analysisData.opportunities && analysisData.opportunities.length > 3) {
  priority = 'medium';
} else {
  priority = 'low';
}
```

### 10.3 Personalizar Email Template

Edita el HTML en el nodo "Alert Logic" para personalizar el diseño del email:

```javascript
// Puedes agregar:
- Logo de tu empresa
- Colores corporativos
- Enlaces a dashboards
- Tablas de datos
- Gráficos
```

## 🐛 Solución de Problemas

### Problema: "Authorization failed"

**Solución:**
1. Verifica que las API keys sean correctas
2. Revisa que las keys tengan los permisos necesarios
3. Confirma que las keys no hayan expirado
4. Regenera las keys si es necesario

### Problema: "Bad request"

**Solución:**
1. Verifica los parámetros de los nodos HTTP Request
2. Revisa la sintaxis de las expresiones
3. Confirma que los datos estén en el formato correcto
4. Revisa la documentación de la API

### Problema: "Connection refused"

**Solución:**
1. Verifica que n8n esté corriendo: `ps aux | grep n8n`
2. Revisa el puerto configurado (default: 5678)
3. Confirma que no haya otro servicio usando el puerto
4. Reinicia n8n si es necesario

### Problema: Email no llega

**Solución:**
1. Verifica la configuración de Resend
2. Revisa que el dominio esté verificado
3. Confirma que la API key sea correcta
4. Revisa la carpeta de spam
5. Verifica logs de Resend

### Problema: Slack no envía alertas

**Solución:**
1. Verifica la URL del webhook
2. Revisa que el nodo esté conectado correctamente
3. Confirma que la prioridad sea "critical"
4. Verifica que el webhook esté activo en Slack
5. Revisa los logs de Slack

## 📚 Recursos Adicionales

### Documentación Oficial

- **n8n:** https://docs.n8n.io
- **Supabase:** https://supabase.com/docs
- **Groq:** https://groq.com/docs
- **Resend:** https://resend.com/docs
- **Slack API:** https://api.slack.com

### Tutoriales y Guías

- **n8n Tutorials:** https://n8n.io/blog/
- **Supabase Learn:** https://supabase.com/learn
- **Groq Examples:** https://groq.com/docs/examples

### Comunidad

- **n8n Community:** https://community.n8n.io
- **Supabase Discord:** https://supabase.com/discord
- **Groq Discord:** https://groq.com/discord

## 🎞️ Capturas de Pantalla

### Ejemplo de Workflow en n8n

![Workflow en n8n](screenshots/workflow.png)

### Ejemplo de Email de Alerta

![Email de Alerta](screenshots/email-example.png)

### Ejemplo de Dashboard de Supabase

![Dashboard de Supabase](screenshots/dashboard.png)

## ✅ Checklist de Configuración

Antes de considerar la configuración completa, verifica:

- [ ] Node.js 18+ instalado
- [ ] npm instalado
- [ ] Git instalado
- [ ] Cuenta en Supabase creada
- [ ] Proyecto de Supabase creado
- [ ] Tablas de Supabase creadas
- [ ] Cuenta en Groq creada
- [ ] API Key de Groq obtenida
- [ ] Cuenta en Resend creada
- [ ] API Key de Resend obtenida
- [ ] Dominio de Resend configurado
- [ ] Workspace de Slack creado (opcional)
- [ ] Webhook de Slack configurado (opcional)
- [ ] n8n instalado
- [ ] n8n iniciado correctamente
- [ ] Repositorio clonado
- [ ] Archivo .env configurado
- [ ] Script de setup ejecutado
- [ ] Workflow importado en n8n
- [ ] Credenciales configuradas en nodos
- [ ] Workflow guardado
- [ ] Workflow ejecutado manualmente
- [ ] Resultados verificados en Supabase
- [ ] Email recibido correctamente
- [ ] Slack notificado correctamente (opcional)
- [ ] Trigger programado configurado
- [ ] Workflow activado

## 🆘 Soporte

Si tienes problemas después de seguir esta guía:

1. **Revisa esta guía** nuevamente
2. **Consulta la documentación oficial** de cada servicio
3. **Abre un issue** en el repositorio de GitHub
4. **Contacta al soporte** de cada servicio:
   - n8n: https://community.n8n.io
   - Supabase: https://supabase.com/support
   - Groq: https://groq.com/support
   - Resend: https://resend.com/support
   - Slack: https://slack.com/help

---

**Última actualización:** Mayo 2026

**Versión:** 1.0.0

**Autor:** Market Intelligence AI Team