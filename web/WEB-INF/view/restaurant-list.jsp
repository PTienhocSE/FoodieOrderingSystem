<%-- 
    Document   : restaurant
    Created on : Oct 2, 2024, 2:16:53 PM
    Author     : phuct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
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
        <link rel="stylesheet" href="./assets/css/header-footer.css" />
    </head>
    <body>
        <!-- HEADER -->

        
        <%@ include file="/include/header.jsp" %>


        <!-- PAGE INFO -->
        <div id="page-info">
            <div class="page-title">Restaurant</div>
<!--            <div class="page-info-more">
                <a href="/OrderingSystem/">Home</a>
                <a style="border-left: 1px solid #e8e8ea" href="#"
                   >Restaurant Management</a
                >
            </div>-->
        </div>

        <!-- RESTAURANT CONTENT -->
        <div class="container container-res">
            <main class="restaurant-section res-section">
                <div class="header res-header">
                    <div class="restaurant-search">
                        <form style="display: flex" action="restaurant" method="post">
                            <input <c:if test="${not empty keyword}">value=${keyword}</c:if> type="text" name="keyword" placeholder="Search for a restaurant..." required />
                            <button type="submit">Search</button>
                        </form>
                    </div>
<!--                    <form style="display: flex;
                          gap: 10px;" action="restaurant" method="GET" class="filter-form">
                        <select name="sortOption">
                            <option value="none">None</option>
                            <option value="timeOpen">Sort by Time Open</option>
                            <option value="timeClose">Sort by Time Close</option>
                        </select>
                        <button class="filter-search" type="submit">Filter</button>
                    </form>-->
                </div>
                <!--                <option>Sort by Rating</option>-->
                <div class="restaurant-list">
                    <c:if test="${not empty restaurantList}">
                        <c:forEach var="restaurant" items="${restaurantList}">
                            <a style="text-decoration: none" href="./restaurant-detail?shopId=${restaurant.getShopID()}">
                                <div class="restaurant-card">
                                    <img src="${restaurant.getShopImage()}" alt="${restaurant.getName()}" />
                                    <div class="restaurant-info">
                                        <span class="rating">4.5</span>
                                        <h4>${restaurant.getName()}</h4>
                                        <p>${restaurant.getDescription()}</p>
                                        <div class="restaurant-more-info">
                                            <p>${restaurant.getTimeOpen()}</p>
                                            <p>${restaurant.getTimeClose()}</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:if>
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
        <script>
            document.querySelectorAll(".pagination button").forEach((button) => {
                button.addEventListener("click", function () {
                    document
                            .querySelector(".pagination button.active")
                            .classList.remove("active");
                    this.classList.add("active");
                    // Load new content based on the page clicked
                });
            });
        </script>
    </body>
</html>
