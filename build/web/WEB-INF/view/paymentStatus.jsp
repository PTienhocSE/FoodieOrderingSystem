<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Payment Status</title>
        <link rel="stylesheet" href="./assets/font/themify-icons/themify-icons.css"/>
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/cart.css">
        <link rel="stylesheet" href="./assets/css/header-footer.css">
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

        <style>
            #footer {
                margin: 0 !important;
            }
            .container {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                width: 100%;
                padding: 50px 20px;
            }
            .bill-box {
                background-color: #ffffff;
                border: 1px solid #dee2e6;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
                max-width: 650px;
                width: 100%;
                padding: 30px;
            }
            .bill-box h3 {
                text-align: center;
                margin-bottom: 30px;
                color: #ff6b6b;
                font-size: 28px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
                border-bottom: 2px solid #ff6b6b;
                padding-bottom: 10px;
            }
            .form-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                padding: 10px;
                border-bottom: 1px solid #eee;
            }
            .form-group label:first-child {
                font-weight: 700;
                color: #333;
                font-size: 15px;
                flex: 1;
            }
            .form-group label:last-child {
                font-weight: 500;
                color: #5eae53  ;
                font-size: 16px;
                flex: 2;
                text-align: right;
                word-break: break-word;
            }
            .footer {
                margin-top: 30px;
                text-align: center;
                color: #888;
                font-size: 14px;
            }
        </style>
    <body>
        <%@ include file="/include/header.jsp" %>

        <%
            // Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
        %>

        <div class="container">
            <div class="bill-box">
                <h3>PAYMENT RESULT</h3>
                <div class="table-responsive">
                    <div class="form-group">
                        <label>Transaction Reference Number:</label>
                        <label><%=request.getParameter("vnp_TxnRef")%></label>
                    </div>    
                    <div class="form-group">
                        <label>Amount:</label>
                        <%
     String amountStr = request.getParameter("vnp_Amount");
     String formattedAmount = "";
     if (amountStr != null && !amountStr.isEmpty()) {
         try {
             long amount = Long.parseLong(amountStr) / 100; 
             java.text.NumberFormat formatter = java.text.NumberFormat.getInstanc
             e(new java.util.Locale("vi", "VN"));
             formattedAmount = formatter.format(amount) + " VND";
         } catch (NumberFormatException e) {
             formattedAmount = "Invalid amount";
         }
     }
                        %>
                        <label><%= formattedAmount %></label>
                    </div>  
                    <div class="form-group">
                        <label>Transaction Description:</label>
                        <label><%=request.getParameter("vnp_OrderInfo")%></label>
                    </div> 
                    <div class="form-group">
                        <label>Payment Error Code:</label>
                        <label><%=request.getParameter("vnp_ResponseCode")%></label>
                    </div> 
                    <div class="form-group">
                        <label>Transaction ID at CTT VNPAY-QR:</label>
                        <label><%=request.getParameter("vnp_TransactionNo")%></label>
                    </div> 
                    <div class="form-group">
                        <label>Bank Code:</label>
                        <label><%=request.getParameter("vnp_BankCode")%></label>
                    </div> 
                    <div class="form-group">
                        <label>Payment Time:</label>
                        <label><%=request.getParameter("vnp_PayDate")%></label>
                    </div> 
                    <div class="form-group">
                        <label>Transaction Status:</label>
                        <label>
                            <%
                                if (signValue.equals(vnp_SecureHash)) {
                                    if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                        out.print("Successful");
                                    } else {
                                        out.print("Not successful");
                                    }
                                } else {
                                    out.print("Invalid signature");
                                }
                            %>
                        </label>
                    </div> 
                </div>
            </div>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>

        <!-- AD BLOG -->
        <img style="width: 100%" src="./assets/img/adblog.svg" alt="" class="blog-ad" />
        <%@ include file="/include/footer.jsp" %>
    </body>
</html>
