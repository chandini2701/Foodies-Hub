package com.food.controllers;

import java.io.IOException;
import java.util.List;

import com.dao.implementation.CartDAOImpl;
import com.dao.implementation.CartItemDAOImpl;
import com.dao.implementation.MenuDAOImpl;
import com.dao.implementation.OrderDAOImpl;
import com.dao.implementation.OrderItemDAOImpl;

import com.food.dao.CartDAO;
import com.food.dao.CartItemDAO;
import com.food.dao.MenuDAO;
import com.food.dao.OrderDAO;
import com.food.dao.OrderItemDAO;

import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Menu;
import com.food.model.Order;
import com.food.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        Object userIdObject =
                session.getAttribute("userId");

        if (userIdObject == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.html"
            );

            return;
        }

        int userId =
                (int) userIdObject;

        String paymentMethod =
                request.getParameter("paymentMethod");

        /*
         * DELIVERY ADDRESS
         */

        String address =
                request.getParameter("address");

        if (address == null || address.trim().isEmpty()) {

            response.getWriter().println(
                    "Delivery address is required"
            );

            return;
        }

        /*
         * Address ni session lo store chestunnam
         */

        session.setAttribute(
                "deliveryAddress",
                address
        );

        CartDAO cartDAO =
                new CartDAOImpl();

        Cart cart =
                cartDAO.getCartByUserId(userId);

        if (cart == null) {

            response.getWriter().println(
                    "Cart is empty"
            );

            return;
        }

        CartItemDAO cartItemDAO =
                new CartItemDAOImpl();

        List<CartItem> cartItemList =
                cartItemDAO.getCartItems(
                        cart.getCartId()
                );

        if (cartItemList == null
                || cartItemList.isEmpty()) {

            response.getWriter().println(
                    "Cart is empty"
            );

            return;
        }

        /*
         * Calculate subtotal
         */

        double subtotal = 0;

        for (CartItem cartItem : cartItemList) {

            double itemTotal =
                    cartItem.getPrice()
                    * cartItem.getQuantity();

            subtotal =
                    subtotal + itemTotal;
        }

        /*
         * Calculate delivery fee and tax
         */

        double deliveryFee = 65;

        double tax = 0;

        /*
         * Get coupon discount from session
         */

        double discount = 0;

        Object discountObject =
                session.getAttribute("discount");

        if (discountObject != null) {

            discount =
                    ((Number) discountObject).doubleValue();
        }

        if (discount > subtotal) {

            discount = subtotal;
        }

        /*
         * Calculate final order amount
         */

        double totalAmount =
                subtotal
                + deliveryFee
                + tax
                - discount;

        /*
         * Get restaurant ID from menu item
         */

        MenuDAO menuDAO =
                new MenuDAOImpl();

        int restaurantId = 0;

        boolean restaurantFound = false;

        for (CartItem cartItem : cartItemList) {

            Menu menu =
                    menuDAO.getMenu(
                            cartItem.getMenuId()
                    );

            if (menu == null) {

                response.getWriter().println(
                        "Menu item not found"
                );

                return;
            }

            if (!restaurantFound) {

                restaurantId =
                        menu.getRestaurantId();

                restaurantFound = true;

            } else {

                if (restaurantId
                        != menu.getRestaurantId()) {

                    response.getWriter().println(
                            "Items from different restaurants cannot be ordered together"
                    );

                    return;
                }
            }
        }

        if (!restaurantFound) {

            response.getWriter().println(
                    "Restaurant not found"
            );

            return;
        }

        /*
         * Create order
         */

        Order order =
                new Order(
                        0,
                        userId,
                        restaurantId,
                        address,
                        null,
                        totalAmount,
                        "PLACED",
                        paymentMethod,
                        "PENDING"
                );

        OrderDAO orderDAO =
                new OrderDAOImpl();

        orderDAO.addOrder(order);

        /*
         * Get newly created order
         */

        Order createdOrder =
                orderDAO.getLatestOrderByUserId(userId);

        if (createdOrder == null) {

            response.getWriter().println(
                    "Order could not be created"
            );

            return;
        }

        int orderId =
                createdOrder.getOrderId();

        /*
         * Create order items
         */

        OrderItemDAO orderItemDAO =
                new OrderItemDAOImpl();

        for (CartItem cartItem : cartItemList) {

            OrderItem orderItem =
                    new OrderItem(
                            0,
                            orderId,
                            cartItem.getMenuId(),
                            cartItem.getQuantity(),
                            cartItem.getPrice()
                    );

            orderItemDAO.addOrderItem(
                    orderItem
            );
        }

        /*
         * Clear cart after order placement
         */

        for (CartItem cartItem : cartItemList) {

            cartItemDAO.deleteCartItem(
                    cartItem.getCartItemId()
            );
        }

        /*
         * Clear coupon data after order placement
         */

        session.removeAttribute(
                "couponCode"
        );

        session.removeAttribute(
                "discount"
        );

        session.removeAttribute(
                "couponMessage"
        );

        /*
         * Open order history
         */

        response.sendRedirect(
                request.getContextPath()
                + "/OrderHistoryServlet"
        );
    }
}