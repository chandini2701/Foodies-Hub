package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.CartItemDAO;
import com.food.model.CartItem;
import com.food.db.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    private static final String INSERT_CART_ITEM_QUERY =
            "INSERT INTO cart_item(cartId, menuId, quantity, price) VALUES (?, ?, ?, ?)";

    private static final String GET_CART_ITEMS_QUERY =
            "SELECT * FROM cart_item WHERE cartId=?";

    private static final String UPDATE_CART_ITEM_QUERY =
            "UPDATE cart_item SET quantity=? WHERE cartItemId=?";

    private static final String DELETE_CART_ITEM_QUERY =
            "DELETE FROM cart_item WHERE cartItemId=?";


    @Override
    public void addCartItem(CartItem cartItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_CART_ITEM_QUERY)) {

            prepareStatement.setInt(1, cartItem.getCartId());
            prepareStatement.setInt(2, cartItem.getMenuId());
            prepareStatement.setInt(3, cartItem.getQuantity());
            prepareStatement.setDouble(4, cartItem.getPrice());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<CartItem> getCartItems(int cartId) {

        List<CartItem> cartItemList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_CART_ITEMS_QUERY)) {

            prepareStatement.setInt(1, cartId);

            ResultSet res = prepareStatement.executeQuery();

            while (res.next()) {

                int cartItemId = res.getInt("cartItemId");
                int cartIdFromDB = res.getInt("cartId");
                int menuId = res.getInt("menuId");
                int quantity = res.getInt("quantity");
                double price = res.getDouble("price");

                CartItem cartItem = new CartItem(
                        cartItemId,
                        cartIdFromDB,
                        menuId,
                        quantity,
                        price
                );

                cartItemList.add(cartItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItemList;
    }


    @Override
    public void updateCartItem(CartItem cartItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(UPDATE_CART_ITEM_QUERY)) {

            prepareStatement.setInt(1, cartItem.getQuantity());
            prepareStatement.setInt(2, cartItem.getCartItemId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteCartItem(int cartItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(DELETE_CART_ITEM_QUERY)) {

            prepareStatement.setInt(1, cartItemId);

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}