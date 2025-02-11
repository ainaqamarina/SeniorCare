package bean;

public class RoomBean {

    private String roomId; // Changed from int to String
    private String roomPackage;
    private double roomPrice;
    private String roomPicture;

    public String getRoomId() { // Return type changed to String
        return roomId;
    }

    public void setRoomId(String roomId) { // Parameter type changed to String
        this.roomId = roomId;
    }

    public String getRoomPackage() {
        return roomPackage;
    }

    public void setRoomPackage(String roomPackage) {
        this.roomPackage = roomPackage;
    }

    public double getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(double roomPrice) {
        this.roomPrice = roomPrice;
    }

    public String getRoomPicture() {
        return roomPicture;
    }

    public void setRoomPicture(String roomPicture) {
        this.roomPicture = roomPicture;
    }
}
