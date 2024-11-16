/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import context.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Order;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "OrderManageServlet", urlPatterns = {"/order-manage"})
public class OrderManageServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderManageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderManageServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        OrderDAO oDAO = new OrderDAO();
        Account u = (Account) session.getAttribute("user");

        int page = 1; // Trang mặc định
        int size = 10; // Số mục mặc định mỗi trang
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");

        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
        if (sizeParam != null) {
            size = Integer.parseInt(sizeParam);
        }

        List<Order> pendingList = oDAO.getPagedOrderListByShopIDAndStatus(u.getShopID(), "PENDING", page, size);
        int totalPendingOrders = oDAO.getOrderCountByShopIDAndStatus(u.getShopID(), "PENDING");

        List<Order> prepareList = oDAO.getPagedOrderListByShopIDAndStatus(u.getShopID(), "PREPARING", page, size);
        int totalPreparingOrders = oDAO.getOrderCountByShopIDAndStatus(u.getShopID(), "PREPARING");

        List<Order> readyList = oDAO.getPagedOrderListByShopIDAndStatus(u.getShopID(), "READY", page, size);
        int totalReadyOrders = oDAO.getOrderCountByShopIDAndStatus(u.getShopID(), "READY");

        List<Order> shippingList = oDAO.getPagedOrderListByShopIDAndStatus(u.getShopID(), "SHIPPING", page, size);
        int totalShippingOrders = oDAO.getOrderCountByShopIDAndStatus(u.getShopID(), "SHIPPING");

        List<Order> completeList = oDAO.getPagedOrderListByShopIDAndStatus(u.getShopID(), "COMPLETED", page, size);
        int totalCompletedOrders = oDAO.getOrderCountByShopIDAndStatus(u.getShopID(), "COMPLETED");

        List<Order> cancelList = oDAO.getPagedOrderListByShopIDAndStatus(u.getShopID(), "CANCELLED", page, size);
        int totalCancelledOrders = oDAO.getOrderCountByShopIDAndStatus(u.getShopID(), "CANCELLED");

        request.setAttribute("pendingList", pendingList);
        request.setAttribute("totalPendingOrders", totalPendingOrders);

        request.setAttribute("prepareList", prepareList);
        request.setAttribute("totalPreparingOrders", totalPreparingOrders);

        request.setAttribute("readyList", readyList);
        request.setAttribute("totalReadyOrders", totalReadyOrders);

        request.setAttribute("shippingList", shippingList);
        request.setAttribute("totalShippingOrders", totalShippingOrders);

        request.setAttribute("completeList", completeList);
        request.setAttribute("totalCompletedOrders", totalCompletedOrders);

        request.setAttribute("cancelList", cancelList);
        request.setAttribute("totalCancelledOrders", totalCancelledOrders);

        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.getRequestDispatcher("WEB-INF/view/order-manage.jsp").forward(request, response);
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
        processRequest(request, response);
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
