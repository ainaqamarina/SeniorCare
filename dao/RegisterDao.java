package dao;

import bean.RegisterBean;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterDao {

    public boolean registerUser(RegisterBean registerBean) {
        boolean isRegistered = false;
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("Error: Database connection failed!");
                return false;
            }
            System.out.println("Database connected successfully.");

            String sql = "INSERT INTO seniors (senior_username, senior_name, senior_email, senior_password, senior_contact, senior_gender, senior_age) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Setting parameters
            stmt.setString(1, registerBean.getUsername());
            stmt.setString(2, registerBean.getFullname());
            stmt.setString(3, registerBean.getEmail());
            stmt.setString(4, registerBean.getPassword());
            stmt.setString(5, registerBean.getPhone());
            stmt.setString(6, registerBean.getGender());
            stmt.setInt(7, registerBean.getAge());

            // Print SQL query for debugging
            System.out.println("Executing SQL: " + sql);
            System.out.println("Username: " + registerBean.getUsername());
            System.out.println("Fullname: " + registerBean.getFullname());
            System.out.println("Email: " + registerBean.getEmail());
            System.out.println("Password: " + registerBean.getPassword());
            System.out.println("Phone: " + registerBean.getPhone());
            System.out.println("Gender: " + registerBean.getGender());
            System.out.println("Age: " + registerBean.getAge());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                isRegistered = true;
                System.out.println("User registered successfully!");
            } else {
                System.err.println("Failed to insert user.");
            }

        } catch (SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isRegistered;
    }

}
