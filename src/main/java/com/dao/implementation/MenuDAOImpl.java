package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.MenuDAO;
import com.food.model.Menu;
import com.food.db.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    private static final String INSERT_MENU_QUERY =
            "INSERT INTO menu(restaurantId, name, description, price, category, available, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_MENU_QUERY =
            "SELECT * FROM menu WHERE menuId=?";

    private static final String UPDATE_MENU_QUERY =
            "UPDATE menu SET name=?, description=?, price=?, category=?, available=?, imageUrl=? WHERE menuId=?";

    private static final String DELETE_MENU_QUERY =
            "DELETE FROM menu WHERE menuId=?";

    private static final String GET_ALL_MENUS_QUERY =
            "SELECT * FROM menu";

    // Restaurant ID batti available menu items kosam
    private static final String GET_MENUS_BY_RESTAURANT_ID_QUERY =
            "SELECT * FROM menu WHERE restaurantId=? AND available=true";


    @Override
    public void addMenu(Menu menu) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_MENU_QUERY)) {

            prepareStatement.setInt(1, menu.getRestaurantId());
            prepareStatement.setString(2, menu.getName());
            prepareStatement.setString(3, menu.getDescription());
            prepareStatement.setDouble(4, menu.getPrice());
            prepareStatement.setString(5, menu.getCategory());
            prepareStatement.setBoolean(6, menu.isAvailable());

            // NEW
            prepareStatement.setString(7, menu.getImageUrl());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public Menu getMenu(int menuId) {

        Menu menu = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_MENU_QUERY)) {

            prepareStatement.setInt(1, menuId);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {
                menu = extractMenu(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }


    @Override
    public void updateMenu(Menu menu) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(UPDATE_MENU_QUERY)) {

            prepareStatement.setString(1, menu.getName());
            prepareStatement.setString(2, menu.getDescription());
            prepareStatement.setDouble(3, menu.getPrice());
            prepareStatement.setString(4, menu.getCategory());
            prepareStatement.setBoolean(5, menu.isAvailable());

            // NEW
            prepareStatement.setString(6, menu.getImageUrl());

            prepareStatement.setInt(7, menu.getMenuId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteMenu(int menuId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(DELETE_MENU_QUERY)) {

            prepareStatement.setInt(1, menuId);

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<Menu> getAllMenus() {

        List<Menu> menuList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ALL_MENUS_QUERY);
             ResultSet res = prepareStatement.executeQuery()) {

            while (res.next()) {

                Menu menu = extractMenu(res);

                menuList.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    // Restaurant ID batti menu items fetch cheyyadam
    @Override
    public List<Menu> getMenusByRestaurantId(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(
                             GET_MENUS_BY_RESTAURANT_ID_QUERY)) {

            prepareStatement.setInt(1, restaurantId);

            ResultSet res = prepareStatement.executeQuery();

            while (res.next()) {

                Menu menu = extractMenu(res);

                menuList.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }


    private Menu extractMenu(ResultSet res) throws SQLException {

        int menuId =
                res.getInt("menuId");

        int restaurantId =
                res.getInt("restaurantId");

        String name =
                res.getString("name");

        String description =
                res.getString("description");

        double price =
                res.getDouble("price");

        String category =
                res.getString("category");

        boolean available =
                res.getBoolean("available");

        // NEW
        String imageUrl =
                res.getString("imageUrl");


        Menu menu = new Menu(
                menuId,
                restaurantId,
                name,
                description,
                price,
                category,
                available
        );

        // NEW
        menu.setImageUrl(imageUrl);

        return menu;
    }
}