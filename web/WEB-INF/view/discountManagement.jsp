<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*,java.util.*,util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Foodie-Food</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css" />
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
        <link rel="stylesheet" href="./assets/css/restaurant.css">
        <link rel="stylesheet" href="./assets/css/order-manage.css">
        <link rel="stylesheet" href="./assets/css/refundManage.css">
        <link rel="stylesheet" href="./assets/css/discountManage.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
                    <a class="nav-link active" href="#">
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

        <div class="main-content">
            <div class="container mt-4">
                <h2 style="margin: 25px 0; font-size: 35px;">Manage Discounts</h2>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#discountModal">
                    Create Discount
                </button>

                <div class="modal fade" id="discountModal" tabindex="-1" aria-labelledby="discountModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="discountModalLabel">Create Discount</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="discountForm" action="discountManage" method="post">
                                    <input type="hidden" name="action" value="createDiscount">
                                    <input type="hidden" name="userID" value="${user.userID}">
                                    <div class="mb-3">
                                        <label for="discountCode" class="form-label">Discount Code</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="discountCode" name="discountCode" required>
                                            <button type="button" class="btn btn-secondary" onclick="generateDiscountCode()">Generate</button>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="voucherCount" class="form-label">Total Vouchers</label>
                                        <input type="number" class="form-control" id="voucherCount" name="numberOfDiscount" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discountPercentage" class="form-label">Discount Percentage</label>
                                        <input type="number" class="form-control" id="discountPercentage" name="discountPercentage" required min="0" max="100">
                                    </div>
                                    <div class="mb-3">
                                        <label for="minimumAmount" class="form-label">Minimum Amount</label>
                                        <input type="number" class="form-control" id="minimumAmount" name="minimumAmount" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="maximumAmount" class="form-label">Maximum Discount</label>
                                        <input type="number" class="form-control" id="maximumAmount" name="maximumAmount" required min="0">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Create Discount</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <table class="table table-bordered mt-4">
                    <thead>
                        <tr>
                            <th>Discount Code</th>
                            <th>Total Vouchers</th>
                            <th>Discount Percentage</th>
                            <th>Total Use</th>
                            <th>Minimum Amount</th>
                            <th>Maximum Discount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="discountTableBody">
                        <c:forEach var="discount" items="${discounts}">
                            <tr>
                                <td>${discount.discountCODE}</td>
                                <td>${discount.numberOfDiscount}</td>
                                <td>${discount.discountPercentage}</td>
                                <td>${discount.totalUse}</td>
                                <td>${discount.minimumAmount}</td>
                                <td>${discount.maximumAmount}</td>
                                <td>${discount.status == 1 ? 'Active' : 'Locked'}</td>
                                <td>
                                    <button class="btn btn-warning btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#updateDiscountModal" 
                                            onclick="setUpdateModal('${discount.discountID}', '${discount.discountCODE}', ${discount.numberOfDiscount}, ${discount.discountPercentage}, ${discount.minimumAmount}, ${discount.maximumAmount})">
                                        Update
                                    </button>
                                    <button class="btn ${discount.status == 1 ? 'btn-danger' : 'btn-success'} btn-sm" 
                                            onclick="toggleDiscountStatus(${discount.discountID}, ${discount.status})">
                                        ${discount.status == 1 ? 'Lock' : 'Unlock'}
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <%@ include file="/include/footer.jsp" %>
            
            <!-- Modal Update Discount -->
            <div class="modal fade" id="updateDiscountModal" tabindex="-1" aria-labelledby="updateDiscountModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateDiscountModalLabel">Update Discount</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateDiscountForm" action="discountManage" method="post">
                                <input type="hidden" name="action" value="updateDiscount">
                                <input type="hidden" name="discountID" id="updateDiscountID" value="">
                                <div class="mb-3">
                                    <label for="updateDiscountCode" class="form-label">Discount Code</label>
                                    <input type="text" class="form-control" id="updateDiscountCode" name="discountCode" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="minimumAmount" class="form-label">Minimum Amount</label>
                                    <input type="number" class="form-control" id="updateminimumAmount" name="minimumAmount" required>
                                </div>
                                <div class="mb-3">
                                    <label for="maximumAmount" class="form-label">Maximum Discount</label>
                                    <input type="number" class="form-control" id="updatemaximumAmount" name="maximumAmount" required min="0">
                                </div>
                                <div class="mb-3">
                                    <label for="updateVoucherCount" class="form-label">Total Vouchers</label>
                                    <input type="number" class="form-control" id="updateVoucherCount" name="numberOfDiscount" required>
                                </div>
                                <div class="mb-3">
                                    <label for="updateDiscountPercentage" class="form-label">Discount Percentage</label>
                                    <input type="number" class="form-control" id="updateDiscountPercentage" name="discountPercentage" required min="0" max="100">
                                </div>
                                <button type="submit" class="btn btn-primary">Update Discount</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function generateDiscountCode() {
                var discountCode = 'DIS' + Math.random().toString(36).substring(2, 10).toUpperCase();
                document.getElementById('discountCode').value = discountCode;
            }

            function toggleDiscountStatus(discountID, currentStatus) {
                var action = currentStatus === 1 ? 'lockDiscount' : 'unlockDiscount'; // action dựa trên status hiện tại
                $.post('discountManage', {
                    action: action,
                    discountID: discountID
                }, function (response) {
                    location.reload(); // reload lại trang sau khi hành động được thực hiện
                }).fail(function (xhr, status, error) {
                    alert("Error: " + error); // Nếu có lỗi thì sẽ hiển thị thông báo lỗi
                });
            }

            function setUpdateModal(discountID, discountCode, voucherCount, discountPercentage, minimumAmount, maximumAmount) {
                document.getElementById('updateDiscountID').value = discountID;
                document.getElementById('updateDiscountCode').value = discountCode;
                document.getElementById('updateVoucherCount').value = voucherCount;
                document.getElementById('updateDiscountPercentage').value = discountPercentage;
                document.getElementById('updateminimumAmount').value = minimumAmount;
                document.getElementById('updatemaximumAmount').value = maximumAmount;
            }
        </script>
    </body>
</html>
