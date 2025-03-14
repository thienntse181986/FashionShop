/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package discount;

/**
 *
 * @author ADMIN
 */
public class DiscountDTO {
    private int discountID;
    private String code;
    private double discountValue;
    private String status;
    private boolean used;

    public DiscountDTO() {
    }

    public DiscountDTO(int discountID, String code, double discountValue, String status, boolean used) {
        this.discountID = discountID;
        this.code = code;
        this.discountValue = discountValue;
        this.status = status;
        this.used = used;
    }

    public int getDiscountID() {
        return discountID;
    }

    public void setDiscountID(int discountID) {
        this.discountID = discountID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    @Override
    public String toString() {
        return "DiscountDTO{" + "discountID=" + discountID + ", code=" + code + ", discountValue=" + discountValue + ", status=" + status + ", used=" + used + '}';
    }
    
}
