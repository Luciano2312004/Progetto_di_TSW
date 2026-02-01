package control;

import model.Utente;
import model.UtenteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) email = email.trim();
        if (password != null) password = password.trim();

        // Validazione input
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Compila tutti i campi richiesti.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Usa il DAO così come lo hai scritto (la login apre la connessione internamente)
            UtenteDAO dao = new UtenteDAO();
            Utente u = dao.login(email, password);

            if (u != null) {
                // Autenticazione OK -> salvo utente in sessione
                HttpSession session = request.getSession(true);
                session.setAttribute("utente", u);

                // Reindirizzo in base al ruolo
                if ("admin".equalsIgnoreCase(u.getRuolo())) {
                    response.sendRedirect(request.getContextPath() + "/Admin/adminHome.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } else {
                // Credenziali non valide
                request.setAttribute("error", "Email o password non validi.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Log dell'eccezione e messaggio generico all'utente
            e.printStackTrace();
            request.setAttribute("error", "Errore del server. Riprova più tardi.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Se utente già loggato, non mostrare la login: redirect a index
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("utente") != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
