<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foodie - Wishlist</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="./assets/css/style.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="./assets/css/wishlist.css" rel="stylesheet">
        <link rel="stylesheet" href="./assets/css/header-footer.css">

        <link rel="stylesheet" href="./assets/css/wishlist.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./assets/js/wishlist.js"></script>
    </head>
    <body>

        <%@ include file="/include/header.jsp" %>

        <div class="container my-5 center">
            <h1>Your Wishlist</h1>
            <div class="table-wishlist center">
                <table  class=" center">
                    <thead>
                        <tr>
                            <th class = 'product'>Product</th>
                            <th>Price</th>
                            <th style="text-align: center">Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="item" items='${cart}'>
                            <tr>

                                <td class = 'product'>
                                    <img class="img-product" alt="${item.getProduct().getName()}" src="${item.getImgURL()}" />
                                    <span class="name-product">${item.getProduct().getName()}</span>
                                </td>
                                <td class="price" >${FormatString.formatCurrency(item.getProduct().getPrice())}</td>
                                <td  style="text-align: center">
                                    <form  name = "" action = "" method ="">
                                        <input type = "hidden"  name ="fromWL" value = "">
                                        <input type = "hidden" id="action" name ="" value = "">
                                        <input type = "hidden" name ="productID" value = "${item.getProduct().getProductId()}">
                                        <input type = "hidden" name ="shopID" value = "${item.getProduct().getShopId()}">
                                        <input type = "hidden" name ="userID" value = "${user.getUserID()}">
                                        <button class="round-black-btn add-to-cart-btn" onclick="submitForm(event, 'method1')">Add to Cart</button>
                                        <button class="round-black-btn delete-btn" onclick="submitForm(event, 'method2')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>

        <%@ include file="/include/footer.jsp" %>


        <script src="js/Jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>


    </body>
</html>
