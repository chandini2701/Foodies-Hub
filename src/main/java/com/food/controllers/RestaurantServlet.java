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

@WebServlet("/RestaurantServlet")
public class RestaurantServlet extends HttpServlet {

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

        String message =
                request.getParameter("message");

        request.setAttribute(
                "message",
                message
        );

        request.getRequestDispatcher(
                "/admin-restaurants.jsp"
        ).forward(
                request,
                response
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        RestaurantDAO restaurantDAO =
                new RestaurantDAOImpl();

        // =========================
        // ADD RESTAURANT
        // =========================
        if ("add".equals(action)) {

            String name =
                    request.getParameter("name");

            String address =
                    request.getParameter("address");

            String phone =
                    request.getParameter("phone");

            String cuisineType =
                    request.getParameter("cuisineType");

            double rating =
                    Double.parseDouble(
                            request.getParameter("rating")
                    );

            String deliveryTime =
                    request.getParameter("deliveryTime");

            boolean active =
                    Boolean.parseBoolean(
                            request.getParameter("active")
                    );

            String imageUrl =
                    request.getParameter("imageUrl");

            Restaurant restaurant =
                    new Restaurant(
                            0,
                            name,
                            address,
                            phone,
                            cuisineType,
                            rating,
                            deliveryTime,
                            active
                    );

            restaurant.setImageUrl(imageUrl);

            restaurantDAO.addRestaurant(
                    restaurant
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/RestaurantServlet?message=Restaurant%20added%20successfully"
            );

            return;
        }

        // =========================
        // UPDATE RESTAURANT
        // =========================
        else if ("update".equals(action)) {

            int restaurantId =
                    Integer.parseInt(
                            request.getParameter(
                                    "restaurantId"
                            )
                    );

            String name =
                    request.getParameter("name");

            String address =
                    request.getParameter("address");

            String phone =
                    request.getParameter("phone");

            String cuisineType =
                    request.getParameter("cuisineType");

            double rating =
                    Double.parseDouble(
                            request.getParameter("rating")
                    );

            String deliveryTime =
                    request.getParameter("deliveryTime");

            boolean active =
                    Boolean.parseBoolean(
                            request.getParameter("active")
                    );

            String imageUrl =
                    request.getParameter("imageUrl");

            Restaurant restaurant =
                    new Restaurant(
                            restaurantId,
                            name,
                            address,
                            phone,
                            cuisineType,
                            rating,
                            deliveryTime,
                            active
                    );

            restaurant.setImageUrl(imageUrl);

            restaurantDAO.updateRestaurant(
                    restaurant
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/RestaurantServlet?message=Restaurant%20updated%20successfully"
            );

            return;
        }

        // =========================
        // DELETE RESTAURANT
        // =========================
        else if ("delete".equals(action)) {

            int restaurantId =
                    Integer.parseInt(
                            request.getParameter(
                                    "restaurantId"
                            )
                    );

            restaurantDAO.deleteRestaurant(
                    restaurantId
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/RestaurantServlet?message=Restaurant%20deleted%20successfully"
            );

            return;
        }

        response.sendRedirect(
                request.getContextPath()
                + "/RestaurantServlet"
        );
    }
}