<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
        <link
            rel="stylesheet"
            href="./assets/font/themify-icons/themify-icons.css"
            />

        <style>
            .chart-container {
                width: 45%;
                margin: 20px auto;
            }
            .flex-container {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
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
                        <a class="nav-link text-white active bg-gradient-primary" href="/OrderingSystem/dashboard">
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
                        <a class="nav-link text-white " href="admin-post?action=listPosts">
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
                            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="/OrderingSystem/">home</a></li>


                            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Dashboard</li>
                        </ol>
                        <h6 class="font-weight-bolder mb-0">Dashboard</h6>
                    </nav>
                </div>
            </nav>
            <!-- End Navbar -->
            <div class="container-fluid py-4">
                <div class="row">
                    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <div class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                                    <i class="material-icons opacity-10">store</i>
                                </div>
                                <div class="text-end pt-1">
                                    <p class="text-sm mb-0 text-capitalize">Restaurants</p>
                                    <h4 class="mb-0">${restaurantCount}</h4>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-success text-sm font-weight-bolder">${waitingCount} </span>waiting for approved</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <div class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute">
                                    <i class="material-icons opacity-10 ti-apple"></i>
                                </div>
                                <div class="text-end pt-1">
                                    <p class="text-sm mb-0 text-capitalize">Product</p>
                                    <h4 class="mb-0">${foodCount}</h4>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-danger text-sm font-weight-bolder">${lockedProductCount}</span> product is locked</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <div class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
                                    <i class="material-icons opacity-10">facebook</i>
                                </div>
                                <div class="text-end pt-1">
                                    <p class="text-sm mb-0 text-capitalize">Posts</p>
                                    <h4 class="mb-0">${postCount}</h4>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-danger text-sm font-weight-bolder">${lockedPostCount}</span> posts is locked</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <div class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute">
                                    <i class="material-icons opacity-10">note</i>
                                </div>
                                <div class="text-end pt-1">
                                    <p class="text-sm mb-0 text-capitalize">Revenue</p>
                                    <h4 class="mb-0">$${revenue}</h4>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0">
                                    <span id="statisticText">
                                        ${changeType} 
                                        <span id="percentage" class="font-weight-bolder">${percentage}</span> 
                                        ${message}
                                    </span>
                                </p>
                            </div>

                            <script>
                                const changeType = "${changeType}";
                                const percentage = document.getElementById("percentage");

                                // Xác định màu sắc cho phần trăm tùy theo trạng thái tăng hay giảm
                                if (changeType === "Increased") {
                                    percentage.classList.add("text-success"); // Màu xanh cho tăng
                                } else if (changeType === "Decreased") {
                                    percentage.classList.add("text-danger"); // Màu đỏ cho giảm
                                }
                            </script>

                        </div>
                    </div>
                </div>



                <!--Chart-->

                <div class="flex-container">
                    <div class="chart-container">
                        <h3>Monthly Orders Chart</h3>
                        <canvas id="orderChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h3>Monthly Revenue Chart</h3>
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>


                <div class="row mb-4">
                    <div class="col-lg-8 col-md-6 mb-md-0 mb-4">

                    </div>
                    <div class="col-lg-4 col-md-6">

                    </div>
                </div>
                <footer class="footer py-4  ">
                    <div class="container-fluid">
                        <div class="row align-items-center justify-content-lg-between">
                            <div class="col-lg-6 mb-lg-0 mb-4">
                                <div class="copyright text-center text-sm text-muted text-lg-start">
                                    © <script>
                                        document.write(new Date().getFullYear())
                                    </script>,
                                    made with <i class="fa fa-heart"></i> by
                                    <a href="https://www.creative-tim.com" class="font-weight-bold" target="_blank">RT03-B06</a>
                                    for creating Foodie Project
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <ul class="nav nav-footer justify-content-center justify-content-lg-end">

                                    <li class="nav-item">
                                        <a href="#" class="nav-link text-muted" >About Us</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link text-muted" >Blog</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link pe-0 text-muted" >License</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </main>

        <!--   Core JS Files   -->
        <script src="../assets/js/core/popper.min.js"></script>
        <script src="../assets/js/core/bootstrap.min.js"></script>
        <script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
        <script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
        <script src="../assets/js/plugins/chartjs.min.js"></script>
        <script>



                                        // Gọi API để lấy dữ liệu từ Servlet
                                        fetch('orderRevenueData')
                                                .then(response => {
                                                    if (!response.ok) {
                                                        throw new Error('Network response was not ok ' + response.statusText);
                                                    }
                                                    return response.json();
                                                })
                                                .then(data => {
                                                    // Lấy dữ liệu từ response
                                                    let monthLabels = data.months;
                                                    let orderDataValues = data.orderCounts;
                                                    let revenueDataValues = data.revenues;

                                                    // Chỉ lấy 12 tháng gần nhất
                                                    if (monthLabels.length > 12) {
                                                        monthLabels = monthLabels.slice(-12);
                                                        orderDataValues = orderDataValues.slice(-12);
                                                        revenueDataValues = revenueDataValues.slice(-12);
                                                    }

                                                    // Biểu đồ Đơn Hàng
                                                    const ctx1 = document.getElementById('orderChart').getContext('2d');
                                                    new Chart(ctx1, {
                                                        type: 'line',
                                                        data: {
                                                            labels: monthLabels,
                                                            datasets: [{
                                                                    label: 'Number of orders',
                                                                    data: orderDataValues,
                                                                    borderColor: 'rgba(255, 99, 132, 1)',
                                                                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                                                    fill: true,
                                                                    tension: 0.4
                                                                }]
                                                        },
                                                        options: {
                                                            responsive: true,
                                                            plugins: {
                                                                legend: {position: 'top'},
                                                                title: {display: true, text: 'Number of order per month'}
                                                            }
                                                        }
                                                    });

                                                    // Biểu đồ Doanh Thu
                                                    const ctx2 = document.getElementById('revenueChart').getContext('2d');
                                                    new Chart(ctx2, {
                                                        type: 'bar',
                                                        data: {
                                                            labels: monthLabels,
                                                            datasets: [{
                                                                    label: 'Revenue (USD)',
                                                                    data: revenueDataValues,
                                                                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                                                    borderColor: 'rgba(54, 162, 235, 1)',
                                                                    borderWidth: 1
                                                                }]
                                                        },
                                                        options: {
                                                            responsive: true,
                                                            plugins: {
                                                                legend: {position: 'top'},
                                                                title: {display: true, text: 'Revenue per month (USD)'}
                                                            }
                                                        }
                                                    });
                                                })
                                                .catch(error => console.error('Error fetching data:', error));

        </script>
        <script>
            var win = navigator.platform.indexOf('Win') > -1;
            if (win && document.querySelector('#sidenav-scrollbar')) {
                var options = {
                    damping: '0.5'
                }
                Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
            }
        </script>
        <script async defer src="https://buttons.github.io/buttons.js"></script>
        <script src="./assets/js/material-dashboard.min.js?v=3.1.0"></script>
    </body>

</html>