package com.food.dao;

import java.util.List;

import com.food.model.CartItem;

public interface CartItemDAO {

    void addCartItem(CartItem cartItem);

    List<CartItem> getCartItems(int cartId);

    void updateCartItem(CartItem cartItem);

    void deleteCartItem(int cartItemId);
}