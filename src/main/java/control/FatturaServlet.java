package control;

import model.Fattura;
import model.FatturaDAO;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/fattura")
public class FatturaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("idOrdine");
        if (idParam == null) {
            request.setAttribute("error", "Parametro mancante: idOrdine");
            request.getRequestDispatcher("/Cliente/fattura.jsp").forward(request, response);
            return;
        }

        try {
            int ordineId = Integer.parseInt(idParam);
            FatturaDAO dao = new FatturaDAO();
            Fattura fattura = dao.getByOrdineId(ordineId);

            if (fattura == null) {
                request.setAttribute("error", "Nessuna fattura trovata per l'ordine #" + ordineId);
            } else {
                request.setAttribute("fattura", fattura);
            }
            request.getRequestDispatcher("/Cliente/fattura.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "idOrdine non valido.");
            request.getRequestDispatcher("/Cliente/fattura.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore nel recupero della fattura: " + e.getMessage());
            request.getRequestDispatcher("/Cliente/fattura.jsp").forward(request, response);
        }
    }
}
