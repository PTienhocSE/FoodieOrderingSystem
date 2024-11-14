<%-- 
    Document   : checkout
    Created on : Oct 2, 2024, 2:16:53 PM
    Author     : phuct
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Account" %>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Checkout Page</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
        <link rel="stylesheet" href="assets/css/plugins.css">
        <link rel="stylesheet" href="./assets/css/style.css" />
        <link rel="stylesheet" href="./assets/css/blog.css" />
        <link rel="stylesheet" href="./assets/css/cart.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link rel="stylesheet" href="./assets/css/checkout.css" />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
        <link
            rel="stylesheet"
            href="./assets/font/themify-icons/themify-icons.css"
            />
    </head>

    <body>

        <%@ include file="/include/header.jsp" %>

        <div class="off_canvars_overlay"></div>
        <div class="breadcrumbs_area other_bread">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <!--                            <ul>
                                                            <li><a href="/OrderingSystem/">Home</a></li>
                                                            <li>/</li>
                                                            <li>Checkout</li>
                                                        </ul>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="Checkout_section" id="accordion">
            <div class="container">
                <div class="checkout_form">
                    <form action="checkout" method="POST" id="completeOrderForm">
                        <div class="row">
                            <div class="col-lg-5 col-md-5">
                                <h3>Order details</h3>
                                <div class="row">
                                    <div class="col-lg-12 mb-20">
                                        <label>Customer name<span>*</span></label>
                                        <c:if test="${not empty user}">
                                            <input readonly value="${user.getFullName()}" type="text">
                                        </c:if>
                                        <c:if test="${empty user}">
                                            <input readonly value="User undefined" type="text">
                                        </c:if>
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label>Email <span>*</span></label>
                                        <c:if test="${not empty user}">
                                            <input readonly value="${user.getEmail()}" type="text">
                                        </c:if>
                                        <c:if test="${empty user}">
                                            <input readonly value="User undefined" type="text">
                                        </c:if>
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label>Address<span>*</span></label>
                                        <input required name="address" value="${address}" type="text">
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label>Phone number<span>*</span></label>
                                        <input required name="phone" type="tel" value="${phone}" pattern="[0-9]{10}" title="Enter phone number 10 digit" maxlength="10">
                                    </div>
                                </div>
                                <h4>Payment type</h4>
                                <div class="payment_method">
                                    <div>
                                        <input type="radio" name="payment_method" id="vnpay" <c:if test="${payment_method == 'vnpay'}">checked</c:if> value="vnpay">
                                            <label for="vnpay">VNPAY</label>
                                        </div>
                                        <div>
                                            <input type="radio" name="payment_method" id="cod" <c:if test="${payment_method == 'cod'}">checked</c:if> value="cod">
                                            <label for="cod">COD</label>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <h4>Pickup method</h4>
                                        <div class="shipping_method">
                                            <div>
                                                <input type="radio" name="shipping_method" id="home_delivery" <c:if test="${deliveryOption == 'home_delivery'}">checked</c:if>  value="home_delivery" required>
                                                <label for="home_delivery">Delivery at home</label>
                                            </div>
                                            <div>
                                                <input type="radio" name="shipping_method" id="pickup" <c:if test="${deliveryOption == 'pickup'}">checked</c:if> value="pickup" required>
                                                <label for="pickup">Pick up at store</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 mb-20" id="pickup_time_field" style="display:none;">
                                        <label>Time pick up<span>*</span></label>
                                        <input name="pickup_time" type="datetime-local" value="${pickup_time}" id="pickup_time">
                                </div>
                                <input type="hidden" name="userID" value="${user.userID}">

                                <button class="btn btn-success" type="submit">Complete the order</button>

                            </div>

                            <div class="col-lg-7 col-md-7">
                                <h3>Cart</h3>
                                <!-- Hiển thị giỏ hàng -->
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cart}">
                                            <tr>
                                                <td>${item.product.name}</td>
                                                <td>
                                                    <fmt:formatNumber value="${item.product.price}" type="number" pattern="#,###"/>
                                                </td>
                                                <td>${item.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber value="${item.product.price * item.quantity}" type="number" pattern="#,###"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td style="color: #ff6b6b; font-weight: 700;" colspan="3">Total</td>
                                            <td style="color: #ff6b6b; font-weight: 700;">
                                                <fmt:formatNumber value="${originalAmount}" type="number" pattern="#,###"/>
                                            </td>
                                        </tr>
                                        <c:if test="${not empty discountAmount}">
                                            <tr>
                                                <td style="color: #5eae53; font-weight: 700;" colspan="3">Discount</td>
                                                <td style="color: #5eae53; font-weight: 700;">
                                                    <fmt:formatNumber value="${discountAmount}" type="number" pattern="#,###"/>
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty finalAmount}">
                                            <tr>
                                                <td style="color: #ff6b6b; font-weight: 700;" colspan="3">Total After Discount</td>
                                                <td style="color: #ff6b6b; font-weight: 700;">
                                                    <fmt:formatNumber value="${finalAmount}" type="number" pattern="#,###"/>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>

                                <!-- Hiển thị phần mã giảm giá -->
                                <div class="discount-section">
                                    <label>Discount Code:</label>
                                    <input type="text" id="discount_code" value="${discountCode}" name="discount_code"/>
                                    <input type="hidden" name="userID" value="${user.userID}">
                                    <input type="hidden" name="action" value="applyDiscount">
                                    <button style="width: 25%; padding: 13px;" type="submit" formaction="/OrderingSystem/discountManage" formmethod="POST" class="btn btn-success">Apply</button>
                                </div>

                                <!-- Hiển thị thông báo lỗi nếu có -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger mt-3" role="alert">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                                
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>


        <%@ include file="/include/footer.jsp" %>  

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const pickupRadio = document.getElementById('pickup');
                const homeDeliveryRadio = document.getElementById('home_delivery');
                const pickupTimeField = document.getElementById('pickup_time_field');

                pickupRadio.addEventListener('change', function () {
                    pickupTimeField.style.display = 'block';
                });
                homeDeliveryRadio.addEventListener('change', function () {
                    pickupTimeField.style.display = 'none';
                });
            });
        </script>
    </body>

</html>
