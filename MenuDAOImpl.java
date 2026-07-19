package com.food.dao;

import model.Menu;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    private Menu mapRow(ResultSet rs) throws SQLException {
        return new Menu(rs.getInt("menu_id"), rs.getInt("restaurant_id"),
                rs.getString("item_name"), rs.getString("description"),
                rs.getDouble("price"), rs.getString("category"),
                rs.getBoolean("veg"), rs.getString("image_url"), rs.getBoolean("available"));
    }

    @Override
    public List<Menu> getMenuByRestaurant(int restaurantId) {
        List<Menu> list = new ArrayList<>();
        String sql = "SELECT * FROM menu WHERE restaurant_id = ? AND available = TRUE ORDER BY category";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Menu getMenuItemById(int menuId) {
        String sql = "SELECT * FROM menu WHERE menu_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, menuId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}