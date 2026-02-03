package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CarItem;
import model.Fattura;
import model.FatturaDAO;
import model.OrderDAO;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public void init() {
        orderDAO = new OrderDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 1. Recupera il carrello e l'utente dalla sessione
        @SuppressWarnings("unchecked")
        List<CarItem> cart = (List<CarItem>) session.getAttribute("cart");

        // 2. Recupera l'utente dalla sessione
        model.Utente user = (model.Utente) session.getAttribute("utente");
        String userEmail = null;

        if (user != null) {
            userEmail = user.getEmail();
        } else {
            
            userEmail = "test.user@email.com";
           
        }

        // 3. Recupera i dati del form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zipCode = request.getParameter("zipCode");
        String province = request.getParameter("province");

        String customerName = firstName + " " + lastName;
        String shippingAddress = address + ", " + zipCode + " " + city + " (" + province + ")";

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/configurator.jsp");
            return;
        }

        try {
            // 4. Salva l'ordine nel database.
            int orderId = orderDAO.saveOrder(cart, userEmail);

            // 5. Prepara i dati per la pagina di conferma
            session.setAttribute("confirmedOrderId", orderId);
            session.setAttribute("confirmedCustomerName", customerName);
            session.setAttribute("confirmedShippingAddress", shippingAddress);

            // --- INIZIO CREAZIONE FATTURA AUTOMATICA ---
            try {
                double totalAmount = 0.0;
                StringBuilder detailsBuilder = new StringBuilder();
                if (cart != null && !cart.isEmpty()) {
                    for (CarItem item : cart) {
                        totalAmount += item.getTotalPrice();
                        detailsBuilder.append(item.getQty()).append("x ").append(item.getName())
                                .append(" (").append(item.getYear()).append(") - ")
                                .append(String.format("€%.2f", item.getTotalPrice()))
                                .append("\n");
                    }
                }

                // Validazione: non creare fattura se il totale è 0
                if (totalAmount <= 0) {
                    throw new IllegalStateException("Impossibile creare fattura con totale zero");
                }

                Fattura fattura = new Fattura();
                fattura.setDataEmissione(new java.util.Date()); // Data corrente
                fattura.setTotale(totalAmount);
                fattura.setDettagli(detailsBuilder.toString());
                fattura.setOrdineId(orderId);

                FatturaDAO fatturaDAO = new FatturaDAO();
                fatturaDAO.createFattura(fattura);

            } catch (Exception e) {
               
                e.printStackTrace();
            }
            // --- FINE CREAZIONE FATTURA AUTOMATICA ---

            // Sposta gli item del carrello in "confirmedOrderItems"
            session.setAttribute("confirmedOrderItems", new ArrayList<>(cart));
            session.removeAttribute("cart"); // Svuota il carrello

            // 6. Reindirizza alla pagina di conferma
            response.sendRedirect(request.getContextPath() + "/Cliente/orderConfirmation.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            String msg = e.getMessage();
            String userError = "Errore durante il salvataggio dell'ordine.";

            // Intercetta l'errore di stock esaurito (MySQL Error 1690 o messaggio "out of
            // range")
            if (msg != null && (msg.contains("out of range") || msg.contains("Data truncation"))) {
                userError = "Spiacenti, al momento non abbiamo abbastanza auto in stock per soddisfare la tua richiesta.";
            } else {
                userError += " Dettagli tecnici: " + msg;
            }

            // Gestione errore: reindirizza a una pagina di errore
            request.setAttribute("errorMessage", userError);
            // Assicurati di avere una pagina /error.jsp o simile
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}