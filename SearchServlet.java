package com.food.servlet;

import com.food.dao.RestaurantDAO;
import com.food.dao.RestaurantDAOImpl;
import model.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Restaurant> results = restaurantDAO.searchRestaurants(keyword);
        req.setAttribute("restaurants", results);
        req.getRequestDispatcher("restaurent.jsp").forward(req, resp);
    }
}