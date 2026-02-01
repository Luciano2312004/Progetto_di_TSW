package model;

import java.util.Date;
import java.util.List;

public class Ordine {
    private int id;
    private double totale;
    private String stato;
    private Date dataOrdine;
    private String utenteEmail;
    private List<DettaglioOrdine> dettagli;

    // Getter e Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }
    public String getStato() { return stato; }
    public void setStato(String stato) { this.stato = stato; }
    public Date getDataOrdine() { return dataOrdine; }
    public void setDataOrdine(Date dataOrdine) { this.dataOrdine = dataOrdine; }
    public String getUtenteEmail() { return utenteEmail; }
    public void setUtenteEmail(String utenteEmail) { this.utenteEmail = utenteEmail; }
    public List<DettaglioOrdine> getDettagli() { return dettagli; }
    public void setDettagli(List<DettaglioOrdine> dettagli) { this.dettagli = dettagli; }
}
