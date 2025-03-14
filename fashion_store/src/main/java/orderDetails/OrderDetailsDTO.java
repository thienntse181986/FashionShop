/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package orderDetails;

/**
 *
 * @author ADMIN
 */
public class OrderDetailsDTO {
    private int orderDetailID;
    private int quantity;
    private double price;    
    private double subtotal;
    private int orderID;
    private int productID;
    private int sizeID;
    private String sizeName;

    public OrderDetailsDTO() {
    }

    public OrderDetailsDTO(int orderDetailID, int quantity, double price, double subtotal, int orderID, int productID, int sizeID, String sizeName) {
        this.orderDetailID = orderDetailID;
        this.quantity = quantity;
        this.price = price;
        this.subtotal = subtotal;
        this.orderID = orderID;
        this.productID = productID;
        this.sizeID = sizeID;
        this.sizeName = sizeName;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    @Override
    public String toString() {
        return "OrderDetailsDTO{" + "orderDetailID=" + orderDetailID + ", quantity=" + quantity + ", price=" + price + ", subtotal=" + subtotal + ", orderID=" + orderID + ", productID=" + productID + ", sizeID=" + sizeID + '}';
    } 
}
