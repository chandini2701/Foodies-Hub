package com.food.dao;

import java.util.List;

import com.food.model.Order;

public interface OrderDAO {

    void addOrder(Order order);

    Order getOrder(int orderId);

    Order getLatestOrderByUserId(int userId);

    List<Order> getOrdersByUserId(int userId);

    void updateOrder(Order order);

    void deleteOrder(int orderId);

    List<Order> getAllOrders();

}