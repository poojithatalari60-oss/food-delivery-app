package com.food.servlet;

import com.food.dao.OrderDAO;
import com.food.dao.OrderDAOImpl;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myorders/*")
public class MyOrdersServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect("login.jsp"); return; }

        String pathInfo = req.getPathInfo(); // "/search" for /myorders/search
        List<Order> orders;

        if ("/search".equals(pathInfo)) {
            String keyword = req.getParameter("keyword");
            orders = orderDAO.searchOrdersByItem(user.getUserId(), keyword);
        } else {
            orders = orderDAO.getOrdersByUser(user.getUserId());
        }

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("myOrders.jsp").forward(req, resp);
    }
}