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

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Handles GET requests from the cart page
    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // Get the logged-in user's ID from the session
        HttpSession session = request.getSession();

        Object userIdObject = session.getAttribute("userId");

        if (userIdObject == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.html"
            );

            return;
        }

        int userId = (int) userIdObject;

        // Create Cart Item DAO
        CartItemDAO cartItemDAO = new CartItemDAOImpl();

        // Get the requested action
        String action = request.getParameter("action");


        // =====================================================
        // REMOVE ITEM
        // =====================================================

        if ("remove".equals(action)) {

            int cartItemId = Integer.parseInt(
                    request.getParameter("cartItemId")
            );

            cartItemDAO.deleteCartItem(cartItemId);

            response.sendRedirect(
                    request.getContextPath() + "/CartViewServlet"
            );

            return;
        }


        // =====================================================
        // INCREASE / DECREASE QUANTITY
        // =====================================================

        if ("increase".equals(action)
                || "decrease".equals(action)) {

            int cartItemId = Integer.parseInt(
                    request.getParameter("cartItemId")
            );

            // Get the user's cart
            CartDAO cartDAO = new CartDAOImpl();

            Cart cart = cartDAO.getCartByUserId(userId);

            if (cart != null) {

                List<CartItem> cartItemList =
                        cartItemDAO.getCartItems(cart.getCartId());

                for (CartItem cartItem : cartItemList) {

                    if (cartItem.getCartItemId() == cartItemId) {

                        int quantity =
                                cartItem.getQuantity();


                        // Increase quantity
                        if ("increase".equals(action)) {

                            quantity = quantity + 1;
                        }


                        // Decrease quantity
                        if ("decrease".equals(action)) {

                            if (quantity > 1) {

                                quantity = quantity - 1;

                            } else {

                                quantity = 1;
                            }
                        }


                        // Update quantity in the database
                        cartItem.setQuantity(quantity);

                        cartItemDAO.updateCartItem(cartItem);

                        break;
                    }
                }
            }

            response.sendRedirect(
                    request.getContextPath() + "/CartViewServlet"
            );

            return;
        }


        // =====================================================
        // ADD TO CART
        // =====================================================

        int menuId = Integer.parseInt(
                request.getParameter("menuId")
        );

        double price = Double.parseDouble(
                request.getParameter("price")
        );


        // Create Cart DAO
        CartDAO cartDAO = new CartDAOImpl();


        // Check whether the user already has a cart
        Cart cart = cartDAO.getCartByUserId(userId);


        // Create a new cart if the user does not have one
        if (cart == null) {

            Cart newCart = new Cart(0, userId);

            cartDAO.addCart(newCart);

            // Get the newly created cart from the database
            cart = cartDAO.getCartByUserId(userId);
        }


        // Get current cart items
        List<CartItem> cartItemList =
                cartItemDAO.getCartItems(cart.getCartId());


        boolean itemExists = false;


        // Check whether the same menu item already exists in the cart
        for (CartItem cartItem : cartItemList) {

            if (cartItem.getMenuId() == menuId) {

                // Get the existing quantity
                int oldQuantity =
                        cartItem.getQuantity();


                // Increase the quantity by one
                int newQuantity =
                        oldQuantity + 1;


                // Set the new quantity
                cartItem.setQuantity(newQuantity);


                // Update the item in the database
                cartItemDAO.updateCartItem(cartItem);


                itemExists = true;

                break;
            }
        }


        // Add a new item if it does not already exist in the cart
        if (!itemExists) {

            CartItem cartItem = new CartItem(
                    0,
                    cart.getCartId(),
                    menuId,
                    1,
                    price
            );

            cartItemDAO.addCartItem(cartItem);
        }


        // Redirect to the cart page after adding the item
        response.sendRedirect(
                request.getContextPath() + "/CartViewServlet"
        );
    }
}