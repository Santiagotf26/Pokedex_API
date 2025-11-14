# DOCUMENTACION - PokemonApi

## Descripción general

Sistema de registro de Pokémon para una Pokédex personal, que consume la API pública PokéAPI para obtener datos dinámicos (tipos, estadísticas, habilidades, sprite) y los almacena en una base de datos MySQL.

## Arquitectura

- Patrón MVC simple: JSP (vista), Servlet (controlador), DAO (modelo de acceso a datos).
- API interna REST vía `PokemonServlet` que expone endpoints JSON.
- PokéAPI consumida desde el backend con `HttpURLConnection`.

## Flujo principal

1. El usuario busca un Pokémon por nombre o ID desde la interfaz.
2. El frontend llama a `GET /pokemon?action=getExternal&param={nameOrId}`.
3. El servlet consume PokéAPI, devuelve JSON con datos del Pokémon.
4. El formulario se llena automáticamente con tipos, stats, habilidades y sprite.
5. El usuario completa datos del entrenador, nivel, apodo, observaciones.
6. Al guardar, se envían los datos a `POST /pokemon?action=create` y se almacenan en MySQL.
7. La tabla con DataTables muestra todos los registros (`GET /pokemon?action=getAll`).
8. Desde la tabla se puede editar (`GET getById` + `POST update`) y eliminar (`DELETE`).

## Validaciones

- **Cliente (JS)**: campos obligatorios, alertas con SweetAlert2.
- **Servidor (Java)**: tipado estricto (Integer, Double, Boolean, LocalDate), manejo de errores de conexión a PokéAPI y BD.

## Base de datos

- Script: `database.sql` (tabla `pokemon_record`).
- Restricciones: `codigo_registro` único, campos NOT NULL para datos clave, tipos adecuados.

## Endpoints

Se detallan también en `README.md` y en la colección Postman.

## Recomendaciones de despliegue

- Configurar correctamente el driver de MySQL en el servidor.
- Ajustar URL, usuario y contraseña en `DatabaseConnection.java` según el entorno.
