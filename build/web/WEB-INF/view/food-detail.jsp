<%-- 
    Document   : food-detail
    Created on : Oct 3, 2024, 1:29:13 AM
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
        <script src="/js/blog.js"></script>
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <!--<link rel="stylesheet" href="./assets/css/blog.css" />-->
        <link href="./assets/css/product.css" rel="stylesheet">
        <script src="index.js"></script>
        <style>
            .star-rating .full {
                color: gold; /* Màu của sao đã chọn */
                font-size: 20px; /* Kích thước sao */
            }
            .star-rating .empty {
                color: #d3d3d3; /* Màu của sao trống */
                font-size: 20px;
            }

            .mt-100 {
                margin-top: 100px
            }

            .mb-100 {
                margin-bottom: 100px
            }

            .card {
                position: relative;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                -webkit-box-orient: vertical;
                -webkit-box-direction: normal;
                -ms-flex-direction: column;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0px solid transparent;
                border-radius: 0px
            }

            .card-body {
                -webkit-box-flex: 1;
                -ms-flex: 1 1 auto;
                flex: 1 1 auto;
                padding: 1.25rem
            }

            .card .card-title {
                position: relative;
                font-weight: 600;
                margin-bottom: 10px
            }

            .comment-widgets {
                position: relative;
                margin-bottom: 10px
            }

            .comment-widgets .comment-row {
                border-bottom: 1px solid transparent;
                padding: 14px;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                margin: 10px 0
            }

            .p-2 {
                padding: 0.5rem !important
            }

            .comment-text {
                padding-left: 15px
            }

            .w-100 {
                width: 100% !important
            }

            .m-b-15 {
                margin-bottom: 15px
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.76563rem;
                line-height: 1.5;
                border-radius: 1px
            }

            .btn-cyan {
                color: #fff;
                background-color: #27a9e3;
                border-color: #27a9e3
            }

            .btn-cyan:hover {
                color: #fff;
                background-color: #1a93ca;
                border-color: #198bbe
            }

            .comment-widgets .comment-row:hover {
                background: rgba(0, 0, 0, 0.05)
            }
        </style>


    </head>
    <body>

        <%@ include file="/include/header.jsp" %>



        <div class ="details-container row">
            <div class = "book-img col-12 col-sm-6 col-md-6 col-lg-5" >
                <!--<img src="https://i.pinimg.com/564x/76/19/ef/7619ef4dfcf7382aab410d57e796ffbf.jpg" alt=image" />-->
                <div id="carouselExampleIndicators" class="carousel slide">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <c:forEach var ="i" items='${images}'>
                            <div class="carousel-item active">
                                <img src=${i.getImgURL()} class="d-block w-100" alt="...">
                            </div>
                        </c:forEach>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>

            </div>

            <div id ="details"class ="col-12 col-sm-6 col-md-6 col-lg-7">
                <div class="product-details ">
                    <h1 class="title-product">${p.getName()}</h1>
                    <div class="group-status">
                        <p><b>${p.getPurchaseCount()} </b>orders</p>
                        <p><b>Category: </b><a href="#" title="Rice">${cateName}</a></p>
                    </div>
                    <div class ="shop-info">
                        <a href = "./restaurant-detail?shopId=${p.getShopId()}"><p><b>${shop.getName()}</b>: ${shop.getAddress()}</p></a>
                    </div>
                    <h4 class = "price">
                        <c:out value="${FormatString.formatCurrency(p.getPrice())}" />
                    </h4>
                    <p>${p.getDescription()}</p>
                    <form id ="myForm" name = "addCart" action = "" method ="">
                        <div>
                            <div class = "quantity-label">Quantity</div>
                            <div class="number-input">
                                <button type="button"  onclick="decrement(this)">-</button>
                                <input type="number" id ="${p.getProductId()}" name ="quantity" class ="quantity" value="1" min="1" max="10"onchange="updateAmount(this)">
                                <button  type="button" onclick="increment(this)">+</button>
                                <input type = "hidden" id="action" name ="isAdd" value = "true">
                                <input type = "hidden" name ="productID" value = "${p.getProductId()}">
                                <input type = "hidden" name ="shopID" value = "${p.getShopId()}">
                                <input type = "hidden" name ="userID" value = "${user.getUserID()}">
                            </div>
                        </div>
                        <div class ="add-cart-btn">
                            <h4 class="status">Foodie </h4>
                            <c:if test="${sessionScope.role != 'admin' && p.isStatus()}">
                                <button type ="submit" id ="cart-btn" onclick="submitForm('method1')">Add to cart</button>
                                <c:if test="${fav == null}">
                                    <button id ="fav" onclick="submitForm('method2')"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                                        </svg>
                                    </button>
                                </c:if>
                                <c:if test="${fav != null}">
                                    <button id ="fav2" onclick="submitForm('method3')"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                                        </svg>
                                    </button>
                                </c:if>
                            </c:if>
                        </div>

                    </form>

                    <!--<div class="rating " data-rating="3"></div>-->
                    <!--<p id = "ratingStatus"></p>-->

                    <div class="rating " data-rating=${Integer(p.getRating())}></div>

                    <div class ="rating-border"></div>
                </div>
            </div>




            <div class ="product-descript" >
                <div class ="product-tab">
                    <h4>FEEDBACK</h4>
                </div>
                <form action="FeedbackServlet" method="POST">
                    <c:if test="${sessionScope.role == 'customer' && valid != null}">
                        <input type = "hidden" name ="productID" value = "${p.getProductId()}">
                        <input type = "hidden" name ="action" value = "add">
                        <div class ="rate-product">
                            <label for="rating">Rate:</label>
                            <select name="rating" id="rating">
                                <option value="1">⭐</option>
                                <option value="2">⭐ ⭐</option>
                                <option value="3">⭐ ⭐ ⭐</option>
                                <option value="4">⭐ ⭐ ⭐ ⭐</option>
                                <option value="5">⭐ ⭐ ⭐ ⭐ ⭐</option>
                            </select>
                        </div>
                        <div class ="review-content">
                            <input type = "text" name = "comment" placeholder="Enter content..." style="margin-top: 20px; max-width: 1000px; width:100%; height: 100px">
                        </div>
                        <div>
                            <div style="text-align: center;">
                                <button type="submit" id="send-btn" >Send</button>
                            </div>

                        </div>

                    </c:if>
                </form>
            </div>
            <div class="row d-flex justify-content">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="comment-widgets">
                            <!-- Comment Row -->
                            <c:forEach var="feedback" items="${flist}">
                                <div class="d-flex flex-row comment-row m-t-0">
                                    <img   id="user-avatar"
                                           class="img-responsive img-circle"
                                           src="${user.getAvtImg()}"
                                           onerror="this.onerror=null;this.src='https://i.pinimg.com/564x/09/a9/2c/09a92c1cbe440f31d1818e4fe0bcf23a.jpg';"
                                           alt="Profile Picture"
                                           />
                                    <div class="comment-text w-100">
                                        <h6 class="font-medium">${feedback.userName}</h6>

                                        <div class="star-rating">
                                            <c:forEach begin="1" end="${feedback.rating}" var="i">
                                                <span class="full">★</span>
                                            </c:forEach>
                                            <c:forEach begin="${feedback.rating + 1}" end="5" var="i">
                                                <span class="empty">☆</span>
                                            </c:forEach>
                                        </div>

                                        <!-- Span chứa bình luận, thêm id để JS thao tác -->
                                        <span id="comment-${feedback.feedbackId}" class="m-b-15 d-block">${feedback.comment}</span>
                                        <c:if test="${feedback.userId == user.userID}">
                                            <div class="comment-footer">
                                                <span class="text-muted float-right">${feedback.createdDate}</span> 

                                                <!-- Nút Edit với id -->

                                                <form style="display: inline" action="FeedbackServlet" method="POST">
                                                    <input type="hidden" name="feebackID" value="${feedback.feedbackId}">
                                                    <input type="hidden" name="productID" value="${p.getProductId()}">
                                                    <button name="action" class="btn btn-danger btn-sm" value="delete">Delete</button>

                                                </form>
                                                <button name="action" class="btn btn-update btn-sm" value="update" onclick="showDiv()">Update</button>
                                                <div id="updateDiv" style="display: none;">
                                                    <form style="display: inline" action="FeedbackServlet" method="POST">
                                                        <div class ="update-rate">
                                                            <label for="rating">Rate:</label>
                                                            <select name="rating" id="rating">
                                                                <option value="1">⭐</option>
                                                                <option value="2">⭐ ⭐</option>
                                                                <option value="3">⭐ ⭐ ⭐</option>
                                                                <option value="4">⭐ ⭐ ⭐ ⭐</option>
                                                                <option value="5">⭐ ⭐ ⭐ ⭐ ⭐</option>
                                                            </select>
                                                        </div>
                                                        <div class ="update-content">
                                                            <input type = "text" name = "comment" placeholder="Enter content..." style="margin-top: 20px; max-width: 1000px; width:100%; height: 100px">
                                                        </div>
                                                        <input type="hidden" name="feebackID" value="${feedback.feedbackId}">
                                                        <input type="hidden" name="productID" value="${p.getProductId()}">

                                                        <div>

                                                            <button name="action" class="btn btn-update btn-sm" value="update">Send</button>

                                                        </div>
                                                    </form>

                                                </div>

                                            </div>
                                        </c:if>

                                    </div>
                                </div> <!-- Comment Row -->
                            </c:forEach>

                        </div> <!-- Card -->
                    </div>
                </div>
            </div>

        </div> 

        <div class="pagination">
            <c:set var="currentPage" value="${currentPage}" />
            <c:set var="pageSize" value="${pageSize}" />
            <c:set var="totalFeedbacks" value="${totalFeedbacks}" />
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
        <%@ include file="/include/footer.jsp" %>
        <c:if test="${not empty sessionScope.alert}">

            <script>
                alert("${alert}");
            </script>
            <%session.setAttribute("alert", null);%>
        </c:if>
        <script>
            function showDiv() {
                var updateDiv = document.getElementById("updateDiv");

                // Kiểm tra trạng thái hiển thị của div
                if (updateDiv.style.display === "none") {
                    updateDiv.style.display = "block"; // Hiển thị div
                } else {
                    updateDiv.style.display = "none"; // Ẩn div
                }
            }


        </script>
        <script src="js/Jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>