package control;

import model.Utente;
import model.UtenteDAO;
import utils.PasswordUtils;

import javax.servlet.ServletException;

import javax.servlet.http.*;
import java.io.IOException;


public class Registrazione extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupero dei parametri dalla form
        String nome = request.getParameter("nome").trim();
        String cognome = request.getParameter("cognome").trim();
        String email = request.getParameter("email").trim();
        String telefono = request.getParameter("telefono").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirmPassword").trim();
        String terms = request.getParameter("terms");

        // Validazione lato server
        if (nome.isEmpty() || cognome.isEmpty() || email.isEmpty() || telefono.isEmpty() ||
            password.isEmpty() || confirmPassword.isEmpty() || terms == null) {
            request.setAttribute("error", "Compila tutti i campi richiesti e accetta i termini.");
            request.getRequestDispatcher("/registrazione.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Le password non coincidono.");
            request.getRequestDispatcher("/registrazione.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "La password deve essere di almeno 8 caratteri.");
            request.getRequestDispatcher("/registrazione.jsp").forward(request, response);
            return;
        }

        try {
            UtenteDAO dao = new UtenteDAO();

            // Controllo se l'email esiste già
            // Per fare questo, puoi creare un metodo esisteEmail nel DAO oppure fare direttamente qui:
            try (var con = utils.DBConnection.getConnection();
                 var ps = con.prepareStatement("SELECT 1 FROM utente WHERE indirizzo_email = ?")) {
                ps.setString(1, email);
                try (var rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("error", "Email già registrata.");
                        request.getRequestDispatcher("/registrazione.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Hash della password
            String hashedPassword = PasswordUtils.hashPassword(password);

            // Creazione dell'utente
            Utente u = new Utente(email, nome, cognome, telefono, 0, "utente");

            // Inserimento in DB
            try (var con = utils.DBConnection.getConnection();
                 var ps = con.prepareStatement(
                     "INSERT INTO utente (nome, cognome, indirizzo_email, telefono, passwordhash) VALUES (?, ?, ?, ?, ?)")) {
                ps.setString(1, nome);
                ps.setString(2, cognome);
                ps.setString(3, email);
                ps.setString(4, telefono);
                ps.setString(5, hashedPassword);
                ps.executeUpdate();
            }

            // Registrazione avvenuta, redirect a login con messaggio
            request.setAttribute("success", "Registrazione avvenuta con successo. Accedi ora!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Errore del server. Riprova più tardi.");
            request.getRequestDispatcher("/registrazione.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Se l'utente è già loggato, redirect alla home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("utente") != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.getRequestDispatcher("/registrazione.jsp").forward(request, response);
        }
    }
}
