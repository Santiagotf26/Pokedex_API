# PokemonApi (Pokédex Personal)

Proyecto Maven Java EE que implementa un sistema de registro de Pokémon consumiendo la API pública **PokéAPI**.

## Tecnologías

- Java 8, Servlet 3.1
- Maven, WAR
- MySQL 8
- Gson, MySQL Connector
- JSP + Bootstrap 5 + jQuery + DataTables + SweetAlert2

## Estructura principal

- `src/main/java/sena/adso/model/PokemonRecord.java`
- `src/main/java/sena/adso/dao/PokemonRecordDAO.java`, `PokemonRecordDAOImpl.java`
- `src/main/java/sena/adso/servlet/PokemonServlet.java`
- `src/main/java/sena/adso/util/DatabaseConnection.java`, `LocalDateAdapter.java`, `LocalDateTimeAdapter.java`
- `src/main/webapp/index.jsp`, `js/app.js`
- `src/main/webapp/WEB-INF/web.xml`
- `database.sql`

## API pública utilizada

- **PokéAPI**: https://pokeapi.co/
- Endpoint principal utilizado desde el backend: `https://pokeapi.co/api/v2/pokemon/{id|name}`

## Instalación

1. Importar el proyecto Maven en NetBeans.
2. Crear la base de datos ejecutando `database.sql` en MySQL.
3. Configurar usuario/clave de MySQL en `DatabaseConnection.java`.
4. Limpiar y compilar el proyecto (`Clean and Build`).
5. Desplegar en servidor (GlassFish/Tomcat).
6. Acceder a `http://localhost:8080/PokemonApi/`.

## Funcionalidad

- Buscar Pokémon por nombre o ID (PokéAPI).
- Autocompletar formulario con tipos, stats, habilidades, sprite.
- CRUD completo sobre tabla `pokemon_record` (crear, listar, buscar, actualizar, eliminar).
- Validaciones en cliente (JS) y servidor (tipo de datos obligatorio).

## Endpoints

- `GET /pokemon?action=getAll`
- `GET /pokemon?action=getById&id={id}`
- `GET /pokemon?action=search&query={q}`
- `GET /pokemon?action=getExternal&param={nameOrId}`
- `POST /pokemon?action=create`
- `POST /pokemon?action=update&id={id}`
- `DELETE /pokemon?id={id}`

## Postman

Colección básica incluida en `Postman_Collection_PokemonApi.json`.
