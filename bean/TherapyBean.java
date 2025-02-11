package bean;

public class TherapyBean {

    private String therapyId; // Changed from int to String
    private String therapyPackage;
    private double therapyPrice;
    private String therapyPicture;

    public String getTherapyId() { // Return type changed to String
        return therapyId;
    }

    public void setTherapyId(String therapyId) { // Parameter type changed to String
        this.therapyId = therapyId;
    }

    public String getTherapyPackage() {
        return therapyPackage;
    }

    public void setTherapyPackage(String therapyPackage) {
        this.therapyPackage = therapyPackage;
    }

    public double getTherapyPrice() {
        return therapyPrice;
    }

    public void setTherapyPrice(double therapyPrice) {
        this.therapyPrice = therapyPrice;
    }

    public String getTherapyPicture() {
        return therapyPicture;
    }

    public void setTherapyPicture(String therapyPicture) {
        this.therapyPicture = therapyPicture;
    }
}