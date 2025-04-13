package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import context.CategoryDAO;
import context.ProductDAO;
import context.ShopDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Category;
import model.Product;
import model.Shop;

/**
 *
 * @author phuct
 */
@WebServlet(urlPatterns = {"/restaurant"})
public class RestaurantServlet extends HttpServlet {

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
        request.getRequestDispatcher("WEB-INF/view/restaurant-list.jsp").forward(request, response);
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
        ShopDAO shopDAO = new ShopDAO();

        // Pagination
        int page = 1; // Khởi tạo trang mặc định là 1
        int size = 9; // Số lượng sản phẩm trên mỗi trang

        // Kiểm tra tham số 'page' từ request
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1; // Nếu có lỗi định dạng, quay về trang 1
            }
        }

        // Lấy tham số sắp xếp từ request
        String sortOption = request.getParameter("sortOption");
        List<Shop> restaurantList;

        // Lựa chọn cách sắp xếp
        if ("timeOpen".equals(sortOption)) {
            restaurantList = shopDAO.getShopsSortedByTimeOpen(page, size);
        } else if ("timeClose".equals(sortOption)) {
            restaurantList = shopDAO.getShopsSortedByTimeClose(page, size);
        } else {
            restaurantList = shopDAO.getShops(page, size);
        }

        int totalRestaurants = shopDAO.getTotalShops();
        int totalPages = (int) Math.ceil((double) totalRestaurants / size); // Tính tổng số trang

        request.setAttribute("restaurantList", restaurantList);
        request.setAttribute("totalRestaurants", totalRestaurants);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.setAttribute("totalPages", totalPages);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/restaurant-list.jsp");
        dispatcher.forward(request, response);
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
        String keyword = request.getParameter("keyword");
        ShopDAO shopDAO = new ShopDAO();

        List<Shop> foundShops = shopDAO.searchShop(keyword); // Gọi phương thức tìm kiếm

        // Thiết lập thuộc tính để chuyển đến trang JSP
        request.setAttribute("restaurantList", foundShops);
        request.setAttribute("keyword", keyword);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/restaurant-list.jsp");
        dispatcher.forward(request, response);
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
