<%-- 
    Document   : index
    Created on : Sep 21, 2024, 12:14:27 AM
    Author     : phuct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Account user = (Account) session.getAttribute("loggedUser");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foodie</title>
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


    </head>
    <body>
        <!-- HEADER -->
        <div id="header">
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">

                    <a class="navbar-brand" href="./">FOODIE</a>

                    <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNavAltMarkup"
                        aria-controls="navbarNavAltMarkup"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                            <a class="nav-link" aria-current="page" href="/OrderingSystem/">Home</a>
                            <a class="nav-link" href="/OrderingSystem/food">Food</a>
                            <a class="nav-link" href="/OrderingSystem/restaurant">Restaurant</a>
                            <a class="nav-link" href="/OrderingSystem/blog">Blog</a>
                        </div>

                        <c:if test="${sessionScope.user != null && role == 'shop'}">
                            <div style="justify-content: end; margin-right: 15px" class="navbar__item">
                                <nav id="nav-bar">
                                    <ul class="nav-list">
                                        <li style="padding: 6px; " class="nav-item">
                                            <a href="./restaurant-detail?shopId=${user.getShopID()}" class="nav-link">
                                                <span id="login-text">Go to Shop</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                        <div class="navbar__item">


                            <nav id="nav-bar">
                                <ul class="nav-list">
                                    <li class="nav-item">
                                        <a href="<%= user != null ? "account" : "login" %>" class="nav-link">
                                            <c:choose>
                                                <c:when test="${user != null}">
                                                    <div class="user-dropdown">
                                                        <a style="text-decoration: none" href="/OrderingSystem/account">
                                                            <img
                                                                id="user-avatar"
                                                                class="img-responsive img-circle"
                                                                src="${user.getAvtImg()}"
                                                                onerror="this.onerror=null;this.src='https://i.pinimg.com/564x/09/a9/2c/09a92c1cbe440f31d1818e4fe0bcf23a.jpg';"
                                                                alt="Profile Picture"
                                                                />
                                                            <span id="user-name">${user.getUserName()}</span>
                                                        </a>
                                                        <div class="dropdown-content">
                                                            <a href="/OrderingSystem/account">Account</a>
                                                            <a href="/OrderingSystem/order-history">View Orders</a>
                                                            <a href="/OrderingSystem/logout">Logout</a>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span id="login-text">Login</span>

                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </li>
                                </ul>
                            </nav>

                            <c:choose>
                                <c:when test="${user != null}">
                                    <a style="text-decoration: none" href = "./cart"><div class="icon">
                                            <i class="ti-shopping-cart"></i>
                                        </div></a>
                                    <a href = "./favourite">
                                        <div class="icon">
                                            <i class="ti-heart" style="margin: 0 10px 0 10px; padding:10px; font-size: 25px; border-radius: 25px;
                                               background-color: #ff6b6b; display: inline-block;color: white; text-align: center;"></i>
                                        </div>
                                    </a>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </nav>
        </div>

        <!-- SLIDER -->
        <div id="slider">
            <img src="./assets/img/sliderback.svg" alt="" class="sliderback" />
            <div class="slider-info">
                <h3 class="slider-des">Best food in city</h3>
                <h1 class="title">Delivery Food from the Best Restaurants.</h1>
                <!--                <div class="slider-search">
                                    <input class="default-input" type="text" placeholder="Find Food..." />
                                    <button class="default-btnsearch">Search</button>
                                </div>-->
                <form class="slider-search" action="food" method="post">
                    <input class="default-input" type="text" name="keyword" placeholder="Find Food..." required>
                    <button class="default-btnsearch" type="submit">Search</button>
                </form>
                <div class="icon-group">
                    <i class="ti-facebook slider-icon"></i>
                    <i class="ti-instagram slider-icon"></i>
                    <i class="ti-location-pin slider-icon"></i>
                </div>
            </div>
        </div>

        <!-- CATEGORY -->


        <div id="category">
            <div class="default-text-category">
                <div class="default-tag default-tag-category">CATEGORIES</div>
            </div>
            <div class="default-title default-title-category">Popular Categories</div>
            <div class="category-list">


                <c:if test="${not empty cateList}">
                    <c:forEach var="c" items="${cateList}">
                        <a href = "./food?category=${c.getCategory().getCategoryID()}"><div onclick="" class="card col-md-2" style="width: 11rem">
                                <img
                                    src="${c.getAvtImg()}"
                                    class="card-img-top card-img-top-category"
                                    alt="..."
                                    />
                                <div class="card-body">
                                    <h5 class="card-title card-title-category">${c.getCategory().getType()}</h5>
                                    <p class="card-text">${c.getCategory().getDescription()}</p>
                                </div>
                            </div></a>
                        </c:forEach>
                    </c:if>
            </div>
        </div>


        <!-- BEST DEALS -->
        <div id="bestseller">
            <div class="default-tag default-tag-bestseller">RESTAURANTS</div>
            <div class="default-title">Top Food/Drink</div>
            <div class="default-des">
                <p class="default-slogan">
                    "Savor the finest cuisine from the best restaurants around, with easy
                    and fast ordering at your fingertips!"
                </p>
            </div>
            <div class="row">
                <c:forEach var="p" items="${pdtolist}">
                    <div class="col-md-4 mb-4 top-food">
                        <a style="text-decoration: none" href ="./food-detail?productId=${p.getProductId()}"> 
                            <div class="card-horizontal">
                                <img class="card-img" src="${p.imgURL}" alt="Best Burgers" />
                                <div class="card-body">
                                    <div class="rating">${p.rating}</div>
                                    <p class="bestseller-category">${p.categoryName}</p>
                                    <h5 class="card-title">${p.name}</h5>
                                    <p class="card-text">${p.shopName}</p>
                                    <div class="card-info">
                                        <!--<p class="time">${p.purchaseCount}</p>-->
                                        <p class="price">From $${p.price}</p>
                                    </div>
                                </div>
                            </div>
                        </a>           
                    </div>
                </c:forEach>
            </div>

        </div>

        <!-- MAP RESTAURANTS -->
        <div id="map">
            <img src="./assets/img/mapimg.svg" alt="" class="map-img" />
            <div class="map-info col-md-5">
                <div class="map-tag">MAP</div>
                <div class="map-title default-title">
                    Food Map with more than 900 Restaurants
                </div>
                <div class="map-des default-slogan">
                    Explore a diverse menu from top-rated restaurants, all ready to serve
                    you with just a few clicks!
                </div>
                <div class="map-search">
                    <form style="display: flex" action="restaurant" method="post">
                        <input class="map-input default-input" type="text" name="keyword" placeholder="Search for a restaurant..." required />
                        <button class="map-btnsearch default-btnsearch" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </div>



        <!-- RESTAURANTS -->
        <div id="restaurant">
            <div class="default-text-restaurant">
                <div class="default-tag">RESTAURANTS</div>
                <div class="default-title">Top Restaurants</div>
                <div class="default-des">
                    <p class="default-slogan">
                        "Discover a world of flavors and enjoy the convenience of ordering
                        your favorite meals today!"
                    </p>
                </div>
                <div class="restaurant-list">
                    <!-- Restaurant Card 1 -->
                    <c:forEach var="s" items="${shopdtolist}">
                        <a href="/OrderingSystem/restaurant-detail?shopId=${s.shopID}">
                            <div class="card card-restaurant" style="width: 18rem">
                                <div class="rating-box">${s.rating}</div>
                                <img class="card-img-top" src="${s.shopImage}" style="width: 100%; height: 200px; object-fit: cover;" alt="Card image cap"/>
                                <div class="card-body">
                                    <h5 class="card-title card-title-res">${s.name}</h5>
                                    <div class="restaurant-info">
                                        <p class="res-time">${s.timeOpen} - ${s.timeClose}</p>
                                        <div class="res-category">${s.description}</div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>


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
                    <h4 style="display: flex; justify-content: center;">MENU</h4>
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
