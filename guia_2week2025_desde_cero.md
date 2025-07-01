# Guía Completa: Semana 2week2025 - Implementación desde Cero

## 🎯 Objetivo de la Semana
Aprender PHP básico mediante ejercicios prácticos progresivos, desde formularios simples hasta integración con APIs externas.

## 📋 Requisitos Previos
- Servidor web con PHP (XAMPP, WAMP, Docker, etc.)
- Editor de código (VS Code, Sublime, etc.)
- Navegador web
- Conocimientos básicos de HTML

## 🏗️ Estructura del Proyecto

```
2week2025/
├── 01_adivina.html         # Ejercicio 1: Juego de adivinanza
├── 01_adivina.php
├── 02_ej0002.html          # Ejercicio 2: Calculadora con checkboxes
├── 02_ej0002.php
├── 03_ej3.html             # Ejercicio 3: Calculadora de intereses
├── 03_ej3.php
├── 04_Conversor.html       # Ejercicio 4: Conversor de monedas
├── 04_Conversor.php
├── archivos/               # Ejercicio 5: Manejo de archivos
├── otras/                  # Ejercicio 6: Utilidades varias
└── servicios/              # Ejercicio 7: Servicios web
```

## 📚 Ejercicios Paso a Paso

### Día 1: Ejercicio 1 - Juego de Adivinanza

**Objetivo**: Aprender formularios básicos y función rand()

**Crear `01_adivina.html`:**
```html
<html>
    <head> 
        <title>Adivina el Número</title> 
    </head>
    <body>
        <h2>Juego de Adivinanza</h2>
        <form action="01_adivina.php" method="post">
            Ingrese un número del 1 al 20: 
            <input type="text" name="valor1" required>
            <br><br>
            <input type="submit" name="realizar" value="Adivinar">
            <input type="reset" name="borrar" value="Limpiar">
        </form>
    </body>
</html>
```

**Crear `01_adivina.php`:**
```php
<html>
    <head> 
        <title>Resultado</title> 
    </head>
    <body>
        <h2>Resultado del Juego</h2>
        <?php
            $num = $_POST['valor1'];
            $adivina = rand(1,20);
            
            if($num == $adivina) {
                echo "<h3 style='color: green;'>¡Ganaste!</h3>";
                echo "Tu número: $num - Número secreto: $adivina";
            } else {
                echo "<h3 style='color: red;'>Perdiste</h3>";
                echo "Tu número: $num<br>";
                echo "El número secreto era: $adivina";
            }
        ?>
        <br><br>
        <a href="01_adivina.html">Jugar de nuevo</a>
    </body>
</html>
```

### Día 2: Ejercicio 2 - Calculadora con Checkboxes

**Objetivo**: Aprender checkboxes y función isset()

**Crear `02_ej0002.html`:**
```html
<html>
<head> 
    <title>Calculadora con Checkboxes</title>
</head>
<body>
    <h2>Calculadora Simple</h2>
    <form action="02_ej0002.php" method="post">
        Primer valor: <input type="text" name="valor1" required><br><br>
        Segundo valor: <input type="text" name="valor2" required><br><br>
        
        <h3>Operaciones:</h3>
        <input type="checkbox" name="check1" value="suma" checked> Sumar <br>
        <input type="checkbox" name="check2" value="resta"> Restar <br><br>
        
        <input type="submit" name="Realizar" value="Calcular">
    </form>
</body>
</html>
```

**Crear `02_ej0002.php`:**
```php
<html>
<head>
    <title>Resultado de Operaciones</title>
</head>
<body>
    <h2>Resultados</h2>
    <?php 
        $valor1 = $_POST['valor1'];
        $valor2 = $_POST['valor2'];
        
        if(isset($_POST['check1']) && $_POST['check1'] == 'suma') {
            $suma = $valor1 + $valor2;
            echo "<p>La suma es: <strong>$suma</strong></p>";
        }
        
        if(isset($_POST['check2']) && $_POST['check2'] == 'resta') {
            $resta = $valor1 - $valor2;
            echo "<p>La resta es: <strong>$resta</strong></p>";
        }
        
        if(!isset($_POST['check1']) && !isset($_POST['check2'])) {
            echo "<p style='color: red;'>No seleccionaste ninguna operación</p>";
        }
    ?>
    <br>
    <a href="02_ej0002.html">Volver</a>
</body>
</html>
```

### Día 3: Ejercicio 3 - Calculadora de Intereses

**Objetivo**: Aprender radio buttons y cálculos financieros

