package bean;

public class SeniorBean {
    private String username;
    private String gender;
    private int age;
    private String contact;

    // Constructor
    public SeniorBean() {}

    public SeniorBean(String username, String gender, int age, String contact) {
        this.username = username;
        this.gender = gender;
        this.age = age;
        this.contact = contact;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }
}
