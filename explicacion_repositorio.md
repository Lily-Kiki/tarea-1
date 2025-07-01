# Explicación del Repositorio 2week2025

## Descripción General

Este repositorio contiene scripts y ejercicios en PHP diseñados para aprender programación web con PHP en un entorno Docker. El proyecto está estructurado para enseñar conceptos básicos de desarrollo web con formularios HTML y procesamiento backend en PHP.

## Estructura del Proyecto

```
2week2025/
├── README.md              # Descripción básica del proyecto
├── Tarea.md              # Especificaciones de las tareas a desarrollar
├── 01_adivina.html       # Juego de adivinanza - Frontend
├── 01_adivina.php        # Juego de adivinanza - Backend
├── 02_ej0002.html        # Ejercicio 2 - Frontend
├── 02_ej0002.php         # Ejercicio 2 - Backend
├── 03_ej3.html           # Ejercicio 3 - Frontend
├── 03_ej3.php            # Ejercicio 3 - Backend
├── 04_Conversor.html     # Conversor de monedas - Frontend
├── 04_Conversor.php      # Conversor de monedas - Backend
├── archivos/             # Manejo de archivos
├── otras/                # Utilidades varias
└── servicios/            # Servicios web
```

## Archivos Principales

### 1. Juego de Adivinanza (`01_adivina.html` y `01_adivina.php`)

**Propósito**: Ejercicio básico de formularios y lógica PHP

**Funcionalidad**:
- El usuario ingresa un número del 1 al 20
- El sistema genera un número aleatorio
- Compara ambos números y muestra si ganó o perdió

**Tecnologías**: HTML básico, PHP con función `rand()`

### 2. Conversor de Monedas (`04_Conversor.html` y `04_Conversor.php`)

**Propósito**: Aplicación de conversión de monedas con formularios tipo radio button

**Funcionalidad**:
- Formulario con campo de valor y opciones de moneda (radio buttons)
- Conversiones disponibles: Dólar, Peso Chileno, Euros, Pesos Argentinos
- Utiliza tasas de cambio fijas hardcodeadas

**Características técnicas**:
- Uso de radio buttons para selección de moneda
- Procesamiento de formularios con `$_POST`
- Condicionales `if/elseif` para diferentes conversiones

## Directorios Especializados

### `/archivos` - Manejo de Archivos

**`copa.php`**: Sistema de votación/encuesta
- Maneja archivos de texto para persistir datos
- Lee y escribe votos en archivo `result.dat`
- Implementa lógica para evitar duplicados
- Usa funciones de archivo: `fopen()`, `fgets()`, `fputs()`, `fclose()`

**`opcion.php`**: Complemento del sistema de votación

**`result.dat`**: Archivo de datos con resultados de la encuesta

### `/otras` - Utilidades y Ejemplos

**`fechas.php`**: Manejo de fechas en español
- Convierte fechas del sistema a formato español
- Arrays asociativos para meses y días
- Formateo personalizado de fechas

**`strings.php`**: Manipulación de cadenas
- Ejemplos de la función `substr()`
- Diferentes formas de recortar y extraer partes de strings
- Casos prácticos de manipulación de texto

**`codificado.php`**: Manejo de codificación de caracteres

**`comparar.php`**: Utilidades de comparación

**`borrarcrear.php`**: Operaciones de archivos (crear/eliminar)

**`ip2.php`**: Trabajo con direcciones IP

**`cualesmi.php`**: Identificación de información del sistema

### `/servicios` - Servicios Web

**`conver001.php`**: Conversor de monedas avanzado
- Consume API externa (api.bluelytics.com.ar)
- Obtiene cotizaciones en tiempo real
- Maneja diferentes tipos de dólar y euro (oficial/blue)
- Implementa manejo de errores HTTP

**`conver002.php`**: Versión mejorada del conversor

**`Leer.md`**: Documentación de los servicios de conversión

## Tareas de Desarrollo Propuestas

Según el archivo `Tarea.md`, el proyecto incluye las siguientes asignaciones:

### 1. Formulario de Evento Masivo
- Captura de datos de inscripción
- Campos requeridos: apellidos, nombres, fecha de asistencia, email, fecha de nacimiento, redes sociales, perfil, charlas/cursos
- Validación de emails únicos
- Almacenamiento en archivos planos
- Mensajes de éxito/error

### 2. Sistema de Consultas
- Formulario de búsqueda con múltiples criterios
- Backend de búsqueda coordinado entre equipos
- Presentación de resultados en formato tabla
- Manejo de casos sin coincidencias

### 3. Mejoras en Conversor de Monedas
- Integración con servicios web de cotización
- Historial de cotizaciones de los últimos 3 días
- Interface mejorada para mostrar información histórica

## Conceptos PHP Demostrados

1. **Formularios HTML y PHP**:
   - Método POST
   - Procesamiento con `$_POST`
   - Validación básica

2. **Manejo de Archivos**:
   - Lectura/escritura de archivos
   - Funciones: `fopen()`, `fgets()`, `fputs()`, `fclose()`
   - Manejo de archivos temporales

3. **Consumo de APIs**:
   - `file_get_contents()` para peticiones HTTP
   - `json_decode()` para procesar respuestas JSON
   - Manejo de errores HTTP

4. **Manipulación de Datos**:
   - Arrays asociativos
   - Funciones de string (`substr()`)
   - Conversión de tipos (`settype()`)
   - Fechas y formateo

5. **Estructuras de Control**:
   - Condicionales `if/elseif/else`
   - Bucles `while`
   - Generación de números aleatorios

## Entorno de Desarrollo

- **Tecnología**: PHP + HTML
- **Entorno**: Docker (según README)
- **Propósito**: Aprendizaje de desarrollo web básico
- **Nivel**: Principiante a intermedio

## Metodología de Trabajo

El proyecto sugiere:
- Trabajo en parejas con roles diferenciados
- Uso de ramas Git para desarrollo
- Merge a rama `dev` para testing
- Coordinación entre equipos frontend/backend

Este repositorio representa un conjunto completo de ejercicios progresivos para aprender PHP desde conceptos básicos hasta integración con servicios web externos.