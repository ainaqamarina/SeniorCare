package controller;

import bean.SeniorBean;
import dao.SeniorDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null || username.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String contact = request.getParameter("contact");

        SeniorBean senior = new SeniorBean(username, gender, age, contact);
        SeniorDao seniorDao = new SeniorDao();
        boolean updateSuccess = seniorDao.updateSenior(senior);

        if (updateSuccess) {
            session.setAttribute("updateMessage", "Profile updated successfully!");
        } else {
            session.setAttribute("updateMessage", "Failed to update profile.");
        }

        response.sendRedirect("UserProfile.jsp");
    }
}