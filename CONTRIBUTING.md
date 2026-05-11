# 🤝 Contribuyendo a Market Intelligence AI System

¡Gracias por tu interés en contribuir al **Market Intelligence AI System**! Valoramos cada contribución, ya sea una corrección de errores, una nueva funcionalidad, mejora de documentación, o simplemente reportar un problema.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Cómo Contribuir](#cómo-contribuir)
- [Proceso de Desarrollo](#proceso-de-desarrollo)
- [Reportar Bugs](#reportar-bugs)
- [Sugerir Funcionalidades](#sugerir-funcionalidades)
- [Pull Requests](#pull-requests)
- [Estándares de Código](#estándares-de-código)
- [Documentación](#documentación)
- [Preguntas Frecuentes](#preguntas-frecuentes)

## 🌟 Código de Conducta

### Nuestros Compromisos

Para hacer que este proyecto sea un lugar acogedor para todos, nos comprometemos a:

- Respetar a todos los participantes, independientemente de su experiencia, género, identidad, orientación sexual, discapacidad, apariencia personal, tamaño corporal, raza, etnia, edad, religión o nacionalidad.
- Actuar con consideración y respeto en todas las interacciones.
- Comunicarnos de manera constructiva y profesional.
- Ser abiertos a diferentes perspectivas y opiniones.
- Aceptar críticas constructivas y aprender de ellas.
- Centrarnos en lo que es mejor para la comunidad.
- Mostrar empatía hacia otros miembros de la comunidad.

### Nuestros Estándares

Ejemplos de comportamiento que contribuimos a crear un ambiente positivo:

- Usar lenguaje bienvenida e inclusivo
- Respetar diferentes puntos de vista y experiencias
- Aceptar con gracia críticas constructivas
- Centrarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros de la comunidad

Ejemplos de comportamiento inaceptable:

- Uso de lenguaje sexualizado o imágenes no solicitadas
- Ataques personales o políticos
- Acoso o comportamiento intimidatorio
- Publicación de información privada de otros sin permiso
- Otra conducta no profesional o inapropiada

## 🚀 Cómo Contribuir

### 1. Elige un Área de Contribución

Hay muchas formas de contribuir al proyecto:

- 🐛 **Reportar bugs**: Ayuda a identificar y corregir errores
- ✨ **Nuevas funcionalidades**: Sugiere o implementa nuevas características
- 📚 **Documentación**: Mejora la documentación existente
- 🎨 **Diseño**: Mejora la interfaz o experiencia de usuario
- 🧪 **Testing**: Escribe tests para mejorar la cobertura
- 🌍 **Traducciones**: Traduce el proyecto a otros idiomas
- 💡 **Ideas**: Comparte ideas para mejorar el proyecto

### 2. Busca Issues Abiertos

Revisa los [issues abiertos](https://github.com/tu-usuario/MarketIntelligenceAI-Project/issues) para encontrar áreas donde necesitas ayuda:

- **good first issue**: Issues buenos para principiantes
- **help wanted**: Issues donde se necesita ayuda adicional
- **bug**: Reportes de errores que necesitan ser corregidos
- **enhancement**: Sugerencias de mejoras

### 3. Comunícate

Antes de comenzar a trabajar en una contribución significativa:

- Abre un issue para discutir el cambio que planeas hacer
- Comenta en issues existentes para expresar tu interés
- Únete a nuestras discusiones para obtener feedback

## 🔄 Proceso de Desarrollo

### Fork y Clona el Repositorio

```bash
# 1. Fork el repositorio en GitHub
# 2. Clona tu fork
git clone https://github.com/tu-usuario/MarketIntelligenceAI-Project.git

# 3. Navega al directorio del proyecto
cd MarketIntelligenceAI-Project

# 4. Agrega el repositorio original como upstream
git remote add upstream https://github.com/tu-usuario-original/MarketIntelligenceAI-Project.git
```

### Crea una Rama

```bash
# Crea una nueva rama para tu contribución
git checkout -b feature/tu-nueva-funcionalidad

# O para corrección de bugs
git checkout -b fix/tu-correccion-de-bug

# O para documentación
git checkout -b docs/tu-mejora-de-documentacion
```

### Haz tus Cambios

```bash
# Realiza tus cambios
# Edita archivos, agrega funcionalidad, etc.

# Verifica los cambios
git status

# Agrega los archivos modificados
git add .

# Commit tus cambios con un mensaje claro
git commit -m "Add: descripción clara de tu cambio"
```

### Sincroniza con Upstream

```bash
# Trae los cambios más recientes del repositorio original
git fetch upstream

# Rebase tu rama con la rama principal
git rebase upstream/main
```

### Push y Crea Pull Request

```bash
# Push tus cambios a tu fork
git push origin feature/tu-nueva-funcionalidad
```

Luego ve a GitHub y crea un Pull Request.

## 🐛 Reportar Bugs

### Antes de Reportar un Bug

1. **Busca issues existentes**: Revisa si alguien ya ha reportado el mismo problema
2. **Verifica si está resuelto**: Mira en la rama `main` o en releases recientes
3. **Reproduce el bug**: Asegúrate de poder reproducir el problema consistentemente

### Cómo Reportar un Bug

Usa el template de bug report al crear un issue:

```markdown
**Descripción del Bug**
Una descripción clara y concisa de qué es el bug.

**Pasos para Reproducir**
1. Ve a '...'
2. Haz clic en '....'
3. Desplázate hasta '....'
4. Ve el error

**Comportamiento Esperado**
Una descripción de lo que esperabas que sucediera.

**Comportamiento Actual**
Una descripción de lo que realmente sucedió.

**Capturas de Pantalla**
Si es aplicable, agrega capturas de pantalla para ayudar a explicar tu problema.

**Entorno**
- OS: [ej: Windows 10, macOS 12.0, Ubuntu 20.04]
- Node.js versión: [ej: 18.0.0]
- n8n versión: [ej: 1.0.0]
- Navegador: [ej: Chrome 100, Firefox 99]

**Logs Adicionales**
Agrega logs, errores de consola, o cualquier otra información relevante.

**Contexto Adicional**
Agrega cualquier otro contexto sobre el problema aquí.
```

## 💡 Sugerir Funcionalidades

### Antes de Sugerir una Funcionalidad

1. **Busca funcionalidades existentes**: Revisa si ya existe algo similar
2. **Considera el alcance**: ¿Es esta funcionalidad alineada con los objetivos del proyecto?
3. **Piensa en los usuarios**: ¿Cómo beneficiará esto a los usuarios?

### Cómo Sugerir una Funcionalidad

Usa el template de feature request:

```markdown
**Descripción de la Funcionalidad**
Una descripción clara y concisa de la funcionalidad que propones.

**Problema que Soluciona**
¿Qué problema resuelve esta funcionalidad? ¿Por qué es necesaria?

**Solución Propuesta**
Describe tu solución en detalle. Incluye:

- Cómo funcionaría
- Cómo se integraría con el sistema existente
- Cualquier consideración técnica importante

**Alternativas Consideradas**
Describe cualquier solución alternativa que hayas considerado.

**Impacto en Usuarios**
¿Cómo afectará esto a los usuarios existentes? ¿Necesitarán cambiar algo?

**Riesgos y Desafíos**
¿Qué riesgos o desafíos anticipas con esta implementación?

**Contexto Adicional**
Agrega cualquier otro contexto, capturas de pantalla, o ejemplos.
```

## 📤 Pull Requests

### Antes de Crear un Pull Request

1. **Revisa las guías de contribución**: Asegúrate de seguir los estándares del proyecto
2. **Actualiza tu rama**: Sincroniza con la rama principal más reciente
3. **Escribe tests**: Asegúrate de que tus cambios estén bien testeados
4. **Actualiza la documentación**: Documenta cualquier cambio en la API o funcionalidad

### Cómo Crear un Pull Request

1. Ve a la página de tu fork en GitHub
2. Haz clic en "New Pull Request"
3. Selecciona tu rama
4. Completa el template de PR con:
   - Título descriptivo
   - Descripción detallada de los cambios
   - Referencias a issues relacionados
   - Capturas de pantalla si aplica
5. Haz clic en "Create Pull Request"

### Revisión de Pull Requests

- Sé paciente: Las revisiones pueden tomar tiempo
- Responde a comentarios: Mantén una comunicación abierta
- Haz cambios solicitados: Implementa el feedback de los revisores
- Sé constructivo: Mantén una actitud positiva y colaborativa

## 📐 Estándares de Código

### JavaScript/TypeScript

```javascript
// ✅ Buen ejemplo
async function fetchCompetitorData(url) {
  try {
    const response = await fetch(url);
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching competitor data:', error);
    throw error;
  }
}

// ❌ Mal ejemplo
async function fetch(url) {
  const r = await fetch(url);
  return r.json();
}
```

### Nombres de Variables y Funciones

- Usa nombres descriptivos y claros
- Usa camelCase para variables y funciones
- Usa PascalCase para clases y constructores
- Usa UPPER_CASE para constantes

```javascript
// ✅ Buen ejemplo
const competitorProducts = [];
const MAX_RETRIES = 3;
class ProductScraper { }

// ❌ Mal ejemplo
const cp = [];
const max = 3;
class ps { }
```

### Comentarios

- Comenta el "por qué", no el "qué"
- Usa comentarios para explicar lógica compleja
- Mantén los comentarios actualizados

```javascript
// ✅ Buen ejemplo
// Retry exponential backoff to handle temporary network failures
const retryDelay = Math.pow(2, attemptCount) * 1000;

// ❌ Mal ejemplo
// Set delay
const delay = 1000;
```

### Formato

- Usa 2 espacios para indentación
- Usa comillas simples para strings
- Usa punto y coma al final de statements
- Usa espacios alrededor de operadores

```javascript
// ✅ Buen ejemplo
const result = calculateTotal(price, quantity);

// ❌ Mal ejemplo
const result=calculateTotal(price,quantity);
```

## 📚 Documentación

### Actualizar la Documentación

Cuando hagas cambios que afectan a los usuarios:

1. **README.md**: Actualiza si cambian características principales
2. **docs/**: Actualiza o agrega documentación técnica
3. **CHANGELOG.md**: Agrega entrada para el nuevo release
4. **Comentarios de código**: Actualiza comentarios en el código

### Estilo de Documentación

- Usa lenguaje claro y conciso
- Incluye ejemplos de código
- Agrega capturas de pantalla cuando sea útil
- Mantén la documentación actualizada

### Ejemplo de Documentación de Función

```javascript
/**
 * Fetches competitor product data from a given URL
 * 
 * @param {string} url - The URL to fetch data from
 * @param {Object} options - Configuration options
 * @param {number} options.timeout - Request timeout in milliseconds
 * @param {number} options.retries - Number of retry attempts
 * @returns {Promise<Array>} Array of competitor products
 * @throws {Error} If request fails after all retries
 * 
 * @example
 * const products = await fetchCompetitorData('https://example.com/products', {
 *   timeout: 5000,
 *   retries: 3
 * });
 */
async function fetchCompetitorData(url, options = {}) {
  // Implementation
}
```

## ❓ Preguntas Frecuentes

### ¿Necesito firmar un CLA?

No, actualmente no requerimos un Contributor License Agreement (CLA).

### ¿Puedo contribuir si soy nuevo en desarrollo?

¡Absolutamente! Bienvenemos a contribuidores de todos los niveles. Mira los issues etiquetados como `good first issue` para comenzar.

### ¿Cómo puedo obtener ayuda?

- Abre un issue con la etiqueta `question`
- Únete a nuestras discusiones en GitHub
- Contacta a los mantenedores del proyecto

### ¿Qué pasa si mi PR es rechazado?

No te desanimes. Usa el feedback para mejorar tu contribución y vuelve a intentarlo. Aprendemos de cada intento.

### ¿Puedo sugerir cambios mayores?

Sí, pero primero abre una issue para discutir el cambio antes de comenzar a trabajar en él. Esto ayuda a asegurar que tu esfuerzo se alinee con las metas del proyecto.

## 🎖️ Reconocimiento de Contribuidores

Agradecemos a todos los contribuidores. Sus nombres se agregarán a:

- Lista de contribuidores en el README
- CHANGELOG.md para cada release
- Sección especial de agradecimientos

## 📞 Contacto

Si tienes preguntas sobre cómo contribuir:

- Abre un issue con la etiqueta `question`
- Contacta a los mantenedores del proyecto
- Únete a nuestras discusiones en GitHub

## 🙏 Gracias por Contribuir

Tu contribución ayuda a hacer que el **Market Intelligence AI System** sea mejor para todos. ¡Gracias por tu tiempo y esfuerzo!

---

**Última actualización:** Mayo 2026

**Versión:** 1.0.0