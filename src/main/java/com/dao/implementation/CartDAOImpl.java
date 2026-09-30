package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.food.dao.CartDAO;
import com.food.model.Cart;
import com.food.db.DBConnection;

public class CartDAOImpl implements CartDAO {

    private static final String INSERT_CART_QUERY =
            "INSERT INTO cart(userId) VALUES (?)";

    private static final String GET_CART_BY_USER_QUERY =
            "SELECT * FROM cart WHERE userId=?";


    @Override
    public void addCart(Cart cart) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_CART_QUERY)) {

            prepareStatement.setInt(1, cart.getUserId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public Cart getCartByUserId(int userId) {

        Cart cart = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_CART_BY_USER_QUERY)) {

            prepareStatement.setInt(1, userId);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {

                int cartId = res.getInt("cartId");
                int userIdFromDB = res.getInt("userId");

                cart = new Cart(cartId, userIdFromDB);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }
}