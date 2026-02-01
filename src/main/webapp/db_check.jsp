<%@ page import="java.sql.*" %>
    <%@ page import="utils.DBConnection" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>DB Check (Fresh)</title>
            </head>

            <body>
                <h1>Database Check</h1>
                <hr>
                <h2>Cars Table Dump</h2>
                <table border="1">
                    <tr>
                        <th>Marca</th>
                        <th>Modello</th>
                        <th>Anno</th>
                        <th>Stock</th>
                        <th>Debug (Length)</th>
                    </tr>
                    <% try (Connection conn=DBConnection.getConnection()) { String sqlAuto="SELECT * FROM auto" ; try
                        (Statement stmt=conn.createStatement(); ResultSet rs=stmt.executeQuery(sqlAuto)) { while
                        (rs.next()) { String m=rs.getString("modello"); out.println("<tr>");
                        out.println("<td>" + rs.getString("marca") + "</td>");
                        out.println("<td>'" + m + "'</td>"); // Quotes to see whitespace
                        out.println("<td>" + rs.getInt("anno") + "</td>");
                        out.println("<td>" + rs.getInt("quantita_stock") + "</td>");
                        out.println("<td>" + (m != null ? m.length() : 0) + "</td>");
                        out.println("</tr>");
                        }
                        }
                        } catch (Exception e) {
                        out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
                        e.printStackTrace(new java.io.PrintWriter(out));
                        }
                        %>
                </table>
            </body>

            </html>