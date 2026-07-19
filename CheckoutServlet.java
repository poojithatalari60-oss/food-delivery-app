package com.food.servlet;

import java.io.IOException;
import java.util.List;

import com.food.dao.CartDAO;
import com.food.dao.CartDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect("login.html"); return; }

        List<CartItem> items = cartDAO.getCartItems(user.getUserId());
        double total = cartDAO.getCartTotal(user.getUserId());
        req.setAttribute("cartItems", items);
        req.setAttribute("total", total);
        req.setAttribute("restaurantId", req.getParameter("restaurantId"));
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }
}