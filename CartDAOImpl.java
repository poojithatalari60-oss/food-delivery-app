package com.food.dao;

import model.CartItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    @Override
    public int getOrCreateCart(int userId) {
        String select = "SELECT cart_id FROM cart WHERE user_id = ?";
        String insert = "INSERT INTO cart (user_id) VALUES (?)";
        try (Connection con = DBUtil.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(select)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) return rs.getInt("cart_id");
                }
            }
            try (PreparedStatement ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) return keys.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public boolean addToCart(int userId, int menuId, int quantity) {
        int cartId = getOrCreateCart(userId);
        if (cartId == -1) return false;

        String checkSql = "SELECT cart_item_id, quantity FROM cart_items WHERE cart_id = ? AND menu_id = ?";
        String updateSql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        String insertSql = "INSERT INTO cart_items (cart_id, menu_id, quantity) VALUES (?, ?, ?)";

        try (Connection con = DBUtil.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(checkSql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, menuId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int newQty = rs.getInt("quantity") + quantity;
                        try (PreparedStatement up = con.prepareStatement(updateSql)) {
                            up.setInt(1, newQty);
                            up.setInt(2, rs.getInt("cart_item_id"));
                            return up.executeUpdate() > 0;
                        }
                    }
                }
            }
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setInt(1, cartId);
                ps.setInt(2, menuId);
                ps.setInt(3, quantity);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT ci.cart_item_id, ci.cart_id, ci.menu_id, ci.quantity, " +
                     "m.item_name, m.price, m.restaurant_id FROM cart_items ci " +
                     "JOIN cart c ON ci.cart_id = c.cart_id " +
                     "JOIN menu m ON ci.menu_id = m.menu_id " +
                     "WHERE c.user_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem(rs.getInt("cart_item_id"), rs.getInt("cart_id"),
                            rs.getInt("menu_id"), rs.getInt("quantity"));
                    item.setItemName(rs.getString("item_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setRestaurantId(rs.getInt("restaurant_id"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean removeCartItem(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartItemId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean clearCart(int userId) {
        String sql = "DELETE ci FROM cart_items ci JOIN cart c ON ci.cart_id = c.cart_id WHERE c.user_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public double getCartTotal(int userId) {
        double total = 0;
        for (CartItem item : getCartItems(userId)) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}