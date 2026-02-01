<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>Fattura - FastMotors</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                /* Reset e base */
                * {
                    box-sizing: border-box;
                }

                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 16px;
                    background: #f5f5f5;
                    font-size: 14px;
                    line-height: 1.4;
                }

                .container {
                    max-width: 900px;
                    margin: 0 auto;
                    background: #fff;
                    padding: 16px;
                    border-radius: 8px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, .1);
                }

                h1 {
                    color: #333;
                    border-bottom: 2px solid #e74c3c;
                    padding-bottom: 12px;
                    margin-top: 0;
                    font-size: 1.5rem;
                }

                .error {
                    color: #e74c3c;
                    padding: 12px;
                    background: #ffeaea;
                    border-radius: 4px;
                    margin-bottom: 16px;
                    border: 1px solid #e74c3c;
                }

                /* Layout responsive per la griglia */
                .meta {
                    display: grid;
                    grid-template-columns: 1fr;
                    gap: 12px;
                    margin-top: 16px;
                }

                .card {
                    background: #fafafa;
                    border: 1px solid #eee;
                    border-left: 4px solid #e74c3c;
                    border-radius: 6px;
                    padding: 14px;
                    min-height: 60px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .label {
                    color: #666;
                    font-size: 12px;
                    margin-bottom: 4px;
                }

                .val {
                    font-weight: bold;
                    font-size: 15px;
                    color: #333;
                }

                .box {
                    margin-top: 20px;
                }

                pre.dettagli {
                    background: #0f172a;
                    color: #e2e8f0;
                    padding: 14px;
                    border-radius: 6px;
                    white-space: pre-wrap;
                    font-size: 13px;
                    line-height: 1.5;
                    overflow-x: auto;
                    -webkit-overflow-scrolling: touch;
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

                /* Media Queries per dispositivi più grandi */
                @media (min-width: 768px) {
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

                    .meta {
                        grid-template-columns: 1fr 1fr;
                        gap: 16px;
                    }

                    .label {
                        font-size: 13px;
                    }

                    .val {
                        font-size: 16px;
                    }

                    pre.dettagli {
                        font-size: 14px;
                        padding: 16px;
                    }
                }

                @media (min-width: 1024px) {
                    .meta {
                        grid-template-columns: 1fr 1fr 1fr 1fr;
                    }
                }

                /* Miglioramenti touch */
                @media (max-width: 767px) {
                    .card {
                        padding: 16px 14px;
                        min-height: 70px;
                    }

                    .back-link {
                        display: block;
                        width: 100%;
                        margin-top: 24px;
                    }

                    pre.dettagli {
                        font-size: 12px;
                        padding: 12px;
                    }
                }

                /* Supporto per orientamento landscape su mobile */
                @media (max-width: 767px) and (orientation: landscape) {
                    .meta {
                        grid-template-columns: 1fr 1fr;
                    }

                    .container {
                        padding: 12px;
                    }
                }

                /* Nascondi elementi durante la stampa */
                @media print {
                    .no-print {
                        display: none !important;
                    }

                    body {
                        background: white;
                        margin: 0;
                        padding: 0;
                    }

                    .container {
                        box-shadow: none;
                        border-radius: 0;
                    }
                }
            </style>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        </head>

        <body>
            <div class="container">
                <!-- Header con pulsante stampa -->
                <div class="no-print"
                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 1px solid #eee;">
                    <a href="${pageContext.request.contextPath}/OrdiniUtenteServlet"
                        style="color: #e74c3c; text-decoration: none; font-weight: bold;">
                        ← Torna agli ordini
                    </a>
                    <button onclick="window.print()"
                        style="background: #e74c3c; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: bold;">
                        <i class="fas fa-print" style="margin-right: 8px;"></i>Stampa
                    </button>
                </div>

                <h1>Fattura</h1>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty fattura}">
                        <div class="meta">
                            <div class="card">
                                <div class="label">ID Fattura</div>
                                <div class="val">#${fattura.id}</div>
                            </div>
                            <div class="card">
                                <div class="label">Ordine</div>
                                <div class="val">#${fattura.ordineId}</div>
                            </div>
                            <div class="card">
                                <div class="label">Data emissione</div>
                                <div class="val">${fattura.dataEmissione}</div>
                            </div>
                            <div class="card">
                                <div class="label">Totale</div>
                                <div class="val">€${fattura.totale}</div>
                            </div>
                        </div>

                        <div class="box">
                            <div class="label" style="margin-bottom:8px;">Dettagli</div>
                            <pre class="dettagli">${fattura.dettagli}</pre>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            Nessuna fattura da mostrare.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </body>

        </html>