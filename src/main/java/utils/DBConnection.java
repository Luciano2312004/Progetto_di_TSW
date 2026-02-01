package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Vector;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/FastMotors?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "hm&!MEe!mJ75";

    private static final int MAX_POOL_SIZE = 5;
    private static final Vector<Connection> pool = new Vector<>();

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Inizializza il pool con connessioni
            for (int i = 0; i < MAX_POOL_SIZE; i++) {
                pool.add(DriverManager.getConnection(URL, USER, PASSWORD));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Errore nella creazione del pool di connessioni", e);
        }
    }

    public static synchronized Connection getConnection() throws SQLException {
        if (pool.isEmpty()) {
            // Se il pool Ã¨ vuoto, crea una nuova connessione (opzionale, o puoi bloccare)
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } else {
            return pool.remove(0);
        }
    }

    public static synchronized void releaseConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                pool.add(conn); // restituisci la connessione al pool
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static synchronized void closeAllConnections() {
        for (Connection conn : pool) {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        pool.clear();
    }
}