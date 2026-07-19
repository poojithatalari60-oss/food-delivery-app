package com.food.dao;
import model.Restaurant;
import java.util.List;
public interface RestaurantDAO {
    List<Restaurant> getAllRestaurants();
    Restaurant getRestaurantById(int id);
    List<Restaurant> searchRestaurants(String keyword);
    boolean addRestaurant(Restaurant r);
}