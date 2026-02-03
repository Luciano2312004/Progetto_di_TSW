CREATE DATABASE IF NOT EXISTS FastMotors;

USE FastMotors;

CREATE TABLE IF NOT EXISTS indirizzo(
	id INT PRIMARY KEY AUTO_INCREMENT,
    via VARCHAR(50),
    provincia VARCHAR(50),
    cap CHAR(5),
	civico VARCHAR(4)
);

CREATE TABLE IF NOT EXISTS utente(
	indirizzo_email VARCHAR(80) PRIMARY KEY,
    passwordhash VARCHAR(150),
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    indirizzo INT,
    FOREIGN KEY (indirizzo) REFERENCES indirizzo(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS administrator(
	indirizzo_email VARCHAR(80) PRIMARY KEY,
	passwordhash VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS ordine(
	id INT PRIMARY KEY AUTO_INCREMENT,
    totale DECIMAL (10, 2) NOT NULL,
    stato ENUM('CONFERMATO', 'SPEDITO', 'CONSEGNATO') NOT NULL,
    data_ordine DATE NOT NULL,
    utente VARCHAR(80),
    FOREIGN KEY(utente) REFERENCES utente(indirizzo_email) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS fattura(
	id INT PRIMARY KEY AUTO_INCREMENT,
    data_emissione DATE NOT NULL,
    totale DECIMAL(10, 2) NOT NULL,
    dettagli TEXT NOT NULL,
    ordine INT,
    FOREIGN KEY (ordine) REFERENCES ordine(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS carrello (
	id INT PRIMARY KEY AUTO_INCREMENT,
    utente VARCHAR(80),
    FOREIGN KEY (utente) REFERENCES utente(indirizzo_email) ON DELETE SET NULL
);

-- AUTO senza id, identificata da (modello, anno)
CREATE TABLE IF NOT EXISTS auto(
    specifiche TEXT,
    iva DECIMAL(4, 2),
    prezzo DECIMAL(10, 2),
    quantita_stock INT UNSIGNED,
    marca VARCHAR(20),
    modello VARCHAR(50) NOT NULL,
    anno YEAR NOT NULL,
    PRIMARY KEY (modello, anno)
);

-- aggiornamento riferimenti
CREATE TABLE IF NOT EXISTS articolo_nel_carrello(
	id INT PRIMARY KEY AUTO_INCREMENT,
    quantita INT,
    modello VARCHAR(50) NOT NULL,
    anno YEAR NOT NULL,
    carrello INT NOT NULL,
    FOREIGN KEY (modello, anno) REFERENCES auto(modello, anno) ON DELETE RESTRICT,
    FOREIGN KEY (carrello) REFERENCES carrello(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS dettagli_ordine(
	id INT PRIMARY KEY AUTO_INCREMENT,
    quantita INT UNSIGNED NOT NULL,
    prezzo DECIMAL(10, 2) NOT NULL,
    modello VARCHAR(50) NOT NULL,
    anno YEAR NOT NULL,
    ordine INT,
    FOREIGN KEY (modello, anno) REFERENCES auto(modello, anno) ON DELETE RESTRICT,
    FOREIGN KEY (ordine) REFERENCES ordine(id) ON DELETE CASCADE
);