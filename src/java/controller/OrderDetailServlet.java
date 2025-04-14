/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import context.AccountDAO;
import context.OrderDAO;
import context.OrderItemDAO;
import context.ProductDAO;
import context.ProductImageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.CartItemDTO;
import model.Order;
import model.OrderItem;
import model.Product;
import util.Email;
import util.Utility;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetailServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        if (session.getAttribute("role") == null) {
            response.sendRedirect("login");
        } else {
            int orderID = Integer.parseInt(request.getParameter("orderId"));
            OrderItemDAO oiDAO = new OrderItemDAO();
            List<OrderItem> oi = oiDAO.getOrderItemByOrderID(orderID);
            ProductDAO pDAO = new ProductDAO();
            List<CartItemDTO> orderList = new ArrayList<>();
            ProductImageDAO pid = new ProductImageDAO();
            for (OrderItem c : oi) {
                Product p = pDAO.getProductByID(c.getProductId());
                p.setPrice(c.getTotalPrice() / c.getQuantity());
                CartItemDTO cid = new CartItemDTO(p, c.getQuantity(), pid.getAvatarProductImageByID(c.getProductId()).getImgURL());
                orderList.add(cid);

            }
            OrderDAO oDAO = new OrderDAO();
            Order order = oDAO.getOrderByOrderID(orderID);
            session.setAttribute("orderList", orderList);
            session.setAttribute("order", order);
            request.getRequestDispatcher("WEB-INF/view/order-detail.jsp").forward(request, response);
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
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getOrderByOrderID(orderId);
        String currentStatus = order.getDeliveryStatus();
        AccountDAO aDAO = new AccountDAO();

        switch (currentStatus) {
            case "PENDING":
                if ("prepare".equals(action)) {
                    orderDAO.updateOrderStatus(orderId, "PREPARING");
                }
                break;

            case "PREPARING":
                if ("ready".equals(action)) {
                    if ("pickup".equals(order.getDeliveryOption())) {
                        orderDAO.updateOrderStatus(orderId, "READY");
                        String email = aDAO.getUserById(order.getUserId()).getEmail();
                        String content = "We are excited to inform you that your order has been successfully prepared and is now ready for pickup. You can visit our store at your convenience to collect your order.\nStore Address: " + Utility.getShopAddressByOrderID(orderId);
                        Email.sendEmailNotifying(email, content);
                    } else if ("home_delivery".equals(order.getDeliveryOption())) {
                        orderDAO.updateOrderStatus(orderId, "SHIPPING");
                        String email = aDAO.getUserById(order.getUserId()).getEmail();
                        String content = "Good news! Your order is now on its way to your delivery address. Our delivery team is working hard to ensure that your order reaches you promptly.\nThank you for shopping with us. We hope you enjoy your purchase!";
                        Email.sendEmailNotifying(email, content);
                    }
                }
                break;

            case "READY":
            case "SHIPPING":
                if ("complete".equals(action)) {
                    orderDAO.updateOrderStatus(orderId, "COMPLETED");

                    response.sendRedirect("order-manage");
                    return; 
                }
                break;
            default:
                break;
        }

        if ("cancel".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "CANCELLED");
            String email = aDAO.getUserById(order.getUserId()).getEmail();
            String content = "We regret to inform you that your order has been cancelled. If you have any questions or need further assistance, please feel free to reach out to our support team. We apologize for any inconvenience caused and appreciate your understanding.";
            Email.sendEmailNotifying(email, content);
        }

        response.sendRedirect("order-detail?orderId=" + orderId);
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
