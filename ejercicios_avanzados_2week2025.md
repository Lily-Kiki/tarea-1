# Ejercicios Avanzados 2week2025 - Días 4-7

## Día 4: Conversor de Monedas

### Ejercicio 4A: Conversor Básico

**Crear `04_Conversor.html`:**
```html
<html>
<head>
    <title>Conversor de Monedas</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .container { max-width: 500px; }
        input[type="text"] { padding: 5px; margin: 5px; }
        input[type="radio"] { margin: 10px 5px; }
        .result { background: #f0f8ff; padding: 15px; margin: 10px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Conversor de Monedas</h2>
        <form action="04_Conversor.php" method="POST">
            <p>Ingrese importe: 
               <input type="number" name="Valor" step="0.01" required></p>
            
            <h3>Convertir a:</h3>
            <input type="radio" name="Radio1" value="Dolar"> Dólar USD<br>
            <input type="radio" name="Radio1" value="Peso Chileno"> Peso Chileno<br>
            <input type="radio" name="Radio1" value="Euros"> Euro EUR<br>
            <input type="radio" name="Radio1" value="Pesos Argentinos"> Peso Argentino<br><br>
            
            <input type="submit" value="Convertir">
            <input type="reset" value="Limpiar">
        </form>
    </div>
</body>
</html>
```

**Crear `04_Conversor.php`:**
```php
<html>
<head>
    <title>Resultado Conversión</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .result { background: #e8f5e8; padding: 15px; border-radius: 5px; }
        .error { background: #ffe8e8; color: red; }
    </style>
</head>
<body>
    <h2>Resultado de la Conversión</h2>
    <?php 
    $importe = $_POST['Valor'];
    $moneda = $_POST['Radio1'];
    
    // Tasas de cambio (ejemplo - pesos argentinos como base)
    $tasas = [
        "Dolar" => 350.00,
        "Peso Chileno" => 0.85,
        "Euros" => 380.00,
        "Pesos Argentinos" => 1.00
    ];
    
    if (isset($tasas[$moneda])) {
        $resultado = $importe * $tasas[$moneda];
        echo "<div class='result'>";
        echo "<h3>Conversión Exitosa</h3>";
        echo "<p><strong>Importe original:</strong> $" . number_format($importe, 2) . " ARS</p>";
        echo "<p><strong>Moneda destino:</strong> $moneda</p>";
        echo "<p><strong>Resultado:</strong> " . number_format($resultado, 2) . "</p>";
        echo "<p><em>Tasa aplicada: " . $tasas[$moneda] . "</em></p>";
        echo "</div>";
    } else {
        echo "<div class='result error'>";
        echo "<p>Error: Seleccione una moneda válida</p>";
        echo "</div>";
    }
    ?>
    <br>
    <a href="04_Conversor.html">← Volver al conversor</a>
</body>
</html>
```

## Día 5: Manejo de Archivos

### Ejercicio 5: Sistema de Votación

**Crear directorio `archivos/` y archivo `opcion.php`:**
```php
<html>
<head>
    <title>Sistema de Votación</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .vote-option { margin: 10px 0; padding: 10px; background: #f9f9f9; }
    </style>
</head>
<body>
    <h2>Sistema de Votación - Copa Mundial</h2>
    <form action="copa.php" method="POST">
        <h3>¿Quién ganará la Copa Mundial?</h3>
        
        <div class="vote-option">
            <input type="radio" name="op" value="1"> Argentina
        </div>
        <div class="vote-option">
            <input type="radio" name="op" value="2"> Brasil
        </div>
        <div class="vote-option">
            <input type="radio" name="op" value="3"> España
        </div>
        <div class="vote-option">
            <input type="radio" name="op" value="4"> Francia
        </div>
        <div class="vote-option">
            <input type="radio" name="op" value="5"> Alemania
        </div>
        
        <br>
        <input type="submit" value="Votar">
    </form>
    
    <br><br>
    <a href="mostrar_resultados.php">Ver Resultados</a>
</body>
</html>
```

