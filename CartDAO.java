package com.food.dao;

import model.CartItem;
import java.util.List;

public interface CartDAO {
    int getOrCreateCart(int userId);
    boolean addToCart(int userId, int menuId, int quantity);
    List<CartItem> getCartItems(int userId);
    boolean removeCartItem(int cartItemId);
    boolean clearCart(int userId);
    double getCartTotal(int userId);
}