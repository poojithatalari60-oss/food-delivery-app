package com.food.servlet;

import com.food.dao.*;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAOImpl();
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            resp.sendRedirect("../login.html");
            return;
        }

        List<Order> orders = orderDAO.getAllOrders();
        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
        double revenue = orderDAO.getTotalRevenue();

        req.setAttribute("orders", orders);
        req.setAttribute("restaurants", restaurants);
        req.setAttribute("revenue", revenue);
        req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);
    }
}