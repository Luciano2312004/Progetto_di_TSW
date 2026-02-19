# FastMotors 🏎️

Benvenuti in **FastMotors**, la piattaforma definitiva per gli amanti delle auto di lusso.

## 🌟 Di cosa si tratta
FastMotors non è solo un catalogo online: è un'esperienza immersiva nel mondo delle supercar. Offriamo agli utenti la possibilità di esplorare i modelli più esclusivi dei marchi più prestigiosi al mondo, come **Ferrari, Lamborghini, Porsche, McLaren, Bugatti e Koenigsegg**.

Ma la vera magia avviene nel nostro **Configuratore 3D**: uno strumento potente e interattivo che permette ai clienti di personalizzare ogni dettaglio della loro auto dei sogni. Dai colori della carrozzeria ai cerchi in lega, dagli interni in pelle ai pacchetti performance, ogni scelta viene visualizzata istantaneamente, trasformando il sogno in realtà digitale pronta per l'acquisto.

## 🚀 Prerequisiti
Prima di iniziare, assicurati di avere installato sul tuo sistema:
*   **JDK 11** o superiore.
*   **Apache Tomcat 9** o superiore.
*   Un server **MySQL** (o un altro DB compatibile).
*   Un IDE come **IntelliJ IDEA** o **Eclipse for Enterprise Java and Web Developers**.

## 🛠️ Installazione e Avvio
Segui questi passaggi per avviare il progetto in locale:

1.  **Clona il repository**:
    ```bash
    git clone https://github.com/luca-afe/Progetto_di_TSW.git
    ```

2.  **Configura il database**:
    *   Crea un nuovo database vuoto chiamato `FastMotors`.
    *   Importa lo schema e i dati iniziali eseguendo il file SQL che trovi in:
        `Database/Seed.sql`
    *   Apri il file di configurazione del database nel progetto:
        `src/main/java/utils/DBConnection.java`
    *   Modifica le costanti `USER` e `PASSWORD` con le tue credenziali locali di MySQL:
        ```java
        private static final String USER = "root";
        private static final String PASSWORD = "la_tua_password";
        ```

3.  **Esegui il deploy su Tomcat**:
    *   Apri il progetto nel tuo IDE.
    *   Configura un server Tomcat.
    *   Aggiungi l'artefatto del progetto al deployment.
    *   Avvia il server.

4.  **Apri l'applicazione**:
    Vai nel tuo browser all'indirizzo:
    [http://localhost:8080/FastMotors](http://localhost:8080/FastMotors)
    *(L'URL potrebbe variare in base alla configurazione del context path nel tuo IDE)*

## 📂 Struttura del Progetto
*   `src/main/java`: Codice sorgente Java (Model, Control, Utils).
*   `src/main/webapp`: Pagine JSP, CSS, JavaScript e risorse statiche (immagini).
*   `Database`: Script SQL per la creazione e popolamento del database.

## 👥 Autori
Il progetto è stato realizzato con passione da:

*   **Luca Afeltra** - [GitHub](https://github.com/luca-afe)
*   **Alessandro Cigliano** - [GitHub](https://github.com/AleCigliano089)
*   **Luciano Corvino** - [GitHub](https://github.com/lucianocorvino23-design)
