package dao;

import bean.TherapyBean;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TherapyDao {

    // Add Therapy
    public static boolean addTherapy(TherapyBean therapy) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO Therapy (therapy_id, therapy_package, therapy_price, therapy_picture) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, therapy.getTherapyId()); // Changed from setInt to setString
            stmt.setString(2, therapy.getTherapyPackage());
            stmt.setDouble(3, therapy.getTherapyPrice());
            stmt.setString(4, therapy.getTherapyPicture());

            int rowsInserted = stmt.executeUpdate();
            status = rowsInserted > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Fetch all therapy records
    public static List<TherapyBean> getAllTherapies() {
        List<TherapyBean> therapyList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Therapy";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                TherapyBean therapy = new TherapyBean();
                therapy.setTherapyId(rs.getString("therapy_id"));
                therapy.setTherapyPackage(rs.getString("therapy_package"));
                therapy.setTherapyPrice(rs.getDouble("therapy_price"));
                therapy.setTherapyPicture(rs.getString("therapy_picture"));

                therapyList.add(therapy);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return therapyList;
    }

    // Delete therapy by ID
    public static boolean deleteTherapy(String therapyId) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM Therapy WHERE therapy_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, therapyId);

            int rowsDeleted = stmt.executeUpdate();
            status = rowsDeleted > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static boolean updateTherapy(String therapyId, String therapyPackage, double therapyPrice, String therapyPicture) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql;

            if (therapyPicture != null) {
                sql = "UPDATE Therapy SET therapy_package=?, therapy_price=?, therapy_picture=? WHERE therapy_id=?";
            } else {
                sql = "UPDATE Therapy SET therapy_package=?, therapy_price=? WHERE therapy_id=?";
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, therapyPackage);
            stmt.setDouble(2, therapyPrice);

            if (therapyPicture != null) {
                stmt.setString(3, therapyPicture);
                stmt.setString(4, therapyId);
            } else {
                stmt.setString(3, therapyId);
            }

            int rowsUpdated = stmt.executeUpdate();
            status = rowsUpdated > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static TherapyBean getTherapyById(String therapyId) {
        TherapyBean therapy = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Therapy WHERE therapy_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, therapyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                therapy = new TherapyBean();
                therapy.setTherapyId(rs.getString("therapy_id"));
                therapy.setTherapyPackage(rs.getString("therapy_package"));
                therapy.setTherapyPrice(rs.getDouble("therapy_price"));
                therapy.setTherapyPicture(rs.getString("therapy_picture"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return therapy;
    }

}