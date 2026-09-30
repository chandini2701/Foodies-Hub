package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.OrderItemDAO;
import com.food.model.OrderItem;
import com.food.db.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String INSERT_ORDER_ITEM_QUERY =
            "INSERT INTO order_item(orderId, menuId, quantity, price) VALUES (?, ?, ?, ?)";

    private static final String GET_ORDER_ITEM_QUERY =
            "SELECT * FROM order_item WHERE orderItemId=?";

    private static final String UPDATE_ORDER_ITEM_QUERY =
            "UPDATE order_item SET quantity=?, price=? WHERE orderItemId=?";

    private static final String DELETE_ORDER_ITEM_QUERY =
            "DELETE FROM order_item WHERE orderItemId=?";

    private static final String GET_ALL_ORDER_ITEMS_QUERY =
            "SELECT * FROM order_item";

    private static final String GET_ORDER_ITEMS_BY_ORDER_QUERY =
            "SELECT * FROM order_item WHERE orderId=?";


    @Override
    public void addOrderItem(OrderItem orderItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, orderItem.getOrderId());
            prepareStatement.setInt(2, orderItem.getMenuId());
            prepareStatement.setInt(3, orderItem.getQuantity());
            prepareStatement.setDouble(4, orderItem.getPrice());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public OrderItem getOrderItem(int orderItemId) {

        OrderItem orderItem = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, orderItemId);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {
                orderItem = extractOrderItem(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }


    @Override
    public void updateOrderItem(OrderItem orderItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(UPDATE_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, orderItem.getQuantity());
            prepareStatement.setDouble(2, orderItem.getPrice());
            prepareStatement.setInt(3, orderItem.getOrderItemId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteOrderItem(int orderItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(DELETE_ORDER_ITEM_QUERY)) {

            prepareStatement.setInt(1, orderItemId);

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> orderItemList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ALL_ORDER_ITEMS_QUERY);
             ResultSet res = prepareStatement.executeQuery()) {

            while (res.next()) {

                OrderItem orderItem = extractOrderItem(res);

                orderItemList.add(orderItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemList;
    }


    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        List<OrderItem> orderItemList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ORDER_ITEMS_BY_ORDER_QUERY)) {

            prepareStatement.setInt(1, orderId);

            ResultSet res = prepareStatement.executeQuery();

            while (res.next()) {

                OrderItem orderItem = extractOrderItem(res);

                orderItemList.add(orderItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemList;
    }


    private OrderItem extractOrderItem(ResultSet res) throws SQLException {

        int orderItemId = res.getInt("orderItemId");
        int orderId = res.getInt("orderId");
        int menuId = res.getInt("menuId");
        int quantity = res.getInt("quantity");
        double price = res.getDouble("price");

        OrderItem orderItem = new OrderItem(
                orderItemId,
                orderId,
                menuId,
                quantity,
                price
        );

        return orderItem;
    }
}