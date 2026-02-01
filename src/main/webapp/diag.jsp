%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>DB Diagnostic</title>
        </head>

        <body>
            <h1>Database Diagnostic</h1>
            <hr>
            <h2>1. Checking User (test.user@email.com)</h2>
            <ul>
                <% try (Connection conn=DBConnection.getConnection()) { String
                    sqlUser="SELECT * FROM utente WHERE indirizzo_email = 'test.user@email.com'" ; try (Statement
                    stmt=conn.createStatement(); ResultSet rs=stmt.executeQuery(sqlUser)) { if (rs.next()) {
                    out.println("<li style='color:green'>User FOUND: " + rs.getString("nome") + " " +
                    rs.getString("cognome") + "</li>");
                    } else {
                    out.println("<li style='color:red;'>User NOT FOUND! (Insert it using the script provided)</li>");
                    }
                    }
                    %>
            </ul>
            <h2>2. Checking Cars (Auto Table)</h2>
            <table border="1">
                <tr>
                    <th>Marca</th>
                    <th>Modello</th>
                    <th>Anno</th>
                    <th>Stock</th>
                </tr>
                <% String sqlAuto="SELECT * FROM auto" ; try (Statement stmt=conn.createStatement(); ResultSet
                    rs=stmt.executeQuery(sqlAuto)) { while (rs.next()) { out.println("<tr>");
                    out.println("<td>" + rs.getString("marca") + "</td>");
                    out.println("<td>" + rs.getString("modello") + "</td>");
                    out.println("<td>" + rs.getInt("anno") + "</td>");
                    out.println("<td>" + rs.getInt("quantita_stock") + "</td>");
                    out.println("</tr>");
                    }
                    }
                    } catch (Exception e) {
                    out.println("<h3 style='color:red'>DB Connect Error: " + e.getMessage() + "</h3>");
                    e.printStackTrace(new java.io.PrintWriter(out));
                    }
                    %>
            </table>
        </body>

        </html>