/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authenticate;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import context.AccountDAO;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.Map;
import model.Account;

/**
 *
 * @author LENOVO
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AccountServlet extends HttpServlet {

    
    private Cloudinary cloudinary;

    @Override
    public void init(ServletConfig config) throws ServletException {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dvyu4f7lq",
                "api_key", "197794349217857",
                "api_secret", "ZChTJNQesSSMQlZiw5VAusDuomA"));
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("WEB-INF/view/account.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("mt").equals("changeAvatar")) {
            updateAvatar(request, response);
        }

    }

    private void updateAvatar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        

        Part filePart = request.getPart("img");
        
        if (filePart != null && filePart.getSize() > 0) {
            
            InputStream fileStream = filePart.getInputStream();
            // Đọc dữ liệu từ InputStream vào một mảng byte
            byte[] fileBytes = fileStream.readAllBytes();

            Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.emptyMap());

            String imageUrl = (String) uploadResult.get("url");
            int userID = Integer.parseInt(request.getParameter("userID"));
            AccountDAO userDAO = new AccountDAO();
            Account account = userDAO.getUserById(userID);
            account.setAvtImg(imageUrl);
            userDAO.changeAvatarByUserID(account);

            HttpSession session = request.getSession();
            session.setAttribute("user", account);
        }
        response.sendRedirect("account");

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
