package com.food.controllers;

import java.io.IOException;
import java.util.List;

import com.dao.implementation.RestaurantDAOImpl;
import com.food.dao.RestaurantDAO;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserRestaurantServlet")
public class UserRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        RestaurantDAO restaurantDAO =
                new RestaurantDAOImpl();

        List<Restaurant> restaurantList =
                restaurantDAO.getAllRestaurants();

        request.setAttribute(
                "restaurantList",
                restaurantList
        );

        request.getRequestDispatcher(
                "/restaurants.jsp"
        ).forward(
                request,
                response
        );
    }
}