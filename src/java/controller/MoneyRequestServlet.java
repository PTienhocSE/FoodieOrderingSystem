/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import context.AccountDAO;
import context.CategoryDAO;
import context.OrderDAO;
import context.PostDAO;
import context.ShopDAO;
import context.WithdrawRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Category;
import model.Order;
import model.Post;
import model.WithdrawalRequest;
import util.Email;
import util.Utility;

/**
 *
 * @author phuct
 */
/**
 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
 * methods.
 *
 * @param request servlet request
 * @param response servlet response
 * @throws ServletException if a servlet-specific error occurs
 * @throws IOException if an I/O error occurs
 */
@WebServlet(name = "MoneyRequestServlet", urlPatterns = {"/moneyrequest"})
public class MoneyRequestServlet extends HttpServlet {

    // Xử lý yêu cầu GET và POST
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        String action = request.getParameter("action");
        if ("submitRequest".equals(action)) {
            handleWithdrawalRequest(request, response);
        } else {
            handleDisplayData(request, response);
        }
    }

    private void handleWithdrawalRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        HttpSession session = request.getSession();
        AccountDAO accountDAO = new AccountDAO();
        OrderDAO orderDAO = new OrderDAO();
        Account u = (Account) session.getAttribute("user");

        double requestedAmount = Double.parseDouble(request.getParameter("requestedAmount"));
        String bankAccount = request.getParameter("bankAccount");
        String bankName = request.getParameter("bankName");
        

        String email = u.getEmail();
        Email.sendEmailNotifyingShopRequest(email, requestedAmount, bankAccount);

        int shopId = accountDAO.getShopIDByUserID(u.getUserID());

//        double availableAmount = orderDAO.getTotalMoneyToday();
//        if (requestedAmount > availableAmount) {
//            response.getWriter().println("Error: Requested amount exceeds available amount.");
//            return;
//        }
        WithdrawRequestDAO withdrawalDAO = new WithdrawRequestDAO();
        WithdrawalRequest requestObj = new WithdrawalRequest(shopId, requestedAmount, new java.util.Date(), "pending", bankAccount, bankName);
        boolean isRequestCreated = withdrawalDAO.addWithdrawalRequest(requestObj);

        // Phản hồi với người dùng
        if (isRequestCreated) {
            response.getWriter().println("Withdrawal request submitted successfully!");
            response.sendRedirect("moneyrequest");
        } else {
            response.getWriter().println("Error: Unable to process withdrawal request.");
        }
    }

    private void handleDisplayData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        OrderDAO orderDAO = new OrderDAO();
        PostDAO postDAO = new PostDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        ShopDAO shopDAO = new ShopDAO();
        HttpSession session = request.getSession();
        AccountDAO accountDAO = new AccountDAO();
        Account u = (Account) session.getAttribute("user");
        int shopId = accountDAO.getShopIDByUserID(u.getUserID());
        
        double totalToday = orderDAO.getTotalMoneyToday();
        double totalYesterday = orderDAO.getTotalMoneyYesterday();
        int percentChange = calculatePercentChange(totalToday, totalYesterday);
        double totalMonth = orderDAO.getTotalMoneyThisMonth();
        double totalMoneyLastMonth = orderDAO.getTotalMoneyLastMonth();
        int percentChangeMonth = calculatePercentChange(totalMonth, totalMoneyLastMonth);
        List<Order> orderList = orderDAO.getRecentOrdersByShopID(shopId);
        List<Post> postList = postDAO.getPostsByUserID(u.getUserID());
        int orderCount = orderDAO.getOrderCountByShopID(shopId);
        List<Double> monthlyAmounts = orderDAO.getMonthlyAmount();
        List<Category> categories = categoryDAO.getAllCategories();
        double shopwallet = shopDAO.getShopWallet(shopId);

        request.setAttribute("shopwallet", shopwallet);
        request.setAttribute("monthlyAmounts", monthlyAmounts);
        request.setAttribute("postList", postList);
        request.setAttribute("categories", categories);
        request.setAttribute("totalToday", totalToday);
        request.setAttribute("totalYesterday", totalYesterday);
        request.setAttribute("orderList", orderList);
        request.setAttribute("orderCount", orderCount);
        request.setAttribute("percentChange", percentChange);
        request.setAttribute("totalMonth", totalMonth);
        request.setAttribute("totalMoneyLastMonth", totalMoneyLastMonth);
        request.setAttribute("percentChangeMonth", percentChangeMonth);

        request.getRequestDispatcher("WEB-INF/view/money-request.jsp").forward(request, response);
    }

    private int calculatePercentChange(double current, double previous) {
        if (previous == 0) {
            return (current > 0) ? 100 : 0;
        }
        return (int) (((current - previous) / previous) * 100);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(MoneyRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(MoneyRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles withdrawal requests for users.";
    }
}
