/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import category.CategoryDAO;
import category.CategoryDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import product.CartItem;
import product.ProductDAO;
import product.ProductDTO;
import product.SizeDTO;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

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
        String action = request.getParameter("action");
        ProductDAO daoProduct = new ProductDAO();
        HttpSession session = request.getSession();
        
        //Lưu thông tin vào giỏ hàng 
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if (action == null) {
            String categoryIDSTR = request.getParameter("categoryID");
            int categoryID = 1; 

            if (categoryIDSTR != null) {
                categoryID = Integer.parseInt(categoryIDSTR);
            }

            ProductDAO dao = new ProductDAO();
            List<ProductDTO> list = dao.getProductsByCategoryID(categoryID); 



            List<CategoryDTO> ca = (List<CategoryDTO>) session.getAttribute("ca");
            if (ca == null) {
                CategoryDAO caDAO = new CategoryDAO();
                ca = caDAO.getCategory(); 
                session.setAttribute("ca", ca); 
            }

            String categoryName = "";
            for (CategoryDTO c : ca) {
                if (c.getCategoryID() == categoryID) {
                    categoryName = c.getCategoryName();
                    break;
                }
            }

            request.setAttribute("list", list);
            request.setAttribute("categoryName", categoryName);
            request.getRequestDispatcher("product.jsp").forward(request, response);
        } else if (action.equals("details")) {
            Integer productID = null;
            try {
                productID = Integer.parseInt(request.getParameter("productID"));
            } catch (NumberFormatException ex) {
                log("Parameter id has wrong format.");
            }

            if (productID != null) {
                ProductDTO product = daoProduct.load(productID);
                request.setAttribute("product", product);
                request.getRequestDispatcher("productDetails.jsp").forward(request, response);
            }
        } else if (action.equals("add")) {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String sizeProduct = request.getParameter("size");
            
            if (sizeProduct == null || sizeProduct.isEmpty()) {
                session.setAttribute("error", "Choose your size.");
                request.getRequestDispatcher("productDetails.jsp").forward(request, response);
                return;
            }            
            
            int sizeID = Integer.parseInt(request.getParameter("size"));
            

            ProductDTO product = daoProduct.load(productID);
            SizeDTO size = daoProduct.getSizeByID(sizeID);
                     

            boolean check = false;
            for (CartItem item : cart) {
                if (item.getProduct().getProductID() == productID && item.getSize().getSizeID() == sizeID) {
                    item.setQuantity(item.getQuantity() + 1); 
                    check = true;
                    break;
                }
            }

            if (!check) {
                cart.add(new CartItem(product, size, 1)); 
            }

            session.setAttribute("cart", cart);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            
        } else if (action.equals("increase") || action.equals("decrease")) {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String size = request.getParameter("size");

            for (CartItem item : cart) {
                if (item.getProduct().getProductID() == productID && item.getSize().getSizeName().equals(size)) {
                    if (action.equals("increase")) {
                        item.setQuantity(item.getQuantity() + 1);
                    } else if (action.equals("decrease") && item.getQuantity() >= 1) {
                        item.setQuantity(item.getQuantity() - 1);
                        if(item.getQuantity() == 0){
                           cart.remove(item);
                        }
                    }
                    break;
                }
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("cart.jsp");
            
        }else if (action.equals("all")) {
            List<ProductDTO> list = daoProduct.list();
            request.setAttribute("list", list);
            request.getRequestDispatcher("product.jsp").forward(request, response);
        }

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