**Crear `copa.php`:**
```php
<?php
$op = $_POST['op'];
$existe = 0;
$equipos = [
    1 => "Argentina",
    2 => "Brasil", 
    3 => "España",
    4 => "Francia",
    5 => "Alemania"
];

// Crear archivo si no existe
if (!file_exists('result.dat')) {
    file_put_contents('result.dat', '');
}

$archivo = fopen('result.dat', 'r') or die("No puedo abrir archivo");
$temp_data = [];

// Leer datos existentes
while (!feof($archivo)) {
    $linea = trim(fgets($archivo));
    if ($linea != '') {
        $datos = explode("|", $linea);
        $equipo_id = (int)$datos[0];
        $votos = (int)$datos[1];
        
        if ($equipo_id == $op) {
            $temp_data[$equipo_id] = $votos + 1;
            $existe = 1;
        } else {
            $temp_data[$equipo_id] = $votos;
        }
    }
}
fclose($archivo);

// Si es nuevo voto, agregarlo
if ($existe == 0) {
    $temp_data[$op] = 1;
}

// Escribir todos los datos actualizados
$archivo = fopen('result.dat', 'w') or die("No puedo escribir archivo");
foreach ($temp_data as $equipo_id => $votos) {
    fputs($archivo, $equipo_id . "|" . $votos . "\n");
}
fclose($archivo);
?>

<html>
<head>
    <title>Voto Registrado</title>
    <style>
        body { font-family: Arial; margin: 20px; text-align: center; }
        .success { color: green; font-size: 18px; }
    </style>
</head>
<body>
    <div class="success">
        <h2>✓ Voto Registrado</h2>
        <p>Tu voto por <strong><?= $equipos[$op] ?></strong> ha sido registrado exitosamente.</p>
    </div>
    
    <br>
    <a href="opcion.php">← Votar nuevamente</a> | 
    <a href="mostrar_resultados.php">Ver Resultados</a>
</body>
</html>
```

**Crear `mostrar_resultados.php`:**
```php
<?php
$equipos = [
    1 => "Argentina",
    2 => "Brasil", 
    3 => "España", 
    4 => "Francia",
    5 => "Alemania"
];

$resultados = [];
$total_votos = 0;

if (file_exists('result.dat')) {
    $archivo = fopen('result.dat', 'r');
    while (!feof($archivo)) {
        $linea = trim(fgets($archivo));
        if ($linea != '') {
            $datos = explode("|", $linea);
            $equipo_id = (int)$datos[0];
            $votos = (int)$datos[1];
            $resultados[$equipo_id] = $votos;
            $total_votos += $votos;
        }
    }
    fclose($archivo);
}
?>

<html>
<head>
    <title>Resultados de Votación</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { border-collapse: collapse; width: 100%; max-width: 500px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        .bar { height: 20px; background-color: #4CAF50; margin: 2px 0; }
    </style>
</head>
<body>
    <h2>Resultados de la Votación</h2>
    <p><strong>Total de votos:</strong> <?= $total_votos ?></p>
    
    <table>
        <tr>
            <th>Equipo</th>
            <th>Votos</th>
            <th>Porcentaje</th>
            <th>Gráfico</th>
        </tr>
        <?php foreach ($equipos as $id => $nombre): ?>
            <?php 
            $votos = isset($resultados[$id]) ? $resultados[$id] : 0;
            $porcentaje = $total_votos > 0 ? ($votos / $total_votos) * 100 : 0;
            $ancho_barra = $porcentaje * 2; // Para el gráfico visual
            ?>
            <tr>
                <td><?= $nombre ?></td>
                <td><?= $votos ?></td>
                <td><?= number_format($porcentaje, 1) ?>%</td>
                <td>
                    <div class="bar" style="width: <?= $ancho_barra ?>px;"></div>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
    
    <br>
    <a href="opcion.php">← Volver a votar</a>
</body>
</html>
```

## Día 6: Utilidades Varias

### Crear directorio `otras/` con utilidades

**Crear `fechas.php`:**
```php
<?php   
// Script de manejo de fechas en español
date_default_timezone_set('America/Argentina/Buenos_Aires');

$mes_actual = date("n");
$array_meses = [
    1=>"Enero", 2=>"Febrero", 3=>"Marzo", 4=>"Abril",
    5=>"Mayo", 6=>"Junio", 7=>"Julio", 8=>"Agosto",  
    9=>"Septiembre", 10=>"Octubre", 11=>"Noviembre", 12=>"Diciembre"
];

$dia_actual = date("w");
$array_dias = [
    0=>"Domingo", 1=>"Lunes", 2=>"Martes", 3=>"Miércoles",
    4=>"Jueves", 5=>"Viernes", 6=>"Sábado"
]; 

$dia = date("d");
$anio = date("Y");
$mes_nombre = $array_meses[$mes_actual];
$dia_nombre = $array_dias[$dia_actual];

$fecha_completa = "Hoy es $dia_nombre $dia de $mes_nombre de $anio";
?>

<html>
<head>
    <title>Utilidad de Fechas</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .fecha { font-size: 18px; color: #2c3e50; padding: 20px; background: #ecf0f1; }
        .info { margin: 10px 0; }
    </style>
</head>
<body>
    <h2>Información de Fecha Actual</h2>
    
    <div class="fecha">
        <?= $fecha_completa ?>
    </div>
    
    <div class="info">
        <h3>Detalles:</h3>
        <p><strong>Día:</strong> <?= $dia_nombre ?></p>
        <p><strong>Fecha:</strong> <?= $dia ?></p>
        <p><strong>Mes:</strong> <?= $mes_nombre ?></p>
        <p><strong>Año:</strong> <?= $anio ?></p>
        <p><strong>Timestamp:</strong> <?= time() ?></p>
    </div>
    
    <h3>Otros Formatos:</h3>
    <ul>
        <li>Formato corto: <?= date('d/m/Y') ?></li>
        <li>Formato largo: <?= date('l, j F Y') ?></li>
        <li>Con hora: <?= date('d/m/Y H:i:s') ?></li>
    </ul>
</body>
</html>
```

