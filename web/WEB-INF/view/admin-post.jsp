<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Account user = (Account) session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post Management</title>
        <title>
            Dashboard  </title>
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


        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

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
                        <a class="nav-link text-white " href="/OrderingSystem/dashboard">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">dashboard</i>
                            </div>
                            <span class="nav-link-text ms-1">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="/OrderingSystem/adminRevenue">
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
                        <a class="nav-link text-white " href="admin-item?action=listProducts">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">inventory</i>
                            </div>
                            <span class="nav-link-text ms-1">Product Management</span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white active bg-gradient-primary" href="admin-post?action=listPosts">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">article</i>
                            </div>
                            <span class="nav-link-text ms-1">Post Management</span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white " href="/OrderingSystem/withdrawalmanagement">
                            <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                <i class="material-icons opacity-10">attach_money</i>
                            </div>
                            <span class="nav-link-text ms-1">Withdrawal Management</span>
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


                            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Post Management</li>
                        </ol>
                        <h6 class="font-weight-bolder mb-0">Post Management</h6>
                    </nav>

                </div>
            </nav>

            <div class="main">
                <center> 
                    <h1 class="mb-5">Posts Management</h1>


                    <!-- Hiển thị thông báo từ session nếu có -->
                    <c:if test="${not empty sessionScope.msg}">
                        <div id="msg-block" style="display:block;">
                            <p style="color:green">${sessionScope.msg}</p>
                            <c:remove var="msg" scope="session"/>
                        </div>
                    </c:if>


                    <form action="admin-post" method="GET">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">User ID</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Heading</th>
                                    <th scope="col">Content</th>
                                    <th scope="col">Created Date</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${posts}" var="post">
                                    <tr>
                                        <td>${post.postID}</td>
                                        <td>${post.userID}</td>
                                        <td><img src="${post.imgURL}" width="50%" height="50%"/></td>
                                        <td>${post.heading}</td>
                                        <td>${post.content}</td>
                                        <td>${post.createdDate}</td>
                                        <td>
                                            <div class="d-flex justify-content-center align-items-center">
                                                <c:choose>
                                                    <c:when test="${post.status}">
                                                        <a class="btn btn-primary btn-sm me-2 text-nowrap" href="postDetails?postID=${post.postID}">View Detail</a>
                                                        <a class="btn btn-danger btn-sm" href="admin-post?action=lockIllegalPost&id=${post.postID}" onclick="return confirmDelete('${post.postID}')">Lock</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="btn btn-warning btn-sm"  href="admin-post?action=unlockPost&id=${post.postID}">Unlock</a>
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>
                                        </td>
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
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
        <script src="assets_01/js/chartsJS.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <!-- JavaScript để xác nhận xóa và hiển thị thông báo -->
        <script>
                                                            function confirmDelete(postID) {
                                                                var confirmAction = confirm("Are you sure you want to delete post #" + postID + "?");
                                                                if (confirmAction) {
                                                                    // Hiển thị khối thông báo nếu người dùng xác nhận
                                                                    document.getElementById('msg-block').style.display = 'block';
                                                                    return true;
                                                                } else {
                                                                    // Người dùng hủy, không hiển thị gì
                                                                    return false;
                                                                }
                                                            }
        </script>
    </body>
</html>