**Crear `03_ej3.html`:**
```html
<html>
<head>
    <title>Calculadora de Intereses</title>
</head>
<body>
    <h2>Calculadora de Financiamiento</h2>
    <form action="03_ej3.php" method="post">
        Importe a financiar: 
        <input type="number" name="valor1" step="0.01" required><br><br>
        
        <h3>Cantidad de cuotas:</h3>
        <input type="radio" name="radio1" value="1"> 1 cuota<br>
        <input type="radio" name="radio1" value="3"> 3 cuotas<br>
        <input type="radio" name="radio1" value="6"> 6 cuotas<br>
        <input type="radio" name="radio1" value="12"> 12 cuotas<br><br>
        
        <input type="submit" name="Realizar" value="Calcular">
        <input type="reset" value="Limpiar">
    </form>
</body>
</html>
```

**Crear `03_ej3.php`:**
```php
<html>
<head>
    <title>Cálculo de Financiamiento</title>
</head>
<body bgcolor="#F3C327">
    <h2>Resultado del Financiamiento</h2>
    <?php 
        $importe = $_POST['valor1'];
        $cuotas = $_POST['radio1'];
        
        // Tabla de intereses según cuotas
        $intereses = [
            1 => 1.00,   // Sin interés
            3 => 1.05,   // 5% interés
            6 => 1.10,   // 10% interés
            12 => 1.20   // 20% interés
        ];
        
        if(isset($intereses[$cuotas])) {
            $total = $importe * $intereses[$cuotas];
            $cuota_valor = $total / $cuotas;
            
            echo "<h3>Detalles del Financiamiento</h3>";
            echo "<p>Importe original: $" . number_format($importe, 2) . "</p>";
            echo "<p>Cantidad de cuotas: $cuotas</p>";
            echo "<p>Total a pagar: $" . number_format($total, 2) . "</p>";
            echo "<p>Valor por cuota: $" . number_format($cuota_valor, 2) . "</p>";
        } else {
            echo "<p style='color: red;'>Seleccione una cantidad de cuotas válida</p>";
        }
    ?>
    <br>
    <a href="03_ej3.html">Volver</a>
</body>
</html>
```

## 🔧 Configuración del Entorno

### Opción 1: Docker (Recomendado)
```bash
# Crear docker-compose.yml
version: '3.8'
services:
  php-apache:
    image: php:8.1-apache
    ports:
      - "8080:80"
    volumes:
      - ./2week2025:/var/www/html
    environment:
      - APACHE_DOCUMENT_ROOT=/var/www/html
```

### Opción 2: XAMPP
1. Descargar XAMPP
2. Instalar y ejecutar Apache + PHP
3. Colocar archivos en `htdocs/2week2025/`
4. Acceder via `http://localhost/2week2025/`

## 📖 Conceptos Clave por Día

### Día 1: Fundamentos
- Formularios HTML con método POST
- Variable superglobal `$_POST`
- Función `rand()` para números aleatorios
- Condicionales `if/else`

### Día 2: Controles de Formulario
- Checkboxes múltiples
- Función `isset()` para verificar variables
- Validación de formularios
- Operaciones matemáticas básicas

### Día 3: Radio Buttons y Arrays
- Radio buttons para selección única
- Arrays asociativos para tablas de datos
- Formateo de números con `number_format()`
- Cálculos financieros básicos

## 🚀 Ejercicios Avanzados (Días 4-7)

Los próximos días incluyen:
- **Día 4**: Conversor de monedas con APIs
- **Día 5**: Manejo de archivos y persistencia
- **Día 6**: Utilidades de fecha, strings e IP
- **Día 7**: Servicios web y consumo de APIs

## ✅ Lista de Verificación

- [ ] Configurar entorno de desarrollo
- [ ] Crear estructura de carpetas
- [ ] Implementar Ejercicio 1 (Adivinanza)
- [ ] Implementar Ejercicio 2 (Calculadora)
- [ ] Implementar Ejercicio 3 (Intereses)
- [ ] Probar todos los formularios
- [ ] Validar funcionamiento en navegador
- [ ] Continuar con ejercicios avanzados

## 🎯 Objetivos de Aprendizaje

Al completar esta semana podrás:
1. Crear formularios HTML funcionales
2. Procesar datos con PHP
3. Manejar diferentes tipos de input
4. Implementar validaciones básicas
5. Realizar cálculos y operaciones
6. Integrar frontend y backend
7. Prepararte para temas avanzados

¡Empieza con el Ejercicio 1 y avanza paso a paso!