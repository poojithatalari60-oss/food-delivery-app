package com.food.servlet;

import com.food.dao.OrderDAO;
import com.food.dao.OrderDAOImpl;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/updateOrder")
public class AdminUpdateOrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAOImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            resp.sendRedirect("../login.html");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String status = req.getParameter("status");
        orderDAO.updateOrderStatus(orderId, status);

        resp.sendRedirect("dashboard");
    }
}