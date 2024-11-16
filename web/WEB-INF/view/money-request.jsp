<%-- 
    Document   : money-request
    Created on : Nov 14, 2024, 1:27:51 PM
    Author     : phuct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Foodie-Food</title>

        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Nucleo Icons -->
        <link href="https://demos.creative-tim.com/argon-dashboard-pro/assets/css/nucleo-icons.css" rel="stylesheet" />
        <link href="https://demos.creative-tim.com/argon-dashboard-pro/assets/css/nucleo-svg.css" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <!-- CSS Files -->
        <link id="pagestyle" href="./assets/css/argon-dashboard.css?v=2.1.0" rel="stylesheet" />
        <link id="pagestyle" href="./assets/css/argon-dashboard.css" rel="stylesheet" />


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link rel="stylesheet" href="./assets/css/restaurant.css">
        <link rel="stylesheet" href="./assets/css/order-manage.css">
        <link rel="stylesheet" href="./assets/css/refundManage.css">
        <link rel="stylesheet" href="./assets/css/discountManage.css">
        <link rel="stylesheet" href="./assets/css/dashboardShop.css">
    </head>
    <body>
        <%@ include file="/include/shop-header.jsp" %>

        <div class="sidebar">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="/OrderingSystem/order-manage">
                        <i class="ti-home"></i> All Orders
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/OrderingSystem/refundManage">
                        <i class="ti-wallet"></i> Refund Request
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link " href="/OrderingSystem/discountManage">
                        <i class="ti-timer"></i> Discount
                    </a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link active" href="#">
                        <i class="ti-timer"></i> Money Request
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <main class="main-content position-relative border-radius-lg ">

                <div class="container-fluid py-4">
                    <div class="row">
                        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                            <div class="card">
                                <div class="card-body p-3">
                                    <div class="row">
                                        <div class="col-8">
                                            <div class="numbers">
                                                <p class="text-sm mb-0 text-uppercase font-weight-bold">Today's Money</p>
                                                <h5 class="font-weight-bolder">
                                                    đ<fmt:formatNumber value="${totalToday}" pattern="#,##0" currencySymbol="đ" groupingUsed="true"/>
                                                </h5>
                                                <p class="mb-0">
                                                    <c:choose>
                                                        <c:when test="${percentChange > 0}">
                                                            <span class="text-success text-sm font-weight-bolder">+${percentChange}%</span> since yesterday
                                                        </c:when>
                                                        <c:when test="${percentChange < 0}">
                                                            <span class="text-danger text-sm font-weight-bolder">${percentChange}%</span> since yesterday
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-success text-sm font-weight-bolder">${percentChange}%</span> since yesterday
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="col-4 text-end">
                                            <div class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
                                                <i class="ni ni-money-coins text-lg opacity-10" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                            <div class="card">
                                <div class="card-body p-3">
                                    <div class="row">
                                        <div class="col-8">
                                            <div class="numbers">
                                                <p class="text-sm mb-0 text-uppercase font-weight-bold">Total This Month</p>
                                                <h5 class="font-weight-bolder">
                                                    đ<fmt:formatNumber value="${totalMoth}" pattern="#,##0" currencySymbol="đ" groupingUsed="true"/>
                                                </h5>
                                                <p class="mb-0">
                                                    <c:choose>
                                                        <c:when test="${percentChangeMoth > 0}">
                                                            <span class="text-success text-sm font-weight-bolder">+${percentChangeMoth}%</span> since last month
                                                        </c:when>
                                                        <c:when test="${percentChangeMoth < 0}">
                                                            <span class="text-danger text-sm font-weight-bolder">${percentChangeMoth}%</span> since last month
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-success text-sm font-weight-bolder">${percentChangeMoth}%</span> since last month
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="col-4 text-end">
                                            <div class="icon icon-shape bg-gradient-danger shadow-danger text-center rounded-circle">
                                                <i class="ni ni-world text-lg opacity-10" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                            <div class="card">
                                <div class="card-body p-3">
                                    <div class="row">
                                        <div class="col-8">
                                            <div class="numbers">
                                                <p class="text-sm mb-0 text-uppercase font-weight-bold">Order Count</p>
                                                <h5 class="font-weight-bolder">
                                                    ${orderCount}
                                                </h5>
                                                <p class="mb-0">
                                                    <span class="text-success text-sm font-weight-bolder"></span> to today
                                                </p>
                                            </div>
                                        </div>
                                        <div class="col-4 text-end">
                                            <div class="icon icon-shape bg-gradient-warning shadow-warning text-center rounded-circle">
                                                <i class="ni ni-cart text-lg opacity-10" aria-hidden="true"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6">
                            <div class="card">
                                <div class="card-body p-3">
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="numbers">
                                                <p class="text-sm mb-0 text-uppercase font-weight-bold">Shop Wallet</p>
                                                <h5 class="font-weight-bolder">

                                                    đ<fmt:formatNumber value="${shopwallet}" pattern="#,##0" currencySymbol="đ" groupingUsed="true"/>
                                                </h5>
                                                <p class="mb-0">
                                                    <span class="text-success text-sm font-weight-bolder">to today</span>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="col-6 text-end">
                                            <div
                                                data-bs-toggle="modal" data-bs-target="#withdrawModal">
                                                <a class="btn btn-success">Request Withdrawal</a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Modal for Withdraw Form -->
                                    <div class="modal fade" id="withdrawModal" tabindex="-1" aria-labelledby="withdrawModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="withdrawModalLabel">Withdraw Money</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form id="withdrawForm" method="POST" action="moneyrequest">
                                                        <input type="hidden" name="action" value="submitRequest">
                                                        <div class="mb-3">
                                                            <label for="availableAmount" class="form-label">Total Available Amount</label>
                                                            <input type="text" class="form-control" id="availableAmount" name="availableAmount" value="<fmt:formatNumber value="${shopwallet}" pattern="#,##0" currencySymbol="đ" groupingUsed="true"/>" readonly>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="requestedAmount" class="form-label">Amount to Withdraw</label>
                                                            <input type="number" class="form-control" id="requestedAmount" name="requestedAmount" placeholder="Enter amount" required min="1" max="${shopwallet}">
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="bankAccount" class="form-label">Bank Account</label>
                                                            <input type="text" class="form-control" id="bankAccount" name="bankAccount" placeholder="Enter account number" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="bankName" class="form-label">Bank Name</label>
                                                            <input type="text" class="form-control" id="bankName" name="bankName" placeholder="Enter bank name" required>
                                                        </div>

                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                    </form>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-lg-7 mb-lg-0 mb-4">
                            <div class="card z-index-2 h-100">
                                <div class="card-header pb-0 pt-3 bg-transparent">
                                    <h6 class="text-capitalize">Sales overview</h6>

                                </div>
                                <div class="card-body p-3">
                                    <div class="chart">
                                        <canvas id="chart-line" class="chart-canvas" height="300"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="card card-carousel overflow-hidden h-100 p-0">
                                <div id="carouselExampleCaptionsPost" class="carousel slide h-100" data-bs-ride="carousel">
                                    <div class="carousel-inner border-radius-lg h-100">
                                        <!-- Loop through postList -->
                                        <c:forEach var="post" items="${postList}">
                                            <div class="carousel-item h-100 ${postList.indexOf(post) == 0 ? 'active' : ''}" 
                                                 style="background-image: url('${post.imgURL}'); background-size: cover;">
                                                <div class="carousel-caption d-none d-md-block bottom-0 text-start start-0 ms-5">
                                                    <h5 style="color: white !important" class="text-white mb-1">${post.heading}</h5>

                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button class="carousel-control-prev w-5 me-3" type="button" data-bs-target="#carouselExampleCaptionsPost" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next w-5 me-3" type="button" data-bs-target="#carouselExampleCaptionsPost" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-lg-7 mb-lg-0 mb-4">
                            <div class="card ">
                                <div class="card-header pb-0 p-3">
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mb-2">Recent Order</h6>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table align-items-center ">
                                        <tbody>
                                            <c:forEach var="order" items="${orderList}">
                                                <tr>
                                                    <td class="w-30">
                                                        <div class="d-flex px-2 py-1 align-items-center">
                                                            <div class="ms-4">
                                                                <p class="text-xs font-weight-bold mb-0">Order ID: </p>
                                                                <h6 class="text-sm mb-0">${order.orderId}</h6> <!-- Display country from order -->
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="text-center">
                                                            <p class="text-xs font-weight-bold mb-0">Total Amount:</p>
                                                            <h6 class="text-sm mb-0">đ<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" currencySymbol="đ" groupingUsed="true"/></h6> <!-- Display sales from order -->
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="text-center">
                                                            <p class="text-xs font-weight-bold mb-0">Delivery Status:</p>
                                                            <h6 class="text-sm mb-0">${order.deliveryStatus}</h6> <!-- Display value from order -->
                                                        </div>
                                                    </td>
                                                    <td class="align-middle text-sm">
                                                        <div class="col text-center">
                                                            <p class="text-xs font-weight-bold mb-0">Payment Option:</p>
                                                            <h6 class="text-sm mb-0">${order.paymentOption}</h6> <!-- Display bounce rate from order -->
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="card">
                                <div class="card-header pb-0 p-3">
                                    <h6 class="mb-0">Categories</h6>
                                </div>
                                <div class="card-body p-3">
                                    <ul class="list-group">
                                        <c:forEach var="category" items="${categories}">
                                            <li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
                                                <div class="d-flex align-items-center">
                                                    <div class="icon icon-shape icon-sm me-3 bg-gradient-dark shadow text-center">
                                                        <i class="ni ni-mobile-button text-white opacity-10"></i>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <h6 class="mb-1 text-dark text-sm">${category.type}</h6>

                                                    </div>
                                                </div>
                                                <div class="d-flex">
                                                    <button class="btn btn-link btn-icon-only btn-rounded btn-sm text-dark icon-move-right my-auto">
                                                        <i class="ni ni-bold-right" aria-hidden="true"></i>
                                                    </button>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </main>

            <%@ include file="/include/footer.jsp" %>
            <!--   Core JS Files   -->
            <script src="./assets/js/core/popper.min.js"></script>
            <script src="./assets/js/core/bootstrap.min.js"></script>
            <script src="./assets/js/plugins/perfect-scrollbar.min.js"></script>
            <script src="./assets/js/plugins/smooth-scrollbar.min.js"></script>
            <script src="./assets/js/plugins/chartjs.min.js"></script>
            <script>
                var ctx1 = document.getElementById("chart-line").getContext("2d");

                var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

                gradientStroke1.addColorStop(1, 'rgba(94, 114, 228, 0.2)');
                gradientStroke1.addColorStop(0.2, 'rgba(94, 114, 228, 0.0)');
                gradientStroke1.addColorStop(0, 'rgba(94, 114, 228, 0)');
                <%
    // Retrieve the monthly amounts passed from the servlet
    List<Double> monthlyAmounts = (List<Double>) request.getAttribute("monthlyAmounts");
    
    // Ensure the list is not null and has the correct size (12 months)
    if (monthlyAmounts == null) {
        monthlyAmounts = new ArrayList<>(Collections.nCopies(12, 0.0)); // If no data, use 0 for all months
    }
    
    // Build a comma-separated string for the chart data
    StringBuilder dataString = new StringBuilder("[");
    for (Double amount : monthlyAmounts) {
        dataString.append(amount).append(",");
    }
    // Remove the last comma
    if (dataString.length() > 1) {
        dataString.setLength(dataString.length() - 1);
    }
    dataString.append("]");
                %>
                new Chart(ctx1, {
                    type: "line",
                    data: {
                        labels: ["Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct"],
                        datasets: [{
                                label: "Mobile apps",
                                tension: 0.4,
                                borderWidth: 0,
                                pointRadius: 0,
                                borderColor: "#5e72e4",
                                backgroundColor: gradientStroke1,
                                borderWidth: 3,
                                fill: true,
                                data: <%= dataString.toString() %>, // Dynamically insert the data
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
                                    borderDash: [5, 5]
                                },
                                ticks: {
                                    display: true,
                                    padding: 10,
                                    color: '#fbfbfb',
                                    font: {
                                        size: 11,
                                        family: "Open Sans",
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
                                    color: '#ccc',
                                    padding: 20,
                                    font: {
                                        size: 11,
                                        family: "Open Sans",
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
            <!-- Github buttons -->
            <script async defer src="https://buttons.github.io/buttons.js"></script>
            <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
            <script src="./assets/js/argon-dashboard.min.js?v=2.1.0"></script>
        </div>
    </body>
</html>
