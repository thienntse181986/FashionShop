/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import product.ProductDTO;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class CategoryDAO {
    public List<CategoryDTO> getCategory(){
        List<CategoryDTO> list = new ArrayList<>();
         
        String sql = "select * from category";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement pr = con.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();
            while(rs.next()) {
                CategoryDTO ca = new CategoryDTO();
                ca.setCategoryID(rs.getInt("categoryID"));
                ca.setCategoryName(rs.getString("categoryName"));
                list.add(ca);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }           
}
