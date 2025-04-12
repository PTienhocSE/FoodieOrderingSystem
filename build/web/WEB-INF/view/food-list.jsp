<%-- 
    Document   : food
    Created on : Oct 2, 2024, 2:21:28 PM
    Author     : phuct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ page import="model.Product" %>
<%@ page import="context.ProductDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Foodie Blog</title>
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
        <script src="/js/blog.js"></script>
        <link rel="stylesheet" href="./assets/css/style.css" />
        <link rel="stylesheet" href="./assets/css/blog.css" />
        <link rel="stylesheet" href="./assets/css/blogdetails.css" />
        <link rel="stylesheet" href="./assets/css/restaurant.css" />
        <link rel="stylesheet" href="./assets/css/food.css" />
        <link rel="stylesheet" href="./assets/css/header-footer.css">
    </head>
    <body>
        <!-- HEADER -->

        <%@ include file="/include/header.jsp" %>

        <!-- PAGE INFO -->
        <div id="page-info">
            <div class="page-title">Food/Drink</div>
            <!--            <div class="page-info-more">
                            <a href="/OrderingSystem/">Home</a>
                            <a style="border-left: 1px solid #e8e8ea" href="#"
                               >Food/Drink Management</a
                            >
                        </div>-->
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
                                    <input type="checkbox" name="categoryIds" value="${category.categoryID}" <c:if test="${categoryIds.contains(category.categoryID)}">checked</c:if>/> ${category.getType()}
                                    </li>
                            </c:forEach>
                        </c:if>
                    </ul>

                    <h3>Rating</h3>
                    <select name="rating">
                        <option value="None" <c:if test="${minRating == 0.0}">selected</c:if>>None</option>
                        <option value="4.5" <c:if test="${minRating == 4.5}">selected</c:if>>4.5+</option>
                        <option value="4.0" <c:if test="${minRating == 4.0}">selected</c:if>>4.0+</option>
                        <option value="3.5" <c:if test="${minRating == 3.5}">selected</c:if>>3.5+</option>
                        </select>

                        <h3>Sort by</h3>
                        <select name="sortBy">
                            <option value="none">None</option>
                            <option value="popularity" <c:if test="${sortBy == 'popularity'}">selected</c:if>>Sort by Popularity</option>
                            <option value="rating" <c:if test="${sortBy == 'rating'}">selected</c:if>>Sort by Rating</option>
                            <option value="price" <c:if test="${sortBy == 'price'}">selected</c:if>>Sort by Price</option>
                        </select>
                        <div class="filter-button">
                            <button class="filter-btn" type="submit">Filter</button>
                            <a href="/OrderingSystem/food" class="unfilter-btn" >Delete Filter</a>
                        </div>
                    </form>
                </aside>

                <main class="restaurant-section">
                    <div class="header">
                        <div class="restaurant-search">
                            <form class="food-search-form" action="food" method="post">
                                <input type="text" name="keyword" placeholder="Enter product name..." required>
                                <button style="width: 30%" type="submit">Search</button>
                            </form>
                        </div>
                    </div>

                    <div class="restaurant-list">
                    <c:if test="${not empty productList}">
                        <c:forEach var="product" items="${productList}">
                            <div class="restaurant-card">
                                <div class = "img-wrapper">
                                    <img src="${product.getImgURL()}" alt="${product.getProduct().getName()}" />

                                </div>

                                <a style="text-decoration: none" href ="./food-detail?productId=${product.getProduct().getProductId()}">
                                    <div class="restaurant-info">
                                        <span class="rating">${product.getProduct().getRating()}</span>
                                        <h4>${product.getProduct().getName()}</h4>
                                        <p>${product.getProduct().getPrice()} VND</p>
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

        <div class="pagination">
            <c:set var="currentPage" value="${currentPage}" />
            <c:set var="pageSize" value="${pageSize}" />
            <c:set var="totalProducts" value="${totalProducts}" />
            <c:set var="totalPages" value="${totalPages}" />

            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}">&laquo;</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="active">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${i}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}">&raquo;</a>
            </c:if>
        </div>



    </main>
</div>

<!-- AD BLOG -->
<img src="./assets/img/adblog.svg" alt="" class="blog-ad" />

<!-- FOOTER -->
<footer id="footer">
    <div class="footer-content">
        <div class="footer-logo">
            <h2>FOODIE</h2>
            <div class="footer-social">
                <a class="icon-footer" href="#"><i class="ti-facebook"></i></a>
                <a class="icon-footer" href="#"><i class="ti-instagram"></i></a>
                <a class="icon-footer" href="#"><i class="ti-location-pin"></i></a>
            </div>
        </div>
        <div class="footer-menu">
            <h4 style="display: flex; justify-content: center">MENU</h4>
            <div class="menu-item">
                <ul>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Restaurants</a></li>
                </ul>
                <ul>
                    <li><a href="#">Map</a></li>
                    <li><a href="#">Submit</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
