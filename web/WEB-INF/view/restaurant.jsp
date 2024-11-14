<%-- 
    Document   : shop
    Created on : Oct 2, 2024, 1:53:59 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foodie-Food</title>
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
        <link rel="stylesheet" href="./assets/css/style.css">
        <script src="./assets/js/shop.js"></script>
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <!--<link rel="stylesheet" href="./assets/css/blog.css" />-->
        <link href="./assets/css/shop.css" rel="stylesheet">
        <link href="./assets/css/restaurant.css" rel="stylesheet">
    </head>
    <body>
        <c:if test="${sessionScope.user != null && sessionScope.user.getRole() == 2}">
            <%@ include file="/include/shop-header.jsp" %>
        </c:if>
        <c:if test="${sessionScope.user == null || sessionScope.user.getRole() != 2}">
            <%@ include file="/include/header.jsp" %>
        </c:if>




        <!-- PAGE INFO -->

        <section class="banner jumbotron text-center" style="background-image: url('${shop.getShopImage()}');">
            <c:if test="${sessionScope.user != null && sessionScope.user.shopID == shop.shopID}">
                <button class="edit-image-btn" onclick="showUpdateAvatarStoreOverlay()">Edit Image</button>
            </c:if>
            <div class="page-title">${shop.getName()}</div>
            <p>${shop.getDescription()}</p>
            <p>${shop.getAddress()}</p>
        </section>

        <div id="page-info">

            <div class="page-info-more">
                <a href="./">Home</a>
                <p>Time Open: ${shop.getTimeOpen()}</p>
                <p>Time Close: ${shop.getTimeClose()}</p>
                <c:if test="${sessionScope.user != null && sessionScope.user.shopID == shop.shopID}">
                    <button type="button" class=""
                            data-shopId="${shop.getShopID()}" 
                            data-name="${shop.getName()}"
                            data-description="${shop.getDescription()}"
                            data-address="${shop.getAddress()}"
                            data-timeOpen="${shop.getTimeOpen()}"
                            data-timeClose="${shop.getTimeClose()}"
                            onclick="showUpdateStoreOverlay(); updateStoreButton(this)">Update Store</button>
                </c:if>
            </div>
            <!-- Overlay form -->
            <div id="update-store-overlay" class="overlay center">
                <div class="overlay-content">
                    <span class="close-btn" onclick="hideUpdateStoreOverlay()">&times;</span><br>
                    <form name="update-store" action="restaurant-detail" method="post">
                        <div class="add-product-form">
                            <h1>Update Store</h1>
                            <input type="hidden" name="mt" value="updateStore">
                            <input id="restaurantID" type="hidden" name="shopID" value="" required>

                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" id="restaurantName" name="name" class="form-control" value="" required>
                            </div>

                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea id="restaurantDescription" name="description" class="form-control" rows="4" cols="50" required></textarea>
                            </div>


                            <div class="form-group">
                                <label for="address">Address:</label>
                                <input type="text" id="restaurantAddress" name="address" class="form-control" value="" required>

                            </div>

                            <div class="form-group">
                                <label for="timeOpen">Time Open:</label>
                                <input type="time" id="timeOpen" name="timeOpen" class="form-control" value="" required>
                            </div>

                            <div class="form-group">
                                <label for="timeClose">Time Close:</label>
                                <input type="time" id="timeClose" name="timeClose" class="form-control" value="" required>
                            </div>

                            <button type="submit" class="btn btn-success btn-block">Save</button>
                        </div>
                    </form>
                </div>
            </div>


        </div>

        <!-- FOOD CONTENT -->
        <div class="container">
            <aside class="filter-section">
                <h3>Categories</h3>
                <form action="filterproducts" method="post">
                    <ul>
                        <c:if test="${not empty categoryList}">
                            <c:forEach var="category" items="${categoryList}">
                                <li>
                                    <input type="checkbox" name="categoryIds" value="${category.categoryID}" /> ${category.getType()}
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>

                    <h3>Rating</h3>
                    <select name="rating">
                        <option value="None">None</option>
                        <option value="4.5">4.5+</option>
                        <option value="4.0">4.0+</option>
                        <option value="3.5">3.5+</option>
                    </select>

                    <h3>Sort by</h3>
                    <select name="sortBy">
                        <option value="none">None</option>
                        <option value="popularity">Sort by Popularity</option>
                        <option value="rating">Sort by Rating</option>
                        <option value="price">Sort by Price</option>
                    </select>
                    <div class="filter-button">
                        <button class="filter-btn" type="submit">Filter</button>
                        <a href="/OrderingSystem/food" class="unfilter-btn" >Delete Filter</a>
                    </div>
                </form>
            </aside>

            <main class="restaurant-section">
                <div class="head">
                    <div class="restaurant-search">
                        <input type="text" placeholder="Search for a food..." />
                        <button>Search</button>
                    </div>
                    <c:if test="${sessionScope.user != null && sessionScope.user.shopID == shop.shopID}">
                        <button class ="sticky-button" 
                                data-shopId="${user.getShopID()}"
                                onclick = "showAddProductOverlay();addButton(this)" >Add product</button>
                    </c:if>
                    <select>
                        <option>Sort by Popularity</option>
                        <option>Sort by Rating</option>
                        <option>Sort by Price</option>
                    </select>
                </div>
                <div class="restaurant-list">



                    <c:if test="${not empty productList}">
                        <c:forEach var="product" items="${productList}">
                            <div class="restaurant-card">
                                <div class = "img-wrapper">
                                    <img src="${product.getImgURL()}" alt="${product.getProduct().getName()}" />
                                    <c:if test="${sessionScope.user != null && sessionScope.user.shopID == shop.shopID}">
                                        <div class="action-buttons">
                                            <button type="button" class="btn-update"
                                                    data-shopId="3" 
                                                    data-productId="${product.getProduct().getProductId()}"
                                                    data-name="${product.getProduct().getName()}"
                                                    data-price="${product.getProduct().getPrice()}"
                                                    data-category="${product.getProduct().getCategoryId()}"
                                                    data-description="${product.getProduct().getDescription()}"
                                                    data-image="${product.getImgURL()}"
                                                    onclick="showUpdateProductOverlay(); updateButton(this)">Update</button>
                                            <form action="restaurant-detail" method="post">
                                                <input type="hidden" name="mt" value="delete">
                                                <input type="hidden" name="shopID" value="${user.getShopID()}">
                                                <input type="hidden" name="productId" value="${product.getProduct().getProductId()}">
                                                <button type="submit" class="btn-delete">Delete</button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>

                                <a href ="./food-detail?productId=${product.getProduct().getProductId()}">
                                    <div class="restaurant-info">
                                        <span class="rating">${product.getProduct().getRating()}</span>
                                        <h4>${product.getProduct().getName()}</h4>
                                        <p>${product.getProduct().getPrice()} $</p>
                                        <div class="restaurant-more-info">
                                            <p>${product.getProduct().getDescription()}</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
        </div>

        <div id ="add-product-overlay" class ="overlay center">
            <div class="overlay-content">
                <span class="close-btn" onclick="hideAddProductOverlay()">&times;</span></br>
                <form name = "add-product" action = "restaurant-detail" method = "post" enctype="multipart/form-data">
                    <div class = "add-product-form">
                        <h1>Add product</h1>
                        <input type="hidden" name="mt" value="add">
                        <input id ="overlayShopID" type ="hidden" name ="shopID" value ="" >
                        <label for="title">Name</label>
                        <input type="text" id="overlayTitle" name="name" required>
                        <label for="price">Price:</label>
                        <input type="number" id="overlayPrice" name="price" required>
                        <label for="category">Category:</label>
                        <select id="category" name="category">
                            <option value="1">Food </option>
                            <option value="2">Drink</option>
                            <option value="3">Dessert</option>
                            <option value="4">Snacks</option>
                            <option value="5">Beverages</option>
                        </select><br>
                        <label for="description">Description:</label>
                        <input type="text"id="overlayDescription" name="description" required>
                        <label for="imgs">Images</label>
                        <input type="file" id="img" name="img" accept="image/*" multiple required><br>
                        <button type ="submit" style="background-color: #b0c4de" class="btn">Save</button>
                    </div>
                </form>
            </div> 
        </div>
        <!--==================================================================-->

        <div id="update-product-overlay" class="overlay center">
            <div class="overlay-content">
                <span class="close-btn" onclick="hideUpdateProductOverlay()">&times;</span><br>
                <form name="update-product" action="restaurant-detail" method="post" enctype="multipart/form-data">
                    <div class="add-product-form">
                        <h1>Update product</h1>
                        <input type="hidden" name="mt" value="update">
                        <input id="shopID" type="hidden" name="shopID" value=""required>
                        <input id="productID" type="hidden" name="productID" value=""required>

                        <label for="title">Name</label>
                        <input type="text" id="name" name="name" value=""required>

                        <label for="price">Price:</label>
                        <input type="number" id="price" name="price" value=""required>

                        <label for="category">Category:</label>
                        <select id="category" name="category">
                            <option value="1">Food</option>
                            <option value="2">Drink</option>
                            <option value="3">Dessert</option>
                            <option value="4">Snacks</option>
                            <option value="5">Beverages</option>
                        </select><br>

                        <label for="description">Description:</label>
                        <textarea type="text" id="description" rows="4" cols="50" name="description" value=""required></textarea>

                        <label for="imgs">Images</label>
                        <input type="file" id="image" name="img" accept="image/*" multiple required><br>

                        <button type="submit" style="background-color: #b0c4de" class="btn">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <div id="update-avatar-overlay" class="overlay center">
            <div class="overlay-content">
                <span class="close-btn" onclick="hideUpdateStoreAvatarOverlay()">&times;</span></br>
                <form name = "changeAvatar" action = "restaurant-detail" method = "post" enctype="multipart/form-data">
                    <input type="hidden" name="mt" value="changeImage">

                    <label for="imgURL">Upload Image</label>
                    <input type="file" id="img" name="img" accept="image/*" required >
                    <input type = "hidden" name = "shopID" value =${shop.getShopID()}>
                    <input type = "hidden" name = "mt" value ="changeAvatar">
                    </br></br></br>
                    <button type ="submit" style="background-color: #b0c4de" class="btn">Save</button>
                </form>
            </div>
        </div>   


        <div class="pagination">
            <c:set var="currentPage" value="${currentPage}" />
            <c:set var="pageSize" value="${pageSize}" />
            <c:set var="totalProducts" value="${totalProducts}" />
            <c:set var="totalPages" value="${totalPages}" />

            <c:if test="${currentPage > 1}">
                <a href="?shopId=${shop.getShopID()}&page=${currentPage - 1}">&laquo;</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="active">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?shopId=${shop.getShopID()}&page=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?shopId=${shop.getShopID()}&page=${currentPage + 1}">&raquo;</a>
            </c:if>
        </div>

        <%@ include file="/include/footer.jsp" %>


        <script src="js/Jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
    </body>
</html>