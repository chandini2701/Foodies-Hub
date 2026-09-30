package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.RestaurantDAO;
import com.food.model.Restaurant;
import com.food.db.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    private static final String INSERT_RESTAURANT_QUERY =
            "INSERT INTO restaurant(name, address, phone, cuisineType, rating, deliveryTime, active, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_RESTAURANT_QUERY =
            "SELECT * FROM restaurant WHERE restaurantId=?";

    private static final String UPDATE_RESTAURANT_QUERY =
            "UPDATE restaurant SET name=?, address=?, phone=?, cuisineType=?, rating=?, deliveryTime=?, active=?, imageUrl=? WHERE restaurantId=?";

    private static final String DELETE_RESTAURANT_QUERY =
            "DELETE FROM restaurant WHERE restaurantId=?";

    private static final String GET_ALL_RESTAURANTS_QUERY =
            "SELECT * FROM restaurant";


    @Override
    public void addRestaurant(Restaurant restaurant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_RESTAURANT_QUERY)) {

            prepareStatement.setString(1, restaurant.getName());
            prepareStatement.setString(2, restaurant.getAddress());
            prepareStatement.setString(3, restaurant.getPhone());
            prepareStatement.setString(4, restaurant.getCuisineType());
            prepareStatement.setDouble(5, restaurant.getRating());
            prepareStatement.setString(6, restaurant.getDeliveryTime());
            prepareStatement.setBoolean(7, restaurant.isActive());
            prepareStatement.setString(8, restaurant.getImageUrl());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public Restaurant getRestaurant(int restaurantId) {

        Restaurant restaurant = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_RESTAURANT_QUERY)) {

            prepareStatement.setInt(1, restaurantId);

            ResultSet res =
                    prepareStatement.executeQuery();

            if (res.next()) {
                restaurant = extractRestaurant(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }


    @Override
    public void updateRestaurant(Restaurant restaurant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(UPDATE_RESTAURANT_QUERY)) {

            prepareStatement.setString(1, restaurant.getName());
            prepareStatement.setString(2, restaurant.getAddress());
            prepareStatement.setString(3, restaurant.getPhone());
            prepareStatement.setString(4, restaurant.getCuisineType());
            prepareStatement.setDouble(5, restaurant.getRating());
            prepareStatement.setString(6, restaurant.getDeliveryTime());
            prepareStatement.setBoolean(7, restaurant.isActive());
            prepareStatement.setString(8, restaurant.getImageUrl());
            prepareStatement.setInt(9, restaurant.getRestaurantId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteRestaurant(int restaurantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(DELETE_RESTAURANT_QUERY)) {

            prepareStatement.setInt(1, restaurantId);

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurantList =
                new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ALL_RESTAURANTS_QUERY);
             ResultSet res =
                     prepareStatement.executeQuery()) {

            while (res.next()) {

                Restaurant restaurant =
                        extractRestaurant(res);

                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }


    private Restaurant extractRestaurant(ResultSet res)
            throws SQLException {

        int restaurantId =
                res.getInt("restaurantId");

        String name =
                res.getString("name");

        String address =
                res.getString("address");

        String phone =
                res.getString("phone");

        String cuisineType =
                res.getString("cuisineType");

        double rating =
                res.getDouble("rating");

        String deliveryTime =
                res.getString("deliveryTime");

        boolean active =
                res.getBoolean("active");

        String imageUrl =
                res.getString("imageUrl");


        Restaurant restaurant =
                new Restaurant(
                        restaurantId,
                        name,
                        address,
                        phone,
                        cuisineType,
                        rating,
                        deliveryTime,
                        active
                );

        restaurant.setImageUrl(imageUrl);

        return restaurant;
    }
}