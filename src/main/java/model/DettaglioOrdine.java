package model;

public class DettaglioOrdine {
    private String modello;
    private int anno;
    private int quantita;
    private double prezzo;
    private String marca;
    public DettaglioOrdine() {}

    public DettaglioOrdine(String modello, int anno, int quantita, double prezzo, String marca) {
    	this.marca=marca;
        this.modello = modello;
        this.anno = anno;
        this.quantita = quantita;
        this.prezzo = prezzo;
    }
    
    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public String getModello() { return modello; }
    public void setModello(String modello) { this.modello = modello; }

    public int getAnno() { return anno; }
    public void setAnno(int anno) { this.anno = anno; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }
}
