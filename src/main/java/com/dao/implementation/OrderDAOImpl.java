package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.OrderDAO;
import com.food.model.Order;
import com.food.db.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    private static final String INSERT_ORDER_QUERY =
            "INSERT INTO orders(userId, restaurantId, address, totalAmount, status, paymentMethod, paymentStatus) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_ORDER_QUERY =
            "SELECT * FROM orders WHERE orderId=?";

    private static final String GET_LATEST_ORDER_BY_USER_QUERY =
            "SELECT * FROM orders WHERE userId=? ORDER BY orderId DESC LIMIT 1";

    private static final String GET_ORDERS_BY_USER_QUERY =
            "SELECT * FROM orders WHERE userId=? ORDER BY orderId DESC";

    private static final String UPDATE_ORDER_QUERY =
            "UPDATE orders SET status=?, paymentMethod=?, paymentStatus=? WHERE orderId=?";

    private static final String DELETE_ORDER_QUERY =
            "DELETE FROM orders WHERE orderId=?";

    private static final String GET_ALL_ORDERS_QUERY =
            "SELECT * FROM orders";


    @Override
    public void addOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_ORDER_QUERY)) {

            prepareStatement.setInt(1, order.getUserId());
            prepareStatement.setInt(2, order.getRestaurantId());
            prepareStatement.setString(3, order.getAddress());
            prepareStatement.setDouble(4, order.getTotalAmount());
            prepareStatement.setString(5, order.getStatus());
            prepareStatement.setString(6, order.getPaymentMethod());
            prepareStatement.setString(7, order.getPaymentStatus());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public Order getOrder(int orderId) {

        Order order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ORDER_QUERY)) {

            prepareStatement.setInt(1, orderId);

            ResultSet res =
                    prepareStatement.executeQuery();

            if (res.next()) {

                order = extractOrder(res);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return order;
    }


    @Override
    public Order getLatestOrderByUserId(int userId) {

        Order order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(
                             GET_LATEST_ORDER_BY_USER_QUERY)) {

            prepareStatement.setInt(1, userId);

            ResultSet res =
                    prepareStatement.executeQuery();

            if (res.next()) {

                order = extractOrder(res);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return order;
    }


    @Override
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orderList =
                new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(
                             GET_ORDERS_BY_USER_QUERY)) {

            prepareStatement.setInt(1, userId);

            ResultSet res =
                    prepareStatement.executeQuery();

            while (res.next()) {

                Order order =
                        extractOrder(res);

                orderList.add(order);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return orderList;
    }


    @Override
    public void updateOrder(Order order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(
                             UPDATE_ORDER_QUERY)) {

            prepareStatement.setString(
                    1,
                    order.getStatus()
            );

            prepareStatement.setString(
                    2,
                    order.getPaymentMethod()
            );

            prepareStatement.setString(
                    3,
                    order.getPaymentStatus()
            );

            prepareStatement.setInt(
                    4,
                    order.getOrderId()
            );

            prepareStatement.executeUpdate();

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public void deleteOrder(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(
                             DELETE_ORDER_QUERY)) {

            prepareStatement.setInt(1, orderId);

            prepareStatement.executeUpdate();

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public List<Order> getAllOrders() {

        List<Order> orderList =
                new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(
                             GET_ALL_ORDERS_QUERY);
             ResultSet res =
                     prepareStatement.executeQuery()) {

            while (res.next()) {

                Order order =
                        extractOrder(res);

                orderList.add(order);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return orderList;
    }


    private Order extractOrder(ResultSet res)
            throws SQLException {

        int orderId =
                res.getInt("orderId");

        int userId =
                res.getInt("userId");

        int restaurantId =
                res.getInt("restaurantId");

        String address =
                res.getString("address");

        java.sql.Timestamp orderDate =
                res.getTimestamp("orderDate");

        double totalAmount =
                res.getDouble("totalAmount");

        String status =
                res.getString("status");

        String paymentMethod =
                res.getString("paymentMethod");

        String paymentStatus =
                res.getString("paymentStatus");


        Order order =
                new Order(
                        orderId,
                        userId,
                        restaurantId,
                        address,
                        orderDate,
                        totalAmount,
                        status,
                        paymentMethod,
                        paymentStatus
                );

        return order;
    }
}