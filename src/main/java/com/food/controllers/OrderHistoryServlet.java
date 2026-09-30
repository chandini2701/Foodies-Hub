package com.food.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dao.implementation.MenuDAOImpl;
import com.dao.implementation.OrderDAOImpl;
import com.dao.implementation.OrderItemDAOImpl;
import com.dao.implementation.RestaurantDAOImpl;

import com.food.dao.MenuDAO;
import com.food.dao.OrderDAO;
import com.food.dao.OrderItemDAO;
import com.food.dao.RestaurantDAO;

import com.food.model.Menu;
import com.food.model.Order;
import com.food.model.OrderItem;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Object userIdObject =
                session.getAttribute("userId");

        if (userIdObject == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.html"
            );

            return;
        }

        int userId = (int) userIdObject;

        OrderDAO orderDAO =
                new OrderDAOImpl();

        List<Order> orderList =
                orderDAO.getOrdersByUserId(userId);

        OrderItemDAO orderItemDAO =
                new OrderItemDAOImpl();

        Map<Integer, List<OrderItem>> orderItemsMap =
                new HashMap<>();

        for (Order order : orderList) {

            int orderId =
                    order.getOrderId();

            List<OrderItem> orderItemList =
                    orderItemDAO.getOrderItemsByOrderId(orderId);

            orderItemsMap.put(
                    orderId,
                    orderItemList
            );
        }

        MenuDAO menuDAO =
                new MenuDAOImpl();

        Map<Integer, String> menuNamesMap =
                new HashMap<>();

        for (List<OrderItem> orderItemList :
                orderItemsMap.values()) {

            for (OrderItem orderItem :
                    orderItemList) {

                int menuId =
                        orderItem.getMenuId();

                if (!menuNamesMap.containsKey(menuId)) {

                    Menu menu =
                            menuDAO.getMenu(menuId);

                    if (menu != null) {

                        menuNamesMap.put(
                                menuId,
                                menu.getName()
                        );
                    }
                }
            }
        }

        RestaurantDAO restaurantDAO =
                new RestaurantDAOImpl();

        Map<Integer, String> restaurantNamesMap =
                new HashMap<>();

        for (Order order : orderList) {

            int restaurantId =
                    order.getRestaurantId();

            if (!restaurantNamesMap.containsKey(
                    restaurantId)) {

                Restaurant restaurant =
                        restaurantDAO.getRestaurant(
                                restaurantId
                        );

                if (restaurant != null) {

                    restaurantNamesMap.put(
                            restaurantId,
                            restaurant.getName()
                    );
                }
            }
        }

        request.setAttribute(
                "orderList",
                orderList
        );

        request.setAttribute(
                "orderItemsMap",
                orderItemsMap
        );

        request.setAttribute(
                "menuNamesMap",
                menuNamesMap
        );

        request.setAttribute(
                "restaurantNamesMap",
                restaurantNamesMap
        );

        request.getRequestDispatcher(
                "/order-history.jsp"
        ).forward(
                request,
                response
        );
    }
}