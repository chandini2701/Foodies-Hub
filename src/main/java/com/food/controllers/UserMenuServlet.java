package com.food.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.dao.implementation.MenuDAOImpl;
import com.food.dao.MenuDAO;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserMenuServlet")
public class UserMenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        MenuDAO menuDAO = new MenuDAOImpl();

        List<Menu> allMenuList = menuDAO.getAllMenus();

        List<Menu> menuList = new ArrayList<>();

        Set<String> addedFoodNames = new HashSet<>();

        for (Menu menu : allMenuList) {

            if (!menu.isAvailable()) {
                continue;
            }

            String foodName = menu.getName();

            if (foodName == null) {
                continue;
            }

            if (addedFoodNames.contains(foodName)) {
                continue;
            }

            addedFoodNames.add(foodName);

            menuList.add(menu);
        }

        request.setAttribute("menuList", menuList);

        request.getRequestDispatcher("/menu.jsp")
               .forward(request, response);
    }
}