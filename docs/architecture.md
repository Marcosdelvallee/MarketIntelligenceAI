# 🏗️ Arquitectura del Sistema

## Visión General

El **Market Intelligence AI System** es una arquitectura de procesamiento de datos en tiempo real de nivel empresarial que combina web scraping, análisis con inteligencia artificial, y notificaciones automáticas para proporcionar inteligencia de mercado competitiva de alta calidad.

### Arquitectura de Alto Nivel

```
┌─────────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Email UI   │  │  Slack UI    │  │  Dashboard   │          │
│  │   (Resend)   │  │  (Webhook)   │  │   (Future)   │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ORCHESTRATION LAYER                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    n8n Workflow Engine                     │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │  │
│  │  │ Trigger  │  │  Logic   │  │  Transform│  │  Action  │  │  │
│  │  │  Nodes   │  │  Nodes   │  │  Nodes   │  │  Nodes   │  │  │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘  │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PROCESSING LAYER                             │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐  │
│  │  Data Processing │  │  AI Analysis     │  │  Alert Logic │  │
│  │  (JavaScript)   │  │  (Groq API)      │  │  (Priority)   │  │
│  └──────────────────┘  └──────────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    INTEGRATION LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  HTTP APIs   │  │  Webhooks    │  │  REST APIs   │          │
│  │  (External)  │  │  (Slack)     │  │  (Supabase)  │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    DATA LAYER                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              Supabase PostgreSQL Database                │  │
│  │  ┌──────────────────┐  ┌──────────────────┐            │  │
│  │  │ competitor_products│  │      alerts      │            │  │
│  │  └──────────────────┘  └──────────────────┘            │  │
│  │  ┌──────────────────┐  ┌──────────────────┐            │  │
│  │  │   daily_reports  │  │   (Future)       │            │  │
│  │  └──────────────────┘  └──────────────────┘            │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Componentes Principales

### 1. Capa de Adquisición de Datos

#### Web Scraping Nodes

**Responsabilidades:**
- Extracción de datos de múltiples competidores simultáneamente
- Manejo de errores y reintentos automáticos
- Normalización de datos de diferentes fuentes
- Programación flexible de frecuencias de scraping

**Componentes:**
```
┌─────────────────────────────────────────────────────────┐
│              Web Scraping Subsystem                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ Competitor 1 │  │ Competitor 2 │  │ Competitor N │  │
│  │   Scraper    │  │   Scraper    │  │   Scraper    │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│         │                 │                 │            │
│         └─────────────────┴─────────────────┘            │
│                           │                                 │
│                   ┌───────────────┐                       │
│                   │ Data Processing│                       │
│                   │    Node       │                       │
│                   └───────────────┘                       │
└─────────────────────────────────────────────────────────┘
```

**Tecnologías:**
- HTTP Request Nodes de n8n
- JavaScript Code Nodes para transformación
- Manejo de errores con reintentos exponenciales
- Rate limiting para evitar bloqueos

**Flujo de Datos:**
```javascript
// Input: URLs de competidores
const competitorUrls = [
  'https://competitor1.com/products',
  'https://competitor2.com/products',
  // ...
];

// Process: HTTP Requests
const responses = await Promise.all(
  competitorUrls.map(url => fetch(url))
);

// Transform: Normalize data
const normalizedData = responses.map(response => ({
  name: extractName(response),
  price: extractPrice(response),
  category: extractCategory(response),
  competitor_id: identifyCompetitor(url),
  url: extractProductUrl(response),
  scraped_at: new Date().toISOString()
}));

// Output: Structured data
return normalizedData;
```

### 2. Capa de Almacenamiento

#### Supabase Integration

**Responsabilidades:**
- Almacenamiento persistente de datos
- Consultas optimizadas y eficientes
- Manejo de transacciones
- Backup y recuperación de datos

**Esquema de Base de Datos:**

```sql
-- Tabla de productos de competidores
CREATE TABLE competitor_products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category TEXT,
  competitor_id TEXT NOT NULL,
  url TEXT,
  scraped_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Índices para optimización
  INDEX idx_competitor_id (competitor_id),
  INDEX idx_scraped_at (scraped_at),
  INDEX idx_category (category),
  INDEX idx_competitor_date (competitor_id, scraped_at)
);

-- Tabla de alertas
CREATE TABLE alerts (
  id SERIAL PRIMARY KEY,
  priority TEXT NOT NULL CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  message TEXT NOT NULL,
  analysis_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Índices para optimización
  INDEX idx_priority (priority),
  INDEX idx_analysis_date (analysis_date),
  INDEX idx_priority_date (priority, analysis_date)
);

-- Tabla de reportes diarios
CREATE TABLE daily_reports (
  id SERIAL PRIMARY KEY,
  summary TEXT,
  trends JSONB,
  opportunities JSONB,
  threats JSONB,
  recommendations JSONB,
  price_changes JSONB,
  alerts JSONB,
  report_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Índices para optimización
  INDEX idx_report_date (report_date)
);
```

**Operaciones CRUD:**

```javascript
// CREATE - Insertar productos
const insertProducts = async (products) => {
  const response = await fetch(
    `${SUPABASE_URL}/rest/v1/competitor_products`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`
      },
      body: JSON.stringify(products)
    }
  );
  return response.json();
};

// READ - Obtener productos recientes
const getRecentProducts = async (limit = 100) => {
  const response = await fetch(
    `${SUPABASE_URL}/rest/v1/competitor_products?order=scraped_at.desc&limit=${limit}`,
    {
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`
      }
    }
  );
  return response.json();
};

