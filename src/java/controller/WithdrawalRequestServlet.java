package controller;

import context.AccountDAO;
import context.ShopDAO;
import context.WithdrawRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.WithdrawalRequest;
import util.Email;

@WebServlet(name = "WithdrawalRequestServlet", urlPatterns = {"/withdrawalmanagement"})
public class WithdrawalRequestServlet extends HttpServlet {

    // Handles GET and POST requests
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");

        WithdrawRequestDAO withdrawRequestDAO = new WithdrawRequestDAO();

        // Fetch all withdrawal requests
        List<WithdrawalRequest> withdrawalRequests = withdrawRequestDAO.getAllWithdrawalRequests();

        // Set withdrawal requests as a request attribute for JSP
        request.setAttribute("withdrawalRequests", withdrawalRequests);

        // Forward to JSP page to display the withdrawal requests
        request.getRequestDispatcher("WEB-INF/view/admin-withdrawal.jsp").forward(request, response);
    }

    // Handles GET request
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String amount = request.getParameter("amount");
        String shopId = request.getParameter("shopId");

        ShopDAO shopDAO = new ShopDAO();

        if (action != null && !action.isEmpty()) {
            int id = Integer.parseInt(request.getParameter("id"));
            WithdrawRequestDAO withdrawRequestDAO = new WithdrawRequestDAO();
            AccountDAO accountDAO = new AccountDAO();

            if ("approve".equals(action)) {
                try {
                    withdrawRequestDAO.updateRequestStatus(id, "approved");
                    shopDAO.updateShopWallet(Integer.parseInt(shopId), (-Double.parseDouble(amount)));

                    String email = accountDAO.getEmailByShopID(Integer.parseInt(shopId));
                    Email.sendEmailAcceptingShopRequest(email, Double.parseDouble(amount));
                } catch (Exception ex) {
                    Logger.getLogger(WithdrawalRequestServlet.class.getName()).log(Level.SEVERE, null, ex);

                }
                request.getSession().setAttribute("msg", "Withdrawal request approved.");
            } else if ("reject".equals(action)) {
                try {
                    String email = accountDAO.getEmailByShopID(Integer.parseInt(shopId));
                    Email.sendEmailRejectingShopRequest(email);
                    withdrawRequestDAO.updateRequestStatus(id, "rejected");
                } catch (Exception ex) {
                    Logger.getLogger(WithdrawalRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.getSession().setAttribute("msg", "Withdrawal request rejected.");
            }

            response.sendRedirect(request.getContextPath() + "/withdrawalmanagement");
        } else {
            try {
                processRequest(request, response);  // Normal GET request processing
            } catch (Exception ex) {
                Logger.getLogger(WithdrawalRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // Handles POST request
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);  // Process POST request the same way as GET
        } catch (Exception ex) {
            Logger.getLogger(WithdrawalRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle withdrawal requests.";
    }
}
