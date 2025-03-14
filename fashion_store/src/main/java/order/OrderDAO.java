/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package order;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import orderDetails.OrderDetailsDTO;
import product.CartItem;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class OrderDAO {
    public int saveOrder(OrderDTO order, List<CartItem> cart) {
    int orderID = -1;
    String sql = "insert into orders(userID,orderDate,address,status,totalPrice) VALUES (?, ?, ?, ?, ?)";

    double totalPrice = 0;
    for (CartItem item : cart) {
        totalPrice += item.getProduct().getPrice() * item.getQuantity();
    }
    order.setTotalPrice(totalPrice); 

    try (Connection conn = DBUtils.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

        pstmt.setInt(1, order.getUserID());
        pstmt.setDate(2, order.getOrderDate());
        pstmt.setString(3, order.getAddress());
        pstmt.setString(4, order.getStatus());
        pstmt.setDouble(5, order.getTotalPrice()); 

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
        } 
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return orderID;
}

    public boolean saveOrderDetails(int orderID, List<CartItem> cart) {
        String sql = "insert into order_detail(orderID,productID,quantity,price,sizeID) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            for (CartItem item : cart) {
                pstmt.setInt(1, orderID);
                pstmt.setInt(2, item.getProduct().getProductID());
                pstmt.setInt(3, item.getQuantity());
                pstmt.setDouble(4, item.getProduct().getPrice());
                pstmt.setInt(5, item.getSize().getSizeID());
                pstmt.addBatch();
            }
            int[] rows = pstmt.executeBatch();
            return rows.length > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<OrderDTO> getOrdersByUser(int userID) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userID = ? ORDER BY orderDate DESC";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderID(rs.getInt("orderID"));
                order.setOrderDate(rs.getDate("orderDate"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setAddress(rs.getString("address"));
                order.setStatus(rs.getString("status"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<OrderDetailsDTO> getOrderDetails(int orderID) {
        List<OrderDetailsDTO> list = new ArrayList<>();
        String sql = "select od.orderDetailID,od.quantity,od.price,od.subtotal,od.orderID,od.productID,s.sizeID,s.sizeName\n"
                + "from order_detail od\n"
                + "join sizes s on od.sizeID = s.sizeID\n"
                + "where od.orderID = ?";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetailsDTO detail = new OrderDetailsDTO();
                detail.setOrderDetailID(rs.getInt("orderDetailID"));
                detail.setOrderID(rs.getInt("orderID"));
                detail.setProductID(rs.getInt("productID"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));
                detail.setSizeID(rs.getInt("sizeID"));
                detail.setSizeName(rs.getString("sizeName")); 
                list.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
