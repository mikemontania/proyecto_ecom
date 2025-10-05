# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# 📦 Proyecto E-commerce (Ruby on Rails + Node)

Este proyecto es un **e-commerce** desarrollado principalmente con **Ruby on Rails** en el backend y que utiliza **Node.js/NPM** para la gestión de dependencias y compilación del frontend (JS/CSS).  

A continuación se detalla la función de cada directorio y archivo en la raíz del proyecto:

---

## 📂 Directorios principales

- **.git/**  
  Carpeta de control de versiones (Git).

- **app/**  
  Contiene el **código principal de la aplicación Rails**:  
  - `models/`: Definición de modelos (lógica de negocio y conexión con la base de datos).  
  - `controllers/`: Controladores que exponen endpoints y manejan requests HTTP.  
  - `views/`: Vistas renderizadas en HTML/ERB.  
  - `assets/` o `javascript/`: Archivos frontend (JS, CSS) compilados por Rails/Webpack.  

- **bin/**  
  Scripts ejecutables usados por Rails (`rails server`, `rails console`, etc.).

- **config/**  
  Configuración de la aplicación:  
  - Rutas (`routes.rb`).  
  - Configuración de base de datos.  
  - Inicializadores y entornos (development, production, test).  

- **db/**  
  Migraciones, seeds y `schema.rb` que definen la estructura de la base de datos.

- **lib/**  
  Librerías y módulos personalizados que extienden la aplicación.

- **log/**  
  Archivos de logs generados en ejecución (desarrollo, producción, etc.).

- **node_modules/**  
  Dependencias instaladas con **npm o yarn** para el frontend.

- **public/**  
  Archivos estáticos accesibles directamente (HTML, imágenes, JS/CSS compilados).

- **storage/**  
  Archivos almacenados por **ActiveStorage** (subidas de usuarios, adjuntos, etc.).

- **test/**  
  Pruebas automatizadas (tests unitarios, de integración, etc.).

- **tmp/**  
  Archivos temporales generados en ejecución (cachés, sockets, pids).

- **vendor/**  
  Dependencias externas que no se instalan vía `Gemfile` ni `package.json`.

---

## 📄 Archivos principales

- **.browserslistrc**  
  Define compatibilidad de navegadores para transpilar CSS/JS con Babel y PostCSS.

- **.dockerignore**  
  Lista de archivos y carpetas a ignorar al construir imágenes Docker.

- **.gitignore**  
  Archivos/carpetas que no se deben versionar con Git.

- **.ruby-version**  
  Indica la versión de Ruby requerida por el proyecto.

- **babel.config.js**  
  Configuración de Babel (transpilación de JS moderno para navegadores antiguos).

- **config.ru**  
  Archivo de configuración de **Rack**, necesario para que Rails arranque en servidores web.

- **core.1**  
  Archivo de volcado (dump) generado por un error/segfault. Generalmente no es necesario.

- **docker-compose.yml**  
  Orquestación de contenedores (Rails, base de datos, Sidekiq, etc.).

- **Dockerfile_dev**  
  Imagen Docker para entorno de desarrollo.

- **Dockerfile_prod**  
  Imagen Docker para entorno de producción.

- **Dockerfile_sidekiq**  
  Imagen Docker para correr **Sidekiq** (procesamiento en background).

- **entrypoint.sh / entrypoint_*.sh**  
  Scripts de inicialización usados en los contenedores Docker.  
  (Ejecutan migraciones, arrancan Rails, levantan Sidekiq, etc.).

- **Gemfile**  
  Lista de dependencias de Ruby (gems necesarias para correr el proyecto).

- **Gemfile.lock**  
  Versión exacta de cada gema instalada.

- **package.json**  
  Lista de dependencias de Node (JS/CSS, build del frontend) y scripts disponibles.

- **package-lock.json / yarn.lock**  
  Bloquean las versiones exactas de dependencias JS.

- **postcss.config.js**  
  Configuración de PostCSS (procesa CSS moderno y lo adapta a navegadores).

- **Rakefile**  
  Definición de tareas Rake (similar a scripts npm o makefiles en Rails).

- **README.md**  
  Documentación del proyecto.

---

## 🔎 Conclusión

- **Backend**: Ruby on Rails (`app/`, `config/`, `db/`, `lib/`).  
- **Frontend**: Administrado con Node + Babel + PostCSS (`package.json`, `node_modules/`, `babel.config.js`).  
- **Infraestructura**: Docker y Sidekiq para procesos en segundo plano.  

---

👉 Para migrar a **Node.js + Angular**:  
1. Reescribir la lógica de negocio (modelos, controladores, migraciones) en **Node.js (Express/Sequelize)**.  
2. Migrar el frontend que Rails servía hacia un proyecto independiente en **Angular**.  
3. Sustituir Sidekiq (jobs en background de Rails) por un sistema en Node (ej. Bull, Agenda).  
4. Mantener la compatibilidad con la base de datos (probablemente PostgreSQL o MySQL).  