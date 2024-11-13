<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Account user = (Account) session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            Revenue Management  </title>
        <!--     Fonts and icons     -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
        <!-- Nucleo Icons -->
        <link href="./assets/css/nucleo-icons.css" rel="stylesheet" />
        <link href="./assets/css/nucleo-svg.css" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
        <link id="pagestyle" href="./assets/css/material-dashboard.css?v=3.1.0" rel="stylesheet" />
        <script defer data-site="YOUR_DOMAIN_HERE" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>


        <link rel="stylesheet" href="./assets/css/dashboard.css">
        <link
            rel="stylesheet"
            href="./assets/font/themify-icons/themify-icons.css"
            />



        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <style>
            table th, table td {
                text-align: center;
                vertical-align: middle;
            }
            .bnt-button{
                background-color: #5eae53;
                color: white;
            }
        </style>


    </head>

    <body class="g-sidenav-show  bg-gray-200">
        <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark" id="sidenav-main">
            <div class="sidenav-header">
                <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
                <a class="navbar-brand m-0" href="#">
                    <i class="material-icons icon-foodie">store</i><span class="ms-1 font-weight-bold text-white">Foodie Dashboard </span>

                </a>
            </div>
            <hr class="horizontal light mt-0 mb-2">
            <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="/OrderingSystem/dashboard">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">dashboard</i>
                            </div>
                            <span class="nav-link-text ms-1">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white  active bg-gradient-primary" href="/OrderingSystem/adminRevenue">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">attach_money</i>
                            </div>
                            <span class="nav-link-text ms-1">Revenue Management</span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white " href="/OrderingSystem/userBan">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">person</i>
                            </div>
                            <span class="nav-link-text ms-1">User Management</span>
                        </a>
                    </li>         
                    <li class="nav-item">
                        <a class="nav-link text-white" href="admin-item?action=listProducts">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">inventory</i>
                            </div>
                            <span class="nav-link-text ms-1">Product Management</span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white " href="admin-post?action=listPosts">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">article</i>
                            </div>
                            <span class="nav-link-text ms-1">Post Management</span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white " href="admin-register-restaurant">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">restaurant</i>
                            </div>
                            <span class="nav-link-text ms-1">Register Restaurant</span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white " href="/OrderingSystem/logout">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">logout</i>
                            </div>
                            <span class="nav-link-text ms-1">Sign Out</span>
                        </a>
                    </li>

                </ul>
            </div>

        </aside>


        <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
            <!-- Navbar -->
            <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" data-scroll="true">
                <div class="container-fluid py-1 px-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark underline-home" href="/OrderingSystem/">home</a></li>


                            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Revenue management</li>
                        </ol>
                        <h6 class="font-weight-bolder mb-0">Revenue management</h6>
                    </nav>
                    
                </div>
            </nav>






            <div class="main" >
                <center> 
                    <h1 class="mb-5" style="text-align: center;">Revenue Management</h1>

                    <!-- Hiển thị thông báo từ session -->
                    <c:if test="${not empty sessionScope.msg}">
                        <p style="color:green">${sessionScope.msg}</p>
                        <c:remove var="msg" scope="session"/>
                    </c:if>


                    <div style="display: flex; margin-right: 60px; justify-content: flex-end">
                        <a class="btn btn-primary btn-sm" href="/OrderingSystem/adminRevenue?action=export">Export CSV File</a>
                    </div>


                    <form action="admin-item" method="GET">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Shop Name</th>
                                    <th scope="col">Shop Owner</th>
                                    <th scope="col">VNPay Revenue</th>
                                    <th scope="col">COD Revenue</th>
                                    <th scope="col">Total Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${shops}" var="shop">
                                    <tr>
                                        <td>${shop.shopID}</td>
                                        <td>${shop.shopName}</td>
                                        <td>${shop.shopOwner}</td>
                                        <td>${shop.vnPayRevenue}</td>
                                        <td>${shop.codRevenue}</td>
                                        <td>${shop.totalRevenue}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                </center>
            </div>
        </main>

        <!-- =========== Scripts =========  -->
        <script src="assets_01/js/main.js"></script>

        <!-- ======= Charts JS ====== -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
        <script src="assets_01/js/chartsJS.js"></script>

        <!-- ====== ionicons ======= -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <!-- JavaScript confirm delete -->
        <script>
            function confirmLock(productId) {
                return confirm("Are you sure you want to lock product #" + productId + "?");
            }
        </script>
    </body>
</html>