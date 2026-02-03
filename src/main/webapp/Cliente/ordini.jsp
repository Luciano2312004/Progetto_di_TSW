<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>I miei Ordini - FastMotors</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* RESET BASE (normalizza padding/margini di default su tutta la pagina) */
        * { 
            box-sizing: border-box; 
            margin: 0;
            padding: 0;
        }
        
        /* STILE GENERALE PAGINA (sfondo grigio + font + spaziatura esterna) */
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #f5f5f5;
            color: #2d2d2d;
            line-height: 1.6;
            padding: 20px;
        }
        
        /* CONTENITORE PRINCIPALE (box bianco centrato che contiene tutta la pagina) */
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: #ffffff; 
            padding: 48px;
            border-radius: 2px; 
            box-shadow: 0 1px 4px rgba(0,0,0,0.04);
        }
        
        /* TITOLO PAGINA "I miei Ordini" (con linea divisoria sotto) */
        h1 { 
            color: #1a1a1a;
            font-size: 2rem;
            font-weight: 600;
            letter-spacing: -0.5px;
            margin-bottom: 8px;
            padding-bottom: 16px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        /* BLOCCO STATISTICHE (le 2 card "Totale ordini" / "Ordini attivi") */
        .stats { 
            display: flex;
            gap: 16px;
            margin: 32px 0;
        }
        
        /* CARD STATISTICHE (aspetto delle singole card) */
        .stat-card { 
            flex: 1;
            background: #fafafa; 
            padding: 20px; 
            border-radius: 2px;
            border: 1px solid #f0f0f0;
            transition: all 0.2s ease;
        }
        
        /* EFFETTO HOVER CARD STATISTICHE */
        .stat-card:hover {
            background: #f5f5f5;
            border-color: #e0e0e0;
        }
        
        /* TESTO ETICHETTA STATISTICA (es. "Totale Ordini") */
        .stat-label {
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        
        /* NUMERO STATISTICA (es. 3, 10...) */
        .stat-value {
            font-size: 28px;
            font-weight: 600;
            color: #1a1a1a;
            letter-spacing: -0.5px;
        }
        
        /* TABELLA ORDINI (vista desktop) */
        .orders-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 24px;
            font-size: 14px;
        }
        
        /* CELLE TABELLA (spaziature + separatori riga) */
        .orders-table th, .orders-table td { 
            padding: 16px; 
            text-align: left; 
            vertical-align: top;
            border-bottom: 1px solid #f0f0f0;
        }
        
        /* INTESTAZIONE TABELLA (riga con "ID Ordine, Data, Totale...") */
        .orders-table th { 
            background: #fafafa;
            color: #666;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        /* HOVER RIGHE TABELLA (evidenzia riga ordine al passaggio del mouse) */
        .orders-table tbody tr { 
            transition: all 0.2s ease;
        }
        
        .orders-table tbody tr:hover { 
            background: #fafafa;
        }
        
        /* COLORI STATO ORDINE (span in colonna "Stato") */
        .status-confermato { 
            color: #f39c12; 
            font-weight: 500;
            font-size: 13px;
        }
        
        .status-spedito { 
            color: #3498db; 
            font-weight: 500;
            font-size: 13px;
        }
        
        .status-consegnato { 
            color: #27ae60; 
            font-weight: 500;
            font-size: 13px;
        }
        
        /* MESSAGGIO "Nessun ordine trovato" (vista quando ordini è vuoto) */
        .empty-state { 
            text-align: center; 
            padding: 80px 20px;
            color: #666; 
        }
        
        .empty-state h3 {
            font-size: 20px;
            color: #1a1a1a;
            margin-bottom: 8px;
            font-weight: 600;
        }
        
        .empty-state p {
            color: #666;
            margin-bottom: 24px;
        }
        
        /* BLOCCO ERRORE (se ${error} è presente) */
        .error { 
            color: #e74c3c; 
            padding: 16px; 
            background: #fafafa;
            border-radius: 2px;
            margin-bottom: 24px;
            border: 1px solid #e74c3c;
            font-size: 14px;
        }
        
        /* LINK "Torna alla Home" / "Inizia a fare shopping" (stile bottone) */
        .back-link { 
            display: inline-block; 
            margin-top: 32px; 
            color: #1a1a1a;
            text-decoration: none; 
            padding: 12px 24px;
            border: 1px solid #e0e0e0;
            border-radius: 2px;
            font-weight: 500;
            font-size: 14px;
            letter-spacing: 0.3px;
            transition: all 0.2s ease;
        }
        
        .back-link:hover { 
            background: #1a1a1a;
            color: white;
            border-color: #1a1a1a;
            text-decoration: none;
            transform: translateY(-1px);
        }

        /* COLONNA DETTAGLI (stile testo e righe nella cella "Dettagli") */
        .col-dettagli { 
            font-size: 13px;
            line-height: 1.6;
            color: #666;
        }
        
        .dettaglio-riga { 
            padding: 6px 0; 
            border-bottom: 1px solid #f5f5f5;
        }
        
        .dettaglio-riga:last-child { 
            border-bottom: none; 
        }
        
        .d-marca { 
            font-weight: 500;
            color: #1a1a1a;
        }
        
        /* PREZZO NEI DETTAGLI (evita che vada a capo) */
        .d-prezzo { 
            white-space: nowrap;
            font-weight: 500;
            color: #1a1a1a;
        }
        
        /* RIGA CLICCABILE IN TABELLA (cambia cursore per suggerire click) */
        .row-link { 
            cursor: pointer;
        }

        /* STILE ID ORDINE (colonna #123) */
        .order-id {
            font-weight: 500;
            color: #1a1a1a;
        }

        /* LISTA ORDINI MOBILE (card: nascosta su desktop, visibile su mobile via media query) */
        .mobile-orders {
            display: none;
            flex-direction: column;
            gap: 16px;
            margin-top: 24px;
        }

        /* CARD ORDINE (vista mobile) */
        .order-card {
            background: white;
            border: 1px solid #f0f0f0;
            border-radius: 2px;
            padding: 20px;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        /* Hover card: effetto “alzata” */
        .order-card:hover {
            border-color: #e0e0e0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            transform: translateY(-2px);
        }

        /* Pressione su mobile (tap) */
        .order-card:active {
            transform: translateY(0);
        }

        /* Intestazione card: ID a sinistra, data a destra */
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f5f5f5;
        }

        .order-id-mobile {
            font-weight: 600;
            color: #1a1a1a;
            font-size: 16px;
        }

        .order-date {
            color: #666;
            font-size: 13px;
        }

        /* Griglia info card (Totale / Stato, ecc.) */
        .order-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
        }

        /* Blocco singola info dentro la griglia */
        .info-item {
            display: flex;
            flex-direction: column;
        }

        /* Label piccola (Totale/Stato) */
        .info-label {
            font-size: 11px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        /* Valore (prezzo/stato) */
        .info-value {
            font-weight: 500;
            font-size: 15px;
            color: #1a1a1a;
        }

        /* Box dettagli dentro la card (sfondo grigio chiaro) */
        .order-details {
            background: #fafafa;
            padding: 16px;
            border-radius: 2px;
            margin-top: 12px;
            border: 1px solid #f5f5f5;
        }

        /* RESPONSIVE (MOBILE / DESKTOP) */
        @media (max-width: 768px) {
            /* Adatta padding e spaziature su schermi piccoli */
            body {
                padding: 16px;
            }
            
            .container {
                padding: 24px;
            }
            
            h1 {
                font-size: 1.5rem;
            }
            
            /* Su mobile: nasconde la tabella e mostra le card */
            .orders-table {
                display: none;
            }
            
            .mobile-orders {
                display: flex;
            }
            
            /* Statistiche in colonna su mobile */
            .stats {
                flex-direction: column;
                gap: 12px;
            }
            
            .stat-card {
                padding: 16px;
            }
            
            .stat-value {
                font-size: 24px;
            }
            
            /* Link “bottone” a larghezza piena su mobile */
            .back-link {
                display: block;
                width: 100%;
                text-align: center;
            }
        }

        @media (min-width: 1024px) {
            /* Su schermi larghi: più colonne nella griglia info card */
            .order-info {
                grid-template-columns: 1fr 1fr 1fr 1fr;
            }
        }

        /* Landscape su mobile: più colonne, padding leggermente ridotto */
        @media (max-width: 768px) and (orientation: landscape) {
            .order-info {
                grid-template-columns: 1fr 1fr 1fr;
            }
            
            .container {
                padding: 20px;
            }
        }
    </style>
</head>

<body>
<div class="container">
    <h1>I miei Ordini</h1>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-label">Totale Ordini</div>
            <div class="stat-value">${totaleOrdini}</div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Ordini Attivi</div>
            <div class="stat-value">${ordiniAttivi}</div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty ordini}">
            <!-- Tabella per desktop -->
            <table class="orders-table">
                <thead>
                <tr>
                    <th>ID Ordine</th>
                    <th>Data</th>
                    <th>Totale</th>
                    <th>Stato</th>
                    <th>Dettagli</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ordine" items="${ordini}">
                    <tr class="row-link"
                        data-href="${pageContext.request.contextPath}/fattura?idOrdine=${ordine.id}">
                        <td class="order-id">#${ordine.id}</td>
                        <td>${ordine.dataOrdine}</td>
                        <td><strong>€${ordine.totale}</strong></td>
                        <td>
                            <c:choose>
                                <c:when test="${ordine.stato == 'CONFERMATO'}"><span class="status-confermato">● CONFERMATO</span></c:when>
                                <c:when test="${ordine.stato == 'SPEDITO'}"><span class="status-spedito">● SPEDITO</span></c:when>
                                <c:when test="${ordine.stato == 'CONSEGNATO'}"><span class="status-consegnato">● CONSEGNATO</span></c:when>
                            </c:choose>
                        </td>
                        <td class="col-dettagli">
                            <c:choose>
                                <c:when test="${not empty ordine.dettagli}">
                                    <c:forEach var="d" items="${ordine.dettagli}" varStatus="st">
                                        <div class="dettaglio-riga">
                                            <span class="d-marca"><c:if test="${not empty d.marca}">${d.marca}</c:if></span>
                                            <span class="d-modello">${d.modello}</span>
                                            <span class="d-anno">(${d.anno})</span>
                                            — ${d.quantita}x
                                            <span class="d-prezzo">€${d.prezzo}</span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>—</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Card per mobile -->
            <div class="mobile-orders">
                <c:forEach var="ordine" items="${ordini}">
                    <div class="order-card" 
                         onclick="window.location.href='${pageContext.request.contextPath}/fattura?idOrdine=${ordine.id}'">
                        <div class="order-header">
                            <div class="order-id-mobile">#${ordine.id}</div>
                            <div class="order-date">${ordine.dataOrdine}</div>
                        </div>
                        <div class="order-info">
                            <div class="info-item">
                                <span class="info-label">Totale</span>
                                <span class="info-value">€${ordine.totale}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Stato</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${ordine.stato == 'CONFERMATO'}"><span class="status-confermato">CONFERMATO</span></c:when>
                                        <c:when test="${ordine.stato == 'SPEDITO'}"><span class="status-spedito">SPEDITO</span></c:when>
                                        <c:when test="${ordine.stato == 'CONSEGNATO'}"><span class="status-consegnato">CONSEGNATO</span></c:when>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                        <div class="order-details">
                            <div class="info-label" style="margin-bottom: 8px;">Dettagli:</div>
                            <c:choose>
                                <c:when test="${not empty ordine.dettagli}">
                                    <c:forEach var="d" items="${ordine.dettagli}" varStatus="st">
                                        <div class="dettaglio-riga">
                                            <span class="d-marca"><c:if test="${not empty d.marca}">${d.marca}</c:if></span>
                                            <span class="d-modello">${d.modello}</span>
                                            <span class="d-anno">(${d.anno})</span>
                                            — ${d.quantita}x
                                            <span class="d-prezzo">€${d.prezzo}</span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>—</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <script>
                // Click su riga ordine → vai a fattura (solo per desktop)
                document.addEventListener('click', function(e){
                    const tr = e.target.closest('.row-link');
                    if (tr) window.location.href = tr.dataset.href;
                });
            </script>

        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <h3>Nessun ordine trovato</h3>
                <p>Non hai ancora effettuato ordini.</p>
                <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">Inizia a fare shopping</a>
            </div>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">← Torna alla Home</a>
</div>
</body>
</html>
