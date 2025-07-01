#!/bin/bash

# Script de configuración automática para 2week2025
# Crea toda la estructura del proyecto desde cero

echo "🚀 Configurando proyecto 2week2025..."

# Crear directorios principales
mkdir -p 2week2025/{archivos,otras,servicios}

echo "📁 Directorios creados"

# Cambiar al directorio del proyecto
cd 2week2025

# Crear archivo de índice principal
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2week2025 - Ejercicios PHP</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            background: rgba(255,255,255,0.1);
            padding: 30px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        .exercise {
            background: rgba(255,255,255,0.1);
            margin: 15px 0;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #fff;
        }
        .exercise h3 {
            margin-top: 0;
            color: #ffd700;
        }
        .exercise a {
            color: #87ceeb;
            text-decoration: none;
            font-weight: bold;
        }
        .exercise a:hover {
            text-decoration: underline;
        }
        .day {
            background: rgba(255,215,0,0.2);
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎯 Semana 2week2025 - Ejercicios PHP</h1>
        <p>Bienvenido al programa de aprendizaje PHP de 7 días. Cada ejercicio está diseñado para enseñarte conceptos específicos.</p>
        
        <div class="day">Día 1: Fundamentos</div>
        <div class="exercise">
            <h3>🎲 Ejercicio 1: Juego de Adivinanza</h3>
            <p>Aprende formularios básicos y la función rand()</p>
            <a href="01_adivina.html">→ Iniciar Ejercicio 1</a>
        </div>
        
        <div class="day">Día 2: Controles de Formulario</div>
        <div class="exercise">
            <h3>🧮 Ejercicio 2: Calculadora con Checkboxes</h3>
            <p>Manejo de checkboxes y función isset()</p>
            <a href="02_ej0002.html">→ Iniciar Ejercicio 2</a>
        </div>
        
        <div class="day">Día 3: Radio Buttons y Arrays</div>
        <div class="exercise">
            <h3>💰 Ejercicio 3: Calculadora de Intereses</h3>
            <p>Radio buttons y cálculos financieros</p>
            <a href="03_ej3.html">→ Iniciar Ejercicio 3</a>
        </div>
        
        <div class="day">Día 4: APIs y Conversiones</div>
        <div class="exercise">
            <h3>💱 Ejercicio 4: Conversor de Monedas</h3>
            <p>Conversiones con tasas fijas</p>
            <a href="04_Conversor.html">→ Iniciar Ejercicio 4</a>
        </div>
        
        <div class="day">Día 5: Manejo de Archivos</div>
        <div class="exercise">
            <h3>🗳️ Ejercicio 5: Sistema de Votación</h3>
            <p>Persistencia de datos en archivos</p>
            <a href="archivos/opcion.php">→ Iniciar Ejercicio 5</a>
        </div>
        
        <div class="day">Día 6: Utilidades</div>
        <div class="exercise">
            <h3>📅 Ejercicio 6: Manejo de Fechas</h3>
            <p>Fechas en español y formateo</p>
            <a href="otras/fechas.php">→ Iniciar Ejercicio 6</a>
        </div>
        
        <div class="day">Día 7: Servicios Web</div>
        <div class="exercise">
            <h3>🌐 Ejercicio 7: Cotizaciones en Tiempo Real</h3>
            <p>Consumo de APIs externas</p>
            <a href="servicios/conver001.php">→ Iniciar Ejercicio 7</a>
        </div>
        
        <hr style="margin: 30px 0; border: 1px solid rgba(255,255,255,0.3);">
        
        <h2>📚 Documentación</h2>
        <p>
            <a href="https://github.com/proffabianlopez/2week2025" target="_blank">🔗 Repositorio Original</a> |
            <a href="#" onclick="alert('Consulta las guías creadas para implementación desde cero')">📖 Guía Completa</a>
        </p>
    </div>
</body>
</html>
EOF

# Crear docker-compose.yml para desarrollo local
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  php-apache:
    image: php:8.1-apache
    container_name: 2week2025-php
    ports:
      - "8080:80"
    volumes:
      - .:/var/www/html
    environment:
      - APACHE_DOCUMENT_ROOT=/var/www/html
    restart: unless-stopped

  # Opcional: Base de datos para ejercicios avanzados
  mysql:
    image: mysql:8.0
    container_name: 2week2025-mysql
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: 2week2025
      MYSQL_USER: php_user
      MYSQL_PASSWORD: php_pass
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    restart: unless-stopped

volumes:
  mysql_data:
EOF

# Crear archivo README.md
cat > README.md << 'EOF'
# 2week2025 - Curso PHP Intensivo

## 🎯 Descripción
Programa de aprendizaje PHP de 7 días con ejercicios progresivos desde formularios básicos hasta integración con APIs.

## 🚀 Inicio Rápido

### Opción 1: Docker (Recomendado)
```bash
docker-compose up -d
```
Luego visita: http://localhost:8080

### Opción 2: Servidor Local
- Instala XAMPP/WAMP
- Copia archivos a htdocs/
- Inicia Apache + PHP

## 📋 Estructura del Curso

- **Día 1**: Formularios básicos y PHP
- **Día 2**: Checkboxes y validación
- **Día 3**: Radio buttons y arrays
- **Día 4**: Conversor de monedas
- **Día 5**: Manejo de archivos
- **Día 6**: Utilidades y fechas
- **Día 7**: APIs y servicios web

## 🎓 Objetivos de Aprendizaje

✅ Formularios HTML y PHP
✅ Manejo de datos POST/GET
✅ Validación y verificación
✅ Archivos y persistencia
✅ APIs y JSON
✅ Fechas y formateo
✅ Interfaces de usuario

## 🛠️ Requisitos
- PHP 7.4+
- Servidor web (Apache/Nginx)
- Navegador moderno

## 📞 Soporte
Consulta las guías incluidas o el repositorio original para documentación completa.
EOF

echo "✅ Proyecto 2week2025 configurado exitosamente!"
echo ""
echo "📋 Próximos pasos:"
echo "1. cd 2week2025"
echo "2. docker-compose up -d   (o configurar servidor local)"
echo "3. Abrir http://localhost:8080"
echo "4. ¡Comenzar con los ejercicios!"
echo ""
echo "🎯 ¡Disfruta aprendiendo PHP!"