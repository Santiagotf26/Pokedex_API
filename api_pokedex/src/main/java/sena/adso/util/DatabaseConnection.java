package sena.adso.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/pokemon_api_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    static {
        try {
            // Cargar driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Crear base de datos y tabla si no existen
            String rootUrl = "jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC";
            try (Connection con = DriverManager.getConnection(rootUrl, USER, PASSWORD);
                 Statement st = con.createStatement()) {
                st.executeUpdate("CREATE DATABASE IF NOT EXISTS pokemon_api_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
            }

            try (Connection conDb = DriverManager.getConnection(URL, USER, PASSWORD);
                 Statement stDb = conDb.createStatement()) {
                stDb.executeUpdate("CREATE TABLE IF NOT EXISTS pokemon_record (" +
                        "id INT AUTO_INCREMENT PRIMARY KEY," +
                        "codigo_registro VARCHAR(50) NOT NULL UNIQUE," +
                        "pokemon_id INT NOT NULL," +
                        "nombre VARCHAR(100) NOT NULL," +
                        "nombre_japones VARCHAR(100) NULL," +
                        "tipo1 VARCHAR(50) NOT NULL," +
                        "tipo2 VARCHAR(50) NULL," +
                        "altura DECIMAL(10,2) NOT NULL," +
                        "peso DECIMAL(10,2) NOT NULL," +
                        "habilidad1 VARCHAR(100) NOT NULL," +
                        "habilidad2 VARCHAR(100) NULL," +
                        "habilidad_oculta VARCHAR(100) NULL," +
                        "hp INT NOT NULL," +
                        "ataque INT NOT NULL," +
                        "defensa INT NOT NULL," +
                        "ataque_especial INT NOT NULL," +
                        "defensa_especial INT NOT NULL," +
                        "velocidad INT NOT NULL," +
                        "sprite_url VARCHAR(255) NOT NULL," +
                        "nombre_entrenador VARCHAR(100) NOT NULL," +
                        "email_entrenador VARCHAR(150) NOT NULL," +
                        "apodo VARCHAR(100) NULL," +
                        "nivel INT NOT NULL," +
                        "es_capturado TINYINT(1) NOT NULL DEFAULT 1," +
                        "fecha_captura DATE NULL," +
                        "observaciones TEXT NULL," +
                        "fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP" +
                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
