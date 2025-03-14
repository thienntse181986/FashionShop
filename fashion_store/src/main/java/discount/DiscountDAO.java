/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package discount;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class DiscountDAO {

    public DiscountDTO getDiscountCode(String code) {
        String sql = "select * from discount where code = ?";
        try {
            DiscountDTO dis = new DiscountDTO();
            Connection con = DBUtils.getConnection();
            PreparedStatement pr = con.prepareStatement(sql);
            pr.setString(1, code);
            ResultSet rs = pr.executeQuery();
            if (rs.next()) {
                
                dis.setDiscountID(rs.getInt("discountID"));
                dis.setCode(rs.getString("code"));
                dis.setDiscountValue(rs.getDouble("discountValue"));
                dis.setUsed(rs.getBoolean("used"));
               
            }
            con.close();
             return dis;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUseDiscount(int discountID) {
        String sql = "update discount set used = 1 where discountID = ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement pr = con.prepareStatement(sql);
            pr.setInt(1, discountID);
            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } 
}
