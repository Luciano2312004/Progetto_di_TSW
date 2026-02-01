package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;
import utils.DBConnection;

public class OrderDAO {
    /**
     * Salva un ordine nel database usando le tabelle 'ordine' e 'dettagli_ordine'.
     * 
     * @param cart      La lista di CarItem dalla sessione.
     * @param userEmail L'email dell'utente (chiave primaria di 'utente').
     * @return L'ID del nuovo ordine creato.
     * @throws SQLException
     */
    public synchronized int saveOrder(List<CarItem> cart, String userEmail) throws SQLException {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetails = null;
        ResultSet generatedKeys = null;
        int orderId = -1;
        // Query per la tabella 'ordine' (Corretta)
        String insertOrderSQL = "INSERT INTO ordine (totale, stato, data_ordine, utente) VALUES (?, ?, ?, ?)";

        // *** MODIFICA QUI ***
        // Query per 'dettagli_ordine' (rimosse le colonne di configurazione)
        String insertDetailsSQL = "INSERT INTO dettagli_ordine "
                + "(ordine, quantita, prezzo, marca, modello, anno) " // Colonne base
                + "VALUES (?, ?, ?, ?, ?, ?)"; // 6 parametri

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Inizia la transazione
            // 1. Calcola il totale
            double totalAmount = cart.stream().mapToDouble(CarItem::getTotalPrice).sum();
            // 2. Inserisci l'ordine principale
            psOrder = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            psOrder.setDouble(1, totalAmount);
            psOrder.setString(2, "CONFERMATO"); // Stato di default
            // CORRETTO
            psOrder.setDate(3, new java.sql.Date(System.currentTimeMillis()));
            psOrder.setString(4, userEmail);
            psOrder.executeUpdate();
            // 3. Recupera l'ID dell'ordine appena creato
            generatedKeys = psOrder.getGeneratedKeys();
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            } else {
                conn.rollback();
                throw new SQLException("Creazione ordine fallita, nessun ID ottenuto.");
            }
            // 4. Inserisci tutti i dettagli dell'ordine
            psDetails = conn.prepareStatement(insertDetailsSQL);
            for (CarItem item : cart) {

                // (Non ci servono più le stringhe per packages e accessories)

                // Simuliamo marca e anno (come prima)
                String carName = item.getName();
                String carBrand = "Sconosciuta";
                int carYear = 2024;

                String lowerName = carName.toLowerCase();

                if (lowerName.contains("ferrari") || lowerName.contains("sf90") || lowerName.contains("roma")
                        || lowerName.contains("296") || lowerName.contains("812") || lowerName.contains("laferrari")
                        || lowerName.contains("enzo") || lowerName.contains("f40") || lowerName.contains("portofino")
                        || lowerName.contains("f8"))
                    carBrand = "Ferrari";
                else if (lowerName.contains("lamborghini") || lowerName.contains("revuelto")
                        || lowerName.contains("huracan") || lowerName.contains("aventador")
                        || lowerName.contains("urus") || lowerName.contains("countach") || lowerName.contains("sian"))
                    carBrand = "Lamborghini";
                else if (lowerName.contains("porsche") || lowerName.contains("911") || lowerName.contains("taycan")
                        || lowerName.contains("panamera") || lowerName.contains("macan")
                        || lowerName.contains("cayenne") || lowerName.contains("718") || lowerName.contains("carrera"))
                    carBrand = "Porsche";
                else if (lowerName.contains("mclaren") || lowerName.contains("720s") || lowerName.contains("765lt")
                        || lowerName.contains("artura") || lowerName.contains("p1") || lowerName.contains("senna")
                        || lowerName.contains("speedtail") || lowerName.contains("elva") || lowerName.contains("gt"))
                    carBrand = "McLaren";
                else if (lowerName.contains("bugatti") || lowerName.contains("chiron") || lowerName.contains("divo")
                        || lowerName.contains("veyron") || lowerName.contains("bolide")
                        || lowerName.contains("mistral"))
                    carBrand = "Bugatti";
                else if (lowerName.contains("koenigsegg") || lowerName.contains("jesko") || lowerName.contains("gemera")
                        || lowerName.contains("regera") || lowerName.contains("agera") || lowerName.contains("one:1")
                        || lowerName.contains("attackodin"))
                    carBrand = "Koenigsegg";

                // *** MODIFICA QUI ***
                // Impostiamo solo i 6 parametri richiesti
                psDetails.setInt(1, orderId);
                psDetails.setInt(2, item.getQty());
                psDetails.setDouble(3, item.getTotalPrice()); // Prezzo configurato
                psDetails.setString(4, carBrand);
                psDetails.setString(5, item.getName());
                psDetails.setInt(6, item.getYear()); // FIXED: Use actual year from item

                // (Tutte le righe da 7 a 12 per i dati di configurazione sono state rimosse)

                psDetails.addBatch();
            }
            psDetails.executeBatch(); // FIXED: Execute the batch!

            // 5. Aggiorna lo stock per ogni auto
            String updateStockSQL = "UPDATE auto SET quantita_stock = quantita_stock - ? WHERE modello = ? AND anno = ?";
            try (PreparedStatement psStock = conn.prepareStatement(updateStockSQL)) {
                for (CarItem item : cart) {
                    psStock.setInt(1, item.getQty());
                    psStock.setString(2, item.getName()); // Nome modello (es. "Lamborghini Revuelto")
                    psStock.setInt(3, item.getYear());
                    psStock.addBatch();
                }
                psStock.executeBatch();
            }

            conn.commit(); // Finalizza la transazione

            return orderId; // Restituisce l'ID dell'ordine creato
        } catch (SQLException e) {
            if (conn != null)
                conn.rollback(); // Annulla tutto se c'è un errore
            e.printStackTrace();
            throw e;
        } finally {
            // Chiusura risorse
            if (generatedKeys != null)
                try {
                    generatedKeys.close();
                } catch (SQLException e) {
                    /* ignored */ }
            if (psOrder != null)
                try {
                    psOrder.close();
                } catch (SQLException e) {
                    /* ignored */ }
            if (psDetails != null)
                try {
                    psDetails.close();
                } catch (SQLException e) {
                    /* ignored */ }
            if (conn != null)
                DBConnection.releaseConnection(conn);
        }
    }
}