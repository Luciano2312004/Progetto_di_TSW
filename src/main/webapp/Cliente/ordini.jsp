<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>I miei Ordini - FastMotors</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Reset e base */
        * { box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 16px;
            background-color: #f5f5f5; 
            font-size: 14px;
            line-height: 1.4;
        }
        
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: white; 
            padding: 16px;
            border-radius: 8px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        }
        
        h1 { 
            color: #333; 
            border-bottom: 2px solid #e74c3c; 
            padding-bottom: 12px;
            margin-top: 0;
            font-size: 1.5rem;
        }
        
        .stats { 
            background: #f8f9fa; 
            padding: 12px; 
            border-radius: 5px; 
            margin-bottom: 16px; 
            display: flex; 
            flex-direction: column;
            gap: 12px;
        }
        
        .stat-card { 
            background: white; 
            padding: 14px; 
            border-radius: 5px; 
            border-left: 4px solid #e74c3c; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        /* Tabella responsive */
        .orders-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 16px;
            font-size: 13px;
        }
        
        .orders-table th, .orders-table td { 
            border: 1px solid #ddd; 
            padding: 8px; 
            text-align: left; 
            vertical-align: top; 
        }
        
        .orders-table th { 
            background-color: #e74c3c; 
            color: white; 
            font-size: 12px;
        }
        
        .orders-table tr:nth-child(even) { 
            background-color: #f9f9f9; 
        }
        
        .status-confermato { color: #f39c12; font-weight: bold; }
        .status-spedito { color: #3498db; font-weight: bold; }
        .status-consegnato { color: #27ae60; font-weight: bold; }
        
        .empty-state { 
            text-align: center; 
            padding: 30px 16px; 
            color: #666; 
        }
        
        .error { 
            color: #e74c3c; 
            padding: 12px; 
            background: #ffeaea; 
            border-radius: 4px; 
            margin-bottom: 16px;
            border: 1px solid #e74c3c;
        }
        
        .back-link { 
            display: inline-block; 
            margin-top: 20px; 
            color: #e74c3c; 
            text-decoration: none; 
            padding: 10px 16px;
            border: 1px solid #e74c3c;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
        }
        
        .back-link:hover { 
            background: #e74c3c;
            color: white;
            text-decoration: none;
        }

        .col-dettagli { 
            font-size: 0.9rem; 
            line-height: 1.3; 
        }
        
        .dettaglio-riga { 
            padding: 3px 0; 
            border-bottom: 1px dashed #e5e5e5; 
        }
        
        .dettaglio-riga:last-child { 
            border-bottom: none; 
        }
        
        .d-marca { font-weight: 600; }
        .d-prezzo { white-space: nowrap; }
        .row-link { cursor: pointer; }
        .row-link:hover { background: #fff7f7; }

        /* Layout per card su mobile */
        .mobile-orders {
            display: none;
            flex-direction: column;
            gap: 12px;
            margin-top: 16px;
        }

        .order-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 14px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .order-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid #eee;
        }

        .order-id {
            font-weight: bold;
            color: #e74c3c;
            font-size: 15px;
        }

        .order-date {
            color: #666;
            font-size: 12px;
        }

        .order-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-bottom: 12px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 11px;
            color: #666;
            margin-bottom: 2px;
        }

        .info-value {
            font-weight: bold;
            font-size: 13px;
        }

        .order-details {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 4px;
            margin-top: 8px;
        }

        /* Media Queries */
        @media (max-width: 768px) {
            .orders-table {
                display: none;
            }
            
            .mobile-orders {
                display: flex;
            }
            
            .stats {
                flex-direction: row;
                flex-wrap: wrap;
            }
            
            .stat-card {
                flex: 1;
                min-width: 140px;
            }
            
            .back-link {
                display: block;
                width: 100%;
                margin-top: 24px;
            }
        }

        @media (min-width: 769px) {
            body {
                margin: 20px;
                padding: 0;
                font-size: 16px;
            }
            
            .container {
                padding: 24px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .stats {
                flex-direction: row;
                padding: 15px;
                gap: 20px;
            }
            
            .stat-card {
                padding: 15px;
                text-align: left;
            }
            
            .orders-table th, .orders-table td {
                padding: 12px;
            }
            
            .orders-table th {
                font-size: 14px;
            }
            
            .col-dettagli {
                font-size: 0.95rem;
            }
        }

        @media (min-width: 1024px) {
            .order-info {
                grid-template-columns: 1fr 1fr 1fr 1fr;
            }
        }

        /* Supporto per orientamento landscape su mobile */
        @media (max-width: 768px) and (orientation: landscape) {
            .order-info {
                grid-template-columns: 1fr 1fr 1fr;
            }
            
            .container {
                padding: 12px;
            }
        }

        /* Miglioramenti touch */
        .order-card {
            transition: transform 0.2s ease;
        }

        .order-card:active {
            transform: scale(0.98);
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
        <div class="stat-card"><strong>Totale Ordini:</strong> ${totaleOrdini}</div>
        <div class="stat-card"><strong>Ordini Attivi:</strong> ${ordiniAttivi}</div>
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
                        <td>#${ordine.id}</td>
                        <td>${ordine.dataOrdine}</td>
                        <td>€${ordine.totale}</td>
                        <td>
                            <c:choose>
                                <c:when test="${ordine.stato == 'CONFERMATO'}"><span class="status-confermato">✅ CONFERMATO</span></c:when>
                                <c:when test="${ordine.stato == 'SPEDITO'}"><span class="status-spedito">🚚 SPEDITO</span></c:when>
                                <c:when test="${ordine.stato == 'CONSEGNATO'}"><span class="status-consegnato">📦 CONSEGNATO</span></c:when>
                            </c:choose>
                        </td>
                        <td class="col-dettagli">
                            <c:choose>
                                <c:when test="${not empty ordine.dettagli}">
                                    <c:forEach var="d" items="${ordine.dettagli}" varStatus="st">
                                        <div class="dettaglio-riga">
                                            <span class="d-marca"><c:if test="${not empty d.marca}">${d.marca}</c:if></span>
                                            <span class="d-modello">${d.modello}</span>
                                            <span class="d-anno">${d.anno}</span>
                                            — x${d.quantita}
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
                            <div class="order-id">#${ordine.id}</div>
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
                            <div class="info-label" style="margin-bottom: 6px;">Dettagli:</div>
                            <c:choose>
                                <c:when test="${not empty ordine.dettagli}">
                                    <c:forEach var="d" items="${ordine.dettagli}" varStatus="st">
                                        <div class="dettaglio-riga">
                                            <span class="d-marca"><c:if test="${not empty d.marca}">${d.marca}</c:if></span>
                                            <span class="d-modello">${d.modello}</span>
                                            <span class="d-anno">${d.anno}</span>
                                            — x${d.quantita}
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
                <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">Torna allo shopping</a>
            </div>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">← Torna alla Home</a>
</div>
</body>
</html>