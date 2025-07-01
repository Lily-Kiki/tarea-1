# 🚀 SEMANA 2WEEK2025 - GUÍA COMPLETA DESDE CERO

## 📋 ¿Qué es 2week2025?

**2week2025** es un programa intensivo de aprendizaje PHP de **7 días** diseñado para llevarte desde cero hasta un nivel intermedio en desarrollo web con PHP. Cada día tiene ejercicios específicos que construyen conocimiento progresivamente.

## 🎯 Objetivos del Programa

✅ **Dominar formularios HTML** y su procesamiento en PHP
✅ **Aprender manejo de datos** (POST, GET, validación)
✅ **Implementar persistencia** con archivos de texto
✅ **Consumir APIs externas** y procesar JSON
✅ **Crear interfaces de usuario** funcionales
✅ **Desarrollar aplicaciones web completas**

## 📅 Cronograma de 7 Días

### **DÍA 1: Fundamentos** 🎲
- **Ejercicio**: Juego de adivinanza de números
- **Conceptos**: Formularios básicos, `$_POST`, `rand()`, condicionales
- **Archivos**: `01_adivina.html`, `01_adivina.php`

### **DÍA 2: Controles de Formulario** 🧮
- **Ejercicio**: Calculadora con checkboxes
- **Conceptos**: Checkboxes múltiples, `isset()`, operaciones matemáticas
- **Archivos**: `02_ej0002.html`, `02_ej0002.php`

### **DÍA 3: Radio Buttons y Arrays** 💰
- **Ejercicio**: Calculadora de intereses financieros
- **Conceptos**: Radio buttons, arrays asociativos, cálculos complejos
- **Archivos**: `03_ej3.html`, `03_ej3.php`

### **DÍA 4: Conversión de Datos** 💱
- **Ejercicio**: Conversor de monedas
- **Conceptos**: Tasas de cambio, formateo de números, validación avanzada
- **Archivos**: `04_Conversor.html`, `04_Conversor.php`

### **DÍA 5: Manejo de Archivos** 🗳️
- **Ejercicio**: Sistema de votación con persistencia
- **Conceptos**: `fopen()`, `fwrite()`, `fread()`, archivos de datos
- **Archivos**: `archivos/opcion.php`, `copa.php`, `result.dat`

### **DÍA 6: Utilidades del Sistema** 📅
- **Ejercicio**: Manejo de fechas y strings en español
- **Conceptos**: `date()`, arrays de traducción, timezone, formateo
- **Archivos**: `otras/fechas.php`, `strings.php`, utilidades varias

### **DÍA 7: Servicios Web** 🌐
- **Ejercicio**: Cotizaciones de monedas en tiempo real
- **Conceptos**: `file_get_contents()`, `json_decode()`, APIs externas
- **Archivos**: `servicios/conver001.php`, manejo de errores HTTP

## 🛠️ Cómo Implementar desde Cero

### Opción 1: Instalación Automática (Recomendado)

```bash
# Ejecutar el script de configuración
./setup_2week2025.sh

# Iniciar con Docker
cd 2week2025
docker-compose up -d

# Abrir en navegador
http://localhost:8080
```

### Opción 2: Configuración Manual

```bash
# 1. Crear estructura de directorios
mkdir -p 2week2025/{archivos,otras,servicios}

# 2. Configurar servidor web (XAMPP/WAMP)
# 3. Copiar archivos a htdocs/2week2025/
# 4. Implementar ejercicios día por día
```

### Opción 3: Clonar Repositorio Original

```bash
git clone git@github.com:proffabianlopez/2week2025.git
cd 2week2025
# Configurar servidor web
```

## 🔧 Configuración del Entorno

### Requisitos Mínimos
- **PHP 7.4+** (recomendado 8.1)
- **Servidor web** (Apache/Nginx)
- **Navegador moderno**
- **Editor de código** (VS Code, Sublime)

### Configuración Docker (Incluida)
```yaml
# docker-compose.yml generado automáticamente
services:
  php-apache:
    image: php:8.1-apache
    ports: ["8080:80"]
    volumes: [".:/var/www/html"]
```

## 📚 Estructura de Archivos Creados

```
2week2025/
├── index.html                 # Página principal con navegación
├── docker-compose.yml         # Configuración Docker
├── README.md                  # Documentación del proyecto
│
├── 01_adivina.html/php        # Día 1: Juego de adivinanza
├── 02_ej0002.html/php         # Día 2: Calculadora checkboxes
├── 03_ej3.html/php            # Día 3: Intereses financieros
├── 04_Conversor.html/php      # Día 4: Conversor monedas
│
├── archivos/                  # Día 5: Manejo de archivos
│   ├── opcion.php            # Interface de votación
│   ├── copa.php              # Procesamiento de votos
│   ├── mostrar_resultados.php # Visualización de resultados
│   └── result.dat            # Archivo de datos
│
├── otras/                     # Día 6: Utilidades
│   ├── fechas.php            # Manejo de fechas en español
│   ├── strings.php           # Manipulación de strings
│   └── [otras utilidades]
│
└── servicios/                 # Día 7: APIs externas
    ├── conver001.php         # Cotizaciones tiempo real
    ├── conver002.php         # Versión mejorada
    └── Leer.md               # Documentación servicios
```

## 🎓 Progresión del Aprendizaje

### **Nivel Principiante** (Días 1-3)
- Formularios HTML básicos
- Variables PHP y superglobales
- Condicionales y operaciones
- Validación simple

### **Nivel Intermedio** (Días 4-5)
- Arrays y estructuras de datos
- Manejo de archivos
- Persistencia de información
- Interfaces de usuario

### **Nivel Avanzado** (Días 6-7)
- Utilidades del sistema
- Consumo de APIs externas
- Manejo de JSON
- Arquitectura web

## 📊 Métrica de Éxito

Al completar la semana 2week2025 podrás:

✅ **Crear formularios web funcionales** con validación
✅ **Procesar datos del usuario** de manera segura
✅ **Implementar persistencia** sin base de datos
✅ **Consumir servicios web externos** (APIs)
✅ **Manejar fechas y strings** en español
✅ **Desarrollar interfaces** atractivas y funcionales
✅ **Estructurar proyectos PHP** profesionalmente

## 🚀 Comenzar Ahora

### Paso 1: Configuración
```bash
./setup_2week2025.sh
```

### Paso 2: Iniciar Servidor
```bash
docker-compose up -d
```

### Paso 3: Abrir Navegador
```
http://localhost:8080
```

### Paso 4: Seguir el Programa
- Día 1: Ejercicio de adivinanza
- Día 2: Calculadora con checkboxes
- Día 3: Calculadora de intereses
- ... y continuar secuencialmente

## 📞 Recursos Adicionales

- **📖 Guía Paso a Paso**: `guia_2week2025_desde_cero.md`
- **🔧 Ejercicios Avanzados**: `ejercicios_avanzados_2week2025.md`
- **🌐 Repositorio Original**: [github.com/proffabianlopez/2week2025](https://github.com/proffabianlopez/2week2025)
- **🐳 Docker Hub**: Configuración automatizada incluida

## 💡 Consejos para el Éxito

1. **Sigue el orden**: Cada día construye sobre el anterior
2. **Experimenta**: Modifica el código para entender mejor
3. **Documenta**: Toma notas de conceptos clave
4. **Practica**: Repite ejercicios si es necesario
5. **Pregunta**: La comunidad PHP es muy colaborativa

---

**¡Comienza tu journey PHP hoy mismo con 2week2025!** 🎯🚀