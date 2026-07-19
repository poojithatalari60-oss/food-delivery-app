package com.food.dao;
import model.Order;
import java.util.List;
import java.util.ArrayList;
public class OrderDAOImpl implements OrderDAO {
    public List<Order> getOrdersByUser(int userId) {
        List<Order> result = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public int placeOrder(int userId, int restaurantId, double total, String address) {
        String sql = "INSERT INTO orders (user_id, restaurant_id, total_amount, delivery_address, status, order_date) VALUES (?, ?, ?, ?, ?, NOW())";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, restaurantId);
            ps.setDouble(3, total);
            ps.setString(4, address);
            ps.setString(5, "PLACED");
            int rows = ps.executeUpdate();
            if (rows > 0) {
                java.sql.ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    public void addOrderItem(int orderId, int menuId, int quantity, double price) {
        String sql = "INSERT INTO order_items (order_id, menu_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, menuId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Order> searchOrdersByItem(int userId, String keyword) {
        List<Order> result = new ArrayList<>();
        String sql = "SELECT DISTINCT o.* FROM orders o " +
                     "JOIN order_items oi ON o.order_id = oi.order_id " +
                     "JOIN menu m ON oi.menu_id = m.menu_id " +
                     "WHERE o.user_id = ? AND m.item_name LIKE ? " +
                     "ORDER BY o.order_date DESC";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public List<Order> getAllOrders() {
        List<Order> result = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) AS revenue FROM orders WHERE status != 'CANCELLED'";
        try (java.sql.Connection con = DBUtil.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("revenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    private Order mapRow(java.sql.ResultSet rs) throws java.sql.SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setRestaurantId(rs.getInt("restaurant_id"));
        o.setTotalAmount(rs.getDouble("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setDeliveryAddress(rs.getString("delivery_address"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        return o;
    }
    public boolean deleteOrder(int orderId) {
        String deleteItemsSql = "DELETE FROM order_items WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";
        try (java.sql.Connection con = DBUtil.getConnection()) {
            try (java.sql.PreparedStatement ps1 = con.prepareStatement(deleteItemsSql)) {
                ps1.setInt(1, orderId);
                ps1.executeUpdate();
            }
            try (java.sql.PreparedStatement ps2 = con.prepareStatement(deleteOrderSql)) {
                ps2.setInt(1, orderId);
                return ps2.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}