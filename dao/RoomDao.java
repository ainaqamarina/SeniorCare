package dao;

import bean.RoomBean;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDao {

//    Add Room
    public static boolean addRoom(RoomBean room) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO Room (room_id, room_package, room_price, room_picture) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, room.getRoomId()); // Changed from setInt to setString
            stmt.setString(2, room.getRoomPackage());
            stmt.setDouble(3, room.getRoomPrice());
            stmt.setString(4, room.getRoomPicture());

            int rowsInserted = stmt.executeUpdate();
            status = rowsInserted > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Fetch all room records
    public static List<RoomBean> getAllRooms() {
        List<RoomBean> roomList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Room";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                RoomBean room = new RoomBean();
                room.setRoomId(rs.getString("room_id"));
                room.setRoomPackage(rs.getString("room_package"));
                room.setRoomPrice(rs.getDouble("room_price"));
                room.setRoomPicture(rs.getString("room_picture"));

                roomList.add(room);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roomList;
    }

    // Delete room by ID
    public static boolean deleteRoom(String roomId) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM Room WHERE room_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomId);

            int rowsDeleted = stmt.executeUpdate();
            status = rowsDeleted > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static boolean updateRoom(String roomId, String roomPackage, double roomPrice, String roomPicture) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql;

            if (roomPicture != null) {
                sql = "UPDATE Room SET room_package=?, room_price=?, room_picture=? WHERE room_id=?";
            } else {
                sql = "UPDATE Room SET room_package=?, room_price=? WHERE room_id=?";
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomPackage);
            stmt.setDouble(2, roomPrice);

            if (roomPicture != null) {
                stmt.setString(3, roomPicture);
                stmt.setString(4, roomId);
            } else {
                stmt.setString(3, roomId);
            }

            int rowsUpdated = stmt.executeUpdate();
            status = rowsUpdated > 0;

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static RoomBean getRoomById(String roomId) {
        RoomBean room = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Room WHERE room_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                room = new RoomBean();
                room.setRoomId(rs.getString("room_id"));
                room.setRoomPackage(rs.getString("room_package"));
                room.setRoomPrice(rs.getDouble("room_price"));
                room.setRoomPicture(rs.getString("room_picture"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return room;
    }

}
