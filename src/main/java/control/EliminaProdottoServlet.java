package control;

import model.AutoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;


public class EliminaProdottoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String modello = request.getParameter("modello");
        int anno = Integer.parseInt(request.getParameter("anno"));

        AutoDAO dao = new AutoDAO();
        try {
            dao.delete(modello, anno);
            request.getSession().setAttribute("message", "Prodotto eliminato con successo!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Errore durante l'eliminazione del prodotto");
        }
        response.sendRedirect(request.getContextPath() + "/AdminProdottiServlet");
    }
}
