package controller;

import bean.LoginBean;
import dao.LoginDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        LoginBean loginBean = new LoginBean();
        loginBean.setUsername(username);
        loginBean.setPassword(password);

        LoginDao loginDao = new LoginDao();

        // Check for admin credentials
        if ("admin".equals(username) && "admin123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "admin");
            response.sendRedirect("AdminDashboard.jsp"); // Redirect Admin
        } 
        // Check for senior credentials
        else if (loginDao.validateSenior(loginBean)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("SeniorHomepage.jsp"); // Redirect Senior
        } else {
            response.sendRedirect("login.jsp?error=Invalid Credentials");
        }
    }
}
