package controller;

import context.AccountDAO;
import context.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.RewardRedemptionDAO;
import java.security.SecureRandom;
import model.Account;
import model.Discount;
import util.Email;
import util.Utility;

@WebServlet(name = "RewardRedemptionServlet", urlPatterns = {"/reward"})
public class RewardRedemptionServlet extends HttpServlet {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int CODE_LENGTH = 8;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/view/reward.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Account user = (Account) session.getAttribute("user");
            if (user != null) {
                int userId = user.getUserID();
                RewardRedemptionDAO rwDAO = new RewardRedemptionDAO();
                try {
                    int points = rwDAO.getPointsByUserID(userId);
                    request.setAttribute("points", points);
                } catch (Exception ex) {
                    Logger.getLogger(RewardRedemptionServlet.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("message", "Error retrieving points.");
                }
                processRequest(request, response);
            } else {
                request.setAttribute("message", "User session not found.");
                processRequest(request, response);
            }
        } else {
            request.setAttribute("message", "Session expired. Please log in again.");
            processRequest(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "redeem":
                redeemVoucher(request, response);
                break;
            case "register":
                registerReward(request, response);
                break;
            case "redeemPoint":
                redeemPoint(request, response);
                break;
            default:
                processRequest(request, response);
                break;
        }
    }

    public String generateRandomCode() {

        SecureRandom random = new SecureRandom();
        StringBuilder code = new StringBuilder(CODE_LENGTH);

        for (int i = 0; i < CODE_LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            code.append(CHARACTERS.charAt(index));
        }

        return code.toString();
    }

    private void redeemPoint(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String message = "";

        if (session != null) {
            Account user = (Account) session.getAttribute("user");
            if (user != null) {
                try {
                    Integer userId = user.getUserID();
                    int pointsToRedeem = Integer.parseInt(request.getParameter("pointsToRedeem"));

                    DiscountDAO discountDAO = new DiscountDAO();
                    RewardRedemptionDAO rwDAO = new RewardRedemptionDAO();

                    int currentPoints = rwDAO.getPointsByUserID(userId);

                    if (currentPoints >= pointsToRedeem) {
                        if (rwDAO.redeemPoints(userId, pointsToRedeem)) {
                            String coupon = generateRandomCode();
                            int maximumDiscount = pointsToRedeem ; 

                            Discount discount = new Discount();
                            discount.setUserID(userId);
                            discount.setDiscountCODE(coupon);
                            discount.setNumberOfDiscount(1);
                            discount.setDiscountPercentage(100);
                            discount.setMaximumAmount(maximumDiscount);

                            discountDAO.createDiscount(discount);

                            AccountDAO accDAO = new AccountDAO();
                            String email = accDAO.getEmailByUserID(userId);
                            String content = "We have received your points exchange request. "
                                    + "We are pleased to send you this voucher with the code: " + coupon + "\n"
                                    + "Maximum discount: " + maximumDiscount + "\nDiscount Percentage: 100%";

                            Email.sendEmailNotifyingReward(email, content);

                            message = "Redemption successful! You have received your voucher.";

                            response.sendRedirect("/OrderingSystem/reward");
                            return;
                        } else {
                            message = "Redemption failed. Please try again.";
                        }
                    } else if (currentPoints == pointsToRedeem) {
                        message = "You cannot redeem this voucher. You must have more points than required.";
                    } else {
                        message = "You do not have enough points to redeem this voucher.";
                    }
                } catch (NumberFormatException e) {
                    message = "Invalid points value.";
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Error during redemption process.";
                }
            } else {
                message = "User session not found.";
            }
        } else {
            message = "Session expired. Please log in again.";
        }

        // Set the message and forward to reward.jsp
        request.setAttribute("message", message);
        request.getRequestDispatcher("WEB-INF/view/reward.jsp").forward(request, response);
    }

    private void redeemVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String message;

        if (session != null) {
            Account user = (Account) session.getAttribute("user");
            if (user != null) {
                try {
                    Integer userId = user.getUserID();
                    int pointsRequired = Integer.parseInt(request.getParameter("points"));
                    int valueDiscount = Integer.parseInt(request.getParameter("valueDiscount"));
                    DiscountDAO discountDAO = new DiscountDAO();

                    RewardRedemptionDAO rwDAO = new RewardRedemptionDAO();
                    int currentPoints = rwDAO.getPointsByUserID(userId);

                    if (currentPoints > pointsRequired) {
                        if (rwDAO.redeemPoints(userId, pointsRequired)) {
                            message = "Redemption successful! You have received your voucher.";
                            Discount discount = new Discount();
                            String coupon = generateRandomCode();
                            discount.setUserID(userId);
                            discount.setDiscountCODE(coupon);
                            discount.setNumberOfDiscount(1);
                            discount.setDiscountPercentage(valueDiscount);
                            discount.setMaximumAmount(50000);

                            discountDAO.createDiscount(discount);

                            AccountDAO accDAO = new AccountDAO();

                            String email = accDAO.getEmailByUserID(userId);
                            String content = "We have received your points exchange request. We are pleased to send you this voucher with the code: " + coupon;

                            Email.sendEmailNotifyingReward(email, content);

                            response.sendRedirect("/OrderingSystem/reward");
                            return;
                        } else {
                            message = "Redemption failed. Please try again.";
                        }
                    } else if (currentPoints == pointsRequired) {
                        message = "You cannot redeem this voucher. You must have more points than required.";
                    } else {
                        message = "You do not have enough points to redeem this voucher.";
                    }
                } catch (NumberFormatException e) {
                    message = "Invalid points value.";
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Error during redemption process.";
                }
            } else {
                message = "User session not found.";
            }
        } else {
            message = "Session expired. Please log in again.";
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("WEB-INF/view/reward.jsp").forward(request, response);
    }

    private void registerReward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String message;

        if (session != null) {
            Account user = (Account) session.getAttribute("user");
            if (user != null) {
                try {
                    Integer userId = user.getUserID();
                    RewardRedemptionDAO rwDAO = new RewardRedemptionDAO();
                    rwDAO.createRewardRedemption(userId, 10);
                    message = "Registration successful! You have received 10 points.";
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Error during registration process.";
                }
            } else {
                message = "User session not found.";
            }
        } else {
            message = "Session expired. Please log in again.";
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("WEB-INF/view/reward.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Reward redemption servlet";
    }
}
