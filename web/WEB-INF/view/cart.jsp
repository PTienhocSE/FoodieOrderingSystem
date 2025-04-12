<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foodie-Food</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css"/>
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/cart.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <script src="./assets/js/cart.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var quantityInputs = document.querySelectorAll('.quantity');
                quantityInputs.forEach(function (input) {
                    updateAmount(input);
                });
            });
        </script>
    </head>
    <body>
        <%@ include file="/include/header.jsp" %>

        <div class="container my-4 cart">
            <h1 style="text-align: center">Your Cart</h1>
            <form id="myForm" name="process" action="" method="">
                <c:forEach var="entry" items="${cart}">
                    <div class="cart-shop">
                        <div class="cart-shop-detail">
                            <h3 style="color: #5EAE53;
                                font-size: 40px;
                                font-weight: 400;
                                width: fit-content;
                                padding: 10px;
                                margin: 50px 0 0 0;">${shopNames[entry.key]}</h3>
                            <div class="cart-thead row">
                                <div class="col-1"></div>
                                <div class="col-1 text-center"></div>
                                <div class="col-4 text-center">Product</div>
                                <div class="col-2 text-center">Price</div>
                                <div class="col-2 text-center"><span>Quantity</span></div>
                                <div class="col-2 text-end ">Amount</div>
                            </div>
                            <div class="cart-tbody">
                                <c:forEach var="item" items="${entry.value}">
                                    <div class="cart-item row align-items-center">
                                        <div class="col-1">
                                            <input name="isSelected" type="checkbox" value="${item.product.productId}"/>
                                        </div>
                                        <div class="col-1 text-start">
                                            <img width="120" height="auto" alt="${item.product.name}" src="${item.imgURL}"/>
                                        </div>
                                        <div class="col-4">
                                            <h2 class="product-name" title="${item.product.name}">
                                                <a href="./food-detail?productId=${item.product.productId}">${item.product.name}</a>

                                            </h2>
                                        </div>
                                        <div class="col-2">
                                            <span class="price">${item.price} VND</span>
                                        </div>
                                        <div class="col-2">
                                            <div class="number-input">
                                                <button type="button" onclick="decrement(this)">-</button>
                                                <input readonly="" type="number" id="${item.product.productId}" name="quantity_${item.product.productId}" class="quantity" value="${item.quantity}" min="1" max="10" onchange="updateAmount(this)">
                                                <button type="button" onclick="increment(this)">+</button>
                                            </div>
                                        </div>
                                        <div class="col-2 text-end price-col">
                                            <span class="amount"></span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <input type="hidden" id="mt" name="mt" value="display">
                <input type="hidden" id="userID" name="userID" value="${user.userID}">
                <table class="total-table mt-3">
                    <tr>
                        <td class="a-right"><span class="total_tt">Total:</span>
                            <span class="totals_price"></span>
                        </td>
                    </tr>
                </table>
                <p style="text-align: center; color: red">${cartStatus}</p>
                <div class="button-group mt-3">
                    <button id="delete-btn" type="submit" onclick="submitForm('method1')">Delete</button>
                    <button type="submit" onclick="submitForm('method2')">Order</button>
                </div>
            </form>
        </div>

        <%@ include file="/include/footer.jsp" %>
        <script src="js/Jquery.js"></script>
    </body>
</html>
