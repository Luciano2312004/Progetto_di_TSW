package model;


import java.io.Serializable;

public class Utente {
    private String email;
    private String nome;
    private String cognome;
    private String telefono;
    private int indirizzo;
    private String ruolo; // "utente" o "admin"

    // Costruttore
    public Utente(String email, String nome, String cognome, String telefono, int indirizzo, String ruolo) {
        this.email = email;
        this.nome = nome;
        this.cognome = cognome;
        this.telefono = telefono;
        this.indirizzo = indirizzo;
        this.ruolo = ruolo;
    }

    // Getters & Setters
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public int getIndirizzo() { return indirizzo; }
    public void setIndirizzo(int indirizzo) { this.indirizzo = indirizzo; }

    public String getRuolo() { return ruolo; }
    public void setRuolo(String ruolo) { this.ruolo = ruolo; }
}