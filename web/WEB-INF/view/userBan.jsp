<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Account" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>
            User Management  </title>
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
        <link rel="stylesheet" href="./assets/css/userBan.css">

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
                        <a class="nav-link text-white active bg-gradient-primary" href="/OrderingSystem/userBan">


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
                            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="/OrderingSystem/;">home</a></li>


                            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">User management</li>
                        </ol>
                        <h6 class="font-weight-bolder mb-0">User management</h6>
                    </nav>
                    
                </div>
            </nav>
            <!-- End Navbar -->
            <div class="container-fluid py-4">

                <div class="row mt-4">

                       <h1 class="mb-5" style="text-align: center;">User Management</h1>



                    <div class="container bootstrap snippets bootdey">
                        <div class="row">
                            <div class="user-list" style="max-height: 300px; overflow-y: scroll;">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>User's ID</th>
                                            <th>Avatar</th>
                                            <th>Name</th>
                                            <th>Phone</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${userList}">
                                            <tr>
                                                <td>
                                                    <h5>${user.userID}</h5>
                                                </td>
                                                <td>
                                                    <img src="${user.avtImg}" onerror="this.src='https://i.pinimg.com/564x/09/a9/2c/09a92c1cbe440f31d1818e4fe0bcf23a.jpg';" alt="Avatar of ${user.fullName}" class="img-responsive img-circle" style="width: 40px; height: 40px;">
                                                </td>
                                                <td>${user.fullName}</td>
                                                <td>${user.phoneNumber}</td>
                                                <td>


                                                    <form method="post" action="userBan">
                                                        <input type="hidden" name="userID" value="${user.getUserID()}">
                                                        <input type="hidden" name="action" value="${user.isStatus() == true ? 'ban' : 'unban'}">
                                                        <button type="submit" class="btn btn-danger">${user.isStatus() == true ? 'Ban' : 'Unban'}</button>
                                                    </form>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
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
                                        var ctx = document.getElementById("chart-bars").getContext("2d");

                                        new Chart(ctx, {
                                            type: "bar",
                                            data: {
                                                labels: ["M", "T", "W", "T", "F", "S", "S"],
                                                datasets: [{
                                                        label: "Sales",
                                                        tension: 0.4,
                                                        borderWidth: 0,
                                                        borderRadius: 4,
                                                        borderSkipped: false,
                                                        backgroundColor: "rgba(255, 255, 255, .8)",
                                                        data: [50, 20, 10, 22, 50, 10, 40],
                                                        maxBarThickness: 6
                                                    }, ],
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    legend: {
                                                        display: false,
                                                    }
                                                },
                                                interaction: {
                                                    intersect: false,
                                                    mode: 'index',
                                                },
                                                scales: {
                                                    y: {
                                                        grid: {
                                                            drawBorder: false,
                                                            display: true,
                                                            drawOnChartArea: true,
                                                            drawTicks: false,
                                                            borderDash: [5, 5],
                                                            color: 'rgba(255, 255, 255, .2)'
                                                        },
                                                        ticks: {
                                                            suggestedMin: 0,
                                                            suggestedMax: 500,
                                                            beginAtZero: true,
                                                            padding: 10,
                                                            font: {
                                                                size: 14,
                                                                weight: 300,
                                                                family: "Roboto",
                                                                style: 'normal',
                                                                lineHeight: 2
                                                            },
                                                            color: "#fff"
                                                        },
                                                    },
                                                    x: {
                                                        grid: {
                                                            drawBorder: false,
                                                            display: true,
                                                            drawOnChartArea: true,
                                                            drawTicks: false,
                                                            borderDash: [5, 5],
                                                            color: 'rgba(255, 255, 255, .2)'
                                                        },
                                                        ticks: {
                                                            display: true,
                                                            color: '#f8f9fa',
                                                            padding: 10,
                                                            font: {
                                                                size: 14,
                                                                weight: 300,
                                                                family: "Roboto",
                                                                style: 'normal',
                                                                lineHeight: 2
                                                            },
                                                        }
                                                    },
                                                },
                                            },
                                        });


                                        var ctx2 = document.getElementById("chart-line").getContext("2d");

                                        new Chart(ctx2, {
                                            type: "line",
                                            data: {
                                                labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                                datasets: [{
                                                        label: "Mobile apps",
                                                        tension: 0,
                                                        borderWidth: 0,
                                                        pointRadius: 5,
                                                        pointBackgroundColor: "rgba(255, 255, 255, .8)",
                                                        pointBorderColor: "transparent",
                                                        borderColor: "rgba(255, 255, 255, .8)",
                                                        borderColor: "rgba(255, 255, 255, .8)",
                                                        borderWidth: 4,
                                                        backgroundColor: "transparent",
                                                        fill: true,
                                                        data: [50, 40, 300, 320, 500, 350, 200, 230, 500],
                                                        maxBarThickness: 6

                                                    }],
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    legend: {
                                                        display: false,
                                                    }
                                                },
                                                interaction: {
                                                    intersect: false,
                                                    mode: 'index',
                                                },
                                                scales: {
                                                    y: {
                                                        grid: {
                                                            drawBorder: false,
                                                            display: true,
                                                            drawOnChartArea: true,
                                                            drawTicks: false,
                                                            borderDash: [5, 5],
                                                            color: 'rgba(255, 255, 255, .2)'
                                                        },
                                                        ticks: {
                                                            display: true,
                                                            color: '#f8f9fa',
                                                            padding: 10,
                                                            font: {
                                                                size: 14,
                                                                weight: 300,
                                                                family: "Roboto",
                                                                style: 'normal',
                                                                lineHeight: 2
                                                            },
                                                        }
                                                    },
                                                    x: {
                                                        grid: {
                                                            drawBorder: false,
                                                            display: false,
                                                            drawOnChartArea: false,
                                                            drawTicks: false,
                                                            borderDash: [5, 5]
                                                        },
                                                        ticks: {
                                                            display: true,
                                                            color: '#f8f9fa',
                                                            padding: 10,
                                                            font: {
                                                                size: 14,
                                                                weight: 300,
                                                                family: "Roboto",
                                                                style: 'normal',
                                                                lineHeight: 2
                                                            },
                                                        }
                                                    },
                                                },
                                            },
                                        });

                                        var ctx3 = document.getElementById("chart-line-tasks").getContext("2d");

                                        new Chart(ctx3, {
                                            type: "line",
                                            data: {
                                                labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                                datasets: [{
                                                        label: "Mobile apps",
                                                        tension: 0,
                                                        borderWidth: 0,
                                                        pointRadius: 5,
                                                        pointBackgroundColor: "rgba(255, 255, 255, .8)",
                                                        pointBorderColor: "transparent",
                                                        borderColor: "rgba(255, 255, 255, .8)",
                                                        borderWidth: 4,
                                                        backgroundColor: "transparent",
                                                        fill: true,
                                                        data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
                                                        maxBarThickness: 6

                                                    }],
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                plugins: {
                                                    legend: {
                                                        display: false,
                                                    }
                                                },
                                                interaction: {
                                                    intersect: false,
                                                    mode: 'index',
                                                },
                                                scales: {
                                                    y: {
                                                        grid: {
                                                            drawBorder: false,
                                                            display: true,
                                                            drawOnChartArea: true,
                                                            drawTicks: false,
                                                            borderDash: [5, 5],
                                                            color: 'rgba(255, 255, 255, .2)'
                                                        },
                                                        ticks: {
                                                            display: true,
                                                            padding: 10,
                                                            color: '#f8f9fa',
                                                            font: {
                                                                size: 14,
                                                                weight: 300,
                                                                family: "Roboto",
                                                                style: 'normal',
                                                                lineHeight: 2
                                                            },
                                                        }
                                                    },
                                                    x: {
                                                        grid: {
                                                            drawBorder: false,
                                                            display: false,
                                                            drawOnChartArea: false,
                                                            drawTicks: false,
                                                            borderDash: [5, 5]
                                                        },
                                                        ticks: {
                                                            display: true,
                                                            color: '#f8f9fa',
                                                            padding: 10,
                                                            font: {
                                                                size: 14,
                                                                weight: 300,
                                                                family: "Roboto",
                                                                style: 'normal',
                                                                lineHeight: 2
                                                            },
                                                        }
                                                    },
                                                },
                                            },
                                        });
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
