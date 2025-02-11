package dao;

import bean.LoginBean;
import util.DBConnection;
import java.sql.*;
import java.security.MessageDigest;

public class LoginDao {

    public String validateAdmin(LoginBean loginBean) {
        String role = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT role FROM administrator WHERE username=? AND password=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginBean.getUsername());
            stmt.setString(2, hashPassword(loginBean.getPassword())); // Hashing the password

            rs = stmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return role;
    }

    public boolean validateSenior(LoginBean loginBean) {
        boolean isValid = false;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT senior_password FROM seniors WHERE senior_username=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, loginBean.getUsername());

            rs = stmt.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("senior_password");
                String enteredHashedPassword = hashPassword(loginBean.getPassword());

                if (storedHashedPassword.equals(enteredHashedPassword)) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt, conn);
        }
        return isValid;
    }

    // Password Hashing Method (SHA-256)
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }

            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Close resources method to prevent memory leaks
    private void closeResources(ResultSet rs, PreparedStatement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
