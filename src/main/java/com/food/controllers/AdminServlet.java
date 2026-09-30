package com.food.controllers;

import java.io.IOException;
import java.util.List;

import com.dao.implementation.RestaurantDAOImpl;
import com.dao.implementation.MenuDAOImpl;
import com.food.dao.RestaurantDAO;
import com.food.dao.MenuDAO;
import com.food.model.Restaurant;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        RestaurantDAO restaurantDAO =
                new RestaurantDAOImpl();

        MenuDAO menuDAO =
                new MenuDAOImpl();

        List<Restaurant> restaurantList =
                restaurantDAO.getAllRestaurants();

        List<Menu> menuList =
                menuDAO.getAllMenus();

        request.setAttribute(
                "restaurantList",
                restaurantList
        );

        request.setAttribute(
                "menuList",
                menuList
        );

        request.getRequestDispatcher(
                "/admin.html"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}