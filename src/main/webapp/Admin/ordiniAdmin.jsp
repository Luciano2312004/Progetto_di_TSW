<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestione Ordini</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f0f0f0; }
        .filter { margin-bottom: 20px; }
    </style>
</head>
<body>

<h2>Visualizza Ordini</h2>

<form class="filter" action="AmministratoreOrdiniServlet" method="get">
    Cliente (email): <input type="text" name="utente" value="${utenteSelezionato}"/>
    Da: <input type="date" name="dataInizio" value="${dataInizio}"/>
    A: <input type="date" name="dataFine" value="${dataFine}"/>
    <input type="submit" value="Filtra"/>
</form>

<c:if test="${not empty errore}">
    <p style="color:red">${errore}</p>
</c:if>

<table>
    <tr>
        <th>ID</th>
        <th>Cliente</th>
        <th>Data</th>
        <th>Totale</th>
        <th>Stato</th>
        <th>Dettagli</th>
    </tr>

    <c:forEach var="o" items="${ordini}">
        <tr>
            <td>${o.id}</td>
            <td>${o.utenteEmail}</td>
            <td>${o.dataOrdine}</td>
            <td>€${o.totale}</td>
            <td>${o.stato}</td>
            <td>
                <ul>
                    <c:forEach var="d" items="${o.dettagli}">
                        <li>${d.marca}   ${d.modello} (${d.anno}) - Q.ta: ${d.quantita} - Prezzo: €${d.prezzo}</li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
