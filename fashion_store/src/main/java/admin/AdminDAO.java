/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import product.ProductDTO;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class AdminDAO {
    public List<ProductDTO> getAllProducts() {
        List<ProductDTO> products = new ArrayList<>();
        String sql = "SELECT * FROM products";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(new ProductDTO(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getDouble("price"),
                        rs.getString("color"),
                        rs.getString("img"),
                        rs.getString("description"),
                        rs.getInt("categoryID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Thêm sản phẩm mới
    public boolean addProduct(ProductDTO product) {
        Connection conn = DBUtils.getConnection();
        String sql = "INSERT INTO products (productName, price, color, img, description, categoryID) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getProductName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getColor());
            ps.setString(4, product.getImg());
            ps.setString(5, product.getDescription());
            ps.setInt(6, product.getCategoryID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa sản phẩm theo ID
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE productID = ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(ProductDTO product) {
        String sql = "UPDATE products SET productName=?, price=?, color = ?, img=?, description=?, categoryID=? WHERE productID=?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, product.getProductName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getColor());
            ps.setString(4, product.getImg());
            ps.setString(5, product.getDescription());
            ps.setInt(6, product.getCategoryID());
            ps.setInt(7, product.getProductID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy sản phẩm theo ID
    public ProductDTO getProductById(int id) {
        Connection conn = DBUtils.getConnection();
        String sql = "SELECT * FROM products WHERE productID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ProductDTO(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getDouble("price"),
                        rs.getString("color"),
                        rs.getString("img"),
                        rs.getString("description"),
                        rs.getInt("categoryID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
