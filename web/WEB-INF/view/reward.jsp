<%@ page contentType="text/html" pageEncoding="UTF-8" import="jakarta.servlet.http.HttpSession, model.*, java.util.*, util.*, jakarta.servlet.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="context.RewardRedemptionDAO" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Account</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link rel="stylesheet" href="./assets/css/account.css">
        <link rel="stylesheet" href="./assets/css/reward.css">
    </head>

    <body>
        <%@ include file="/include/header.jsp" %>

        <div class="container">
            <div class="header">
                <div class="user-info">
                    <img src="${user.getAvtImg()}" onerror="this.onerror=null;this.src='https://i.pinimg.com/564x/09/a9/2c/09a92c1cbe440f31d1818e4fe0bcf23a.jpg';" alt="Profile Picture">
                    <div>
                        <h2>${user.getFullName()}</h2>
                        <p>${user.getEmail()}</p>
                        <p>
                            <i class="ti-gift"></i>
                            Point: 
                            <% 
                                int points = 0;
                                try {
                                    RewardRedemptionDAO rwDAO = new RewardRedemptionDAO();
                                    Integer userId = user.getUserID(); 
                                    points = rwDAO.getPointsByUserID(userId);
                                    out.println(points);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("Error retrieving points.");
                                }
                            %>
                        </p>
                        <c:if test="${points == 0}">
                            <a href="#" class="btn btn-success" onclick="document.getElementById('registerReward').submit();">Register Member</a>
                            <form id="registerReward" action="reward" method="post" style="display: none;">
                                <input type="hidden" name="action" value="register">
                                <input type="hidden" name="userId" value="${user.getUserID()}">
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Input to redeem points -->
            <div class="redeem-points-section mt-4">
                <h2>Redeem Points</h2>
                <c:if test="${not empty message}">
                    <div class="alert alert-info">
                        ${message}
                    </div>
                </c:if>

                <form action="reward" method="post" class="d-flex align-items-center">
                    <label for="pointsToRedeem" class="mr-2">Enter Points:</label>
                    <p style="margin: 0">1000 point = 1000 đ</p>
                    <input type="number" id="pointsToRedeem" name="pointsToRedeem" min="1" class="form-control w-25" required>
                    <input type="hidden" name="action" value="redeemPoint">
                    <input type="hidden" name="userId" value="${user.getUserID()}">
                    <button type="submit" class="btn btn-primary ml-3">Redeem</button>
                </form>
            </div>

            <div class="mt-4">
                <h2>Available Vouchers</h2>

                <!-- Display any message after redeeming -->
                <c:if test="${not empty requestScope.message}">
                    <div class="alert alert-info">${requestScope.message}</div>
                </c:if>

                <div class="row">
                    <div class="col-md-6">
                        <div class="voucher-card">
                            <img src="./assets/img/5.png" alt="5%" class="voucher-image">
                            <div class="voucher-info">
                                <h3>5%</h3>
                                <p>Requires: 200 points <br> Maximum discount: 50.000đ</p>
                                <form action="reward" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="redeem">
                                    <input type="hidden" name="userId" value="${user.getUserID()}">
                                    <input type="hidden" name="points" value="200">
                                    <input type="hidden" name="valueDiscount" value="5">
                                    <button type="submit" class="btn btn-primary">Redeem</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="voucher-card">
                            <img src="./assets/img/10.png" alt="10%" class="voucher-image">
                            <div class="voucher-info">
                                <h3>10%</h3>
                                <p>Requires: 500 points <br> Maximum discount: 50.000đ</p>
                                <form action="reward" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="redeem">
                                    <input type="hidden" name="userId" value="${user.getUserID()}">
                                    <input type="hidden" name="points" value="500">
                                    <input type="hidden" name="valueDiscount" value="10">
                                    <button type="submit" class="btn btn-primary">Redeem</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="voucher-card">
                            <img src="./assets/img/20.png" alt="20%" class="voucher-image">
                            <div class="voucher-info">
                                <h3>20%</h3>
                                <p>Requires: 1000 points<br> Maximum discount: 50.000đ</p>
                                <form action="reward" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="redeem">
                                    <input type="hidden" name="userId" value="${user.getUserID()}">
                                    <input type="hidden" name="points" value="1000">
                                    <input type="hidden" name="valueDiscount" value="20">
                                    <button type="submit" class="btn btn-primary">Redeem</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="voucher-card">
                            <img src="./assets/img/50.png" alt="50%" class="voucher-image">
                            <div class="voucher-info">
                                <h3>50%</h3>
                                <p>Requires: 5000 points <br> Maximum discount: 50.000đ</p>
                                <form action="reward" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="redeem">
                                    <input type="hidden" name="userId" value="${user.getUserID()}">
                                    <input type="hidden" name="points" value="5000">
                                    <input type="hidden" name="valueDiscount" value="50">
                                    <button type="submit" class="btn btn-primary">Redeem</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="/include/footer.jsp" %>
    </body>
</html>
