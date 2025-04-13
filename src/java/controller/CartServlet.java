package controller;

import model.CartItemDTO;
import context.CartDAO;
import context.ShopDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.CartItem;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login");
        } else {
            CartDAO cartDAO = new CartDAO();
            Account user = (Account) session.getAttribute("user");

            // Group cart items by shop
            Map<Integer, List<CartItemDTO>> groupedCartItems = cartDAO.groupCartItemsByShop(user.getUserID());
            session.setAttribute("cart", groupedCartItems);

            // Create a map to hold shop names
            ShopDAO shopDAO = new ShopDAO();
            Map<Integer, String> shopNames = new HashMap<>();
            for (Integer shopId : groupedCartItems.keySet()) {
                String shopName = shopDAO.getShopNameByID(shopId); // Assuming this method exists in ShopDAO
                shopNames.put(shopId, shopName);

            }
            // Set shop names in the session or request
            request.setAttribute("shopNames", shopNames);

            request.getRequestDispatcher("WEB-INF/view/cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("isAdd") != null) {
            addProduct(request, response);

        } else if (request.getParameter("isUpdate") != null) {

            updateCartQuantity(request, response);
        } else {
            deleteProduct(request, response);
        }
    }

    private void updateCartQuantity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        CartDAO cd = new CartDAO();
        cd.updateCartItemQuantity(user.getUserID(), productId, quantity);

        Map<Integer, List<CartItemDTO>> groupedCartItems = cd.groupCartItemsByShop(user.getUserID());
        session.setAttribute("cart", groupedCartItems);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login");
        } else {
            int productID = Integer.parseInt(request.getParameter("productID"));
            int shopID = Integer.parseInt(request.getParameter("shopID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
        int quantity;
        if (request.getParameter("quantity") == null) {
                quantity = 1;
            } else {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
            CartItem c = new CartItem(userID, productID, quantity, shopID);

            CartDAO cartDAO = new CartDAO();
            if (cartDAO.addToCart(c)) {
                session.setAttribute("alert", "Added to cart successfully!");
            } else {
                session.setAttribute("alert", "Failed to add product!");
            }

            if (request.getParameter("fromWL") != null) {
                session.removeAttribute("alert");
                response.sendRedirect("favourite");
            } else {

                Map<Integer, List<CartItemDTO>> groupedCartItems = cartDAO.groupCartItemsByShop(userID);
                session.setAttribute("cart", groupedCartItems);

                response.sendRedirect("food-detail?productId=" + productID);
            }
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String[] selected = request.getParameterValues("isSelected");
        if (selected == null) {
            session.setAttribute("cartStatus", "Choose product to delete!");
            response.sendRedirect("cart");
        } else {
            CartDAO cartDAO = new CartDAO();
            int userID = Integer.parseInt(request.getParameter("userID"));

            for (String productID : selected) {
                int id;
                try {
                    id = Integer.parseInt(productID);
                    if (!cartDAO.deleteCartProduct(id, userID)) {
                        session.setAttribute("cartStatus", "Cannot delete!");
                    }
                } catch (NumberFormatException e) {
                    throw new ServletException("invalid id");
                }
            }
            Map<Integer, List<CartItemDTO>> groupedCartItems = cartDAO.groupCartItemsByShop(userID);
            session.setAttribute("cart", groupedCartItems);

            session.setAttribute("cartStatus", "Delete products successfully!");
            response.sendRedirect("cart");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
