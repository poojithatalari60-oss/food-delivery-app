package com.food.servlet;

import com.food.dao.*;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/globalSearch")
public class GlobalSearchServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Restaurant> restaurants = restaurantDAO.searchRestaurants(keyword);

        User user = (User) req.getSession().getAttribute("user");
        List<Order> orders = null;
        if (user != null) {
            orders = orderDAO.searchOrdersByItem(user.getUserId(), keyword);
        }

        req.setAttribute("restaurants", restaurants);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("searchResults.jsp").forward(req, resp);
    }
}