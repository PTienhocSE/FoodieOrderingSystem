package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.vnpay.common.Config;
import context.AccountDAO;
import context.OrderDAO;
import context.RefundDAO;
import context.RewardRedemptionDAO;
import context.ShopDAO;
import context.VNPayBillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;
import java.util.TimeZone;
import model.Order;
import model.Refund;
import model.VNPay_Bill;
import util.Email;
import util.Json;
import util.Utility;

@WebServlet(name = "RefundServlet", urlPatterns = {"/refund"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class RefundServlet extends HttpServlet {

    private static final String SAVE_DIR = "refundReasonImg";
    OrderDAO orderDAO = new OrderDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RefundServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RefundServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse response)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        // Check if action parameter is null or empty
        if (action == null || action.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
            return;
        }

        // Log the action received for debugging
        System.out.println("Received action: " + action);

        switch (action) {
            case "refundCancelOrder":
                RefundCancelOrder(req, response);
                break;
            case "refundHandler":
                RefundHandle(req, response);
                break;
            case "refundRequest":
                RefundRequest(req, response);
                break;
            case "refundPointHandler":
                handleRefundPoints(req, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void RefundRequest(HttpServletRequest req, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderID = Integer.parseInt(req.getParameter("orderId"));
            String refundReason = req.getParameter("refundReason");
            String refundOption = req.getParameter("refundOption");
            Part filePart = req.getPart("refundReasonImg");

            if (refundOption == null) {
                req.getSession().setAttribute("alertMessage", "Please select a refund option.");
                response.sendRedirect("/OrderingSystem/order-history");
                return;
            }

            Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", "dvyu4f7lq",
                    "api_key", "197794349217857",
                    "api_secret", "ZChTJNQesSSMQlZiw5VAusDuomA"));

            // Handle image file upload to Cloudinary
            String imageUrl = null;
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileStream = filePart.getInputStream();
                byte[] fileBytes = fileStream.readAllBytes();

                Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.emptyMap());

                imageUrl = (String) uploadResult.get("url");
            }

            RefundDAO refundDAO = new RefundDAO();
            int refundType = refundOption.equals("points") ? 1 : 2;
            Refund refund = new Refund(orderID, refundReason, BigDecimal.ZERO, "PENDING", imageUrl, refundType);
            refundDAO.addRefundRequest(refund);

            OrderDAO orderDAO = new OrderDAO();
            String paymentID = orderDAO.getPaymentIDByOrderID(orderID);
            orderDAO.updateRefundStatus(paymentID, 2);

            String email = orderDAO.getEmailByOrderID(orderID);
            String content = "Refund request submitted successfully. We will review your Refund Application. Please wait 1-2 days for the result.\nStore Address: " + Utility.getShopAddressByOrderID(orderID);
            Email.sendEmailNotifying(email, content);

            req.getSession().setAttribute("alertMessage", "Refund request submitted successfully. We will review your Refund Application. Please wait 1-2 days for the result.\n --FOODIE--");
            response.sendRedirect("/OrderingSystem/order-history");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while processing refund request.");
        }
    }

