package sena.adso.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/pokemon_api_db?useSSL=false&serverTimezone=UTC";
    private static final String URL_SERVER = "jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void initializeDatabase() throws SQLException {
        try (Connection serverConn = DriverManager.getConnection(URL_SERVER, USER, PASSWORD);
             Statement stmt = serverConn.createStatement()) {
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS pokemon_api_db");
        }

        try (Connection dbConn = getConnection();
             Statement stmt = dbConn.createStatement()) {
            stmt.executeUpdate("DROP TABLE IF EXISTS pokemon_record");
            stmt.executeUpdate(
                    "CREATE TABLE pokemon_record (" +
                            "id INT AUTO_INCREMENT PRIMARY KEY," +
                            "codigo_registro VARCHAR(100) NOT NULL," +
                            "pokemon_id INT NOT NULL," +
                            "nombre VARCHAR(100) NOT NULL," +
                            "nombre_japones VARCHAR(100)," +
                            "tipo1 VARCHAR(50) NOT NULL," +
                            "tipo2 VARCHAR(50)," +
                            "altura DOUBLE," +
                            "peso DOUBLE," +
                            "habilidad1 VARCHAR(100)," +
                            "habilidad2 VARCHAR(100)," +
                            "habilidad_oculta VARCHAR(100)," +
                            "hp INT," +
                            "ataque INT," +
                            "defensa INT," +
                            "ataque_especial INT," +
                            "defensa_especial INT," +
                            "velocidad INT," +
                            "sprite_url VARCHAR(255)," +
                            "nombre_entrenador VARCHAR(150)," +
                            "email_entrenador VARCHAR(150)," +
                            "apodo VARCHAR(100)," +
                            "nivel INT," +
                            "es_capturado BOOLEAN DEFAULT TRUE," +
                            "fecha_captura DATE," +
                            "observaciones TEXT," +
                            "fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                            ")"
            );
        }
    }
}
