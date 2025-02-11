package controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Encrypt the password using SHA-256
        String encryptedPassword = hashPassword(password);

        Connection conn = null;
        PreparedStatement stmt = null;
        String errorMessage = null;

        try {
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/SeniorCareDD", "app", "app");

            String sql = "INSERT INTO seniors (senior_name, senior_contact, senior_email, senior_age, senior_gender, senior_username, senior_password) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, phone);
            stmt.setString(3, email);
            stmt.setInt(4, age);
            stmt.setString(5, gender);
            stmt.setString(6, username);
            stmt.setString(7, encryptedPassword); // Store hashed password

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("register.jsp?message=Registration%20successful!");
            } else {
                errorMessage = "An error occurred while registering.";
                response.sendRedirect("register.jsp?error=" + errorMessage);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            errorMessage = "Database error: " + e.getMessage();
            response.sendRedirect("register.jsp?error=" + errorMessage);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Function to hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
