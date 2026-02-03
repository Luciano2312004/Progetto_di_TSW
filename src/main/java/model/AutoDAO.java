package model;

import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * AutoDAO unificato: compatibile con il progetto originale (package model,
 * utils.DBConnection)
 * e arricchito con i metodi utility del secondo DAO.
 *
 * Assunzioni:
 * - Tabella: auto(marca, modello, anno, prezzo, iva, quantita_stock,
 * specifiche)
 * - PK logica: (modello, anno)
 * - Classe model.Auto:
 * - costruttore Auto(String marca, String modello, int anno, double prezzo,
 * double iva, int quantitaStock, String specifiche)
 * - getter/setter con double per prezzo/iva
 */
public class AutoDAO {

    // === Helper di mapping ===
    private Auto mapResultSetToAuto(ResultSet rs) throws SQLException {
        return new Auto(
                rs.getString("marca"),
                rs.getString("modello"),
                rs.getInt("anno"),
                rs.getDouble("prezzo"),
                rs.getDouble("iva"),
                rs.getInt("quantita_stock"),
                rs.getString("specifiche"));
    }

    // === METODI DI LETTURA BASE ===

    /** Recupera tutte le auto (ordinate per marca, modello, anno) */
    public List<Auto> getAll() throws SQLException {
        List<Auto> lista = new ArrayList<>();
        String sql = "SELECT marca, modello, anno, prezzo, iva, quantita_stock, specifiche " +
                "FROM auto ORDER BY marca, modello, anno";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToAuto(rs));
            }
        }
        return lista;
    }

    /** Recupera un'auto per chiave primaria (modello + anno) */
    public Auto getByPK(String modello, int anno) throws SQLException {
        String sql = "SELECT marca, modello, anno, prezzo, iva, quantita_stock, specifiche " +
                "FROM auto WHERE modello=? AND anno=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, modello);
            ps.setInt(2, anno);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAuto(rs);
                }
            }
        }
        return null;
    }

    // === METODI DI LETTURA ESTESI ===

    /** Recupera solo le auto con stock > 0 */
    public List<Auto> getAutoDisponibili() throws SQLException {
        List<Auto> lista = new ArrayList<>();
        String sql = "SELECT marca, modello, anno, prezzo, iva, quantita_stock, specifiche " +
                "FROM auto WHERE quantita_stock > 0 ORDER BY marca, modello, anno";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapResultSetToAuto(rs));
            }
        }
        return lista;
    }

    /** Verifica se una specifica auto (modello+anno) è disponibile (stock > 0) */
    public boolean isAutoDisponibile(String modello, int anno) throws SQLException {
        String sql = "SELECT quantita_stock FROM auto WHERE modello=? AND anno=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, modello);
            ps.setInt(2, anno);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("quantita_stock") > 0;
                }
            }
        }
        return false;
    }

    /** Ritorna le auto disponibili raggruppate per marca */
    public Map<String, List<Auto>> getAutoPerMarca() throws SQLException {
        Map<String, List<Auto>> perMarca = new LinkedHashMap<>();
        for (Auto auto : getAutoDisponibili()) {
            perMarca.computeIfAbsent(auto.getMarca(), k -> new ArrayList<>()).add(auto);
        }
        return perMarca;
    }

    // === CRUD ===

    /** Inserisce una nuova auto */
    public void insert(Auto auto) throws SQLException {
        String sql = "INSERT INTO auto (marca, modello, anno, prezzo, iva, quantita_stock, specifiche) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, auto.getMarca());
            ps.setString(2, auto.getModello());
            ps.setInt(3, auto.getAnno());
            ps.setDouble(4, auto.getPrezzo()); // double
            ps.setDouble(5, auto.getIva()); // double
            ps.setInt(6, auto.getQuantitaStock());
            ps.setString(7, auto.getSpecifiche());

            ps.executeUpdate();
        }
    }

    /** Aggiorna tutti i campi eccetto (modello, anno) che identificano l'auto */
    public void update(Auto auto) throws SQLException {
        String sql = "UPDATE auto SET marca=?, prezzo=?, iva=?, quantita_stock=?, specifiche=? " +
                "WHERE modello=? AND anno=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, auto.getMarca());
            ps.setDouble(2, auto.getPrezzo()); // double
            ps.setDouble(3, auto.getIva()); // double
            ps.setInt(4, auto.getQuantitaStock());
            ps.setString(5, auto.getSpecifiche());
            ps.setString(6, auto.getModello());
            ps.setInt(7, auto.getAnno());

            ps.executeUpdate();
        }
    }

    /**
     * Aggiorna solo la quantità a stock; ritorna true se almeno una riga è stata
     * aggiornata
     */
    public boolean aggiornaQuantitaStock(String modello, int anno, int nuovaQuantita) throws SQLException {
        String sql = "UPDATE auto SET quantita_stock=? WHERE modello=? AND anno=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, nuovaQuantita);
            ps.setString(2, modello);
            ps.setInt(3, anno);

            int updated = ps.executeUpdate();
            return updated > 0;
        }
    }

    /** Elimina un'auto per chiave primaria */
    public void delete(String modello, int anno) throws SQLException {
        String sql = "DELETE FROM auto WHERE modello=? AND anno=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, modello);
            ps.setInt(2, anno);
            ps.executeUpdate();
        }
    }

    /** Ricerca auto per nome (marca o modello) */
    public List<Auto> searchByName(String query) throws SQLException {
        List<Auto> lista = new ArrayList<>();
        String sql = "SELECT marca, modello, anno, prezzo, iva, quantita_stock, specifiche " +
                "FROM auto WHERE (marca LIKE ? OR modello LIKE ?) AND quantita_stock > 0 ORDER BY marca, modello";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            String likeQuery = "%" + query + "%";
            ps.setString(1, likeQuery);
            ps.setString(2, likeQuery);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapResultSetToAuto(rs));
                }
            }
        }
        return lista;
    }
}
