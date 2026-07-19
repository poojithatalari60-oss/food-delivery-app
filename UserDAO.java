package com.food.dao;

import model.User;

public interface UserDAO {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    User getUserById(int userId);
}