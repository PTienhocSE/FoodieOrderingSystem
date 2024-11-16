<%-- 
   Document   : refundManage
   Created on : Oct 19, 2024, 4:21:16 PM
   Author     : phuct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Foodie-Food</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link rel="stylesheet" href="./assets/css/restaurant.css">
        <link rel="stylesheet" href="./assets/css/order-manage.css">
        <link rel="stylesheet" href="./assets/css/refundManage.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="./assets/js/order-history.js"></script>
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
                    <a class="nav-link active" href="/OrderingSystem/refundManage">
                        <i class="ti-wallet"></i> Refund Request
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/OrderingSystem/discountManage">
                        <i class="ti-timer"></i> Discount
                    </a>
                </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/OrderingSystem/moneyrequest">
                        <i class="ti-timer"></i> Money Request
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <ul class="nav nav-tabs mt-4" id="refundTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="refund-tab" data-bs-toggle="tab" href="#refund" role="tab" aria-controls="refund" aria-selected="true">Refund Requests  <b style="color:#F6B76C; margin-left: 8px"> (${requestList != null ? requestList.size() : 0})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="rejected-tab" data-bs-toggle="tab" href="#rejected" role="tab" aria-controls="rejected" aria-selected="false">Rejected Requests <b style="color:#F6B76C; margin-left: 8px"> (${rejectedList != null ? rejectedList.size() : 0})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="approved-tab" data-bs-toggle="tab" href="#approved" role="tab" aria-controls="approved" aria-selected="false">Approved Requests <b style="color:#F6B76C; margin-left: 8px"> (${approvedList != null ? approvedList.size() : 0})</b></a>
                </li>
            </ul>

            <div style="min-height: 80vh" class="tab-content" id="refundTabsContent">
                <!-- Refund Requests Section -->
                <div class="tab-pane fade show active" id="refund" role="tabpanel" aria-labelledby="refund-tab">
                    <h2 class="refund-section-header">Request List For Refund Point Option</h2>
                    <c:if test="${not empty requestListPointOption}">
                        <c:forEach var="request" items="${requestListPointOption}">
                            <div class="card p-3 mb-3">
                                <a href="./refundDetails?refundID=${request.getRefundId()}">
                                    <div style="justify-content: space-between" class="row">
                                        <div class="col-sm-2">No: ${request.getOrderId()}</div>
                                        <div class="col-sm-6">Refund Reason: ${request.getRefundReason()}</div>
                                        <div class="col-sm-4">Created Time: <b>${request.getCreatedAt()}</b></div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestListPointOption}">
                        <div class="alert alert-warning">No refund requests found.</div>
                    </c:if>

                    <h2 class="refund-section-header">Request List For Refund VNPay Option</h2>
                    <c:if test="${not empty requestListVNPayOption}">
                        <c:forEach var="request" items="${requestListVNPayOption}"> <!-- Đảm bảo sửa đúng tên list -->
                            <div class="card p-3 mb-3">
                                <a href="./refundDetails?refundID=${request.getRefundId()}">
                                    <div style="justify-content: space-between" class="row">
                                        <div class="col-sm-2">No: ${request.getOrderId()}</div>
                                        <div class="col-sm-6">Refund Reason: ${request.getRefundReason()}</div>
                                        <div class="col-sm-4">Created Time: <b>${request.getCreatedAt()}</b></div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestListVNPayOption}">
                        <div class="alert alert-warning">No refund requests found.</div>
                    </c:if>
                </div>

                <!-- Rejected Requests Section -->
                <div class="tab-pane fade" id="rejected" role="tabpanel" aria-labelledby="rejected-tab">
                    <c:if test="${not empty rejectedList}">
                        <c:forEach var="request" items="${rejectedList}">
                            <div class="card p-3 mb-3 bg-danger text-white">
                                <a href="./refundDetails?refundID=${request.getRefundId()}" class="text-white">
                                    <div style="justify-content: space-between" class="row">
                                        <div class="col-sm-2">No: ${request.getOrderId()}</div>
                                        <div class="col-sm-6">Refund Reason: ${request.getRefundReason()}</div>
                                        <div class="col-sm-4">Created Time: <b>${request.getCreatedAt()}</b></div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty rejectedList}">
                        <div class="alert alert-warning">No rejected requests found.</div>
                    </c:if>
                </div>

                <!-- Approved Requests Section -->
                <div class="tab-pane fade" id="approved" role="tabpanel" aria-labelledby="approved-tab">
                    <c:if test="${not empty approvedList}">
                        <c:forEach var="request" items="${approvedList}">
                            <div class="card p-3 mb-3 bg-success text-white">
                                <a href="./refundDetails?refundID=${request.getRefundId()}" class="text-white">
                                    <div style="justify-content: space-between" class="row">
                                        <div class="col-sm-2">No: ${request.getOrderId()}</div>
                                        <div class="col-sm-6">Refund Reason: ${request.getRefundReason()}</div>
                                        <div class="col-sm-4">Created Time: <b>${request.getCreatedAt()}</b></div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty approvedList}">
                        <div class="alert alert-warning">No approved requests found.</div>
                    </c:if>
                </div>
            </div>

            <%@ include file="/include/footer.jsp" %>
            <script src="js/Jquery.js"></script>
            <script src="js/bootstrap.min.js"></script>
        </div>
    </body>
</html>
