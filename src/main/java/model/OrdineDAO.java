package model;

import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {

    /**
     * Restituisce tutti gli ordini di un utente specifico
     */
    public List<Ordine> getOrdiniByUtente(String emailUtente) throws SQLException {
        List<Ordine> ordini = new ArrayList<>();

        final String sql = "SELECT id, totale, stato, data_ordine, utente " +
                "FROM ordine WHERE utente = ? ORDER BY data_ordine DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, emailUtente);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    o.setId(rs.getInt("id")); // IMPORTANTE
                    o.setTotale(rs.getDouble("totale"));
                    o.setStato(rs.getString("stato"));
                    o.setDataOrdine(rs.getDate("data_ordine"));
                    o.setUtenteEmail(rs.getString("utente")); // è l'email
                    o.setDettagli(getDettagliOrdine(o.getId(), conn)); // carica i dettagli veri
                    ordini.add(o);
                }
            }
        }

        System.out.println("[OrdineDAO] " + emailUtente + " -> ordini=" + ordini.size());
        return ordini;
    }

    /**
     * Restituisce la lista di ordini filtrata per utente e/o intervallo di date.
     * Se i parametri sono null o vuoti, il filtro viene ignorato.
     */
    public List<Ordine> getOrdini(String utente, java.util.Date dataInizio, java.util.Date dataFine)
            throws SQLException {
        List<Ordine> ordini = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM ordine WHERE 1=1");

        if (utente != null && !utente.isEmpty()) {
            sql.append(" AND utente = ?");
        }
        if (dataInizio != null && dataFine != null) {
            sql.append(" AND data_ordine BETWEEN ? AND ?");
        } else if (dataInizio != null) {
            sql.append(" AND data_ordine >= ?");
        } else if (dataFine != null) {
            sql.append(" AND data_ordine <= ?");
        }

        sql.append(" ORDER BY data_ordine DESC");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (utente != null && !utente.isEmpty()) {
                ps.setString(index++, utente);
            }
            if (dataInizio != null && dataFine != null) {
                ps.setDate(index++, new java.sql.Date(dataInizio.getTime()));
                ps.setDate(index++, new java.sql.Date(dataFine.getTime()));
            } else if (dataInizio != null) {
                ps.setDate(index++, new java.sql.Date(dataInizio.getTime()));
            } else if (dataFine != null) {
                ps.setDate(index++, new java.sql.Date(dataFine.getTime()));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    o.setId(rs.getInt("id"));
                    o.setTotale(rs.getDouble("totale"));
                    o.setStato(rs.getString("stato"));
                    o.setDataOrdine(rs.getDate("data_ordine"));
                    o.setUtenteEmail(rs.getString("utente"));
                    o.setDettagli(getDettagliOrdine(o.getId(), conn)); // recupera dettagli
                    ordini.add(o);
                }
            }
        }

        return ordini;
    }

    /** Recupera i dettagli di un ordine */
    private List<DettaglioOrdine> getDettagliOrdine(int ordineId, Connection conn) throws SQLException {
        List<DettaglioOrdine> dettagli = new ArrayList<>();

        // Aggiungi la colonna "marca" alla SELECT
        String sql = "SELECT modello, anno, quantita, prezzo, marca FROM dettagli_ordine WHERE ordine = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ordineId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Usa il nuovo costruttore con marca
                    DettaglioOrdine d = new DettaglioOrdine(
                            rs.getString("modello"),
                            rs.getInt("anno"),
                            rs.getInt("quantita"),
                            rs.getDouble("prezzo"),
                            rs.getString("marca"));
                    dettagli.add(d);
                }
            }
        }

        return dettagli;
    }

}
