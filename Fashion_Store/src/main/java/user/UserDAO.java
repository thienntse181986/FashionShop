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
                    user.setUserID(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("fullName"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    return user;
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

    public void register(String phone, String username, String password) {
        String sql = "insert into users(username, password, phone) values (?,?,?) ";
        try {
            Connection con = utils.DBUtils.getConnection();

            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, phone);

            int row = stmt.executeUpdate();
            if (row > 0) {
                System.out.println("true");
            } else {
                System.out.println("false");
            }
            con.close();
        } catch (Exception e) {
            System.out.println("Error in servlet. Details:" + e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean updateUser(int userID, String fullName, String email, String address, String phone) {
        String sql = "UPDATE users SET fullName = ?, email = ?, phone = ?, address = ? WHERE userID = ?";
        try (Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, userID);
            int rowsUpdated = ps.executeUpdate();
            System.out.println("Số dòng bị ảnh hưởng: " + rowsUpdated);

            return rowsUpdated > 0; 
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi khi cập nhật user: " + e.getMessage());
        }
        return false;
    }

}