//        if (refundStatus == 1) {
//            out.print("APPROVED");
//        } else if (refundStatus == 2) {
//            out.print("PENDING");
//        } else if (refundStatus == 3) {
//            out.print("REJECTED");
    private void RefundCancelOrder(HttpServletRequest req, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderID = Integer.parseInt(req.getParameter("orderId"));

            OrderDAO orderDAO = new OrderDAO();
            VNPayBillDAO vnpaybillDAO = new VNPayBillDAO();
            String paymentID = orderDAO.getPaymentIDByOrderID(orderID);
            VNPay_Bill bill = vnpaybillDAO.getBill(paymentID);

            String vnp_RequestId = Config.getRandomNumber(8);
            String vnp_Version = "2.1.0";
            String vnp_Command = "refund";
            String vnp_TmnCode = Config.vnp_TmnCode;
            String vnp_TransactionType = "02";
            String vnp_TxnRef = String.valueOf(bill.getVnpTxnRef());
            String vnp_Amount = String.valueOf((int) bill.getVnpAmount());
            String vnp_OrderInfo = "Refund transaction Foodie OrderID :" + orderID;
            String vnp_TransactionNo = "";
            String vnp_TransactionDate = bill.getVnpPayDate();
            String vnp_CreateBy = "Tran Phuc Tien";

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());

            String vnp_IpAddr = Config.getIpAddress(req);

            JsonObject vnp_Params = new JsonObject();
            vnp_Params.addProperty("vnp_RequestId", vnp_RequestId);
            vnp_Params.addProperty("vnp_Version", vnp_Version);
            vnp_Params.addProperty("vnp_Command", vnp_Command);
            vnp_Params.addProperty("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.addProperty("vnp_TransactionType", vnp_TransactionType);
            vnp_Params.addProperty("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.addProperty("vnp_Amount", vnp_Amount);
            vnp_Params.addProperty("vnp_OrderInfo", vnp_OrderInfo);
            if (vnp_TransactionNo != null && !vnp_TransactionNo.isEmpty()) {
                vnp_Params.addProperty("vnp_TransactionNo", vnp_TransactionNo);
            }
            vnp_Params.addProperty("vnp_TransactionDate", vnp_TransactionDate);
            vnp_Params.addProperty("vnp_CreateBy", vnp_CreateBy);
            vnp_Params.addProperty("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.addProperty("vnp_IpAddr", vnp_IpAddr);

            String hash_Data = String.join("|", vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode,
                    vnp_TransactionType, vnp_TxnRef, vnp_Amount, vnp_TransactionNo, vnp_TransactionDate,
                    vnp_CreateBy, vnp_CreateDate, vnp_IpAddr, vnp_OrderInfo);
            String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hash_Data);
            vnp_Params.addProperty("vnp_SecureHash", vnp_SecureHash);

            URL url = new URL(Config.vnp_ApiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);

            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.writeBytes(vnp_Params.toString());
                wr.flush();
            }

            int responseCode = con.getResponseCode();
            System.out.println("Sending 'POST' request to URL: " + url);
            System.out.println("Post Data: " + vnp_Params);
            System.out.println("Response Code: " + responseCode);

            StringBuilder responseContent = new StringBuilder();
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                String output;
                while ((output = in.readLine()) != null) {
                    responseContent.append(output);
                }
            }

            System.out.println("Response Content: " + responseContent.toString());
            // Update refund Status
            orderDAO.updateRefundStatus(paymentID, 1);

            response.setContentType("application/json");
            response.getWriter().write(responseContent.toString());

            Json Json = new Json();

            String vnp_Amount_Response = Json.getValueOfParamInJsonString(responseContent.toString(), "vnp_Amount");

            RefundDAO refundDAO = new RefundDAO();
            Refund refund = new Refund(orderID, "Refund Cancel Order", new BigDecimal(vnp_Amount_Response), "APPROVED");

            refundDAO.addRefund(refund);

            String email = orderDAO.getEmailByOrderID(orderID);
            String content = "Refund submitted successfully. Please allow 1-2 business days for the funds to be returned to your payment account.";
            Email.sendEmailNotifying(email, content);

            int shopID = orderDAO.getShopIDByPaymentID(paymentID);
            ShopDAO shopDAO = new ShopDAO();

            boolean success = shopDAO.updateShopWallet(shopID, (-Float.parseFloat(vnp_Amount)) / 100);

            if (success) {
                System.out.println("Shop wallet updated successfully for shopId: " + shopID);
            } else {
                System.out.println("Failed to update shop wallet for shopId: " + shopID);
            }

            response.sendRedirect("/OrderingSystem/order-history");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred during the refund process");
        }
    }

    private void RefundHandle(HttpServletRequest req, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        String refundID = req.getParameter("refundId");
        AccountDAO aDAO = new AccountDAO();
        Order order = new Order();

        try {
            String paymentID = req.getParameter("paymentID");
            int orderID = orderDAO.getOrderIDByPaymentID(paymentID);

            String vnp_RequestId = Config.getRandomNumber(8);
            String vnp_Version = "2.1.0";
            String vnp_Command = "refund";
            String vnp_TmnCode = Config.vnp_TmnCode;
            String vnp_TransactionType = req.getParameter("trantype");
            String vnp_TxnRef = paymentID;
            long amount = Integer.parseInt(req.getParameter("amount"));
            String vnp_Amount = String.valueOf(amount);
            String vnp_OrderInfo = "Refund transaction Foodie OrderID :" + orderID;
            String vnp_TransactionNo = "";
            String vnp_TransactionDate = req.getParameter("trans_date");
            String vnp_CreateBy = req.getParameter("user");

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());

            String vnp_IpAddr = Config.getIpAddress(req);

            JsonObject vnp_Params = new JsonObject();
            vnp_Params.addProperty("vnp_RequestId", vnp_RequestId);
            vnp_Params.addProperty("vnp_Version", vnp_Version);
            vnp_Params.addProperty("vnp_Command", vnp_Command);
            vnp_Params.addProperty("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.addProperty("vnp_TransactionType", vnp_TransactionType);
            vnp_Params.addProperty("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.addProperty("vnp_Amount", vnp_Amount);
            vnp_Params.addProperty("vnp_OrderInfo", vnp_OrderInfo);
            if (vnp_TransactionNo != null && !vnp_TransactionNo.isEmpty()) {
                vnp_Params.addProperty("vnp_TransactionNo", vnp_TransactionNo);
            }
            vnp_Params.addProperty("vnp_TransactionDate", vnp_TransactionDate);
            vnp_Params.addProperty("vnp_CreateBy", vnp_CreateBy);
            vnp_Params.addProperty("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.addProperty("vnp_IpAddr", vnp_IpAddr);

            String hash_Data = String.join("|", vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode,
                    vnp_TransactionType, vnp_TxnRef, vnp_Amount, vnp_TransactionNo, vnp_TransactionDate,
                    vnp_CreateBy, vnp_CreateDate, vnp_IpAddr, vnp_OrderInfo);
            String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hash_Data);
            vnp_Params.addProperty("vnp_SecureHash", vnp_SecureHash);

            URL url = new URL(Config.vnp_ApiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);

            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.writeBytes(vnp_Params.toString());
                wr.flush();
            }

            int responseCode = con.getResponseCode();
            System.out.println("Sending 'POST' request to URL: " + url);
            System.out.println("Post Data: " + vnp_Params);
            System.out.println("Response Code: " + responseCode);

            StringBuilder responseContent = new StringBuilder();
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                String output;
                while ((output = in.readLine()) != null) {
                    responseContent.append(output);
                }
            }

            System.out.println("Response Content: " + responseContent.toString());
            orderDAO.updateRefundStatus(paymentID, 1);

            response.setContentType("application/json");
            response.getWriter().write(responseContent.toString());

            Json Json = new Json();

            String vnp_ResponseCode = Json.getValueOfParamInJsonString(responseContent.toString(), "vnp_ResponseCode");

            if (vnp_ResponseCode.equals("00")) {
                RefundDAO refundDAO = new RefundDAO();
                refundDAO.updateRefundStatusAndAmount(Integer.parseInt(refundID), "APPROVED", vnp_Amount);
                String email = orderDAO.getEmailByOrderID(orderID);
                String content = "We have reviewed your refund request, and we are pleased to inform you that it has been approved. Please allow 1-2 business days for the funds to be returned to your payment account.\nRefund Amount: " + vnp_Amount;
                Email.sendEmailNotifying(email, content);

                int shopID = orderDAO.getShopIDByPaymentID(paymentID);
                ShopDAO shopDAO = new ShopDAO();

                boolean success = shopDAO.updateShopWallet(shopID, (-Float.parseFloat(vnp_Amount)) / 100);
                
                if (success) {
                    System.out.println("Shop wallet updated successfully for shopId: " + shopID);
                } else {
                    System.out.println("Failed to update shop wallet for shopId: " + shopID);
                }
                response.sendRedirect("/OrderingSystem/refundManage");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred during the refund process");
        }
    }

    private void handleRefundPoints(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RefundDAO refundDAO = new RefundDAO();
        OrderDAO orderDAO = new OrderDAO();
        AccountDAO accountDAO = new AccountDAO();
        RewardRedemptionDAO rwDAO = new RewardRedemptionDAO();

        String refundID = request.getParameter("refundId");
        double pointsToRefund = Double.parseDouble(request.getParameter("pointsToRefund"));
        int pointsToRefundInt = (int) pointsToRefund;
        int orderID;
        try {
            orderID = refundDAO.getOrderIdByRefundId(Integer.parseInt(refundID));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid refund ID");
            return;
        }
        int userID = orderDAO.getUserIDByOrderID(orderID);

        try {
            boolean success = rwDAO.updatePoints(userID, pointsToRefundInt);
            if (success) {
                refundDAO.updateRefundStatusAndAmount(Integer.parseInt(refundID), "APPROVED", String.valueOf(pointsToRefund));

                String email = orderDAO.getEmailByOrderID(orderID);
                String content = "We have processed your refund of " + pointsToRefund + " points.";
                Email.sendEmailNotifying(email, content);

                response.sendRedirect("/OrderingSystem/refundManage");
            } else {
                request.setAttribute("errorMessage", "Failed to update points.");
                request.getRequestDispatcher("WEB-INF/view/refundDetails.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the refund.");
        }
    }

    @Override
    public String getServletInfo() {
        return "RefundServlet handles refund requests to VNPay.";
    }
}
