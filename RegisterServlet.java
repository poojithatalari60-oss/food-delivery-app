package com.food.servlet;

import com.food.dao.UserDAO;
import com.food.dao.UserDAOImpl;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = new User();
        user.setName(req.getParameter("name"));
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        user.setPhone(req.getParameter("phone"));
        user.setAddress(req.getParameter("address"));

        boolean success = userDAO.registerUser(user);
        if (success) {
            resp.sendRedirect("login.html?registered=true");
        } else {
            resp.sendRedirect("register.html?error=true");
        }
    }
}