package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import context.OrderDAO;
import context.ShopDAO;
import context.VNPayBillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.VNPay_Bill;

/**
 *
 * @author phuct
 */
@WebServlet(urlPatterns = {"/paymentStatus"})
public class PaymentStatusServlet extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        HttpSession session = request.getSession(true);
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_PayDate = request.getParameter("vnp_PayDate");

        System.out.println("Response Code: " + vnp_ResponseCode);
        System.out.println("Transaction Status: " + vnp_TransactionStatus);
        System.out.println("Transaction Reference: " + vnp_TxnRef);

        OrderDAO orderDAO = new OrderDAO();
        int orderID = orderDAO.getOrderIDByPaymentID(vnp_TxnRef);

        VNPayBillDAO vnpayDAO = new VNPayBillDAO();
        VNPay_Bill bill = new VNPay_Bill(vnp_TxnRef, Float.parseFloat(vnp_Amount) / 100, vnp_PayDate, vnp_TransactionStatus, orderID);

        vnpayDAO.createVNPayBill(bill);

        OrderDAO dao = new OrderDAO();
        String paymentID = vnp_TxnRef;
        if ("00".equals(vnp_ResponseCode) && "00".equals(vnp_TransactionStatus)) {

            dao.updateOrderPaymentStatus(paymentID, "PAID");

            int shopID = orderDAO.getShopIDByPaymentID(paymentID);

            ShopDAO shopDAO = new ShopDAO();
            boolean success = shopDAO.updateShopWallet(shopID, Float.parseFloat(vnp_Amount) / 100);
            if (success) {
                System.out.println("Shop wallet updated successfully for shopId: " + shopID);
            } else {
                System.out.println("Failed to update shop wallet for shopId: " + shopID);
            }
            request.getRequestDispatcher("WEB-INF/view/paymentStatus.jsp").forward(request, response);
            session.removeAttribute("paymentID");

        } else {
            dao.updateOrderPaymentStatus(paymentID, "FAILED");
            dao.updateOrderDeliveryStatus(paymentID, "FAILED");

            request.getRequestDispatcher("WEB-INF/view/paymentStatus.jsp").forward(request, response);

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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(PaymentStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(PaymentStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
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
