package com.food.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.dao.implementation.UserDAOImpl;
import com.food.dao.UserDAO;
import com.food.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        if (!password.equals(confirmPassword)) {
            response.getWriter().println("Password and Confirm Password do not match");
            return;
        }

        User user = new User(
                0,
                name,
                username,
                password,
                email,
                phone,
                address,
                role,
                null,
                null
        );

        UserDAO userDAO = new UserDAOImpl();
        userDAO.addUser(user);

        response.sendRedirect(request.getContextPath() + "/login.html");
    }
}