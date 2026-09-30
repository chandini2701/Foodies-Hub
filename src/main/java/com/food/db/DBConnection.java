package com.food.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/foodie_hub";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "chandini9333";

    public static Connection getConnection() {

        Connection connection = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

        } catch (ClassNotFoundException e) {

            e.printStackTrace();

        } catch (SQLException e) {

            System.out.println("DATABASE CONNECTION ERROR: " + e.getMessage());

            e.printStackTrace();

        }

        return connection;

    }

}