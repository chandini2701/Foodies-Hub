package com.food.controllers;

import java.io.IOException;
import java.util.List;

import com.dao.implementation.CartDAOImpl;
import com.dao.implementation.CartItemDAOImpl;
import com.food.dao.CartDAO;
import com.food.dao.CartItemDAO;
import com.food.model.Cart;
import com.food.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

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

        int userId =
                (int) userIdObject;

        CartDAO cartDAO =
                new CartDAOImpl();

        Cart cart =
                cartDAO.getCartByUserId(userId);

        if (cart == null) {

            response.sendRedirect(
                    request.getContextPath() + "/CartViewServlet"
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

            response.sendRedirect(
                    request.getContextPath() + "/CartViewServlet"
            );

            return;
        }

        double subtotal = 0;

        for (CartItem cartItem : cartItemList) {

            double itemTotal =
                    cartItem.getPrice()
                    * cartItem.getQuantity();

            subtotal =
                    subtotal + itemTotal;
        }

        double deliveryFee = 65;

        double tax = 0;

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

        double total =
                subtotal
                + deliveryFee
                + tax
                - discount;

        request.setAttribute(
                "cartItems",
                cartItemList
        );

        request.setAttribute(
                "subtotal",
                subtotal
        );

        request.setAttribute(
                "deliveryFee",
                deliveryFee
        );

        request.setAttribute(
                "tax",
                tax
        );

        request.setAttribute(
                "discount",
                discount
        );

        request.setAttribute(
                "total",
                total
        );

        String couponMessage =
                (String) session.getAttribute(
                        "couponMessage"
                );

        request.setAttribute(
                "couponMessage",
                couponMessage
        );

        request.getRequestDispatcher(
                "/checkout.jsp"
        ).forward(
                request,
                response
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        doGet(
                request,
                response
        );
    }
}