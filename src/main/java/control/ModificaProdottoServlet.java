package control;

import model.AutoDAO;
import model.Auto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;


public class ModificaProdottoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String marca = request.getParameter("marca");
        String modello = request.getParameter("modello");
        int anno = Integer.parseInt(request.getParameter("anno"));
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        double iva = Double.parseDouble(request.getParameter("iva"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));
        String specifiche = request.getParameter("specifiche");

        Auto auto = new Auto(marca, modello, anno, prezzo, iva, quantita, specifiche);
        AutoDAO dao = new AutoDAO();

        try {
            dao.update(auto);
            request.getSession().setAttribute("message", "Prodotto modificato con successo!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Errore durante la modifica del prodotto");
        }
        response.sendRedirect(request.getContextPath() + "/AdminProdottiServlet");
    }
}
