/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import context.FavouriteDAO;
import context.ProductDAO;
import context.ProductImageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.CartItemDTO;
import model.Favourite;
import model.Product;

/**
 *
 * @author giang
 */
public class FavouriteServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FavouriteServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FavouriteServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        if (session.getAttribute("role") == null) {
            response.sendRedirect("login");
        } else {
            ProductDAO pDAO = new ProductDAO();
            FavouriteDAO fDAO = new FavouriteDAO();
            Account user = (Account) session.getAttribute("user");

            List<Favourite> favourite = fDAO.getWishlistByUserID(user.getUserID());

            List<CartItemDTO> cartList = new ArrayList<>();
            ProductImageDAO pid = new ProductImageDAO();
            for (Favourite f : favourite) {
                Product p = pDAO.getProductByID(f.getProductID());

                CartItemDTO cid = new CartItemDTO(p, pid.getAvatarProductImageByID(f.getProductID()).getImgURL());
                cartList.add(cid);

            }
            session.setAttribute("cart", cartList);

            request.getRequestDispatcher("WEB-INF/view/wishlist.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("addWishList") != null) {
            addWishlist(request, response);
        } else if (request.getParameter("removeWishList") != null) {
            removeWishlist(request, response);
        } else {
            deleteWishlist(request, response);
        }
    }

    private void addWishlist(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login");
        } else {
        int productID = Integer.parseInt(request.getParameter("productID"));
        int userID = Integer.parseInt(request.getParameter("userID"));

        Favourite c = new Favourite(userID, productID);

        FavouriteDAO favouriteDAO = new FavouriteDAO();
        if (favouriteDAO.addToWishlist(c)) {
            session.setAttribute("alert", "Added to wishlist successfully!");
        } else {
            session.setAttribute("alert", "Failed to add product!");
        }
        if (request.getParameter("fromWL") != null) {
            response.sendRedirect("favourite");
        } else {
            response.sendRedirect("food-detail?productId=" + productID);
        }
        }
    }

    private void removeWishlist(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int productID = Integer.parseInt(request.getParameter("productID"));
        int userID = Integer.parseInt(request.getParameter("userID"));

        FavouriteDAO favouriteDAO = new FavouriteDAO();
        favouriteDAO.deleteWishlistProduct(productID, userID) ;
        
        if (request.getParameter("fromWL") != null) {
            response.sendRedirect("favourite");
        } else {
            response.sendRedirect("food-detail?productId=" + productID);
        }
    }

    private void deleteWishlist(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String[] selected = request.getParameterValues("isSelected");
        if (selected == null) {
            session.setAttribute("cartStatus", "Choose product to delete!");
            response.sendRedirect("favourite");

        } else {
            for (String productID : selected) {
                int id, userID;
                try {
                    userID = Integer.parseInt(request.getParameter("userID"));
                    id = Integer.parseInt(productID);
                    FavouriteDAO fDAO = new FavouriteDAO();
                    if (!fDAO.deleteWishlistProduct(id, userID)) {
                        session.setAttribute("cartStatus", "Cannot delete!");
                    }
                } catch (NumberFormatException e) {
                    throw new ServletException("invalid id");
                }

            }
            session.setAttribute("cartStatus", "Delete products successfully!");
            response.sendRedirect("favourite");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
