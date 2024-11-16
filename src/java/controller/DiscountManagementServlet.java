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

    private boolean validateSystemDiscountCode(List<CartItemDTO> cart, double totalOrderAmount, Discount discount) throws Exception {
        Double minimumAmount = discount.getMinimumAmount();
        Double maximumAmount = discount.getMaximumAmount();

        // Kiểm tra giá trị tối thiểu của đơn hàng
        if (totalOrderAmount < minimumAmount) {
            throw new Exception("The discount code requires a minimum order amount of " + minimumAmount + ".");
        }

        // Kiểm tra các sản phẩm trong giỏ hàng (áp dụng cho toàn hệ thống, không cần kiểm tra shop)
        double discountAmount = totalOrderAmount * (discount.getDiscountPercentage() / 100);
        if (discountAmount > maximumAmount) {
            discountAmount = maximumAmount;
        }

        return true;
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

        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");
        double totalOrderAmount = 0.0;

        for (CartItemDTO item : cart) {
            totalOrderAmount += item.getProduct().getPrice() * item.getQuantity();
        }

        try {
            Double discountPercentage = discountDAO.getDiscountPercentageByDiscountCode(discountCode);

            if (discountPercentage == null) {
                throw new Exception("The discount code is invalid or has expired.");
            }

            int discountOwnerUserID = discountDAO.getUserIdByDiscountCode(discountCode);
            int discountShopID = accountDAO.getShopIDByUserID(discountOwnerUserID);

            Discount discount = discountDAO.getAllDiscountsByShopID(discountShopID)
                    .stream()
                    .filter(d -> d.getDiscountCODE().equals(discountCode))
                    .findFirst()
                    .orElse(null);

            if (discount == null) {
                throw new Exception("The discount code is not applicable.");
            }

            double discountAmount = 0.0;
            double finalAmount = totalOrderAmount;

            if (discountShopID == 0) {
                if (validateSystemDiscountCode(cart, totalOrderAmount, discount)) {
                    discountAmount = totalOrderAmount * (discountPercentage / 100);
                    if (discountAmount > discount.getMaximumAmount()) {
                        discountAmount = discount.getMaximumAmount();
                    }
                    finalAmount -= discountAmount;
                }
            } else {
                for (CartItemDTO item : cart) {
                    int productShopID = item.getProduct().getShopId();
                    if (productShopID != discountShopID) {
                        throw new Exception("The discount code is only applicable to products from the same shop.");
                    }
                }

                if (totalOrderAmount < discount.getMinimumAmount()) {
                    throw new Exception("The discount code requires a minimum order amount of " + discount.getMinimumAmount() + ".");
                }

                discountAmount = totalOrderAmount * (discountPercentage / 100);
                if (discountAmount > discount.getMaximumAmount()) {
                    discountAmount = discount.getMaximumAmount();
                }
                finalAmount -= discountAmount;
            }

            if (finalAmount < 0) {
                finalAmount = 0.0;
            }
            
            int discountID = discount.getDiscountID();
            int newTotalUse = discount.getTotalUse() + 1;
            discountDAO.updateTotalUse(discountID, newTotalUse);
            forwardToCheckout(request, response, address, phone, timePickup, paymentMethod, deliveryOption, discountCode, finalAmount, discountAmount, totalOrderAmount);
        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            forwardToCheckout(request, response, address, phone, timePickup, paymentMethod, deliveryOption, discountCode, totalOrderAmount, 0.0, totalOrderAmount);
        }
    }

    private void forwardToCheckout(HttpServletRequest request, HttpServletResponse response, String address, String phone,
            String timePickup, String paymentMethod, String deliveryOption, String discountCode,
            double finalAmount, double discountAmount, double totalOrderAmount)
            throws ServletException, IOException {
        request.setAttribute("address", address);
        request.setAttribute("phone", phone);

        HttpSession session = request.getSession();
        session.setAttribute("timePickup", timePickup);
        session.setAttribute("payment_method", paymentMethod);
        session.setAttribute("deliveryOption", deliveryOption);
        session.setAttribute("discountCode", discountCode);

        session.setAttribute("originalAmount", totalOrderAmount);

        session.setAttribute("discountAmount", discountAmount);
        session.setAttribute("finalAmount", finalAmount);

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
        DiscountDAO discountDAO = new DiscountDAO();
        int discountID = Integer.parseInt(request.getParameter("discountID"));
        discountDAO.unlockDiscount(discountID);
        response.sendRedirect("discountManage");
    }
}
