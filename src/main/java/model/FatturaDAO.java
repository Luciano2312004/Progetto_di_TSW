package model;

import utils.DBConnection;
import java.sql.*;

public class FatturaDAO {

    public void createFattura(Fattura fattura) throws SQLException {
        String sql = "INSERT INTO fattura (data_emissione, totale, dettagli, ordine) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            ps = conn.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(fattura.getDataEmissione().getTime()));
            ps.setDouble(2, fattura.getTotale());
            ps.setString(3, fattura.getDettagli());
            ps.setInt(4, fattura.getOrdineId());

            ps.executeUpdate();
            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    // Ignore rollback errors
                }
            }
            throw e;
        } finally {
            if (ps != null)
                try {
                    ps.close();
                } catch (SQLException e) {
                    /* ignore */ }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Ripristina auto-commit
                } catch (SQLException e) {
                    /* ignore */ }
                DBConnection.releaseConnection(conn);
            }
        }
    }

    public Fattura getByOrdineId(int ordineId) throws SQLException {
        final String sql = "SELECT id, data_emissione, totale, dettagli, ordine " +
                "FROM fattura WHERE ordine = ? ORDER BY id DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ordineId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Fattura f = new Fattura();
                    f.setId(rs.getInt("id"));
                    f.setDataEmissione(rs.getDate("data_emissione"));
                    f.setTotale(rs.getDouble("totale"));
                    f.setDettagli(rs.getString("dettagli"));
                    f.setOrdineId(rs.getInt("ordine"));
                    return f;
                }
            }
        }
        return null;
    }
}
