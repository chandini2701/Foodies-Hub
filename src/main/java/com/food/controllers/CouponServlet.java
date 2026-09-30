package com.food.controllers;

import java.io.IOException;
import java.util.List;

import com.dao.implementation.CartDAOImpl;
import com.dao.implementation.CartItemDAOImpl;
import com.dao.implementation.MenuDAOImpl;

import com.food.dao.CartDAO;
import com.food.dao.CartItemDAO;
import com.food.dao.MenuDAO;

import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CouponServlet")
public class CouponServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Object userIdObject = session.getAttribute("userId");

        if (userIdObject == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.html"
            );

            return;
        }

        int userId = (int) userIdObject;

        String couponCode =
                request.getParameter("couponCode");

        if (couponCode == null
                || couponCode.trim().isEmpty()) {

            session.setAttribute(
                    "couponMessage",
                    "Please enter a coupon code."
            );

            session.setAttribute(
                    "discount",
                    0.0
            );

            response.sendRedirect(
                    request.getContextPath() + "/CheckoutServlet"
            );

            return;
        }

        couponCode = couponCode.trim().toUpperCase();

        CartDAO cartDAO =
                new CartDAOImpl();

        Cart cart =
                cartDAO.getCartByUserId(userId);

        if (cart == null) {

            session.setAttribute(
                    "couponMessage",
                    "Cart is empty."
            );

            session.setAttribute(
                    "discount",
                    0.0
            );

            response.sendRedirect(
                    request.getContextPath() + "/CheckoutServlet"
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

            session.setAttribute(
                    "couponMessage",
                    "Cart is empty."
            );

            session.setAttribute(
                    "discount",
                    0.0
            );

            response.sendRedirect(
                    request.getContextPath() + "/CheckoutServlet"
            );

            return;
        }

        MenuDAO menuDAO =
                new MenuDAOImpl();

        boolean foodFound = false;
        double discount = 0;

        for (CartItem cartItem : cartItemList) {

            Menu menu =
                    menuDAO.getMenu(
                            cartItem.getMenuId()
                    );

            if (menu == null) {
                continue;
            }

            String foodName =
                    menu.getName();

            if ("MUTTON30".equals(couponCode)
                    && "Mutton Biryani".equalsIgnoreCase(foodName)) {

                foodFound = true;
                discount = 30;

                session.setAttribute(
                        "couponMessage",
                        "Mutton Biryani coupon applied! You saved ₹30."
                );

                break;
            }

            if ("PIZZA50".equals(couponCode)
                    && "Margherita Pizza".equalsIgnoreCase(foodName)) {

                foodFound = true;
                discount = 50;

                session.setAttribute(
                        "couponMessage",
                        "Pizza coupon applied! You saved ₹50."
                );

                break;
            }

            if ("BURGER20".equals(couponCode)
                    && "Chicken Burger".equalsIgnoreCase(foodName)) {

                foodFound = true;
                discount = 20;

                session.setAttribute(
                        "couponMessage",
                        "Chicken Burger coupon applied! You saved ₹20."
                );

                break;
            }

            if ("MOMOS25".equals(couponCode)
                    && "Chicken Momos".equalsIgnoreCase(foodName)) {

                foodFound = true;
                discount = 25;

                session.setAttribute(
                        "couponMessage",
                        "Chicken Momos coupon applied! You saved ₹25."
                );

                break;
            }
        }

        if (!foodFound) {

            discount = 0;

            session.setAttribute(
                    "couponMessage",
                    "Invalid coupon for the food in your cart."
            );
        }

        session.setAttribute(
                "couponCode",
                couponCode
        );

        session.setAttribute(
                "discount",
                discount
        );

        response.sendRedirect(
                request.getContextPath() + "/CheckoutServlet"
        );
    }
}