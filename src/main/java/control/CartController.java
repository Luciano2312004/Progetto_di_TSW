package control;

import com.google.gson.Gson;
import model.CarItem;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if ("/add".equals(action)) {
            add(request, response);
        } else if ("/remove".equals(action)) {
            remove(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if ("/get".equals(action)) {
            getCart(request, response);
        }
    }

    // ... (i metodi private add, getCart, remove restano invariati, sono corretti)
    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        try {
            CarItem item = gson.fromJson(request.getReader(), CarItem.class);
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            List<CarItem> cart = (List<CarItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }
            cart.add(item);
            response.getWriter().write("{\"success\":true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Errore interno del server: " + e.getMessage() + "\"}");
        }
    }

    private void getCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CarItem> cart = (List<CarItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(cart));
    }

    private void remove(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        try {
            CarItem itemToRemove = gson.fromJson(request.getReader(), CarItem.class);
            String itemId = itemToRemove.getId();
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            List<CarItem> cart = (List<CarItem>) session.getAttribute("cart");
            if (cart != null && itemId != null) {
                cart.removeIf(item -> itemId.equals(item.getId()));
            }
            response.getWriter().write("{\"success\":true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false, \"message\":\"Errore durante la rimozione.\"}");
        }
    }
}