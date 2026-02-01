package control;

import model.AutoDAO;
import model.Auto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * Servlet Controller per la gestione del catalogo prodotti.
 * Fornisce dati sia per la visualizzazione tramite JSP che tramite API JSON.
 */
@WebServlet(name = "CatalogoServlet", urlPatterns = { "/api/catalogo", "/home", "/catalogo" })
public class CatalogoServlet extends HttpServlet {

    private AutoDAO autoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        autoDAO = new AutoDAO();
        System.out.println("CatalogoServlet inizializzata");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "viewCatalogo";
        }

        try {
            switch (action) {
                case "ping": {
                    response.setContentType("text/plain;charset=UTF-8");
                    response.getWriter().print("pong");
                    return;
                }

                /**
                 * ✅ Nuovo JSON completo per generare le card
                 * - JSON puro: /api/catalogo?action=getCatalogo
                 * - Debug HTML: /api/catalogo?action=getCatalogo&debug=1
                 */
                case "getCatalogo": {
                    getCatalogoJSON(request, response);
                    return;
                }

                /*
                 * Restituisce un mapping semplificato delle auto disponibili.
                 * Utile per controlli rapidi di disponibilità lato client.
                 */
                case "getAutoDisponibili": {
                    getAutoDisponibiliJSON(request, response);
                    return;
                }

                case "checkDisponibilita": {
                    checkDisponibilita(request, response);
                    return;
                }

                case "viewCatalogo":
                default: {
                    viewCatalogo(request, response);
                    return;
                }

                case "dbcheck": {
                    response.setContentType("text/plain;charset=UTF-8");
                    try {
                        var list = autoDAO.getAutoDisponibili();
                        response.getWriter().println("OK DB. Auto disponibili: " + (list == null ? -1 : list.size()));
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.getWriter()
                                .println("ERRORE DB: " + e.getClass().getSimpleName() + " - " + e.getMessage());
                    }
                    return;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().println("Errore server: " + ex.getClass().getSimpleName() + " - " + ex.getMessage());
        }
    }

    /**
     * Visualizza il catalogo con tutte le auto disponibili
     */
    private void viewCatalogo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Carica la lista delle auto disponibili dallo stock
            List<Auto> autoDisponibili = autoDAO.getAutoDisponibili();

            // Crea una mappa per un accesso rapido alla disponibilità tramite chiave
            // composta "modello_anno"
            Map<String, Auto> mappaDisponibilita = new HashMap<>();
            for (Auto auto : autoDisponibili) {
                String chiave = auto.getModello() + "_" + auto.getAnno();
                mappaDisponibilita.put(chiave, auto);
            }

            // Raggruppa i prodotti per marca per facilitare il filtraggio nella
            // visualizzazione
            Map<String, List<Auto>> autoPerMarca = autoDAO.getAutoPerMarca();

            // Imposta gli attributi necessari per il rendering della pagina JSP
            request.setAttribute("autoDisponibili", autoDisponibili);
            request.setAttribute("mappaDisponibilita", mappaDisponibilita);
            request.setAttribute("autoPerMarca", autoPerMarca);
            request.setAttribute("listaAuto", autoDisponibili);

            // Inoltra la richiesta alla vista del catalogo
            request.getRequestDispatcher("/catalogo.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Errore nel caricamento del catalogo: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errore", "Impossibile caricare il catalogo");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Genera e invia una risposta JSON contenente i dettagli completi del catalogo.
     * Supporta una modalità di debug per visualizzare il JSON in formato HTML.
     */
    private void getCatalogoJSON(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {

            List<Auto> tutte = autoDAO.getAll();

            // FILTRAGGIO SERVER-SIDE PER RICERCA AJAX
            String query = request.getParameter("q");
            if (query != null && !query.trim().isEmpty()) {
                String q = query.toLowerCase().trim();
                List<Auto> filtrate = new ArrayList<>();
                for (Auto a : tutte) {
                    if (a.getMarca().toLowerCase().contains(q) ||
                            a.getModello().toLowerCase().contains(q) ||
                            String.valueOf(a.getAnno()).contains(q)) {
                        filtrate.add(a);
                    }
                }
                tutte = filtrate; // Usa la lista filtrata
            }

            StringBuilder json = new StringBuilder();
            json.append("[");

            for (int i = 0; i < tutte.size(); i++) {
                Auto a = tutte.get(i);

                String[] mp = splitMotorePotenza(a.getSpecifiche());
                String motore = mp[0];
                String potenza = mp[1];

                boolean disponibile = a.getQuantitaStock() > 0;
                String coloreDefault = coloreDefaultPerModello(a.getModello());

                json.append("{")
                        .append("\"marca\":\"").append(escapeJson(a.getMarca())).append("\",")
                        .append("\"modello\":\"").append(escapeJson(a.getModello())).append("\",")
                        .append("\"coloreDefault\":\"").append(escapeJson(coloreDefault)).append("\",")
                        .append("\"anno\":").append(a.getAnno()).append(",")
                        .append("\"motore\":\"").append(escapeJson(motore)).append("\",")
                        .append("\"potenza\":\"").append(escapeJson(potenza)).append("\",")
                        .append("\"prezzo\":").append(a.getPrezzo()).append(",")
                        .append("\"quantitaStock\":").append(a.getQuantitaStock()).append(",")
                        .append("\"disponibile\":").append(disponibile)
                        .append("}");

                if (i < tutte.size() - 1)
                    json.append(",");
            }

            json.append("]");
            String jsonOut = json.toString();

            boolean debug = "1".equals(request.getParameter("debug"))
                    || "true".equalsIgnoreCase(request.getParameter("debug"));

            if (debug) {
                // Stampa il JSON sulla console del server per scopi di diagnostica
                System.out.println("=== DEBUG JSON getCatalogo ===");
                System.out.println(jsonOut);
                System.out.println("=== END DEBUG JSON getCatalogo ===");

                // Restituisce una pagina HTML minimalista per una lettura agevole del JSON
                response.setContentType("text/html;charset=UTF-8");
                out.print("<!doctype html><html lang='it'><head><meta charset='UTF-8'>");
                out.print("<title>DEBUG JSON - getCatalogo</title>");
                out.print(
                        "<style>body{font-family:monospace;padding:16px;}pre{white-space:pre-wrap;word-break:break-word;background:#f5f5f5;padding:12px;border-radius:8px;}</style>");
                out.print("</head><body>");
                out.print("<h3>DEBUG JSON - /api/catalogo?action=getCatalogo</h3>");
                out.print("<p>Parametro debug attivo (debug=1). Contenuto JSON generato:</p>");
                out.print("<pre>");
                out.print(escapeHtml(jsonOut));
                out.print("</pre>");
                out.print("</body></html>");
                return;
            }

            // Invia la risposta JSON pura con il relativo MIME type
            response.setContentType("application/json;charset=UTF-8");
            out.print(jsonOut);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    /**
     * Restituisce lo stato di disponibilità delle auto in un formato JSON
     * contratto.
     * La chiave è composta dal modello (senza spazi) e dall'anno (es.
     * Modello_2023).
     */
    private void getAutoDisponibiliJSON(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            List<Auto> tutte = autoDAO.getAll();

            StringBuilder json = new StringBuilder("{");
            for (int i = 0; i < tutte.size(); i++) {
                Auto a = tutte.get(i);
                String chiave = (a.getModello().replace(" ", "")) + "_" + a.getAnno();
                boolean disponibile = a.getQuantitaStock() > 0;

                json.append("\"").append(escapeJson(chiave)).append("\":").append(disponibile);
                if (i < tutte.size() - 1)
                    json.append(",");
            }
            json.append("}");
            out.print(json.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    /**
     * Verifica la disponibilità di un'auto specifica
     */
    private void checkDisponibilita(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String modello = request.getParameter("modello");
        String annoStr = request.getParameter("anno");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int anno = Integer.parseInt(annoStr);
            boolean disponibile = autoDAO.isAutoDisponibile(modello, anno);

            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"modello\":\"").append(escapeJson(modello)).append("\",");
            json.append("\"anno\":").append(anno).append(",");
            json.append("\"disponibile\":").append(disponibile);

            if (disponibile) {
                Auto auto = autoDAO.getByPK(modello, anno);
                if (auto != null) {
                    json.append(",\"quantita\":").append(auto.getQuantitaStock());
                    json.append(",\"prezzo\":").append(auto.getPrezzo());
                }
            }

            json.append("}");
            out.print(json.toString());

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Anno non valido\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        } finally {
            out.flush();
        }
    }

    /**
     * Split "specifiche" usando la virgola come separatore.
     * Ritorna sempre un array di 2 elementi: [motore, potenza]
     */
    private String[] splitMotorePotenza(String specifiche) {
        if (specifiche == null)
            return new String[] { "", "" };
        String[] parts = specifiche.split(",");
        String motore = parts.length >= 1 ? parts[0].trim() : "";
        String potenza = parts.length >= 2 ? parts[1].trim() : "";
        return new String[] { motore, potenza };
    }

    /**
     * Escape dei caratteri speciali per JSON
     */
    private String escapeJson(String str) {
        if (str == null)
            return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    /**
     * Escape HTML (per mostrare il JSON dentro
     * 
     * <pre>
     * quando debug=1)
     */
    private String escapeHtml(String s) {
        if (s == null)
            return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    /**
     * Determina il colore predefinito per un dato modello.
     * Questa informazione viene utilizzata come punto di partenza nel
     * configuratore.
     */
    private String coloreDefaultPerModello(String modello) {
        if (modello == null)
            return "Nero";
        String m = modello.trim().toLowerCase().replaceAll("\\s+", " ");

        if (m.equals("p1"))
            return "Giallo";
        if (m.equals("la ferrari"))
            return "Rosso";
        if (m.equals("sf90"))
            return "Nero";
        if (m.equals("aventador"))
            return "Blu";
        if (m.equals("lamborghini revuelto"))
            return "Bianco";
        if (m.equals("lamborghini sian"))
            return "Giallo";
        if (m.equals("lamborghini veneno"))
            return "Grigio";
        if (m.equals("chiron"))
            return "Nero";
        if (m.equals("bugatti divo"))
            return "Blu";
        if (m.equals("911"))
            return "Nero";
        if (m.equals("918"))
            return "Rosso";
        if (m.equals("agera"))
            return "Bianco";
        if (m.equals("koenigsegg regera"))
            return "Rosso";
        if (m.equals("812"))
            return "Nero";
        if (m.equals("ferrari f8"))
            return "Rosso";
        if (m.equals("ferrari enzo"))
            return "Rosso";
        if (m.equals("720"))
            return "Grigio";

        return "Nero"; // default finale obbligatorio
    }
}
