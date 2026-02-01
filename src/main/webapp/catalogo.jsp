<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="it">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Catalogo Fast Motors</title>

    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="./catalogo.css?v=2">
  </head>

  <body>
    <jsp:include page="WEB-INF/fragments/header.jsp" />

    <div class="container">
      <header>
        <div class="logo-container">
          <img src="images/logo2.png" class="Fast" alt="Fast Motors Logo">
        </div>
        <h1>Auto da Sogno, Realtà da Vivere</h1>
        <p class="subtitle">Viaggio tra i gioielli dell'ingegneria automobilistica</p>
      </header>

      <div class="filters-row">
        <div class="ordinamento-container">
          <button class="ordina-btn">Ordina &#9660;</button>
          <div class="ordina-contenuto">
            <div data-ordine="prezzo-crescente">Prezzo (crescente)</div>
            <div data-ordine="prezzo-decrescente">Prezzo (decrescente)</div>
            <div data-ordine="anno-crescente">Anno (crescente)</div>
            <div data-ordine="anno-decrescente">Anno (decrescente)</div>
            <div data-ordine="potenza-crescente">Potenza (crescente)</div>
            <div data-ordine="potenza-decrescente">Potenza (decrescente)</div>
          </div>
        </div>

        <div class="filtro-tendina">
          <button class="filtro-btn">Filtra per Marca &#9660;</button>
          <div class="filtro-contenuto">
            <div data-marca="tutte">Tutte le auto</div>
            <div data-marca="ferrari">Ferrari <img src="images/Ferrari.png" class="logo-img"></div>
            <div data-marca="lamborghini">Lamborghini<img src="images/Lamborghini.png" class="logo-img"></div>
            <div data-marca="porsche">Porsche<img src="images/porsche.png" class="logo-img"></div>
            <div data-marca="mclaren">McLaren<img src="images/mclaren.png" class="logo-img"></div>
            <div data-marca="bugatti">Bugatti<img src="images/bugatti.png" class="logo-img"></div>
            <div data-marca="koenigsegg">Koenigsegg<img src="images/koenigsegg.png" class="logo-img"></div>
          </div>
        </div>
      </div>

      <!-- Container descrizione brand (Inizialmente nascosto) -->
      <div id="scritta-catalogo"
        style="display: none; background: #f9f9f9; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 5px solid #d32f2f; position: relative;">
        <button id="chiudi-scritta"
          style="position: absolute; top: 10px; right: 15px; border: none; background: transparent; font-size: 20px; cursor: pointer;">&times;</button>
        <p id="testo-brand" style="margin: 0; font-size: 1.1em; line-height: 1.6; color: #333;"></p>
      </div>

      <div class="filtro-prezzo-separato">
        <button class="filtro-prezzo-btn">Filtra per Prezzo</button>
        <div class="filtro-prezzo-box">
          <input type="number" id="prezzo-min" placeholder="Prezzo min (€)" min="0">
          <input type="number" id="prezzo-max" placeholder="Prezzo max (€)" min="0">
          <button id="applica-filtro-prezzo">Applica</button>
          <button id="reset-filtro-prezzo">Azzera Filtro</button>
        </div>
      </div>

      <!-- Messaggio Nessun Risultato -->
      <div id="no-results-message" style="display: none; text-align: center; padding: 40px; margin: 20px 0;">
        <i class="ri-roadster-line" style="font-size: 48px; color: #ccc; margin-bottom: 20px; display: block;"></i>
        <h3 style="font-size: 1.5em; color: #333; margin-bottom: 10px;">Sembra che non ci siano auto che rispecchiano i
          tuoi filtri</h3>
        <p style="color: #666;">Prova a modificare i criteri di ricerca o resetta i filtri.</p>
        <button onclick="document.querySelector('.filtro-contenuto div[data-marca=tutte]').click()"
          style="margin-top: 20px; padding: 10px 20px; background: #333; color: white; border: none; border-radius: 5px; cursor: pointer;">Mostra
          tutte le auto</button>
      </div>

      <div class="catalogo"><!-- popolato dal database --></div>
    </div>

    <script src="catalogo.js?v=4" defer></script>
  </body>

  </html>