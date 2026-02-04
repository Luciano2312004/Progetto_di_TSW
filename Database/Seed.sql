CREATE DATABASE IF NOT EXISTS FastMotors;
USE FastMotors;

-- Indirizzo
CREATE TABLE IF NOT EXISTS indirizzo(
  id INT PRIMARY KEY AUTO_INCREMENT,
  via VARCHAR(50),
  provincia VARCHAR(50),
  cap CHAR(5),
  civico VARCHAR(4)
);

-- Utente
CREATE TABLE IF NOT EXISTS utente(
  indirizzo_email VARCHAR(80) PRIMARY KEY,
  passwordhash VARCHAR(150),
  nome VARCHAR(50) NOT NULL,
  cognome VARCHAR(50) NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  indirizzo INT,
  FOREIGN KEY (indirizzo) REFERENCES indirizzo(id) ON DELETE SET NULL
);

-- Administrator (come nel primo script)
CREATE TABLE IF NOT EXISTS administrator(
  indirizzo_email VARCHAR(80) PRIMARY KEY,
  passwordhash VARCHAR(150)
);

-- Ordine
CREATE TABLE IF NOT EXISTS ordine(
  id INT PRIMARY KEY AUTO_INCREMENT,
  totale DECIMAL(10, 2) NOT NULL,
  stato ENUM('CONFERMATO', 'SPEDITO', 'CONSEGNATO') NOT NULL,
  data_ordine DATE NOT NULL,
  utente VARCHAR(80),
  FOREIGN KEY (utente) REFERENCES utente(indirizzo_email) ON DELETE SET NULL
);

-- Fattura
CREATE TABLE IF NOT EXISTS fattura(
  id INT PRIMARY KEY AUTO_INCREMENT,
  data_emissione DATE NOT NULL,
  totale DECIMAL(10, 2) NOT NULL,
  dettagli TEXT NOT NULL,
  ordine INT,
  FOREIGN KEY (ordine) REFERENCES ordine(id) ON DELETE CASCADE
);

-- Carrello
CREATE TABLE IF NOT EXISTS carrello (
  id INT PRIMARY KEY AUTO_INCREMENT,
  utente VARCHAR(80),
  FOREIGN KEY (utente) REFERENCES utente(indirizzo_email) ON DELETE SET NULL
);

-- Auto (PK composta modello+anno, nessun id)
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

-- Articolo nel carrello (agganciato a PK composta di auto)
CREATE TABLE IF NOT EXISTS articolo_nel_carrello(
  id INT PRIMARY KEY AUTO_INCREMENT,
  quantita INT,
  modello VARCHAR(50) NOT NULL,
  anno YEAR NOT NULL,
  carrello INT NOT NULL,
  FOREIGN KEY (modello, anno) REFERENCES auto(modello, anno) ON DELETE RESTRICT,
  FOREIGN KEY (carrello) REFERENCES carrello(id) ON DELETE CASCADE
);

-- Dettagli ordine (agganciato a PK composta di auto)
CREATE TABLE IF NOT EXISTS dettagli_ordine(
  id INT PRIMARY KEY AUTO_INCREMENT,
  quantita INT UNSIGNED NOT NULL,
  prezzo DECIMAL(10, 2) NOT NULL,
  marca VARCHAR (30) NOT NULL,
  modello VARCHAR(50) NOT NULL,
  anno YEAR NOT NULL,
  ordine INT,
  FOREIGN KEY (modello, anno) REFERENCES auto(modello, anno) ON DELETE RESTRICT,
  FOREIGN KEY (ordine) REFERENCES ordine(id) ON DELETE CASCADE
);

