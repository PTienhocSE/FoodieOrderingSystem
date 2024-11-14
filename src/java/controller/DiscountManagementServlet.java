package controller;

import context.AccountDAO;
import context.DiscountDAO;
import context.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.CartItem;
import model.CartItemDTO;
import model.Discount;

@WebServlet(name = "DiscountManagementServlet", urlPatterns = {"/discountManage"})
public class DiscountManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DiscountManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DiscountManagementServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account u = (Account) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect("login");
            return;
        }

        OrderDAO oDAO = new OrderDAO();
        AccountDAO accDAO = new AccountDAO();
        DiscountDAO discountDAO = new DiscountDAO();
        int userID = u.getUserID();

        int shopID = accDAO.getShopIDByUserID(userID);

        List<Discount> discounts = discountDAO.getAllDiscountsByShopID(shopID);
        request.setAttribute("discounts", discounts);

        request.getRequestDispatcher("WEB-INF/view/discountManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            switch (action) {
                case "createDiscount":
                    createDiscount(request, response);
                    break;
                case "updateDiscount":
                    updateDiscount(request, response);
                    break;
                case "deleteDiscount":
                    deleteDiscount(request, response);
                    break;
                case "applyDiscount":
                    applyDiscount(request, response);
                    break;
                case "unlockDiscount":
                    unlockDiscount(request, response);
                    break;
                default:
                    throw new Error();
            }
        } catch (Exception ex) {
            Logger.getLogger(DiscountManagementServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void applyDiscount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO accountDAO = new AccountDAO();
        DiscountDAO discountDAO = new DiscountDAO();

        String discountCode = request.getParameter("discount_code");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int userID = Integer.parseInt(request.getParameter("userID"));
        String paymentMethod = request.getParameter("payment_method");
        String deliveryOption = request.getParameter("shipping_method");
        String timePickup = request.getParameter("pickup_time");

        Account account = accountDAO.getUserById(userID);
        Double discountPercentage = discountDAO.getDiscountPercentageByDiscountCode(discountCode);

        if (discountPercentage == null) {
            request.setAttribute("errorMessage", "The discount code is invalid or has expired.");
            forwardToCheckout(request, response, address, phone, timePickup, paymentMethod, deliveryOption);
            return;
        }

        int discountOwnerUserID = discountDAO.getUserIdByDiscountCode(discountCode);
        int discountShopID = accountDAO.getShopIDByUserID(discountOwnerUserID);

        Discount discount = discountDAO.getAllDiscountsByShopID(discountShopID)
                .stream()
                .filter(d -> d.getDiscountCODE().equals(discountCode))
                .findFirst()
                .orElse(null);

        if (discount == null) {
            request.setAttribute("errorMessage", "The discount code is not applicable.");
            forwardToCheckout(request, response, address, phone, timePickup, paymentMethod, deliveryOption);
            return;
        }

        Double minimumAmount = discount.getMinimumAmount();
        Double maximumAmount = discount.getMaximumAmount();

        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");
        double totalOrderAmount = 0.0;

        for (CartItemDTO item : cart) {
            int productShopID = item.getProduct().getShopId();

            if (discountShopID != 0 && productShopID != discountShopID) {
                request.setAttribute("errorMessage", "The discount code is only applicable to products from the same shop.");
                forwardToCheckout(request, response, address, phone, timePickup, paymentMethod, deliveryOption);
                return;
            }

            totalOrderAmount += item.getProduct().getPrice() * item.getQuantity();
        }

        if (totalOrderAmount < minimumAmount) {
            request.setAttribute("errorMessage", "The discount code requires a minimum order amount of " + minimumAmount + ".");
            forwardToCheckout(request, response, address, phone, timePickup, paymentMethod, deliveryOption);
            return;
        }

        double discountAmount = totalOrderAmount * (discountPercentage / 100);

        if (discountAmount > maximumAmount) {
            discountAmount = maximumAmount;
        }

        double finalAmount = totalOrderAmount - discountAmount;

        session.setAttribute("payment_method", paymentMethod);
        session.setAttribute("deliveryOption", deliveryOption);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
        session.setAttribute("finalAmount", finalAmount);
        session.setAttribute("discountAmount", discountAmount);
        session.setAttribute("originalAmount", totalOrderAmount);
        session.setAttribute("discountCode", discountCode);

        request.getRequestDispatcher("WEB-INF/view/checkout.jsp").forward(request, response);
    }

    private void forwardToCheckout(HttpServletRequest request, HttpServletResponse response, String address, String phone, String timePickup, String payment_method, String deliveryOption) throws ServletException, IOException {
        request.setAttribute("address", address);
        request.setAttribute("phone", phone);
        HttpSession session = request.getSession();
        session.setAttribute("timePickup", timePickup);
        session.setAttribute("payment_method", payment_method);
        session.setAttribute("deliveryOption", deliveryOption);
        request.getRequestDispatcher("WEB-INF/view/checkout.jsp").forward(request, response);
    }

    protected void createDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accDAO = new AccountDAO();
        String userIDParam = request.getParameter("userID");
        int userID = Integer.parseInt(userIDParam);
        String discountCode = request.getParameter("discountCode");
        int numberOfDiscount = Integer.parseInt(request.getParameter("numberOfDiscount"));
        double discountPercentage = Double.parseDouble(request.getParameter("discountPercentage"));
        double minimumAmount = Double.parseDouble(request.getParameter("minimumAmount"));
        double maximumAmount = Double.parseDouble(request.getParameter("maximumAmount"));
        int shopID = accDAO.getShopIDByUserID(userID);

        Discount discount = new Discount();
        discount.setUserID(userID);
        discount.setDiscountCODE(discountCode);
        discount.setNumberOfDiscount(numberOfDiscount);
        discount.setDiscountPercentage(discountPercentage);
        discount.setShopID(shopID);
        discount.setMinimumAmount(minimumAmount);
        discount.setMaximumAmount(maximumAmount);

        DiscountDAO discountDAO = new DiscountDAO();
        discountDAO.createDiscount(discount);

        response.sendRedirect("discountManage");
    }

    protected void updateDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int discountID = Integer.parseInt(request.getParameter("discountID"));
            int numberOfDiscount = Integer.parseInt(request.getParameter("numberOfDiscount"));
            double discountPercentage = Double.parseDouble(request.getParameter("discountPercentage"));

            Discount discount = new Discount();
            discount.setDiscountID(discountID);
            discount.setNumberOfDiscount(numberOfDiscount);
            discount.setDiscountPercentage(discountPercentage);

            DiscountDAO discountDAO = new DiscountDAO();
            discountDAO.updateDiscount(discount);

            response.sendRedirect("discountManage");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format. Please check your input.");
            request.getRequestDispatcher("discountManage").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("discountManage").forward(request, response);
        }
    }

    protected void deleteDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int discountID = Integer.parseInt(request.getParameter("discountID"));
        DiscountDAO discountDAO = new DiscountDAO();
        discountDAO.deleteDiscount(discountID);
        response.sendRedirect("discountManage");
    }

    protected void unlockDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        int discountID = Integer.parseInt(request.getParameter("discountID"));
        DiscountDAO discountDAO = new DiscountDAO();

        try {
            discountDAO.unlockDiscount(discountID);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error unlocking discount: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/errorPage.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("discountManage");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
