package model;

import java.math.BigDecimal;

public class Auto {
    private String marca;
    private String modello;
    private int anno;
    private double prezzo;
    private double iva;
    private int quantitaStock;
    private String specifiche;

    // === Costruttori ===

    // Costruttore richiesto dal progetto principale (compatibile 100%)
    public Auto(String marca, String modello, int anno, double prezzo, double iva, int quantitaStock, String specifiche) {
        this.marca = marca;
        this.modello = modello;
        this.anno = anno;
        this.prezzo = prezzo;
        this.iva = iva;
        this.quantitaStock = quantitaStock;
        this.specifiche = specifiche;
    }

    // Aggiungo costruttore vuoto (comodo per mappe via setter / JSP / framework)
    public Auto() {}

    // Facoltativo: costruttore compatibile con il secondo progetto (converte BigDecimal -> double)
    public Auto(String modello, int anno, String specifiche, BigDecimal iva, BigDecimal prezzo, int quantitaStock, String marca) {
        this(
            marca,
            modello,
            anno,
            prezzo != null ? prezzo.doubleValue() : 0.0,
            iva != null ? iva.doubleValue() : 0.0,
            quantitaStock,
            specifiche
        );
    }

    // === Getter e Setter (immutati per compatibilità) ===
    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }
    public String getModello() { return modello; }
    public void setModello(String modello) { this.modello = modello; }
    public int getAnno() { return anno; }
    public void setAnno(int anno) { this.anno = anno; }
    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }
    public double getIva() { return iva; }
    public void setIva(double iva) { this.iva = iva; }
    public int getQuantitaStock() { return quantitaStock; }
    public void setQuantitaStock(int quantitaStock) { this.quantitaStock = quantitaStock; }
    public String getSpecifiche() { return specifiche; }
    public void setSpecifiche(String specifiche) { this.specifiche = specifiche; }

    // === Utility portate dal secondo modello ===
    public boolean isDisponibile() {
        return quantitaStock > 0;
    }

    public String getChiaveIdentificativa() {
        return (modello != null ? modello : "N/A") + "_" + anno;
    }

    @Override
    public String toString() {
        return "Auto{" +
                "modello='" + modello + '\'' +
                ", anno=" + anno +
                ", marca='" + marca + '\'' +
                ", prezzo=" + prezzo +
                ", quantitaStock=" + quantitaStock +
                '}';
    }
}
