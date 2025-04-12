package controller;

import context.CategoryDAO;
import context.ProductDAO;
import context.ProductImageDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Category;
import model.Product;
import model.ProductDTO;

@WebServlet(name = "FilterProductsServlet", urlPatterns = {"/filterproducts"})
public class FilterProductsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/view/food.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = null;

        try {
            boolean isConnectedCategory = categoryDAO.checkConnection();
            if (isConnectedCategory) {
                System.out.println("Connected to database.");
                categoryList = categoryDAO.getAllCategories();
            } else {
                System.out.println("Failed to connect to the database Category");
            }
        } catch (Exception ex) {
            Logger.getLogger(FilterProductsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Lấy danh mục đã chọn
        String[] categoryIdsParam = request.getParameterValues("categoryIds");
        List<Integer> categoryIds = new ArrayList<>();
        if (categoryIdsParam != null) {
            for (String categoryId : categoryIdsParam) {
                categoryIds.add(Integer.parseInt(categoryId));
            }
        }
        System.out.println("Selected Category IDs: " + categoryIds);

        // Lấy rating
        String ratingStr = request.getParameter("rating");
        double minRating = 0.0;
        if (!"None".equals(ratingStr)) {
            minRating = Double.parseDouble(ratingStr);
        }
        System.out.println("Min Rating: " + minRating);

        // Lấy sortBy
        String sortBy = request.getParameter("sortBy");
        System.out.println("Sort By: " + sortBy);

        List<Product> products = productDAO.filterProducts(categoryIds, minRating, sortBy);
        
            List<ProductDTO> productList = new ArrayList<>();
            ProductImageDAO pid= new ProductImageDAO();
            for(Product p: products){
                ProductDTO pd = new ProductDTO(p, pid.getAvatarProductImageByID(p.getProductId()).getImgURL());
                productList.add(pd);
            }
        
        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("categoryIds", categoryIds);
        request.setAttribute("minRating", minRating);
        request.setAttribute("sortBy", sortBy);
    
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/food-list.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
