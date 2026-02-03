package control;

import model.Auto;
import model.AutoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("q");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if (query == null || query.trim().isEmpty()) {
                out.print("[]");
                return;
            }

            AutoDAO dao = new AutoDAO();
            List<Auto> results = dao.searchByName(query);

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < results.size(); i++) {
                Auto a = results.get(i);
                json.append("{");
                json.append("\"marca\":\"").append(escapeJson(a.getMarca())).append("\",");
                json.append("\"modello\":\"").append(escapeJson(a.getModello())).append("\",");
                json.append("\"anno\":").append(a.getAnno()).append(",");
                json.append("\"prezzo\":").append(a.getPrezzo());
                json.append("}");
                if (i < results.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            out.print(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Errore durante la ricerca\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null)
            return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
