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
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect("login.jsp"); return; }

        List<CartItem> items = cartDAO.getCartItems(user.getUserId());
        double total = cartDAO.getCartTotal(user.getUserId());
        req.setAttribute("cartItems", items);
        req.setAttribute("total", total);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect("login.jsp"); return; }

        String action = req.getParameter("action");
        if ("add".equals(action)) {
            int menuId = Integer.parseInt(req.getParameter("menuId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            cartDAO.addToCart(user.getUserId(), menuId, quantity);
        } else if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
            cartDAO.removeCartItem(cartItemId);
        }
        resp.sendRedirect("cart");
    }
}