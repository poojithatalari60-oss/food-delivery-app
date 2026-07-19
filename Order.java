package model;

import java.sql.Timestamp;

public class Order {
    private int orderId, userId, restaurantId;
    private double totalAmount;
    private String status, deliveryAddress;
    private Timestamp orderDate;

    public Order() {}
    public Order(int orderId, int userId, int restaurantId, double totalAmount,
                 String status, String deliveryAddress, Timestamp orderDate) {
        this.orderId = orderId; this.userId = userId; this.restaurantId = restaurantId;
        this.totalAmount = totalAmount; this.status = status;
        this.deliveryAddress = deliveryAddress; this.orderDate = orderDate;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}