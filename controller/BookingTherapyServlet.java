package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookingTherapyServlet")
public class BookingTherapyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            try {
                int bookingtId = Integer.parseInt(request.getParameter("bookingt_id"));
                // Call method to delete the booking from the database
                deleteBooking(bookingtId);

                // Get the username from session
                String username = (String) request.getSession().getAttribute("username");
                if (username != null) {
                    // Redirect user back to their booking history after deletion
                    response.sendRedirect("UserHistoryTherapyList.jsp?username=" + username);
                } else {
                    // If no session username, redirect to login
                    response.sendRedirect("login.jsp");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID format");
            }
        }
    }

    private void deleteBooking(int bookingId) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            // Establish connection to the database
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/SeniorCareDD", "app", "app");

            // SQL query to delete booking from the database
            String sql = "DELETE FROM BOOKINGT WHERE BOOKINGT_ID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);

            // Execute the deletion query
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log SQL error for debugging
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace(); // Close resources safely
            }
        }
    }

    // Removed unnecessary duplicate methods from the template
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    public String getServletInfo() {
        return "Handles booking actions such as deleting bookings";
    }
    // </editor-fold>
}
