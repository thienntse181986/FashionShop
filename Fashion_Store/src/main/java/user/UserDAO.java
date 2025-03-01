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
        try {
            Connection con = utils.DBUtils.getConnection();
            String sql = " SELECT username, fullName FROM users ";
            sql += " WHERE username = ?  AND password = ?";

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

}
