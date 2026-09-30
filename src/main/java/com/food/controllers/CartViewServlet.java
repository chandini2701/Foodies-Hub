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

@WebServlet("/CartViewServlet")
public class CartViewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
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

        CartDAO cartDAO = new CartDAOImpl();

        Cart cart = cartDAO.getCartByUserId(userId);

        if (cart == null) {

            request.setAttribute(
                    "cartItems",
                    null
            );

            request.getRequestDispatcher("/cart.jsp")
                   .forward(request, response);

            return;
        }

        CartItemDAO cartItemDAO = new CartItemDAOImpl();

        List<CartItem> cartItemList =
                cartItemDAO.getCartItems(cart.getCartId());

        request.setAttribute(
                "cartItems",
                cartItemList
        );

        request.getRequestDispatcher("/cart.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}