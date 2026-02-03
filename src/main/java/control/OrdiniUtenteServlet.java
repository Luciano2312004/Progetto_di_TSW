package control;

import model.Ordine;
import java.util.List;
import java.util.ArrayList;

import model.OrdineDAO;
import model.Utente;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

public class OrdiniUtenteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp"); //redirect al login se l'utente non è loggato
            return;
        }

        String email = utente.getEmail(); //legge l'email dell'utente
        System.out.println("[OrdiniUtenteServlet] email sessione = " + email);
        List<String> debugMsgs = new ArrayList<>();
        debugMsgs.add("👤 Email utente: " + email);

        try {
            OrdineDAO ordineDAO = new OrdineDAO(); //accesso al database 
            List<Ordine> ordini = ordineDAO.getOrdiniByUtente(email);//legge gli ordini per quella specifica mail

            long attivi = ordini.stream()//calcolo degli ordini attivi
                    .filter(o -> o.getStato() != null && !"CONSEGNATO".equalsIgnoreCase(o.getStato()))
                    .count();
            //mesaggi di debug
            debugMsgs.add("📦 Ordini trovati: " + ordini.size());
            debugMsgs.add("🟠 Ordini attivi: " + attivi);
            //pasaggio dei dati alla view
            request.setAttribute("ordini", ordini);
            request.setAttribute("ordiniAttivi", attivi);
            request.setAttribute("totaleOrdini", ordini.size());
            //mesaggi di errore
        } catch (Exception e) {
            e.printStackTrace();
            debugMsgs.add("❌ Errore: " + e.getMessage());
            request.setAttribute("error", "Impossibile recuperare i tuoi ordini al momento.");
            request.setAttribute("ordini", java.util.Collections.emptyList());
            request.setAttribute("ordiniAttivi", 0L);
            request.setAttribute("totaleOrdini", 0);
        }

        // passaggio dei mesaggi di debug
        request.setAttribute("debugMsgs", debugMsgs);

        request.getRequestDispatcher("/Cliente/ordini.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
