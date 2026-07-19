package com.food.dao;

import model.Menu;
import java.util.List;

public interface MenuDAO {
    List<Menu> getMenuByRestaurant(int restaurantId);
    Menu getMenuItemById(int menuId);
}