// UPDATE - Actualizar producto
const updateProduct = async (id, data) => {
  const response = await fetch(
    `${SUPABASE_URL}/rest/v1/competitor_products?id=eq.${id}`,
    {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`
      },
      body: JSON.stringify(data)
    }
  );
  return response.json();
};

// DELETE - Eliminar productos antiguos
const deleteOldProducts = async (days = 30) => {
  const cutoffDate = new Date();
  cutoffDate.setDate(cutoffDate.getDate() - days);
  
  const response = await fetch(
    `${SUPABASE_URL}/rest/v1/competitor_products?scraped_at=lt.${cutoffDate.toISOString()}`,
    {
      method: 'DELETE',
      headers: {
        'apikey': SUPABASE_KEY,
        'Authorization': `Bearer ${SUPABASE_KEY}`
      }
    }
  );
  return response.json();
};
```

**Tecnologías:**
- Supabase REST API
- PostgreSQL como motor de base de datos
- HTTP Request Nodes para operaciones CRUD
- JSONB para datos estructurados complejos

### 3. Capa de Procesamiento con IA

#### Groq API Integration

**Responsabilidades:**
- Procesamiento de lenguaje natural
- Análisis de tendencias y patrones
- Generación de insights y recomendaciones
- Clasificación de prioridades

**Arquitectura de IA:**

```
┌─────────────────────────────────────────────────────────┐
│              AI Processing Subsystem                      │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Input Data Preparation                   │  │
│  │  - Data normalization                             │  │
│  │  - Feature extraction                             │  │
│  │  - Context building                                │  │
│  └──────────────────────────────────────────────────┘  │
│                         │                                 │
│                         ▼                                 │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Groq API Integration                      │  │
│  │  - Llama 3.3-70B-versatile model                  │  │
│  │  - Prompt engineering                              │  │
│  │  - Response parsing                                │  │
│  └──────────────────────────────────────────────────┘  │
│                         │                                 │
│                         ▼                                 │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Output Processing                         │  │
│  │  - Structured data extraction                      │  │
│  │  - Confidence scoring                              │  │
│  │  - Quality validation                              │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

**Prompt Engineering:**

```javascript
const generateAnalysisPrompt = (data) => {
  return `
Analiza los siguientes datos de competidores y genera un reporte estratégico completo.

DATOS DE COMPETIDORES:
${JSON.stringify(data, null, 2)}

INSTRUCCIONES:
1. Identifica TENDENCIAS del mercado (mínimo 3)
2. Detecta OPORTUNIDADES estratégicas (mínimo 3)
3. Identifica AMENAZAS competitivas (mínimo 3)
4. Genera RECOMENDACIONES accionables (mínimo 3)

FORMATO DE RESPUESTA:
{
  "summary": "Resumen ejecutivo del análisis",
  "trends": [
    {"descripcion": "Descripción de la tendencia"},
    // ...
  ],
  "opportunities": [
    {"descripcion": "Descripción de la oportunidad"},
    // ...
  ],
  "threats": [
    {"descripcion": "Descripción de la amenaza"},
    // ...
  ],
  "recommendations": [
    {"descripcion": "Descripción de la recomendación"},
    // ...
  ]
}

IMPORTANTE:
- Sé específico y accionable
- Usa datos concretos del análisis
- Prioriza insights de alto valor
- Mantén un tono profesional
`;
};

// Llamada a la API
const analyzeWithGroq = async (data) => {
  const prompt = generateAnalysisPrompt(data);
  
  const response = await fetch('https://api.groq.com/openai/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${GROQ_API_KEY}`
    },
    body: JSON.stringify({
      model: 'llama-3.3-70b-versatile',
      messages: [
        {
          role: 'system',
          content: 'Eres un experto en inteligencia de mercado y análisis competitivo.'
        },
        {
          role: 'user',
          content: prompt
        }
      ],
      temperature: 0.7,
      max_tokens: 2000
    })
  });
  
  const result = await response.json();
  return JSON.parse(result.choices[0].message.content);
};
```

**Tecnologías:**
- Groq API (Llama 3.3-70B-versatile)
- Procesamiento de lenguaje natural
- Análisis de sentimiento
- Extracción de información estructurada

### 4. Capa de Lógica de Negocio

#### Alert Logic Node

**Responsabilidades:**
- Determinar prioridad de alertas
- Clasificar eventos por urgencia
- Generar mensajes de alerta
- Coordinar notificaciones

**Lógica de Priorización:**

```javascript
const determineAlertPriority = (analysisData) => {
  let priority = 'low';
  let score = 0;
  
  // Factores de prioridad
  const factors = {
    critical: {
      trends: 5,           // Muchas tendencias = crítico
      threats: 4,          // Amenazas detectadas
      priceChanges: 3,    // Cambios significativos de precio
      newCompetitors: 5   // Nuevos competidores
    },
    high: {
      trends: 3,
      threats: 2,
      priceChanges: 2,
      opportunities: 3
    },
    medium: {
      trends: 1,
      opportunities: 2,
      priceChanges: 1
    },
    low: {
      opportunities: 1
    }
  };
  
  // Calcular score
  if (analysisData.trends && analysisData.trends.length > 0) {
    score += factors.critical.trends * analysisData.trends.length;
  }
  
  if (analysisData.threats && analysisData.threats.length > 0) {
    score += factors.critical.threats * analysisData.threats.length;
  }
  
  if (analysisData.priceChanges && analysisData.priceChanges.length > 0) {
    score += factors.critical.priceChanges * analysisData.priceChanges.length;
  }
  
  if (analysisData.opportunities && analysisData.opportunities.length > 0) {
    score += factors.high.opportunities * analysisData.opportunities.length;
  }
  
  // Determinar prioridad basado en score
  if (score >= 15) {
    priority = 'critical';
  } else if (score >= 10) {
    priority = 'high';
  } else if (score >= 5) {
    priority = 'medium';
  } else {
    priority = 'low';
  }
  
  return {
    priority,
    score,
    factors: {
      trends: analysisData.trends?.length || 0,
      threats: analysisData.threats?.length || 0,
      opportunities: analysisData.opportunities?.length || 0,
      priceChanges: analysisData.priceChanges?.length || 0
    }
  };
};

// Generar mensaje de alerta
const generateAlertMessage = (analysisData, priority) => {
  const timestamp = new Date().toLocaleString();
  
  let message = `
🚨 MARKET INTELLIGENCE ALERT
⚡ Priority: ${priority.toUpperCase()}
📅 Date: ${timestamp}

`;
  
  if (analysisData.summary) {
    message += `📋 SUMMARY:\n${analysisData.summary}\n\n`;
  }
  
  if (analysisData.trends && analysisData.trends.length > 0) {
    message += `📈 TRENDS:\n`;
    analysisData.trends.forEach((trend, index) => {
      message += `${index + 1}. ${trend.descripcion || trend}\n`;
    });
    message += '\n';
  }
  
  if (analysisData.threats && analysisData.threats.length > 0) {
    message += `⚠️ THREATS:\n`;
    analysisData.threats.forEach((threat, index) => {
      message += `${index + 1}. ${threat.descripcion || threat}\n`;
    });
    message += '\n';
  }
  
  if (analysisData.opportunities && analysisData.opportunities.length > 0) {
    message += `💡 OPPORTUNITIES:\n`;
    analysisData.opportunities.forEach((opp, index) => {
      message += `${index + 1}. ${opp.descripcion || opp}\n`;
    });
    message += '\n';
  }
  
  if (analysisData.recommendations && analysisData.recommendations.length > 0) {
    message += `🎯 RECOMMENDATIONS:\n`;
    analysisData.recommendations.forEach((rec, index) => {
      message += `${index + 1}. ${rec.descripcion || rec}\n`;
    });
  }
  
  return message;
};
```

**Conditional Branching:**

```
┌─────────────────────────────────────────────────────────┐
│              Alert Logic Subsystem                        │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Priority Determination                   │  │
│  │  - Score calculation                              │  │
│  │  - Factor analysis                                │  │
│  │  - Priority assignment                            │  │
│  └──────────────────────────────────────────────────┘  │
│                         │                                 │
│                         ▼                                 │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Conditional Branching                    │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐        │  │
│  │  │ Critical │  │   High   │  │  Medium  │        │  │
│  │  │  Branch  │  │  Branch  │  │  Branch  │        │  │
│  │  └──────────┘  └──────────┘  └──────────┘        │  │
│  │       │              │              │            │  │
│  │       ▼              ▼              ▼            │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐        │  │
│  │  │  Slack   │  │  Email   │  │  Email   │        │  │
│  │  │ + Email  │  │  Alert   │  │  Alert   │        │  │
│  │  └──────────┘  └──────────┘  └──────────┘        │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### 5. Capa de Notificaciones

#### Email System (Resend)

**Responsabilidades:**
- Envío de emails transaccionales
- Generación de HTML profesional
- Manejo de plantillas
- Tracking de entregas

**Arquitectura de Email:**

```
┌─────────────────────────────────────────────────────────┐
│              Email Notification Subsystem                │
│  ┌──────────────────────────────────────────────────┐  │
│  │           HTML Generation                          │  │
│  │  - Template rendering                             │  │
│  │  - Dynamic content                                 │  │
│  │  - CSS styling                                     │  │
│  └──────────────────────────────────────────────────┘  │
│                         │                                 │
│                         ▼                                 │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Resend API Integration                  │  │
│  │  - Email sending                                  │  │
│  │  - Delivery tracking                              │  │
│  │  - Error handling                                 │  │
│  └──────────────────────────────────────────────────┘  │
│                         │                                 │
│                         ▼                                 │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Delivery & Tracking                      │  │
│  │  - Delivery confirmation                          │  │
│  │  - Open tracking                                  │  │
│  │  - Click tracking                                 │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

**HTML Email Template:**

```javascript
const generateHTMLEmail = (analysisData, priority) => {
  const priorityColors = {
    low: '#28a745',
    medium: '#ffc107',
    high: '#fd7e14',
    critical: '#dc3545'
  };
  
  const color = priorityColors[priority] || priorityColors.medium;
  
  return `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Market Intelligence Alert</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px 10px 0 0;
            text-align: center;
        }
        .priority-badge {
            display: inline-block;
            padding: 5px 15px;
            background: ${color};
            color: white;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .section {
            margin: 20px 0;
            padding: 15px;
            border-left: 4px solid #667eea;
            background: #f8f9fa;
        }
        .section h3 {
            margin-top: 0;
            color: #667eea;
        }
        .item {
            padding: 10px;
            margin: 5px 0;
            background: white;
            border-radius: 5px;
            border-left: 3px solid #ddd;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #666;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🤖 Market Intelligence Alert</h1>
            <div class="priority-badge">⚡ Priority: ${priority.toUpperCase()}</div>
        </div>
        
        ${analysisData.summary ? `
        <div class="section">
            <h3>📋 Summary</h3>
            <p>${analysisData.summary}</p>
        </div>
        ` : ''}
        
        ${analysisData.trends && analysisData.trends.length > 0 ? `
        <div class="section">
            <h3>📈 Trends</h3>
            ${analysisData.trends.map(trend => `
                <div class="item">
                    <strong>${trend.descripcion || trend}</strong>
                </div>
            `).join('')}
        </div>
        ` : ''}
        
        ${analysisData.threats && analysisData.threats.length > 0 ? `
        <div class="section">
            <h3>⚠️ Threats</h3>
            ${analysisData.threats.map(threat => `
                <div class="item">
                    <strong>${threat.descripcion || threat}</strong>
                </div>
            `).join('')}
        </div>
        ` : ''}
        
        ${analysisData.opportunities && analysisData.opportunities.length > 0 ? `
        <div class="section">
            <h3>💡 Opportunities</h3>
            ${analysisData.opportunities.map(opp => `
                <div class="item">
                    <strong>${opp.descripcion || opp}</strong>
                </div>
            `).join('')}
        </div>
        ` : ''}
        
        ${analysisData.recommendations && analysisData.recommendations.length > 0 ? `
        <div class="section">
            <h3>🎯 Recommendations</h3>
            ${analysisData.recommendations.map(rec => `
                <div class="item">
                    <strong>${rec.descripcion || rec}</strong>
                </div>
            `).join('')}
        </div>
        ` : ''}
        
        <div class="footer">
            <p>Generated by Market Intelligence AI System</p>
            <p>${new Date().toLocaleString()}</p>
        </div>
    </div>
</body>
</html>
  `;
};

// Enviar email
const sendEmailAlert = async (analysisData, priority) => {
  const html = generateHTMLEmail(analysisData, priority);
  
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${RESEND_API_KEY}`
    },
    body: JSON.stringify({
      from: 'onboarding@resend.dev',
      to: ['your-email@company.com'],
      subject: `🚨 Market Intelligence Alert - ${priority.toUpperCase()} Priority`,
      html: html
    })
  });
  
  return response.json();
};
```

#### Slack Integration

**Responsabilidades:**
- Envío de mensajes a Slack
- Formateo de mensajes
- Manejo de webhooks
- Confirmación de entrega

**Slack Message Format:**

```javascript
const generateSlackMessage = (analysisData, priority) => {
  const priorityEmojis = {
    low: '🟢',
    medium: '🟡',
    high: '🟠',
    critical: '🔴'
  };
  
  const emoji = priorityEmojis[priority] || '🟡';
  
  let message = {
    text: `${emoji} MARKET INTELLIGENCE ALERT - ${priority.toUpperCase()} PRIORITY`,
    blocks: [
      {
        type: 'header',
        text: {
          type: 'plain_text',
          text: `${emoji} Market Intelligence Alert`
        }
      },
      {
        type: 'section',
        fields: [
          {
            type: 'mrkdwn',
            text: `*Priority:*\n${priority.toUpperCase()}`
          },
          {
            type: 'mrkdwn',
            text: `*Time:*\n${new Date().toLocaleString()}`
          }
        ]
      }
    ]
  };
  
  // Add summary if available
  if (analysisData.summary) {
    message.blocks.push({
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: `*Summary:*\n${analysisData.summary}`
      }
    });
  }
  
  // Add trends if available
  if (analysisData.trends && analysisData.trends.length > 0) {
    const trendsText = analysisData.trends
      .map((trend, index) => `${index + 1}. ${trend.descripcion || trend}`)
      .join('\n');
    
    message.blocks.push({
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: `*📈 Trends:*\n${trendsText}`
      }
    });
  }
  
  // Add threats if available
  if (analysisData.threats && analysisData.threats.length > 0) {
    const threatsText = analysisData.threats
      .map((threat, index) => `${index + 1}. ${threat.descripcion || threat}`)
      .join('\n');
    
    message.blocks.push({
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: `*⚠️ Threats:*\n${threatsText}`
      }
    });
  }
  
  return message;
};

// Enviar a Slack
const sendSlackAlert = async (analysisData, priority) => {
  const message = generateSlackMessage(analysisData, priority);
  
  const response = await fetch(SLACK_WEBHOOK_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(message)
  });
  
  return response.json();
};
```

## Flujo de Datos Completo

```
┌─────────────────────────────────────────────────────────────────┐
│                    COMPLETE DATA FLOW                            │
└─────────────────────────────────────────────────────────────────┘

1. DATA ACQUISITION
   ┌──────────────┐
   │ Competitor 1 │──┐
   │   Scraper    │  │
   └──────────────┘  │
                    ├──►┌──────────────┐
   ┌──────────────┐  │   │ Data         │
   │ Competitor 2 │──┘   │ Processing   │
   │   Scraper    │      │   Node       │
   └──────────────┘      └──────┬───────┘
                                 │
                                 ▼
2. DATA STORAGE
                          ┌──────────────┐
                          │ Save to      │
                          │ Supabase     │
                          └──────┬───────┘
                                 │
                                 ▼
3. DATA RETRIEVAL
                          ┌──────────────┐
                          │ Get Latest   │
                          │ Data         │
                          └──────┬───────┘
                                 │
                                 ▼
4. AI ANALYSIS
                          ┌──────────────┐
                          │ Groq         │
                          │ Analysis     │
                          └──────┬───────┘
                                 │
                                 ▼
5. INSIGHT PROCESSING
                          ┌──────────────┐
                          │ Insight      │
                          │ Processing   │
                          └──────┬───────┘
                                 │
                                 ▼
6. PRICE COMPARISON
                          ┌──────────────┐
                          │ Price        │
                          │ Comparison   │
                          └──────┬───────┘
                                 │
                                 ▼
7. ALERT LOGIC
                          ┌──────────────┐
                          │ Alert        │
                          │ Logic        │
                          └──────┬───────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
8. NOTIFICATIONS
         ┌──────────────┐          ┌──────────────┐
         │ Send Email   │          │ Send Slack   │
         │ Alert        │          │ Alert        │
         └──────┬───────┘          └──────┬───────┘
                │                         │
                └────────────┬────────────┘
                             │
                             ▼
9. DATA PERSISTENCE
                          ┌──────────────┐
                          │ Save Alert   │
                          │ to Supabase  │
                          └──────────────┘
```

## Patrones de Diseño

### 1. Pipeline Pattern

Los datos fluyen a través de una serie de etapas de procesamiento, cada una transformando los datos para la siguiente etapa.

**Implementación:**
```javascript
class DataPipeline {
  constructor(stages) {
    this.stages = stages;
  }
  
  async execute(inputData) {
    let data = inputData;
    
    for (const stage of this.stages) {
      data = await stage.process(data);
    }
    
    return data;
  }
}

// Usage
const pipeline = new DataPipeline([
  new ScrapingStage(),
  new ProcessingStage(),
  new StorageStage(),
  new AnalysisStage(),
  new AlertStage()
]);

const result = await pipeline.execute(competitorUrls);
```

### 2. Strategy Pattern

Diferentes estrategias de notificación según la prioridad de la alerta.

**Implementación:**
```javascript
class NotificationStrategy {
  async send(alertData) {
    throw new Error('Must implement send method');
  }
}

class EmailNotificationStrategy extends NotificationStrategy {
  async send(alertData) {
    return await sendEmailAlert(alertData);
  }
}

class SlackNotificationStrategy extends NotificationStrategy {
  async send(alertData) {
    return await sendSlackAlert(alertData);
  }
}

class NotificationContext {
  constructor(strategy) {
    this.strategy = strategy;
  }
  
  setStrategy(strategy) {
    this.strategy = strategy;
  }
  
  async notify(alertData) {
    return await this.strategy.send(alertData);
  }
}

// Usage
const context = new NotificationContext(new EmailNotificationStrategy());

if (priority === 'critical') {
  context.setStrategy(new SlackNotificationStrategy());
  await context.notify(alertData);
}

await context.notify(alertData); // Always sends email
```

### 3. Observer Pattern

El sistema reacciona a cambios en los datos de competidores y genera alertas automáticamente.

**Implementación:**
```javascript
class DataObserver {
  constructor() {
    this.observers = [];
  }
  
  subscribe(observer) {
    this.observers.push(observer);
  }
  
  unsubscribe(observer) {
    this.observers = this.observers.filter(obs => obs !== observer);
  }
  
  async notify(data) {
    for (const observer of this.observers) {
      await observer.update(data);
    }
  }
}

class AlertObserver {
  async update(data) {
    const priority = determineAlertPriority(data);
    const message = generateAlertMessage(data, priority);
    
    if (priority === 'critical') {
      await sendSlackAlert(data, priority);
    }
    
    await sendEmailAlert(data, priority);
    await saveAlertToSupabase(message, priority);
  }
}

// Usage
const dataObserver = new DataObserver();
dataObserver.subscribe(new AlertObserver());

// When data changes
await dataObserver.notify(newData);
```

### 4. Repository Pattern

Abstracción de la capa de acceso a datos mediante Supabase REST API.

**Implementación:**
```javascript
class ProductRepository {
  constructor(supabaseUrl, supabaseKey) {
    this.baseUrl = supabaseUrl;
    this.apiKey = supabaseKey;
  }
  
  async findAll(options = {}) {
    const params = new URLSearchParams();
    
    if (options.limit) params.append('limit', options.limit);
    if (options.offset) params.append('offset', options.offset);
    if (options.order) params.append('order', options.order);
    
    const response = await fetch(
      `${this.baseUrl}/rest/v1/competitor_products?${params}`,
      {
        headers: {
          'apikey': this.apiKey,
          'Authorization': `Bearer ${this.apiKey}`
        }
      }
    );
    
    return response.json();
  }
  
  async findById(id) {
    const response = await fetch(
      `${this.baseUrl}/rest/v1/competitor_products?id=eq.${id}`,
      {
        headers: {
          'apikey': this.apiKey,
          'Authorization': `Bearer ${this.apiKey}`
        }
      }
    );
    
    const data = await response.json();
    return data[0];
  }
  
  async create(product) {
    const response = await fetch(
      `${this.baseUrl}/rest/v1/competitor_products`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'apikey': this.apiKey,
          'Authorization': `Bearer ${this.apiKey}`
        },
        body: JSON.stringify(product)
      }
    );
    
    return response.json();
  }
  
  async update(id, data) {
    const response = await fetch(
      `${this.baseUrl}/rest/v1/competitor_products?id=eq.${id}`,
      {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'apikey': this.apiKey,
          'Authorization': `Bearer ${this.apiKey}`
        },
        body: JSON.stringify(data)
      }
    );
    
    return response.json();
  }
  
  async delete(id) {
    const response = await fetch(
      `${this.baseUrl}/rest/v1/competitor_products?id=eq.${id}`,
      {
        method: 'DELETE',
        headers: {
          'apikey': this.apiKey,
          'Authorization': `Bearer ${this.apiKey}`
        }
      }
    );
    
    return response.json();
  }
}

// Usage
const productRepository = new ProductRepository(SUPABASE_URL, SUPABASE_KEY);

const products = await productRepository.findAll({ limit: 100 });
const product = await productRepository.findById(1);
const newProduct = await productRepository.create({ name: 'Product', price: 99.99 });
```

## Escalabilidad

### Horizontal Scaling

**Multiple n8n Instances:**
```bash
# Instance 1
N8N_PORT=5678 n8n start

# Instance 2
N8N_PORT=5679 n8n start

# Instance 3
N8N_PORT=5680 n8n start
```

**Load Balancing:**
```nginx
upstream n8n_backend {
    server localhost:5678;
    server localhost:5679;
    server localhost:5680;
}

server {
    listen 80;
    server_name market-intelligence.example.com;
    
    location / {
        proxy_pass http://n8n_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Vertical Scaling

**Database Optimization:**
```sql
-- Create indexes for frequently queried columns
CREATE INDEX idx_products_competitor_date 
ON competitor_products(competitor_id, scraped_at DESC);

CREATE INDEX idx_alerts_priority_date 
ON alerts(priority, analysis_date DESC);

-- Partition large tables
CREATE TABLE competitor_products_2026 PARTITION OF competitor_products
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Optimize queries with materialized views
CREATE MATERIALIZED VIEW latest_products AS
SELECT DISTINCT ON (competitor_id, name) *
FROM competitor_products
ORDER BY competitor_id, name, scraped_at DESC;

REFRESH MATERIALIZED VIEW latest_products;
```

**Connection Pooling:**
```javascript
// Configure connection pool in n8n
process.env.N8N_DB_POOL_SIZE = '20';
process.env.N8N_DB_POOL_MIN = '5';
```

### Queue System

**Redis Queue for Async Processing:**
```javascript
const Redis = require('ioredis');
const Queue = require('bull');

const redis = new Redis();
const analysisQueue = new Queue('market-intelligence', { redis });

// Add job to queue
await analysisQueue.add({
  type: 'analysis',
  data: competitorData
}, {
  attempts: 3,
  backoff: {
    type: 'exponential',
    delay: 2000
  }
});

// Process jobs
analysisQueue.process(async (job) => {
  const result = await analyzeWithGroq(job.data.data);
  return result;
});

// Handle completion
analysisQueue.on('completed', (job, result) => {
  console.log(`Job ${job.id} completed:`, result);
});

// Handle failure
analysisQueue.on('failed', (job, err) => {
  console.error(`Job ${job.id} failed:`, err);
});
```

## Seguridad

### Data Security

**Environment Variables:**
```bash
# Never commit .env file
.env
.env.local
.env.*.local

# Use .env.example as template
cp config/.env.example config/.env
```

**API Keys Management:**
```javascript
// Rotate API keys regularly
const rotateAPIKeys = async () => {
  const newKey = await generateNewAPIKey();
  await updateEnvironmentVariable('GROQ_API_KEY', newKey);
  await invalidateOldAPIKey(oldKey);
};

// Use short-lived tokens
const generateShortLivedToken = async () => {
  const token = await jwt.sign(
    { userId: 'user123' },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
  return token;
};
```

**HTTPS Encryption:**
```nginx
server {
    listen 443 ssl http2;
    server_name market-intelligence.example.com;
    
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    location / {
        proxy_pass http://n8n_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Access Control

**Role-Based Access Control (RBAC):**
```javascript
const roles = {
  admin: ['read', 'write', 'delete', 'manage'],
  analyst: ['read', 'write'],
  viewer: ['read']
};

const checkPermission = (userRole, requiredPermission) => {
  const userPermissions = roles[userRole] || [];
  return userPermissions.includes(requiredPermission);
};

// Middleware for n8n
const permissionMiddleware = (requiredPermission) => {
  return (req, res, next) => {
    const userRole = req.user.role;
    
    if (checkPermission(userRole, requiredPermission)) {
      next();
    } else {
      res.status(403).json({ error: 'Permission denied' });
    }
  };
};
```

**API Rate Limiting:**
```javascript
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', limiter);
```

## Monitoreo y Logging

### System Monitoring

**Workflow Execution Monitoring:**
```javascript
const monitorWorkflow = async (workflowId) => {
  const execution = await n8n.getExecution(workflowId);
  
  const metrics = {
    workflowId: execution.id,
    status: execution.status,
    duration: execution.finishedAt - execution.startedAt,
    nodesExecuted: execution.executionData.nodes.length,
    nodesFailed: execution.executionData.nodes.filter(
      node => node.executionStatus === 'error'
    ).length,
    dataProcessed: execution.executionData.resultData.length
  };
  
  // Send to monitoring system
  await sendToMonitoringSystem(metrics);
  
  return metrics;
};
```

**Error Tracking:**
```javascript
const trackError = async (error, context) => {
  const errorData = {
    message: error.message,
    stack: error.stack,
    context: context,
    timestamp: new Date().toISOString(),
    userId: context.userId,
    workflowId: context.workflowId
  };
  
  // Log to error tracking system
  await logToErrorTracking(errorData);
  
  // Send alert if critical
  if (error.severity === 'critical') {
    await sendCriticalAlert(errorData);
  }
};
```

**Performance Metrics:**
```javascript
const trackPerformance = async (operation, duration) => {
  const metrics = {
    operation: operation,
    duration: duration,
    timestamp: new Date().toISOString(),
    memoryUsage: process.memoryUsage(),
    cpuUsage: process.cpuUsage()
  };
  
  // Send to metrics system
  await sendToMetricsSystem(metrics);
  
  // Alert if slow
  if (duration > 5000) { // 5 seconds
    await sendPerformanceAlert(metrics);
  }
};
```

### Logging Strategy

**Structured Logs:**
```javascript
const logger = {
  info: (message, data = {}) => {
    console.log(JSON.stringify({
      level: 'info',
      timestamp: new Date().toISOString(),
      message: message,
      data: data
    }));
  },
  
  warn: (message, data = {}) => {
    console.warn(JSON.stringify({
      level: 'warn',
      timestamp: new Date().toISOString(),
      message: message,
      data: data
    }));
  },
  
  error: (message, data = {}) => {
    console.error(JSON.stringify({
      level: 'error',
      timestamp: new Date().toISOString(),
      message: message,
      data: data
    }));
  }
};

// Usage
logger.info('Workflow started', { workflowId: '123' });
logger.warn('Slow response', { duration: 8000 });
logger.error('API call failed', { error: 'Connection timeout' });
```

**Log Levels:**
```javascript
const LOG_LEVELS = {
  DEBUG: 0,
  INFO: 1,
  WARN: 2,
  ERROR: 3
};

const currentLogLevel = LOG_LEVELS.INFO;

const shouldLog = (level) => {
  return level >= currentLogLevel;
};

const log = (level, message, data) => {
  if (shouldLog(level)) {
    const logEntry = {
      level: Object.keys(LOG_LEVELS)[level],
      timestamp: new Date().toISOString(),
      message: message,
      data: data
    };
    
    console.log(JSON.stringify(logEntry));
  }
};
```

**Log Retention:**
```bash
# Rotate logs daily
0 0 * * * /usr/bin/logrotate /etc/logrotate.d/n8n

# Keep logs for 30 days
/var/log/n8n/*.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 0640 n8n n8n
}
```

## Optimizaciones

### Performance

**Parallel Processing:**
```javascript
const processCompetitorsInParallel = async (competitors) => {
  const results = await Promise.all(
    competitors.map(competitor => 
      scrapeCompetitor(competitor)
    )
  );
  
  return results;
};
```

**Batch Operations:**
```javascript
const batchInsert = async (products, batchSize = 100) => {
  const batches = [];
  
  for (let i = 0; i < products.length; i += batchSize) {
    batches.push(products.slice(i, i + batchSize));
  }
  
  for (const batch of batches) {
    await insertProducts(batch);
  }
};
```

**Caching:**
```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 600 }); // 10 minutes

const getCachedData = async (key) => {
  const cached = cache.get(key);
  
  if (cached) {
    return cached;
  }
  
  const data = await fetchDataFromAPI(key);
  cache.set(key, data);
  
  return data;
};
```

### Cost Optimization

**Groq API Usage:**
```javascript
const optimizeGroqUsage = async (data) => {
  // Batch similar requests
  const batches = groupSimilarData(data);
  
  // Use smaller model for simple tasks
  const model = data.length > 1000 
    ? 'llama-3.3-70b-versatile' 
    : 'llama-3.1-8b-instant';
  
  // Limit tokens
  const maxTokens = data.length > 500 ? 1000 : 2000;
  
  const result = await analyzeWithGroq(data, { model, maxTokens });
  return result;
};
```

**Supabase Optimization:**
```javascript
const optimizeSupabaseQueries = async () => {
  // Use specific columns instead of *
  const products = await supabase
    .from('competitor_products')
    .select('id, name, price')
    .limit(100);
  
  // Use indexes
  const recentProducts = await supabase
    .from('competitor_products')
    .select('*')
    .order('scraped_at', { ascending: false })
    .limit(50);
  
  // Use pagination
  const page1 = await supabase
    .from('competitor_products')
    .select('*')
    .range(0, 49);
  
  const page2 = await supabase
    .from('competitor_products')
    .select('*')
    .range(50, 99);
};
```

**Email Consolidation:**
```javascript
const consolidateEmails = async (alerts) => {
  // Group alerts by priority
  const grouped = groupBy(alerts, 'priority');
  
  // Send one email per priority
  for (const [priority, priorityAlerts] of Object.entries(grouped)) {
    const consolidatedAlert = {
      priority: priority,
      message: generateConsolidatedMessage(priorityAlerts),
      alerts: priorityAlerts
    };
    
    await sendEmailAlert(consolidatedAlert);
  }
};
```

## Disaster Recovery

### Backup Strategy

**Database Backups:**
```bash
# Daily backup
0 2 * * * pg_dump -U postgres -h db.supabase.co -d postgres > /backups/daily_$(date +\%Y\%m\%d).sql

# Weekly backup
0 3 * * 0 pg_dump -U postgres -h db.supabase.co -d postgres > /backups/weekly_$(date +\%Y\%m\%d).sql

# Monthly backup
0 4 1 * * pg_dump -U postgres -h db.supabase.co -d postgres > /backups/monthly_$(date +\%Y\%m).sql
```

**Workflow Export:**
```javascript
const exportWorkflows = async () => {
  const workflows = await n8n.getWorkflows();
  
  for (const workflow of workflows) {
    const workflowData = await n8n.getWorkflow(workflow.id);
    
    await fs.writeFile(
      `backups/workflows/${workflow.id}_${workflow.name}.json`,
      JSON.stringify(workflowData, null, 2)
    );
  }
};
```

**Configuration Backup:**
```bash
# Backup environment variables
cp config/.env backups/.env.$(date +\%Y\%m\%d)

# Backup n8n configuration
cp ~/.n8n/config backups/n8n_config.$(date +\%Y\%m\%d)
```

### Recovery Plan

**RTO (Recovery Time Objective): 4 horas**
**RPO (Recovery Point Objective): 24 horas**

**Recovery Steps:**
```bash
# 1. Restore database
psql -U postgres -h db.supabase.co -d postgres < /backups/latest_backup.sql

# 2. Restore workflows
for workflow in backups/workflows/*.json; do
  n8n import:workflow --input="$workflow"
done

# 3. Restore configuration
cp backups/.env.latest config/.env
cp backups/n8n_config.latest ~/.n8n/config

# 4. Restart services
systemctl restart n8n

# 5. Verify system
n8n health-check
```

**Failover:**
```nginx
# Primary server
upstream primary {
    server primary.example.com:5678;
}

# Backup server
upstream backup {
    server backup.example.com:5678;
}

# Automatic failover
server {
    listen 80;
    server_name market-intelligence.example.com;
    
    location / {
        proxy_pass http://primary;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_set_header Host $host;
    }
}
```

## Integraciones Futuras

### Planned Integrations

**Dashboard Web:**
```javascript
// React Dashboard
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Dashboard from './components/Dashboard';
import Analytics from './components/Analytics';
import Alerts from './components/Alerts';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/analytics" element={<Analytics />} />
        <Route path="/alerts" element={<Alerts />} />
      </Routes>
    </BrowserRouter>
  );
}
```

**Mobile App:**
```javascript
// React Native
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

const Tab = createBottomTabNavigator();

function App() {
  return (
    <NavigationContainer>
      <Tab.Navigator>
        <Tab.Screen name="Dashboard" component={Dashboard} />
        <Tab.Screen name="Alerts" component={Alerts} />
        <Tab.Screen name="Settings" component={Settings} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}
```

**API REST:**
```javascript
// Express.js API
const express = require('express');
const app = express();

app.get('/api/products', async (req, res) => {
  const products = await productRepository.findAll(req.query);
  res.json(products);
});

app.post('/api/products', async (req, res) => {
  const product = await productRepository.create(req.body);
  res.status(201).json(product);
});

app.get('/api/alerts', async (req, res) => {
  const alerts = await alertRepository.findAll(req.query);
  res.json(alerts);
});

app.listen(3000);
```

**Machine Learning:**
```python
# Python ML Model
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

# Load data
df = pd.read_csv('competitor_data.csv')

# Prepare features
X = df[['price', 'category', 'competitor_id']]
y = df['trend']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Train model
model = RandomForestClassifier()
model.fit(X_train, y_train)

# Predict
predictions = model.predict(X_test)
```

### Extension Points

**Custom Scrapers:**
```javascript
class CustomScraper {
  constructor(config) {
    this.config = config;
  }
  
  async scrape() {
    // Custom scraping logic
    const response = await fetch(this.config.url);
    const data = await this.parseResponse(response);
    return this.normalizeData(data);
  }
  
  parseResponse(response) {
    // Custom parsing logic
  }
  
  normalizeData(data) {
    // Custom normalization logic
  }
}

// Register custom scraper
const scraperRegistry = new ScraperRegistry();
scraperRegistry.register('custom', CustomScraper);
```

**Notification Channels:**
```javascript
class NotificationChannel {
  async send(alertData) {
    throw new Error('Must implement send method');
  }
}

class SMSNotificationChannel extends NotificationChannel {
  async send(alertData) {
    // SMS sending logic
  }
}

class PushNotificationChannel extends NotificationChannel {
  async send(alertData) {
    // Push notification logic
  }
}

// Register custom channels
const channelRegistry = new ChannelRegistry();
channelRegistry.register('sms', SMSNotificationChannel);
channelRegistry.register('push', PushNotificationChannel);
```

**Analysis Plugins:**
```javascript
class AnalysisPlugin {
  async analyze(data) {
    throw new Error('Must implement analyze method');
  }
}

class SentimentAnalysisPlugin extends AnalysisPlugin {
  async analyze(data) {
    // Sentiment analysis logic
  }
}

class PricePredictionPlugin extends AnalysisPlugin {
  async analyze(data) {
    // Price prediction logic
  }
}

// Register custom plugins
const pluginRegistry = new PluginRegistry();
pluginRegistry.register('sentiment', SentimentAnalysisPlugin);
pluginRegistry.register('price-prediction', PricePredictionPlugin);
```

---

**Última actualización:** Mayo 2026

**Versión:** 1.0.0

**Autor:** Market Intelligence AI Team