-- === SOLO INSERIMENTO AUTO (adattato alla PK composta) ===
INSERT INTO auto (modello, anno, marca, specifiche, iva, prezzo, quantita_stock) VALUES
('La Ferrari',        2016, 'Ferrari',     'Motore V12, 900 CV, ibrido',                              22.00, 2300000.00, 1),
('Aventador',         2021, 'Lamborghini', 'Motore V10, 770 CV, trazione integrale',                  22.00,  450000.00, 1),
('SF90',              2019, 'Ferrari',     'Motore V8 biturbo, 1030 CV, ibrido plug-in',              22.00,  440000.00, 1),
('911 Carrera 4S',    2023, 'Porsche',     'Motore boxer 3.0L biturbo, 450 CV, interni in pelle',     22.00,  190000.00, 2),
('720',               2022, 'McLaren',     'Motore V8 4.0L, 720 CV, telaio in carbonio',              22.00,  290000.00, 1),
('Chiron',            2016, 'Bugatti',     'Motore W16, 1500 CV, velocità massima 420 km/h',          22.00, 2400000.00, 1),
('P1',                2013, 'McLaren',     'Motore V8 Biturbo, 900 CV, ibrido',                       22.00, 4000000.00, 1),
('918',               2023, 'Porsche',     'Motore V8 4.0L, 620 CV, pacchetto sportivo plus',         22.00,  195000.00, 2),
('AttackOdin',        2022, 'Koenigsegg',  'Motore V8 5.0L, 1160 CV, carrozzeria in carbonio',        22.00,  350000.00, 1),
('Ferrari F8',        2019, 'Ferrari',     'Motore V8, 720 CV, cambio F1',                            22.00,  275000.00, 1),
('Ferrari 812',       2019, 'Ferrari',     'Motore V12, 800 CV, aspirato',                            22.00,  365000.00, 1),
('Lamborghini revuelto', 2024, 'Lamborghini','Motore V12 aspirato ibrido, 1000 CV, trazione integrale',22.00,  580000.00, 1),
('Agera',             2010, 'Koenigsegg',  'Motore V8 biturbo, 1100 CV, alesaggio 92 mm',             22.00, 2000000.00, 1),
('Bugatti divo',      2019, 'Bugatti',     'Motore W16, 1500 CV, edizione limitata',                  22.00, 4800000.00, 1),
('Koenigsegg Regera', 2016, 'Koenigsegg',  'Motore biturbo 5.0 V8, 1500 CV, ibrido',                  22.00, 2000000.00, 1),
('Lamborghini sian',  2022, 'Lamborghini', 'Motore V12 aspirato ibrido, 800 CV, edizione limitata',   22.00, 2100000.00, 1),
('Lamborghini veneno',2013, 'Lamborghini', 'Motore V12 ibrido, 750 CV, carrozzeria in carbonio',      22.00, 3900000.00, 1),
('Ferrari Enzo',      2003, 'Ferrari',     'Motore V12, 660 CV, cambio sequenziale',                  22.00,  665000.00, 1);

USE FastMotors; 
UPDATE auto SET quantita_stock = 0 WHERE marca = 'Ferrari' AND modello = 'La Ferrari' AND anno = 2016;
INSERT INTO utente (indirizzo_email, passwordhash, nome, cognome, telefono, indirizzo)
VALUES (
  'test.user@email.com',
  SHA2('user1234', 512),
  'Mario',
  'Rossi',
  '+39123456789',
NULL
);
SELECT * FROM utente WHERE indirizzo_email = 'test.user@email.com';
INSERT INTO ordine (totale, stato, data_ordine, utente) 
VALUES (665000.00, 'CONFERMATO', CURDATE(), 'test.user@email.com');
INSERT INTO ordine (totale, stato, data_ordine, utente) 
VALUES (3900000.00, 'SPEDITO', CURDATE(), 'test.user@email.com');
SELECT * FROM ordine WHERE totale = 475000.00;
INSERT INTO fattura (data_emissione, totale, dettagli, ordine)
VALUES (CURRENT_DATE, 665000.00, 'test', 1);
INSERT INTO fattura (data_emissione, totale, dettagli, ordine)
VALUES (CURRENT_DATE, 3900000.00, 'test', 2);
SELECT * FROM fattura WHERE totale = 465000.00;
INSERT INTO dettagli_ordine (id, quantita, prezzo, marca, modello, anno, ordine)
VALUES (1, 1, 665000.00, 'ferrari', 'Ferrari Enzo', 2003, 1);
INSERT INTO dettagli_ordine (id, quantita, prezzo, marca, modello, anno, ordine)
VALUES (2, 1, 3900000.00, 'Lamborghini', 'Lamborghini veneno', 2013, 2);
SELECT * FROM dettagli_ordine WHERE id = 2;

INSERT INTO administrator (indirizzo_email, passwordhash)
VALUES (
  'admin@fastmotors.it',
  SHA2('admin123', 512)
);
