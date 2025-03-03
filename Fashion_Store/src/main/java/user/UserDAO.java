package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class UserDAO {

    public UserDTO login(String username, String password) {
        UserDTO user = null;
        String sql = " SELECT * FROM users ";
            sql += " WHERE username = ?  AND password = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUsername(rs.getString("username"));
                    user.setFullName(rs.getString("fullName"));
                }
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();

        }
        return user;
    }
    
    
    public UserDTO checkUsername(String username) {
        UserDTO user = null;
        String sql = "select * from users where username = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
                
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUsername(rs.getString("username"));
                }
            }
            con.close();
        } catch (Exception ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return user;
    }

   public void register(String fullName, String phone, String username, String password) {
       String sql = "insert into users(username, password, fullName, phone) values (?,?,?,?) ";
       try {
           Connection con = utils.DBUtils.getConnection();
            
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, fullName);
            stmt.setString(4, phone);

            int row = stmt.executeUpdate();
            if(row > 0) {
                System.out.println("true");
            }else {
                System.out.println("false");
            }
            con.close();
       } catch (Exception e) {
           System.out.println("Error in servlet. Details:" + e.getMessage());
            e.printStackTrace();
       }
   }


}
//    public static void main(String[] args) {
//        UserDAO dao = new UserDAO();
//        String username = "thinh";
//        String password = "thinh";
//
//        UserDTO user = dao.login(username, password);
//        if (user != null) {
//            System.out.println("success " + user.getFullName());
//        } else {
//            System.out.println("fail ");
//        }
//    }