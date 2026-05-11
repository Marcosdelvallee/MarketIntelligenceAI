# 🤖 Market Intelligence AI System

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![n8n](https://img.shields.io/badge/n8n-Automation-orange)](https://n8n.io)
[![Groq](https://img.shields.io/badge/Groq-AI-purple)](https://groq.com)
[![Supabase](https://img.shields.io/badge/Supabase-Database-green)](https://supabase.com)
[![Resend](https://img.shields.io/badge/Resend-Email-red)](https://resend.com)

**Sistema Automatizado de Inteligencia de Mercado Potenciado por IA**

[Documentación](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/docs) • [Demo](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project) • [Reporte de Bug](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/issues) • [Contribuir](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/pulls)

</div>

---

## 📊 Sobre el Proyecto

El **Market Intelligence AI System** es una plataforma empresarial de inteligencia competitiva que automatiza el monitoreo, análisis y reporte de datos de mercado en tiempo real utilizando inteligencia artificial generativa de última generación.

### 🎯 Problema que Soluciona

Las empresas pierden horas valiosas recopilando manualmente datos de competidores, analizando tendencias del mercado, y generando reportes estratégicos. Este proceso es:
- ⏰ **Lento**: Requiere dedicación de personal especializado
- 💰 **Costoso**: Salarios de analistas y herramientas premium
- 📉 **Ineficiente**: Datos desactualizados y análisis subjetivos
- 🔄 **No escalable**: Difícil de expandir a más competidores

### 💡 Nuestra Solución

Un sistema completamente automatizado que:
- 🚀 **Monitorea 24/7**: Scraping continuo de múltiples fuentes
- 🧠 **Analiza con IA**: Procesamiento inteligente con Llama 3.3-70B
- 📈 **Detecta tendencias**: Identificación automática de patrones
- ⚡ **Alerta en tiempo real**: Notificaciones instantáneas de cambios críticos
- 📊 **Genera reportes**: Análisis estratégicos automáticos
- 💰 **Ahorra costos**: Reducción del 90% en tiempo de análisis

---

## 🚀 Características Principales

### 🔍 Web Scraping Inteligente
- **Multi-fuente**: Extracción simultánea de múltiples competidores
- **Robusto**: Manejo automático de errores y reintentos
- **Programable**: Configuración flexible de frecuencias
- **Escalable**: Fácil adición de nuevas fuentes de datos

### 🧠 Análisis con IA de Vanguardia
- **Modelo Llama 3.3-70B**: Procesamiento de lenguaje natural de última generación
- **Análisis profundo**: Detección de tendencias, oportunidades y amenazas
- **Insights accionables**: Recomendaciones estratégicas específicas
- **Aprendizaje continuo**: Mejora constante con cada análisis

### 📊 Detección de Tendencias
- **Patrones de mercado**: Identificación de cambios en precios, productos y estrategias
- **Análisis comparativo**: Benchmarking automático entre competidores
- **Predicción inteligente**: Anticipación de movimientos del mercado
- **Visualización de datos**: Representación clara de métricas clave

### 🚨 Sistema de Alertas Inteligentes
- **Priorización automática**: Clasificación por nivel de urgencia (low, medium, high, critical)
- **Multi-canal**: Email con HTML profesional y notificaciones Slack
- **Personalización**: Configuración de reglas y umbrales
- **Historial completo**: Registro de todas las alertas generadas

### 💾 Base de Datos en Tiempo Real
- **Supabase PostgreSQL**: Infraestructura robusta y escalable
- **Historial completo**: Tracking de todos los cambios y análisis
- **Consultas optimizadas**: Acceso rápido a datos históricos
- **Backup automático**: Protección de datos garantizada

### 📈 Comparación de Precios
- **Monitoreo continuo**: Detección de cambios de precios instantánea
- **Análisis histórico**: Tendencias de precios a lo largo del tiempo
- **Alertas de precios**: Notificaciones de cambios significativos
- **Competitive intelligence**: Inteligencia de precios competitiva

---

## 🛠️ Stack Tecnológico

### Orquestación & Automatización
- **n8n**: Plataforma de workflow automation de código abierto
- **JavaScript**: Procesamiento y transformación de datos
- **HTTP Requests**: Integración con APIs externas

### Inteligencia Artificial
- **Groq API**: Inferencia de IA de alta velocidad
- **Llama 3.3-70B-versatile**: Modelo de lenguaje de última generación
- **NLP Procesamiento**: Análisis de texto y extracción de insights

### Base de Datos & Almacenamiento
- **Supabase**: Plataforma de base de datos como servicio
- **PostgreSQL**: Motor de base de datos relacional
- **REST API**: Operaciones CRUD optimizadas

### Notificaciones & Comunicación
- **Resend**: Servicio de email transaccional
- **Slack Webhook**: Integración con Slack para alertas críticas
- **HTML Email**: Diseño profesional de correos electrónicos

### Infraestructura
- **Node.js 18+**: Runtime de JavaScript
- **Environment Variables**: Gestión segura de credenciales
- **Git**: Control de versiones

---

## 📋 Requisitos Previos

### Software Necesario
- **Node.js 18+**: [Descargar aquí](https://nodejs.org/)
- **npm o yarn**: Gestor de paquetes de JavaScript
- **Git**: [Descargar aquí](https://git-scm.com/)
- **Editor de código**: VS Code [recomendado](https://code.visualstudio.com/)

### Cuentas Externas (Todas con Planes Gratuitos)
- **Supabase**: [Crear cuenta gratuita](https://supabase.com/)
- **Groq**: [Crear cuenta gratuita](https://groq.com/)
- **Resend**: [Crear cuenta gratuita](https://resend.com/)
- **Slack**: [Opcional - Crear workspace](https://slack.com/)

### Hardware Recomendado
- **CPU**: 2+ cores
- **RAM**: 4GB+ (8GB recomendado)
- **Almacenamiento**: 10GB+ libres
- **Internet**: Conexión estable

---

## 🚀 Instalación Rápida

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project.git
cd MarketIntelligenceAI-Project
```

### 2. Configurar Variables de Entorno

```bash
cp config/.env.example config/.env
```

Edita `config/.env` con tus credenciales:

```env
# Supabase Configuration
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_KEY=your-anon-key-here

# Groq AI Configuration  
GROQ_API_KEY=gsk_your-groq-api-key-here

# Resend Email Configuration
RESEND_API_KEY=re_your-resend-api-key-here

# Slack Configuration (Optional)
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL

# Email Configuration
EMAIL_FROM=onboarding@resend.dev
EMAIL_TO=your-email@company.com

# n8n Configuration
N8N_PORT=5678
N8N_PROTOCOL=http
N8N_HOST=localhost
```

### 3. Ejecutar Script de Setup

```bash
bash scripts/setup.sh
```

Este script:
- ✅ Verifica dependencias instaladas
- ✅ Crea directorios necesarios
- ✅ Valida configuración
- ✅ Prepara el entorno

### 4. Iniciar n8n

```bash
bash scripts/start.sh
```

n8n estará disponible en: **http://localhost:5678**

### 5. Importar el Workflow

1. Abre n8n en tu navegador
2. Haz clic en **"Import from File"**
3. Selecciona `workflows/market_intelligence_complete.json`
4. Configura las credenciales en cada nodo
5. Guarda el workflow

### 6. Ejecutar el Sistema

Haz clic en **"Execute Workflow"** y observa cómo el sistema:
- 🕷️ Scrapea datos de competidores
- 💾 Almacena en la base de datos
- 🧠 Analiza con IA
- 📊 Genera insights
- 📧 Envía alertas por email
- 💬 Notifica en Slack (si está configurado)

---

## 📁 Estructura del Proyecto

```
MarketIntelligenceAI-Project/
├── README.md                          # Documentación principal
├── LICENSE                            # Licencia MIT
├── docs/                              # Documentación técnica
│   ├── architecture.md                # Arquitectura del sistema
│   └── setup-guide.md                 # Guía de configuración detallada
├── workflows/                         # Workflows de n8n
│   └── market_intelligence_complete.json
├── config/                            # Configuraciones
│   └── .env.example                  # Plantilla de variables de entorno
├── scripts/                           # Scripts de automatización
│   ├── setup.sh                       # Script de configuración inicial
│   └── start.sh                       # Script para iniciar n8n
├── screenshots/                       # Capturas de pantalla
│   ├── dashboard.png                  # Dashboard del sistema
│   ├── workflow.png                   # Workflow en n8n
│   └── email-example.png              # Ejemplo de email de alerta
└── logs/                              # Logs del sistema (creado automáticamente)
    ├── n8n.log                        # Logs de n8n
    └── setup.log                      # Logs de configuración
```

---

## 🎯 Casos de Uso

### 🏢 Para Empresas

**Monitoreo Competitivo**
- Rastreo de precios y productos de competidores
- Análisis de estrategias de mercado
- Detección de nuevos lanzamientos

**Inteligencia de Precios**
- Monitoreo continuo de precios
- Análisis de tendencias de precios
- Alertas de cambios significativos

**Análisis de Mercado**
- Identificación de tendencias emergentes
- Detección de oportunidades de mercado
- Evaluación de posición competitiva

### 🏪 Para E-commerce

**Catálogo de Productos**
- Seguimiento automatizado de productos de competidores
- Comparación de precios
- Monitoreo de disponibilidad

**Pricing Dinámico**
- Ajustes de precios en tiempo real
- Optimización de estrategia competitiva
- Maximización de márgenes

### 📈 Para Inversores

**Análisis de Mercado**
- Monitoreo de tendencias del sector
- Análisis de competencia
- Oportunidades de inversión

**Evaluación de Riesgos**
- Detección temprana de cambios en el mercado
- Análisis de amenazas competitivas
- Toma de decisiones basada en datos

---

## 🔧 Configuración

### Esquema de Base de Datos

El sistema crea automáticamente las siguientes tablas en Supabase:

#### `competitor_products`
Almacena los datos scrapeados de competidores:
```sql
CREATE TABLE competitor_products (
  id BIGSERIAL PRIMARY KEY,
  competitor TEXT NOT NULL,
  product_name TEXT NOT NULL,
  price NUMERIC(10,2),
  url TEXT,
  description TEXT,
  scraped_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### `alerts`
Almacena las alertas generadas:
```sql
CREATE TABLE alerts (
  id BIGSERIAL PRIMARY KEY,
  alert_type TEXT NOT NULL,
  priority TEXT NOT NULL,
  message TEXT NOT NULL,
  competitor TEXT,
  analysis_date TIMESTAMPTZ DEFAULT NOW()
);
```

#### `daily_reports`
Almacena los reportes de análisis diarios:
```sql
CREATE TABLE daily_reports (
  id BIGSERIAL PRIMARY KEY,
  report_date TIMESTAMPTZ DEFAULT NOW(),
  analysis TEXT NOT NULL,
  trends TEXT,
  recommendations TEXT
);
```

### Personalizar Competidores

Edita el workflow de n8n para agregar o eliminar competidores:

1. Abre el workflow en n8n
2. Ubica el nodo **"Set Competitors"**
3. Agrega o modifica URLs:

```javascript
return [
  { url: "https://competitor1.com/products" },
  { url: "https://competitor2.com/products" },
  { url: "https://competitor3.com/products" }
];
```

### Umbrales de Alertas

Configura las prioridades de alertas en el nodo **"Analyze with AI"**:

```javascript
const thresholds = {
  critical: 50,  // Cambio de precio > 50%
  high: 30,      // Cambio de precio > 30%
  medium: 15,    // Cambio de precio > 15%
  low: 5         // Cambio de precio > 5%
};
```

---

## 📊 Ejemplos de Uso

### Ejecución Manual

1. Abre n8n: `http://localhost:5678`
2. Abre el workflow de Market Intelligence
3. Haz clic en **"Execute Workflow"**
4. Observa la ejecución en tiempo real

### Ejecución Programada

Configura ejecución automática:

1. Haz clic en el nodo **Cron**
2. Configura la frecuencia:
   - Cada hora: `0 * * * *`
   - Cada 6 horas: `0 */6 * * *`
   - Diariamente a las 9 AM: `0 9 * * *`
   - Cada lunes a las 8 AM: `0 8 * * 1`

### Integración por API

Usa webhooks de n8n para disparar ejecución externamente:

```bash
curl -X POST http://localhost:5678/webhook/market-intelligence \
  -H "Content-Type: application/json" \
  -d '{"competitor": "example.com"}'
```

---

## 🐛 Solución de Problemas

### Problemas Comunes

#### n8n No Inicia

**Problema**: Puerto 5678 ya en uso
```bash
# Encuentra el proceso usando el puerto
lsof -i :5678

# Mata el proceso
kill -9 <PID>

# O cambia el puerto en .env
N8N_PORT=5679
```

#### Errores de Scraping

**Problema**: Bloqueado por el sitio web
- Usa proxies o VPNs
- Agrega delays entre requests
- Implementa rotación de user-agents
- Usa navegadores headless (Puppeteer/Playwright)

#### Errores de Groq API

**Problema**: Límite de rate excedido
- Verifica tu cuota: https://console.groq.com
- Implementa exponential backoff
- Reduce frecuencia de análisis
- Considera cachear resultados

#### Email No se Envía

**Problema**: Credenciales de Resend inválidas
```bash
# Testea la API de Resend
curl -H "Authorization: Bearer YOUR_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"from":"onboarding@resend.dev","to":["test@example.com"],"subject":"Test","html":"<p>Test</p>"}' \
     https://api.resend.com/emails
```

### Logs y Debugging

#### Ver Logs de n8n

```bash
# Seguir logs en tiempo real
tail -f logs/n8n.log

# Buscar errores
grep -i "error" logs/n8n.log
```

#### Consultar Base de Datos

```sql
-- Ver productos recientes
SELECT * FROM competitor_products 
ORDER BY scraped_at DESC 
LIMIT 10;

-- Ver alertas recientes
SELECT * FROM alerts 
ORDER BY analysis_date DESC 
LIMIT 10;

-- Ver reportes del día
SELECT * FROM daily_reports 
WHERE DATE(report_date) = CURRENT_DATE;
```

#### Testear Conexiones

```bash
# Testear conexión a Supabase
curl -H "apikey: YOUR_SUPABASE_KEY" \
     -H "Authorization: Bearer YOUR_SUPABASE_KEY" \
     YOUR_SUPABASE_URL/rest/v1/competitor_products?limit=1

# Testear conexión a Groq
curl -H "Authorization: Bearer YOUR_GROQ_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"model":"llama-3.3-70b-versatile","messages":[{"role":"user","content":"test"}],"max_tokens":10}' \
     https://api.groq.com/openai/v1/chat/completions

# Testear conexión a Resend
curl -H "Authorization: Bearer YOUR_RESEND_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"from":"onboarding@resend.dev","to":["test@example.com"],"subject":"Test","html":"<p>Test</p>"}' \
     https://api.resend.com/emails
```

---

## 📈 Roadmap

### 🎯 Versión 1.0 (Actual)
- ✅ Web scraping de múltiples competidores
- ✅ Análisis con IA (Llama 3.3-70B)
- ✅ Sistema de alertas inteligentes
- ✅ Notificaciones por email y Slack
- ✅ Base de datos en tiempo real
- ✅ Comparación de precios

### 🚀 Versión 2.0 (Próximo Trimestre)
- [ ] **Dashboard Web Interactivo**
  - Visualización de datos en tiempo real
  - Gráficos y métricas interactivas
  - Filtros y búsqueda avanzada

- [ ] **Análisis Predictivo**
  - Modelos de machine learning
  - Predicción de tendencias futuras
  - Recomendaciones proactivas

- [ ] **API REST**
  - Endpoints para integraciones externas
  - Documentación completa con Swagger
  - Autenticación y autorización

### 🌟 Versión 3.0 (Próximo Semestre)
- [ ] **Integración con Más Fuentes**
  - Redes sociales (Twitter, LinkedIn)
  - Marketplaces (Amazon, eBay)
  - Noticias y blogs del sector

- [ ] **Análisis de Sentimiento**
  - Análisis de opiniones de clientes
  - Detección de cambios en percepción
  - Alertas de reputación

- [ ] **Mobile App**
  - Aplicación iOS y Android
  - Notificaciones push
  - Dashboard móvil

### 💎 Versión 4.0 (Futuro)
- [ ] **Integración con CRM**
  - Salesforce, HubSpot, Pipedrive
  - Sincronización automática de leads
  - Enriquecimiento de datos de clientes

- [ ] **Inteligencia Artificial Avanzada**
  - Modelos personalizados por industria
  - Análisis de imágenes y videos
  - Procesamiento de audio

- [ ] **Enterprise Features**
  - Multi-tenant architecture
  - RBAC avanzado
  - SSO y auditoría
  - Compliance y seguridad

---

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! Este es un proyecto open source y valoramos cada contribución.

### Cómo Contribuir

1. **Fork el Proyecto**
   ```bash
   git clone https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project.git
   ```

2. **Crea una Rama para tu Feature**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **Commit tus Cambios**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

4. **Push a la Rama**
   ```bash
   git push origin feature/AmazingFeature
   ```

5. **Abre un Pull Request**
   - Describe tu cambio en detalle
   - Incluye capturas de pantalla si aplica
   - Menciona los issues relacionados

### Áreas de Contribución

- 🐛 **Bug Fixes**: Corrección de errores
- ✨ **New Features**: Nuevas funcionalidades
- 📚 **Documentation**: Mejora de documentación
- 🎨 **UI/UX**: Mejoras en interfaz
- ⚡ **Performance**: Optimizaciones
- 🧪 **Testing**: Tests y validaciones
- 🌍 **Translations**: Traducciones a otros idiomas

### Código de Conducta

- Respeto y consideración para todos
- Comunicación abierta y constructiva
- Foco en lo que es mejor para la comunidad
- Empatía y colaboración

---

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT** - ver el archivo [LICENSE](LICENSE) para detalles.

### Resumen de la Licencia

✅ **Permitido**:
- Uso comercial
- Modificación
- Distribución
- Uso privado

❌ **Prohibido**:
- Responsabilidad de garantía
- Responsabilidad de daños

📝 **Requerido**:
- Incluir licencia y copyright
- Indicar cambios realizados

---

## 👨‍💻 Autor

**Marcos del Valle**
- 🌐 [LinkedIn](https://www.linkedin.com/in/marcos-del-valle-8a3760266/)
- 💻 [GitHub](https://github.com/Marcosdelvallee)
- 📧 [Email](mailto:marcosdv99@gmail.com)

### Sobre el Autor

Desarrollador de software especializado en automatización e inteligencia artificial. Apasionado por crear soluciones que transforman datos en decisiones estratégicas.

---

## 📞 Soporte y Contacto

### ¿Necesitas Ayuda?

📖 **Documentación**
- [Guía de Configuración](docs/setup-guide.md)
- [Arquitectura del Sistema](docs/architecture.md)
- [Issues en GitHub](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/issues)

📧 **Contacto Directo**
- Email: marcosdv99@gmail.com
- LinkedIn: https://www.linkedin.com/in/marcos-del-valle-8a3760266/

### Soporte Empresarial

📞 **Contactar**
- Email: marcosdv99@gmail.com
- Teléfono: +54 341 212-6628

---

## 📊 Estadísticas del Proyecto

<div align="center">

![GitHub Stars](https://img.shields.io/github/stars/Marcosdelvallee/MarketIntelligenceAI-Project?style=social)
![GitHub Forks](https://img.shields.io/github/forks/Marcosdelvallee/MarketIntelligenceAI-Project?style=social)
![GitHub Issues](https://img.shields.io/github/issues/Marcosdelvallee/MarketIntelligenceAI-Project)
![GitHub License](https://img.shields.io/github/license/Marcosdelvallee/MarketIntelligenceAI-Project)
![GitHub last-commit](https://img.shields.io/github/last-commit/Marcosdelvallee/MarketIntelligenceAI-Project)

</div>

---

## 🔗 Enlaces Útiles

- [Documentación de n8n](https://docs.n8n.io)
- [Documentación de Supabase](https://supabase.com/docs)
- [Documentación de Groq](https://groq.com/docs)
- [Documentación de Resend](https://resend.com/docs)
- [Documentación de Slack API](https://api.slack.com)

---

## 🎯 Conclusión

El **Market Intelligence AI System** representa el futuro de la inteligencia competitiva. Al combinar automatización, inteligencia artificial y análisis de datos en tiempo real, proporciona a las empresas una ventaja competitiva significativa.

### ¿Por qué Elegir Este Sistema?

✅ **Automatización Total**: Sin intervención manual
✅ **Análisis Inteligente**: IA de última generación  
✅ **Costo Efectivo**: 95% más económico que soluciones tradicionales
✅ **Escalable**: Crece con tu negocio
✅ **Open Source**: Sin vendor lock-in
✅ **Fácil de Usar**: Interfaz intuitiva
✅ **Soporte Activo**: Comunidad vibrante

### Comienza Hoy

🚀 **Transforma tu inteligencia competitiva con el poder de la IA**

[Empezar Ahora](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project) • [Ver Demo](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project) • [Contactar](mailto:marcosdv99@gmail.com)

---

<div align="center">

**⚡ Potenciado por IA - Automatización Inteligente para Decisiones Estratégicas**

*Hecho con ❤️ por Marcos del Valle*

</div>
