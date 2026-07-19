package com.food.servlet;

import com.food.dao.MenuDAO;
import com.food.dao.MenuDAOImpl;
import model.Menu;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private MenuDAO menuDAO = new MenuDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        List<Menu> menuItems = menuDAO.getMenuByRestaurant(restaurantId);
        req.setAttribute("menuItems", menuItems);
        req.setAttribute("restaurantId", restaurantId);
        req.getRequestDispatcher("menu.jsp").forward(req, resp);
    }
}