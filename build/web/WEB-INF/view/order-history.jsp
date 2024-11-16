<%@ page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    String alertMessage = (String) session.getAttribute("alertMessage");
    if (alertMessage != null) {
%>
<script>
    alert("<%= alertMessage %>");
</script>
<%
        session.removeAttribute("alertMessage");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foodie-Food</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css"/>
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link href="./assets/css/order-history.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./assets/js/order-history.js"></script>
        <script>
    // Hàm cập nhật số lượng và giá trị
    document.addEventListener('DOMContentLoaded', function () {
        var quantityInputs = document.querySelectorAll('.quantity');
        quantityInputs.forEach(function (input) {
            updateAmount(input);
        });
    });
        </script>
    </head>
    <body>
        <%@ include file="/include/header.jsp" %>
        <div>
            <br><br>
            <div class="center container cart">
                <h1>Order History</h1>
                <c:forEach var="order" items="${orderList}">
                    <div class='order-inf'><p></p></div>
                    <form name="order" action="checkout" method="get">
                        <div class="cart-products">
                            <div class="cart-thead">
                                <div style="width: 6%"></div>
                                <div style="width: 21%;text-align: left;">ID: ${order.getOrder().getOrderId()}</div>
                                <div style="width: 21%;text-align: left;padding-left: 5px;">Products</div>
                                <div id="head2" style="width: 21%"><span>Price</span></div>
                                <div style="width: 16%">Quantity</div>
                                <div id="head3" style="width: 13%;text-align: right!important;">Amount</div>
                            </div>
                            <div class="cart-tbody">
                                <c:forEach var="item" items="${order.getOrderItem()}">
                                    <div class="cart-item">
                                        <div style="width: 6%"></div>
                                        <div style="width: 6%;text-align: left;">
                                            <img width="120" height="auto" alt="Product Image" src="${item.getImg()}"/>
                                        </div>
                                        <div style="width: 6%"></div>
                                        <div id="col1" style="width: 30%;" class="a-center cart2">
                                            <h2 class="product-name" title="${item.getProduct().getName()}">
                                                <a href="./food-detail?productId=${item.getProduct().getProductId()}">${item.getProduct().getName()}</a>
                                            </h2>
                                        </div>
                                        <div id="col2" style="width: 21%;">
                                            <span class="price">${item.getProduct().getPrice()}</span>
                                        </div>
                                        <div style="width: 16%">
                                            <div class="number-input">
                                                <input name="isSelected" type="hidden" value="${item.getProduct().getProductId()}">
                                                <input type="number" readonly id="${item.getProduct().getProductId()}" name="quantity_${item.getProduct().getProductId()}" class="quantity" value="${item.getQuantity()}" min="1" max="10" onchange="updateAmount(this)">
                                            </div>
                                        </div>
                                        <div id="col3" style="width: 13%; text-align: right!important;align-items: flex-end; padding-right: 0;">
                                            <span class="amount"></span>
                                        </div>
                                    </div>
                                </c:forEach>
                                <input type="hidden" id="userID" name="userID" value="${user.getUserID()}">
                            </div>
                            <table class="total-table">
                                <tr>
                                    <td style="width: 5%"></td>
                                    <td class="table-left">Payment Status: <b>${order.getOrder().getPaymentStatus().toUpperCase()}</b>
                                        <br>Order Status: <b>${order.getOrder().getDeliveryStatus().toUpperCase()}</b>
                                    </td>
                                    <td class="table-center">Delivery Address: ${order.getOrder().getAddress()}<br>
                                        Phone: ${order.getOrder().getPhone()}</td>

                                    <td class="a-right"><span class="total_tt">Total:</span>
                                        <span class="totals_price">${FormatString.formatCurrency(order.getOrder().getTotalAmount())}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%"></td>
                                    <td class="table-left">Date: ${order.getOrder().getCreatedDate()} <br>Time Pickup: <b><fmt:formatDate value="${order.getOrder().getTimePickup()}" pattern="HH:mm:ss" /></b></td>
                                    <td class="table-center">Delivery Option: <b>${order.getOrder().getDeliveryOption().toUpperCase()}</b>
                                        - Payment Option: <b>${order.getOrder().getPaymentOption().toUpperCase()}</b></td>
                                    <td class="a-right">
                                        <c:choose>
                                            <c:when test="${order.getOrder().getDeliveryStatus() == 'PENDING'}">
                                                <a href="#" class='cancel-order' onclick="submitCancelOrderForm(${order.getOrder().getOrderId()});">Cancel Order</a>
                                            </c:when>
                                            <c:when test="${order.getOrder().getDeliveryStatus() == 'CANCELLED' 
                                                            && order.getOrder().getPaymentOption()=='VNPAY' 
                                                            && order.getOrder().getPaymentStatus() =='PAID' 
                                                            && order.getOrder().getIsRefund() == 0 }">
                                                    <a href="#" class='cancel-order' onclick="submitRefundOrderForm(${order.getOrder().getOrderId()});">Refund</a>
                                            </c:when>
                                            <c:when test="${order.getOrder().getDeliveryStatus() == 'COMPLETED' 
                                                            && (order.getOrder().getPaymentOption()=='VNPAY'
                                                            || order.getOrder().getPaymentOption()=='COD' )
                                                            && order.getOrder().getPaymentStatus() =='PAID' 
                                                            && order.getOrder().getIsRefund() == 0 }">
                                                    <a href="#" class='cancel-order' 
                                                       onclick="setOrderIdAndShowModal(${order.getOrder().getOrderId()});">Send Refund Request</a>
                                            </c:when>
                                        </c:choose>
                                        <button type="submit">Buy Again</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>

                    <!-- Refund Request Modal -->
                    <div class="modal fade" id="refundRequestModal" tabindex="-1" aria-labelledby="refundRequestModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="refundRequestModalLabel">Refund Request</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="refund" method="post" id="refundRequestForm" enctype="multipart/form-data" onsubmit="return validateRefundForm();">
                                        <div class="mb-3">
                                            <label for="refundReason" class="form-label">Reason for Refund</label>
                                            <textarea class="form-control" id="refundReason" name="refundReason" rows="3" required></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="refundReasonImg" class="form-label">Refund Reason Image</label>
                                            <input type="file" class="form-control" id="refundReasonImg" name="refundReasonImg" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="refundOption" class="form-label">Refund Option</label>
                                            <select id="refundOption" name="refundOption" class="form-select" aria-label="Refund Option" required>
                                                <option value="" disabled selected>Select a refund option</option>
                                                <option value="points">Refund to Points</option>
                                                <c:if test="${order.getOrder().getPaymentOption()=='VNPAY'}">
                                                    <option value="vnpay">Refund to VNPay</option>
                                                </c:if>
                                            </select>
                                        </div>
                                        <input type="hidden" name="orderId" id="orderId" value="">
                                        <input type="hidden" name="paymentOption" id="paymentOption" value="">
                                        <input type="hidden" name="action" value="refundRequest">
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Submit Request</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Refund Request Modal -->

                    <form id="cancelOrderForm_${order.getOrder().getOrderId()}" action="order-history" method="post" style="display: none;">
                        <input type="hidden" name="orderId" value="${order.getOrder().getOrderId()}">
                    </form>
                    <form id="refundOrderForm_${order.getOrder().getOrderId()}" action="refund" method="post" style="display: none;">
                        <input type="hidden" name="orderId" value="${order.getOrder().getOrderId()}">
                        <input type="hidden" name="action" value="refundCancelOrder">
                    </form>
                </c:forEach>
            </div>
        </div>
        <%@ include file="/include/footer.jsp" %>
        <script>
            function setOrderIdAndShowModal(orderId) {
                document.getElementById('orderId').value = orderId;
                var myModal = new bootstrap.Modal(document.getElementById('refundRequestModal'));
                myModal.show();
            }

            function validateRefundForm() {
                var refundOption = document.getElementById("refundOption").value;
                if (refundOption === "") {
                    alert("Please select a refund option.");
                    return false;
                }
                return true;
            }

            function submitCancelOrderForm(orderId) {
                document.getElementById("cancelOrderForm_" + orderId).submit();
            }

            function submitRefundOrderForm(orderId) {
                document.getElementById("refundOrderForm_" + orderId).submit();
            }
        </script>
        <script src="js/Jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
