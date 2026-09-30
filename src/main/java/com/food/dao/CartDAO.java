package com.food.dao;

import com.food.model.Cart;

public interface CartDAO {

    void addCart(Cart cart);

    Cart getCartByUserId(int userId);

}