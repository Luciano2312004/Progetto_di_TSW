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
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #f5f5f5;
            color: #2d2d2d;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #ffffff;
            padding: 48px;
            border-radius: 2px;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.04);
        }

        /* Header con navigazione */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .nav-link {
            color: #1a1a1a;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            letter-spacing: 0.3px;
            transition: all 0.2s ease;
            padding: 8px 0;
        }

        .nav-link:hover {
            color: #666;
        }

        .print-btn {
            background: #1a1a1a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 2px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            letter-spacing: 0.3px;
            transition: all 0.2s ease;
        }

        .print-btn:hover {
            background: #000000;
            transform: translateY(-1px);
        }

        h1 {
            color: #1a1a1a;
            font-size: 2rem;
            font-weight: 600;
            letter-spacing: -0.5px;
            margin-bottom: 32px;
        }

        .error {
            color: #e74c3c;
            padding: 16px;
            background: #fafafa;
            border-radius: 2px;
            margin-bottom: 24px;
            border: 1px solid #e74c3c;
            font-size: 14px;
        }

        /* Layout responsive per la griglia */
        .meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-top: 24px;
        }

        .card {
            background: #fafafa;
            border: 1px solid #f0f0f0;
            border-radius: 2px;
            padding: 20px;
            transition: all 0.2s ease;
        }

        .card:hover {
            background: #f5f5f5;
            border-color: #e0e0e0;
        }

        .label {
            color: #666;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        .val {
            font-weight: 600;
            font-size: 20px;
            color: #1a1a1a;
            letter-spacing: -0.3px;
        }

        .box {
            margin-top: 32px;
        }

        .box-title {
            color: #666;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 12px;
        }

        pre.dettagli {
            background: #1a1a1a;
            color: #e2e8f0;
            padding: 24px;
            border-radius: 2px;
            white-space: pre-wrap;
            font-size: 14px;
            line-height: 1.7;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace;
            border: 1px solid #0a0a0a;
        }

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

        .empty-card {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        /* Media Queries per dispositivi più grandi */
        @media (min-width: 768px) {
            .meta {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (min-width: 1024px) {
            .meta {
                grid-template-columns: repeat(4, 1fr);
            }
        }

        /* Miglioramenti touch */
        @media (max-width: 767px) {
            body {
                padding: 16px;
            }

            .container {
                padding: 24px;
            }

            h1 {
                font-size: 1.5rem;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .print-btn {
                width: 100%;
            }

            .card {
                padding: 16px;
            }

            .val {
                font-size: 18px;
            }

            .back-link {
                display: block;
                width: 100%;
                text-align: center;
            }

            pre.dettagli {
                font-size: 13px;
                padding: 16px;
            }

            .meta {
                gap: 12px;
            }
        }

        /* Supporto per orientamento landscape su mobile */
        @media (max-width: 767px) and (orientation: landscape) {
            .meta {
                grid-template-columns: repeat(2, 1fr);
            }

            .container {
                padding: 20px;
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
                padding: 20px;
            }

            .card {
                break-inside: avoid;
            }

            pre.dettagli {
                background: white;
                color: black;
                border: 1px solid #ddd;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>
    <div class="container">
        <!-- Header con pulsante stampa -->
        <div class="page-header no-print">
            <a href="${pageContext.request.contextPath}/OrdiniUtenteServlet" class="nav-link">
                ← Torna agli ordini
            </a>
            <button onclick="window.print()" class="print-btn">
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
                        <div class="label">Data Emissione</div>
                        <div class="val">${fattura.dataEmissione}</div>
                    </div>
                    <div class="card">
                        <div class="label">Totale</div>
                        <div class="val">€${fattura.totale}</div>
                    </div>
                </div>

                <div class="box">
                    <div class="box-title">Dettagli</div>
                    <pre class="dettagli">${fattura.dettagli}</pre>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card empty-card">
                    <p>Nessuna fattura da mostrare.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>

</html>
