package com.food.servlet;

import java.io.IOException;
import java.util.List;
import com.food.dao.CartDAO;
import com.food.dao.CartDAOImpl;
import com.food.dao.OrderDAO;
import com.food.dao.OrderDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.User;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) { resp.sendRedirect("login.jsp"); return; }

        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        String address = req.getParameter("address");

        List<CartItem> items = cartDAO.getCartItems(user.getUserId());
        double total = cartDAO.getCartTotal(user.getUserId());

        if (items.isEmpty()) {
            resp.sendRedirect("cart?error=empty");
            return;
        }

        int orderId = orderDAO.placeOrder(user.getUserId(), restaurantId, total, address);
        if (orderId != -1) {
            for (CartItem item : items) {
                orderDAO.addOrderItem(orderId, item.getMenuId(), item.getQuantity(), item.getPrice());
            }
            cartDAO.clearCart(user.getUserId());
            resp.sendRedirect("myorders?success=true");
        } else {
            resp.sendRedirect("cart?error=orderfailed");
        }
    }
}