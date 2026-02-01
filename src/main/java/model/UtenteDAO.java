package model;

import java.sql.*;
import utils.DBConnection;
import utils.PasswordUtils;

public class UtenteDAO {

    public Utente login(String email, String plainPassword) throws Exception {
        try (Connection con = DBConnection.getConnection()) {
            // Controllo tabella administrator
            String sqlAdmin = "SELECT * FROM administrator WHERE indirizzo_email = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlAdmin)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && PasswordUtils.verifyPassword(plainPassword, rs.getString("passwordhash"))) {
                        return new Utente(email, "Admin", "", "", 0, "admin");
                    }
                }
            }

            // Controllo tabella utente
            String sqlUser = "SELECT * FROM utente WHERE indirizzo_email = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlUser)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && PasswordUtils.verifyPassword(plainPassword, rs.getString("passwordhash"))) {
                        return new Utente(
                                rs.getString("indirizzo_email"),
                                rs.getString("nome"),
                                rs.getString("cognome"),
                                rs.getString("telefono"),
                                rs.getInt("indirizzo"),
                                "utente"
                        );
                    }
                }
            }
        }
        return null;
    }
}
