package control;

import model.AutoDAO;
import model.Auto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class AdminProdottiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        AutoDAO dao = new AutoDAO();

        HttpSession session = request.getSession();

        // Copia eventuali messaggi dalla sessione alla request
        String message = (String) session.getAttribute("message");
        if (message != null) {
            request.setAttribute("message", message);
            session.removeAttribute("message");
        }

        String error = (String) session.getAttribute("error");
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }

        try {
            // Carica sempre la lista di auto
            List<Auto> lista = dao.getAll();
            request.setAttribute("listaProdotti", lista);

            // Selezione di un’auto per modifica/cancellazione
            String modello = request.getParameter("modello");
            String annoStr = request.getParameter("anno");

            if (modello != null && annoStr != null) {
                try {
                    int anno = Integer.parseInt(annoStr);
                    Auto autoSelezionata = dao.getByPK(modello, anno);
                    request.setAttribute("autoSelezionata", autoSelezionata);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Anno non valido.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel caricamento del catalogo.");
        }

        request.getRequestDispatcher("/Admin/catalogoAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Reindirizza a GET
        doGet(request, response);
    }
}
