package model;

import java.util.Date;

public class Fattura {
    private int id;
    private Date dataEmissione;
    private double totale;
    private String dettagli;
    private int ordineId;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getDataEmissione() { return dataEmissione; }
    public void setDataEmissione(Date dataEmissione) { this.dataEmissione = dataEmissione; }
    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }
    public String getDettagli() { return dettagli; }
    public void setDettagli(String dettagli) { this.dettagli = dettagli; }
    public int getOrdineId() { return ordineId; }
    public void setOrdineId(int ordineId) { this.ordineId = ordineId; }
}
