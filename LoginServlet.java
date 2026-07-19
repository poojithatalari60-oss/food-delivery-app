package com.food.servlet;
import com.food.dao.UserDAO;
import com.food.dao.UserDAOImpl;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User user = userDAO.loginUser(email, password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            if ("ADMIN".equals(user.getRole())) {
                resp.sendRedirect("admin/dashboard");
            } else {
                resp.sendRedirect("restaurant");
            }
        } else {
            resp.sendRedirect("login.html?error=true");
        }
    }
}