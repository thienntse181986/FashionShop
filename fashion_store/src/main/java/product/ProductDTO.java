/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

/**
 *
 * @author ADMIN
 */
public class ProductDTO {
    private int productID;
    private String productName;
    private double price;
    private String color;
    private String img;
    private String description;
    private int categoryID;

    public ProductDTO() {
    }

    public ProductDTO(int productID, String productName, double price, String color, String img, String description, int categoryID) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.color = color;
        this.img = img;
        this.description = description;
        this.categoryID = categoryID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public String toString() {
        return "ProductDTO{" + "productID=" + productID + ", productName=" + productName + ", price=" + price + ", color=" + color + ", img=" + img + ", description=" + description + ", categoryID=" + categoryID + '}';
    } 
}
