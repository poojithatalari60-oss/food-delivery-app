package com.food.dao;
import model.Order;
import java.util.List;
public interface OrderDAO {
    List<Order> getOrdersByUser(int userId);
    int placeOrder(int userId, int restaurantId, double total, String address);
    void addOrderItem(int orderId, int menuId, int quantity, double price);
    List<Order> searchOrdersByItem(int userId, String keyword);
    List<Order> getAllOrders();
    boolean updateOrderStatus(int orderId, String status);
    double getTotalRevenue();
    boolean deleteOrder(int orderId);
}