<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Errore - FastMotors</title>
    <style>
        body { font-family: sans-serif; padding: 50px; text-align: center; background-color: #f8f9fa; }
        .error-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: inline-block; }
        h1 { color: #dc3545; }
        p { color: #333; font-size: 1.2rem; }
        .details { margin-top: 20px; text-align: left; background: #f1f1f1; padding: 15px; border-radius: 4px; overflow-x: auto; }
        a { color: #007bff; text-decoration: none; margin-top: 20px; display: inline-block; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Ops! Qualcosa è andato storto.</h1>
        <p>
            <% 
                String errorMsg = (String) request.getAttribute("errorMessage");
                if (errorMsg != null && !errorMsg.isEmpty()) {
                    out.print(errorMsg);
                } else if (exception != null) {
                    out.print(exception.getMessage());
                } else {
                    out.print("Si è verificato un errore sconosciuto.");
                }
            %>
        </p>
        
        <% if (exception != null) { %>
            <div class="details">
                <pre><% exception.printStackTrace(new java.io.PrintWriter(out)); %></pre>
            </div>
        <% } %>
        <a href="${pageContext.request.contextPath}/index.jsp">Torna alla Home</a>
    </div>
</body>
</html>
