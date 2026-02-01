package control;

import model.Ordine;
import model.OrdineDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class AmministratoreOrdiniServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parametri dal form JSP (cliente + intervallo date)
        String utente = request.getParameter("utente");
        String dataInizioStr = request.getParameter("dataInizio");
        String dataFineStr = request.getParameter("dataFine");

        Date dataInizio = null;
        Date dataFine = null;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            if (dataInizioStr != null && !dataInizioStr.isEmpty()) {
                dataInizio = sdf.parse(dataInizioStr);
            }
            if (dataFineStr != null && !dataFineStr.isEmpty()) {
                dataFine = sdf.parse(dataFineStr);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Recupero ordini dal DAO
        OrdineDAO ordineDAO = new OrdineDAO();
        List<Ordine> ordini = new ArrayList<>();

        try {
            ordini = ordineDAO.getOrdini(utente, dataInizio, dataFine);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore nel recupero degli ordini.");
        }

        // Passa i dati alla JSP
        request.setAttribute("ordini", ordini);
        request.setAttribute("utenteSelezionato", utente);
        request.setAttribute("dataInizio", dataInizioStr);
        request.setAttribute("dataFine", dataFineStr);

        // Dispatch verso la vista
        request.getRequestDispatcher("/Admin/ordiniAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // gestiamo POST come GET
    }
}
