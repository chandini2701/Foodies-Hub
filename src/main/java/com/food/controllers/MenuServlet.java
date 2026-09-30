package com.food.controllers;

import java.io.IOException;
import java.util.List;

import com.dao.implementation.MenuDAOImpl;
import com.dao.implementation.RestaurantDAOImpl;
import com.food.dao.MenuDAO;
import com.food.dao.RestaurantDAO;
import com.food.model.Menu;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        MenuDAO menuDAO = new MenuDAOImpl();

        RestaurantDAO restaurantDAO =
                new RestaurantDAOImpl();

        // Get ALL menus from database
        List<Menu> menuList =
                menuDAO.getAllMenus();

        // Get ALL restaurants
        List<Restaurant> restaurantList =
                restaurantDAO.getAllRestaurants();

        request.setAttribute(
                "menuList",
                menuList
        );

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
                "/admin-menu.jsp"
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

        MenuDAO menuDAO =
                new MenuDAOImpl();

        // =========================
        // ADD MENU
        // =========================

        if ("add".equals(action)) {

            int restaurantId =
                    Integer.parseInt(
                            request.getParameter("restaurantId")
                    );

            String name =
                    request.getParameter("name");

            String description =
                    request.getParameter("description");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            String category =
                    request.getParameter("category");

            String availableParameter =
                    request.getParameter("available");

            boolean available =
                    "true".equals(availableParameter);

            String imageUrl =
                    request.getParameter("imageUrl");

            Menu menu =
                    new Menu(
                            0,
                            restaurantId,
                            name,
                            description,
                            price,
                            category,
                            available
                    );

            // Admin entered image URL
            menu.setImageUrl(imageUrl);

            menuDAO.addMenu(menu);

            response.sendRedirect(
                    request.getContextPath()
                    + "/MenuServlet?message=Menu%20added%20successfully"
            );

            return;
        }

        // =========================
        // UPDATE MENU
        // =========================

        else if ("update".equals(action)) {

            int menuId =
                    Integer.parseInt(
                            request.getParameter("menuId")
                    );

            int restaurantId =
                    Integer.parseInt(
                            request.getParameter("restaurantId")
                    );

            String name =
                    request.getParameter("name");

            String description =
                    request.getParameter("description");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            String category =
                    request.getParameter("category");

            String availableParameter =
                    request.getParameter("available");

            boolean available =
                    "true".equals(availableParameter);

            String imageUrl =
                    request.getParameter("imageUrl");

            Menu menu =
                    new Menu(
                            menuId,
                            restaurantId,
                            name,
                            description,
                            price,
                            category,
                            available
                    );

            // Admin entered image URL
            menu.setImageUrl(imageUrl);

            menuDAO.updateMenu(menu);

            response.sendRedirect(
                    request.getContextPath()
                    + "/MenuServlet?message=Menu%20updated%20successfully"
            );

            return;
        }

        // =========================
        // DELETE MENU
        // =========================

        else if ("delete".equals(action)) {

            int menuId =
                    Integer.parseInt(
                            request.getParameter("menuId")
                    );

            menuDAO.deleteMenu(menuId);

            response.sendRedirect(
                    request.getContextPath()
                    + "/MenuServlet?message=Menu%20deleted%20successfully"
            );

            return;
        }

        // =========================
        // INVALID ACTION
        // =========================

        else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/MenuServlet?message=Invalid%20action"
            );
        }
    }
}