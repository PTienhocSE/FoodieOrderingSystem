<%-- 
    Document   : order-item
    Created on : Oct 9, 2024, 6:35:15 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link href="./assets/css/restaurant.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="./assets/css/order-manage.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./assets/js/order-history.js"></script>


    </head>
    <body>
        <%@ include file="/include/shop-header.jsp" %>

        <div class="sidebar">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="ti-home"></i> All Orders
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/OrderingSystem/refundManage">
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
                    <a class="nav-link active" id="new-order-tab" data-bs-toggle="tab" href="#new-order" role="tab" aria-controls="new-order" aria-selected="true">New Orders<b style="color:#F6B76C; margin-left: 8px"> (${totalPendingOrders})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="preparing-tab" data-bs-toggle="tab" href="#preparing" role="tab" aria-controls="preparing" aria-selected="false">Preparing<b style="color:#F6B76C; margin-left: 8px"> (${totalPreparingOrders})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="ready-tab" data-bs-toggle="tab" href="#ready" role="tab" aria-controls="ready" aria-selected="false">Ready For Delivery<b style="color:#F6B76C; margin-left: 8px"> (${totalReadyOrders})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="in-transit-tab" data-bs-toggle="tab" href="#in-transit" role="tab" aria-controls="in-transit" aria-selected="false">In Transit<b style="color:#F6B76C; margin-left: 8px"> (${totalShippingOrders})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="completed-tab" data-bs-toggle="tab" href="#completed" role="tab" aria-controls="completed" aria-selected="false">Completed<b style="color:#F6B76C; margin-left: 8px"> (${totalCompletedOrders})</b></a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="cancelled-tab" data-bs-toggle="tab" href="#cancelled" role="tab" aria-controls="cancelled" aria-selected="false">Cancelled<b style="color:#F6B76C; margin-left: 8px">(${totalCancelledOrders})</b></a>
                </li>
            </ul>
            <div style="min-height: 80vh" class="tab-content" id="ordersTabsContent">
                <!-- New Orders Section -->
                <div class="mt-4 tab-pane fade show active" id="new-order" role="tabpanel" aria-labelledby="new-order-tab">
                    <h5>New Orders (${totalPendingOrders})</h5>
                    <c:forEach var="order" items="${pendingList}">
                        <div class="card p-3 mb-3">
                            <a href = "./order-detail?orderId=${order.getOrderId()}">
                                <div class="row">
                                    <div class="col-sm-2">No: ${order.getOrderId()}</div>
                                    <div class="col-sm-2"><b>${FormatString.formatCurrency(order.getTotalAmount())}</b></div>
                                    <div class="col-sm-2"><b>${order.getDeliveryOption()}</b></div>
                                    <div class="col-sm-2">${order.getAddress()}<br>${order.getPhone()}</div>
                                    <div class="col-sm-2">Time Pickup: <b><fmt:formatDate value="${order.getTimePickup()}" pattern="dd/MM/yyy HH:mm:ss" /></b></div>
                                    <div class="col-sm-2" style="display: flex; justify-content: center; align-items: center; gap: 10px;">
                                        <c:choose>
                                            <c:when test="${order.getDeliveryStatus() == 'PENDING'}">
                                                <form method="post" action="order-detail">
                                                    <input type="hidden" name="orderId" value="${order.orderId}" />
                                                    <input type="hidden" name="action" value="prepare" />
                                                    <button class ="status-btn" type="submit"  onclick="return confirm('Are you sure you want to confirm this order?');">Confirm Order</button>
                                                </form>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(totalPendingOrders / pageSize) + (totalPendingOrders % pageSize > 0 ? 1 : 0)}">
                            <a href="order-manage?page=${i}&size=${pageSize}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
                <!-- Preparing Section -->

                <!-- Preparing Section -->
                <div class="mt-4  tab-pane fade " id="preparing" role="tabpanel" aria-labelledby="preparing-tab">
                    <h5>Preparing (${totalPreparingOrders})</h5>
                    <c:forEach var="order" items="${prepareList}">
                        <div class="card p-3 mb-3">
                            <a href = "./order-detail?orderId=${order.getOrderId()}">
                                <div class="row">
                                    <div class="col-sm-2">No: ${order.getOrderId()}</div>
                                    <div class="col-sm-2"><b>${FormatString.formatCurrency(order.getTotalAmount())}</b></div>
                                    <div class="col-sm-2"><b>${order.getDeliveryOption()}</b></div>
                                    <div class="col-sm-2">${order.getAddress()}<br>${order.getPhone()}</div>
                                    <div class="col-sm-2">Time Pickup: <b><fmt:formatDate value="${order.getTimePickup()}" pattern="dd/MM/yyy HH:mm:ss" /></b></div>
                                    <div class="col-sm-2" style="display: flex; justify-content: center; align-items: center; gap: 10px;">
                                        <c:choose>

                                            <c:when test="${order.getDeliveryStatus() == 'PREPARING'}">
                                                <form method="post" action="order-detail">
                                                    <input type="hidden" name="orderId" value="${order.orderId}" />
                                                    <input type="hidden" name="action" value="ready" />
                                                    <button type="submit"  class ="status-btn">Done Preparing</button>
                                                </form>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(totalPreparingOrders / pageSize) + (totalPreparingOrders % pageSize > 0 ? 1 : 0)}">
                            <a href="order-manage?page=${i}&size=${pageSize}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
                <!-- Ready for Delivery Section -->
                <div class="mt-4  tab-pane fade " id="ready" role="tabpanel" aria-labelledby="ready-tab">
                    <h5>Ready For Delivery(${totalReadyOrders})</h5>
                    <c:forEach var="order" items="${readyList}">
                        <div class="card p-3 mb-3">
                            <a href = "./order-detail?orderId=${order.getOrderId()}">
                                <div class="row">
                                    <div class="col-sm-2">No: ${order.getOrderId()}</div>
                                    <div class="col-sm-2"><b>${FormatString.formatCurrency(order.getTotalAmount())}</b></div>
                                    <div class="col-sm-2"><b>${order.getDeliveryOption()}</b></div>
                                    <div class="col-sm-2">${order.getAddress()}<br>${order.getPhone()}</div>

                                    <div class="col-sm-2">Time Pickup: <b><fmt:formatDate value="${order.getTimePickup()}" pattern="dd/MM/yyy HH:mm:ss" /></b></div>
                                    <div class="col-sm-2" style="display: flex; justify-content: center; align-items: center; gap: 10px;">
                                        <c:choose>
                                            <c:when test="${order.getDeliveryStatus() == 'READY' || order.deliveryStatus == 'SHIPPING'}">
                                                <form method="post" action="order-detail">
                                                    <input type="hidden" name="orderId" value="${order.orderId}" />
                                                    <input type="hidden" name="action" value="complete" />
                                                    <button  class ="status-btn" type="submit"  onclick="return confirm('Are you sure you want to complete this order?');">Complete Order</button>
                                                </form>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(totalReadyOrders / pageSize) + (totalReadyOrders % pageSize > 0 ? 1 : 0)}">
                            <a href="order-manage?page=${i}&size=${pageSize}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>

                <div class="mt-4  tab-pane fade " id="in-transit" role="tabpanel" aria-labelledby="in-transit-tab">
                    <h5>In Transit(${totalShippingOrders})</h5>
                    <c:forEach var="order" items="${shippingList}">
                        <div class="card p-3 mb-3">
                            <a href = "./order-detail?orderId=${order.getOrderId()}">
                                <div class="row">
                                    <div class="col-sm-2">No: ${order.getOrderId()}</div>
                                    <div class="col-sm-2"><b>${FormatString.formatCurrency(order.getTotalAmount())}</b></div>
                                    <div class="col-sm-2"><b>${order.getDeliveryOption()}</b></div>
                                    <div class="col-sm-2">${order.getAddress()}<br>${order.getPhone()}</div>

                                    <div class="col-sm-2">Time Pickup: <b><fmt:formatDate value="${order.getTimePickup()}" pattern="dd/MM/yyy HH:mm:ss" /></b></div>
                                    <div class="col-sm-2" style="display: flex; justify-content: center; align-items: center; gap: 10px;">
                                        <c:choose>
                                            <c:when test="${order.getDeliveryStatus() == 'READY' || order.deliveryStatus == 'SHIPPING'}">
                                                <form method="post" action="order-detail">
                                                    <input type="hidden" name="orderId" value="${order.orderId}" />
                                                    <input type="hidden" name="action" value="complete" />
                                                    <button  class ="status-btn" type="submit"  onclick="return confirm('Are you sure you want to complete this order?');">Complete Order</button>
                                                </form>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(totalShippingOrders / pageSize) + (totalShippingOrders % pageSize > 0 ? 1 : 0)}">
                            <a href="order-manage?page=${i}&size=${pageSize}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>


                <div class="mt-4  tab-pane fade" id="completed" role="tabpanel" aria-labelledby="completed-tab">
                    <h5>Completed(${totalCompletedOrders})</h5>
                    <c:forEach var="order" items="${completeList}">
                        <div class="card p-3 mb-3">
                            <a href = "./order-detail?orderId=${order.getOrderId()}">
                                <div class="row">
                                    <div class="col-sm-2">No: ${order.getOrderId()}</div>
                                    <div class="col-sm-2"><b>${FormatString.formatCurrency(order.getTotalAmount())}</b></div>
                                    <div class="col-sm-2"><b>${order.getDeliveryOption()}</b></div>
                                    <div class="col-sm-2">${order.getAddress()}<br>${order.getPhone()}</div>

                                    <div class="col-sm-2">Time Pickup: <b><fmt:formatDate value="${order.getTimePickup()}" pattern="dd/MM/yyy HH:mm:ss" /></b></div>
                                    <div class="col-sm-2"><button class = 'cpl-btn'>Completed</button></div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(totalCompletedOrders / pageSize) + (totalCompletedOrders % pageSize > 0 ? 1 : 0)}">
                            <a href="order-manage?page=${i}&size=${pageSize}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>

                <div class="mt-4  tab-pane fade" id="cancelled" role="tabpanel" aria-labelledby="cancelled-tab">
                    <h5>Cancelled(${totalCancelledOrders})</h5>
                    <c:forEach var="order" items="${cancelList}">
                        <div class="card p-3 mb-3">
                            <a href = "./order-detail?orderId=${order.getOrderId()}">
                                <div class="row">
                                    <div class="col-sm-2">No: ${order.getOrderId()}</div>
                                    <div class="col-sm-2"><b>${FormatString.formatCurrency(order.getTotalAmount())}</b></div>
                                    <div class="col-sm-2"><b>${order.getDeliveryOption()}</b></div>

                                    <div class="col-sm-2">${order.getAddress()}<br>${order.getPhone()}</div>
                                    <div class="col-sm-2">Time Pickup: <b><fmt:formatDate value="${order.getTimePickup()}" pattern="dd/MM/yyy HH:mm:ss" /></b></div>
                                    <div class="col-sm-2"><button class = 'cancel-btn'>Cancelled</button></div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                    <div class="pagination">
                        <c:forEach var="i" begin="1" end="${(totalCancelledOrders / pageSize) + (totalCancelledOrders % pageSize > 0 ? 1 : 0)}">
                            <a href="order-manage?page=${i}&size=${pageSize}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>


            <script src="js/Jquery.js"></script>
            <script src="js/bootstrap.min.js"></script>
        </div>

    
</body>

</html>
