package controller;

import admin.AdminDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.ProductDAO;
import product.ProductDTO;

@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Xóa sản phẩm
        if ("delete".equals(action)) {
            String idStr = request.getParameter("productID");

            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("admin?error=ID không hợp lệ");
                return;
            }

            try {
                int id = Integer.parseInt(idStr);
                boolean success = adminDAO.deleteProduct(id);

                if (success) {
                    response.sendRedirect("admin?message=Xóa thành công");
                } else {
                    response.sendRedirect("admin?error=Không thể xóa sản phẩm");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("admin?error=ID không hợp lệ");
            }
            return;

        // Chỉnh sửa sản phẩm
        } else if ("edit".equals(action)) {
            String idStr = request.getParameter("productID");

            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("admin?error=ID không hợp lệ");
                return;
            }

            try {
                int id = Integer.parseInt(idStr);
                ProductDTO product = adminDAO.getProductById(id);
                if (product != null) {
                    request.setAttribute("product", product);
                } else {
                    request.setAttribute("error", "Không tìm thấy sản phẩm");
                }

                // Hiển thị lại trang với form chỉnh sửa
                List<ProductDTO> products = adminDAO.getAllProducts();
                request.setAttribute("products", products);
                request.getRequestDispatcher("ManageProduct.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("admin?error=ID không hợp lệ");
            }
        }

        // Load lại danh sách sản phẩm
        List<ProductDTO> products = adminDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("ManageProduct.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận dữ liệu tiếng Việt đúng
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String productName = request.getParameter("productName");
                String priceStr = request.getParameter("price");
                String color = request.getParameter("color");
                String img = request.getParameter("img") != null ? request.getParameter("img") : "default.jpg";
                String description = request.getParameter("description") != null ? request.getParameter("description") : "";
                String categoryIdStr = request.getParameter("categoryID");

                // Kiểm tra null hoặc rỗng trước khi parse
                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                int categoryID = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;

                // Kiểm tra xem dữ liệu có hợp lệ không
                if (productName == null || productName.trim().isEmpty()) {
                    throw new IllegalArgumentException("Tên sản phẩm không được để trống");
                }

                ProductDTO newProduct = new ProductDTO(0, productName, price, color, img, description, categoryID);
                adminDAO.addProduct(newProduct);
            } else if ("update".equals(action)) {
                String productIDStr = request.getParameter("productID");
                String productName = request.getParameter("productName");
                String priceStr = request.getParameter("price");
                String color = request.getParameter("color");
                String img = request.getParameter("img") != null ? request.getParameter("img") : "default.jpg";
                String description = request.getParameter("description") != null ? request.getParameter("description") : "";
                String categoryIdStr = request.getParameter("categoryID");

                int productID = (productIDStr != null && !productIDStr.isEmpty()) ? Integer.parseInt(productIDStr) : 0;
                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                int categoryID = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;

                ProductDTO updatedProduct = new ProductDTO(productID, productName, price, color, img, description, categoryID);
                boolean success = adminDAO.updateProduct(updatedProduct);

                if (success) {
                    request.setAttribute("message", "Cập nhật thành công");
                } else {
                    request.setAttribute("error", "Cập nhật thất bại");
                }

                // Load lại danh sách sản phẩm
                List<ProductDTO> products = adminDAO.getAllProducts();
                request.setAttribute("products", products);
                request.getRequestDispatcher("ManageProduct.jsp").forward(request, response);
            }

            response.sendRedirect("admin");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi định dạng số: " + e.getMessage());
            request.getRequestDispatcher("ManageProduct.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("ManageProduct.jsp").forward(request, response);
        }
    }

}
