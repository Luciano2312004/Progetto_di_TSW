<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione Auto</title>
</head>
<body>
<h2>Gestione Auto</h2>

<!-- Messaggi -->
<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<!-- Tabella catalogo -->
<table border="1" cellpadding="5">
    <tr>
        <th>Marca</th>
        <th>Modello</th>
        <th>Anno</th>
        <th>Prezzo</th>
        <th>IVA</th>
        <th>Quantità</th>
        <th>Azioni</th>
    </tr>

    <c:forEach var="auto" items="${listaProdotti}">
        <tr>
            <td>${auto.marca}</td>
            <td>${auto.modello}</td>
            <td>${auto.anno}</td>
            <td>${auto.prezzo}</td>
            <td>${auto.iva}</td>
            <td>${auto.quantitaStock}</td>
            <td>
                <a href="${pageContext.request.contextPath}/AdminProdottiServlet?modello=${auto.modello}&anno=${auto.anno}">Seleziona</a>
            </td>
        </tr>
    </c:forEach>

    <c:if test="${empty listaProdotti}">
        <tr><td colspan="7">Nessun prodotto trovato</td></tr>
    </c:if>
</table>

<hr>

<h3>
<c:choose>
    <c:when test="${not empty autoSelezionata}">Modifica / Cancella Auto</c:when>
    <c:otherwise>Inserisci Nuova Auto</c:otherwise>
</c:choose>
</h3>

<form method="post">
    Marca: <input type="text" name="marca" value="${autoSelezionata.marca}" required><br>

    <c:choose>
        <c:when test="${not empty autoSelezionata}">
            Modello: <input type="text" name="modello" value="${autoSelezionata.modello}" readonly required><br>
            Anno: <input type="number" name="anno" value="${autoSelezionata.anno}" readonly required><br>
        </c:when>
        <c:otherwise>
            Modello: <input type="text" name="modello" required><br>
            Anno: <input type="number" name="anno" required><br>
        </c:otherwise>
    </c:choose>

    Prezzo: <input type="number" step="0.01" name="prezzo" value="${autoSelezionata.prezzo}" required><br>
    IVA: <input type="number" step="0.01" name="iva" value="${autoSelezionata.iva}" required><br>
    Quantità: <input type="number" name="quantita" value="${autoSelezionata.quantitaStock}" required><br>
    Specifiche: <textarea name="specifiche" required>${autoSelezionata.specifiche}</textarea><br><br>

    <c:choose>
        <c:when test="${not empty autoSelezionata}">
            <button formaction="${pageContext.request.contextPath}/ModificaProdottoServlet" formmethod="post">Modifica</button>
            <button formaction="${pageContext.request.contextPath}/EliminaProdottoServlet" formmethod="get"
                    onclick="return confirm('Sei sicuro di eliminare questa auto?')">Elimina</button>
        </c:when>
        <c:otherwise>
            <button formaction="${pageContext.request.contextPath}/InserisciProdottoServlet" formmethod="post">Inserisci</button>
        </c:otherwise>
    </c:choose>
</form>
</body>
</html>
