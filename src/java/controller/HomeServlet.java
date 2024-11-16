/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import context.CategoryDAO;
import context.ProductDAO;
import context.ProductImageDAO;
import context.ShopDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.CategoryDTO;
import model.Product;
import model.ProductDTO;
import model.ProductImage;
import model.Shop;
import model.ShopDTO;

/**
 *
 * @author LENOVO
 */
public class HomeServlet extends HttpServlet {

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

        CategoryDAO cateDAO = new CategoryDAO();
        List<Category> categories = cateDAO.getAllCategories();
        List<CategoryDTO> cateList = new ArrayList<>();
        ProductDAO pDAO = new ProductDAO();
        ProductImageDAO pid = new ProductImageDAO();
        for (Category cate : categories) {
            Product p = pDAO.getProductByCategoryID(cate.getCategoryID()).getFirst();
            CategoryDTO cateDTO = new CategoryDTO(cate, pid.getAvatarProductImageByID(p.getProductId()).getImgURL());
            cateList.add(cateDTO);
        }

        ShopDAO shopdao = new ShopDAO();
        ProductDAO pdao = new ProductDAO();
        List<Shop> shoplist = shopdao.getAllRestaurants();
        List<ShopDTO> shopdtolist = new ArrayList<>();
        for (Shop s : shoplist) {
            float totalRating = 0;
            float avgRating = 0;
            List<Product> plist = pdao.getProductByShopID(s.getShopID());
            if (!plist.isEmpty()) {
                int productCount = plist.size();
                for (Product p : plist) {
                    totalRating += p.getRating();
                }
                avgRating = totalRating / productCount;
            }
            if(avgRating >= 0){
                if(shopdtolist.size() < 4){
                    shopdtolist.add(new ShopDTO(s.getShopID(),s.getName(),s.getDescription(),s.getStatus(), 
                        s.getShopImage(), s.getAddress(), s.getTimeOpen(), s.getTimeClose(), (int)avgRating));
                }
            }
        }
        List<Product> plist = pdao.getAllProducts();
        List<ProductDTO> pdtolist = new ArrayList<>();
        ProductImageDAO iDAO = new ProductImageDAO();
        for(Product p : plist){
            ProductImage pimg = iDAO.getAvatarProductImageByID(p.getProductId());
            Shop shop = shopdao.getRestaurantByID(p.getShopId());
            String cate = cateDAO.getCategoryNameByID(p.getCategoryId());
            if(p.getRating() >= 0){
                if(pdtolist.size() < 6){
                pdtolist.add(new ProductDTO(pimg.getImgURL(),p.getProductId(),p.getName(),p.getDescription(),
                p.getPrice(),p.isStatus(),shop.getName(),cate,p.getPurchaseCount(),p.getRating()));
                }
            }
        }
        request.setAttribute("cateList", cateList);
        request.setAttribute("pdtolist", pdtolist);
        request.setAttribute("shopdtolist", shopdtolist);
        request.getRequestDispatcher("WEB-INF/view/home.jsp").forward(request, response);
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
        processRequest(request, response);
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
