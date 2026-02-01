package control;

import model.Utente;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*") // Applica a tutte le richieste
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);

        // Recupera utente loggato, può essere admin o utente normale
        Utente u = (session != null) ? (Utente) session.getAttribute("utente") : null;

        String path = request.getRequestURI();
        String context = request.getContextPath();

        // 1. Pagine admin → solo admin loggato
        if (path.startsWith(context + "/Admin/")) {
            if (u == null || !"admin".equalsIgnoreCase(u.getRuolo())) {
                // Non loggato o non admin → redirect o 403
                response.sendRedirect(context + "/login.jsp");
                return;
            }
        }

        // 2. Pagine cliente → solo utente loggato
        if (path.startsWith(context + "/Cliente/")) {
            if (u == null || !"utente".equalsIgnoreCase(u.getRuolo())) {
                // Non loggato o non utente → redirect login
                response.sendRedirect(context + "/login.jsp");
                return;
            }
        }

        // 3. Login e registrazione → utenti già loggati non possono accedere
        if (u != null && (path.endsWith("login.jsp") || path.endsWith("registrazione.jsp"))) {
            response.sendRedirect(context + "/index.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