## Día 7: Servicios Web

### Crear directorio `servicios/`

**Crear `conver001.php`:**
```php
<?php
// Consumo de API de cotizaciones
$api_url = "https://api.bluelytics.com.ar/v2/latest";

// Intentar obtener datos de la API
$json_data = @file_get_contents($api_url);

if ($json_data !== false) {
    $data = json_decode($json_data, true);
    
    if ($data) {
        $dolar_oficial = $data['oficial'];
        $dolar_blue = $data['blue'];
        $euro_oficial = $data['oficial_euro'];
        $euro_blue = $data['blue_euro'];
        $ultima_actualizacion = $data['last_update'];
    }
}
?>

<html>
<head>
    <title>Cotizaciones en Tiempo Real</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .cotization { border: 1px solid #ddd; margin: 10px; padding: 15px; border-radius: 5px; }
        .oficial { background-color: #e8f5e8; }
        .blue { background-color: #e8f0ff; }
        .error { background-color: #ffe8e8; color: red; }
        .title { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
    </style>
</head>
<body>
    <h1>Cotizaciones de Monedas</h1>
    
    <?php if (isset($data) && $data): ?>
        
        <div class="cotization oficial">
            <div class="title">💰 Dólar Oficial</div>
            <p><strong>Compra:</strong> $<?= number_format($dolar_oficial['value_buy'], 2) ?></p>
            <p><strong>Venta:</strong> $<?= number_format($dolar_oficial['value_sell'], 2) ?></p>
        </div>
        
        <div class="cotization blue">
            <div class="title">💵 Dólar Blue</div>
            <p><strong>Compra:</strong> $<?= number_format($dolar_blue['value_buy'], 2) ?></p>
            <p><strong>Venta:</strong> $<?= number_format($dolar_blue['value_sell'], 2) ?></p>
        </div>
        
        <div class="cotization oficial">
            <div class="title">🇪🇺 Euro Oficial</div>
            <p><strong>Compra:</strong> $<?= number_format($euro_oficial['value_buy'], 2) ?></p>
            <p><strong>Venta:</strong> $<?= number_format($euro_oficial['value_sell'], 2) ?></p>
        </div>
        
        <div class="cotization blue">
            <div class="title">💶 Euro Blue</div>
            <p><strong>Compra:</strong> $<?= number_format($euro_blue['value_buy'], 2) ?></p>
            <p><strong>Venta:</strong> $<?= number_format($euro_blue['value_sell'], 2) ?></p>
        </div>
        
        <p><em>Última actualización: <?= $ultima_actualizacion ?></em></p>
        
    <?php else: ?>
        
        <div class="cotization error">
            <h2>❌ Error de Conexión</h2>
            <p>No se pudieron obtener las cotizaciones. Verifique su conexión a internet.</p>
        </div>
        
    <?php endif; ?>
    
    <br>
    <button onclick="location.reload()">🔄 Actualizar Cotizaciones</button>
</body>
</html>
```

## 🎯 Objetivos Completados

Al finalizar los 7 días habrás aprendido:

✅ **Formularios HTML**: text, radio, checkbox, submit, reset
✅ **PHP Básico**: variables, condicionales, arrays
✅ **Manejo de Datos**: $_POST, $_GET, isset()
✅ **Archivos**: fopen, fwrite, fread, fclose
✅ **APIs**: file_get_contents, json_decode
✅ **Fechas**: date(), timezone, arrays asociativos
✅ **Validación**: verificación de datos, manejo de errores
✅ **Interfaces**: CSS básico, navegación entre páginas

## 🚀 Próximos Pasos

- Implementar validación con JavaScript
- Agregar base de datos MySQL
- Crear sistema de usuarios
- Implementar sesiones y autenticación
- Responsive design con Bootstrap
- APIs REST propias