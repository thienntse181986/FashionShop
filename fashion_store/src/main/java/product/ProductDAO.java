/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class ProductDAO {

    public List<ProductDTO> list() {
        List<ProductDTO> list = new ArrayList<>();

        String sql = "select productID,productName,price,color,img,description from products";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement pr = con.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getDouble("price"));
                product.setColor(rs.getString("color"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                list.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public ProductDTO load(int productID) {
        String sql = "select productID, productName, price, color, img, description from products where productID = ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement pr = con.prepareStatement(sql);
            pr.setInt(1, productID);
            ResultSet rs = pr.executeQuery();
            if (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getDouble("price"));
                product.setColor(rs.getString("color"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<SizeDTO> getSizesByProductID(int productID) {
        List<SizeDTO> list = new ArrayList<>();
        String sql = "SELECT s.sizeID, s.sizeName FROM size s "
                + "INNER JOIN product_size ps ON s.sizeID = ps.sizeID "
                + "WHERE ps.productID = ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new SizeDTO(rs.getInt("sizeID"), rs.getString("sizeName")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> getProductsByCategoryID(int categoryID) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE categoryID = ?";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement pr = con.prepareStatement(sql);

            pr.setInt(1, categoryID);
            ResultSet rs = pr.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getDouble("price"));
                product.setColor(rs.getString("color"));
                product.setImg(rs.getString("img"));
                product.setDescription(rs.getString("description"));
                list.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public SizeDTO getSizeByID(int sizeID) {
        String sql = "SELECT sizeID, sizeName FROM sizes WHERE sizeID = ?";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sizeID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new SizeDTO(rs.getInt("sizeID"), rs.getString("sizeName"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateProductQuantity(int productID, int sizeID, int quantitySold) {
        String sql = "UPDATE product_sizes SET quantity = quantity - ? WHERE productID = ? AND sizeID = ? AND quantity >= ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantitySold);
            ps.setInt(2, productID);
            ps.setInt(3, sizeID);
            ps.setInt(4, quantitySold);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
