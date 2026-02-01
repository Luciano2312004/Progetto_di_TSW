package control;

import model.AutoDAO;
import model.Auto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;


public class InserisciProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Lettura parametri con gestione errori numerici
        String marca = request.getParameter("marca");
        String modello = request.getParameter("modello");
        String annoStr = request.getParameter("anno");
        String prezzoStr = request.getParameter("prezzo");
        String ivaStr = request.getParameter("iva");
        String quantitaStr = request.getParameter("quantita");
        String specifiche = request.getParameter("specifiche");

        int anno = 0, quantita = 0;
        double prezzo = 0, iva = 0;

        try {
            anno = Integer.parseInt(annoStr);
            prezzo = Double.parseDouble(prezzoStr);
            iva = Double.parseDouble(ivaStr);
            quantita = Integer.parseInt(quantitaStr);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Errore: inserire valori numerici validi per anno, prezzo, iva e quantità.");
            response.sendRedirect(request.getContextPath() + "/AdminProdottiServlet");
            return;
        }

        Auto auto = new Auto(marca, modello, anno, prezzo, iva, quantita, specifiche);
        AutoDAO dao = new AutoDAO();

        try {
            dao.insert(auto);
            session.setAttribute("message", "Prodotto inserito con successo!");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "Errore durante l'inserimento del prodotto.");
        }

        // Redirect PRG per evitare doppio submit
        response.sendRedirect(request.getContextPath() + "/AdminProdottiServlet");
    }
}
