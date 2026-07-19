package com.food.servlet;

import com.food.dao.RestaurantDAO;
import com.food.dao.RestaurantDAOImpl;
import model.Restaurant;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/addRestaurant")
public class AddRestaurantServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        Restaurant r = new Restaurant();
        r.setName(req.getParameter("name"));
        r.setAddress(req.getParameter("address"));
        r.setCuisineType(req.getParameter("cuisineType"));
        r.setRating(Double.parseDouble(req.getParameter("rating")));
        r.setDeliveryTime(req.getParameter("deliveryTime"));
        r.setPriceForTwo(req.getParameter("priceForTwo"));
        r.setImageUrl(req.getParameter("imageUrl"));

        restaurantDAO.addRestaurant(r);
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}