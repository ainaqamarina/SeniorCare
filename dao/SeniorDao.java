package dao;

import bean.SeniorBean;
import java.sql.*;

public class SeniorDao {
    private final String jdbcURL = "jdbc:derby://localhost:1527/SeniorCareDD";
    private final String jdbcUsername = "app";
    private final String jdbcPassword = "app";

    private static final String UPDATE_SENIOR_SQL = 
        "UPDATE SENIORS SET SENIOR_GENDER = ?, SENIOR_AGE = ?, SENIOR_CONTACT = ? WHERE SENIOR_USERNAME = ?";

    public boolean updateSenior(SeniorBean senior) {
        boolean rowUpdated = false;

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SENIOR_SQL)) {

            preparedStatement.setString(1, senior.getGender());
            preparedStatement.setInt(2, senior.getAge());
            preparedStatement.setString(3, senior.getContact());
            preparedStatement.setString(4, senior.getUsername());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging instead
        }

        return rowUpdated;
    }
}