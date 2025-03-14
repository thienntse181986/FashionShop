/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import java.io.Serializable;

/**
 *
 * @author ADMIN
 */
public class CartItem implements Serializable{
   private ProductDTO product;
   private SizeDTO size;
   private int Quantity;

    public CartItem() {
    }

    public CartItem(ProductDTO product, SizeDTO size, int Quantity) {
        this.product = product;
        this.size = size;
        this.Quantity = Quantity;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public SizeDTO getSize() {
        return size;
    }

    public void setSize(SizeDTO size) {
        this.size = size;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    @Override
    public String toString() {
        return "CartItem{" + "product=" + product + ", size=" + size + ", Quantity=" + Quantity + '}';
    }
  
}
