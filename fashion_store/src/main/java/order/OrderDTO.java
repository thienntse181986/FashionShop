/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package order;

import java.sql.Date;




/**
 *
 * @author ADMIN
 */
public class OrderDTO {
    private int orderID;
    private Date orderDate;
    private double totalPrice;
    private String address;
    private String status;
    private int userID;
    private int discountID;

    public OrderDTO() {
    }

    public OrderDTO(int orderID, Date orderDate, double totalPrice, String address, String status, int userID, int discountID) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.address = address;
        this.status = status;
        this.userID = userID;
        this.discountID = discountID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getDiscountID() {
        return discountID;
    }

    public void setDiscountID(int discountID) {
        this.discountID = discountID;
    }

    @Override
    public String toString() {
        return "OrderDTO{" + "orderID=" + orderID + ", orderDate=" + orderDate + ", totalPrice=" + totalPrice + ", address=" + address + ", status=" + status + ", userID=" + userID + ", discountID=" + discountID + '}';
    }
}
