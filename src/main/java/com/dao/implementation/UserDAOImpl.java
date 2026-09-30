package com.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.UserDAO;
import com.food.model.User;
import com.food.db.DBConnection;

public class UserDAOImpl implements UserDAO {

    private static final String INSERT_USER_QUERY =
            "INSERT INTO user(name, username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_USER_QUERY =
            "SELECT * FROM user WHERE userId=?";

    private static final String GET_USER_BY_USERNAME_QUERY =
            "SELECT * FROM user WHERE username=?";

    private static final String UPDATE_USER_QUERY =
            "UPDATE user SET name=?, password=?, phone=?, address=?, role=? WHERE userId=?";

    private static final String DELETE_USER_QUERY =
            "DELETE FROM user WHERE userId=?";

    private static final String GET_ALL_USERS_QUERY =
            "SELECT * FROM user";


    @Override
    public void addUser(User user) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(INSERT_USER_QUERY)) {

            prepareStatement.setString(1, user.getName());
            prepareStatement.setString(2, user.getUsername());
            prepareStatement.setString(3, user.getPassword());
            prepareStatement.setString(4, user.getEmail());
            prepareStatement.setString(5, user.getPhone());
            prepareStatement.setString(6, user.getAddress());
            prepareStatement.setString(7, user.getRole());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public User getUser(int userId) {

        User user = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_USER_QUERY)) {

            prepareStatement.setInt(1, userId);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {
                user = extractUser(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


    @Override
    public User getUserByUsername(String username) {

        User user = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_USER_BY_USERNAME_QUERY)) {

            prepareStatement.setString(1, username);

            ResultSet res = prepareStatement.executeQuery();

            if (res.next()) {
                user = extractUser(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


    @Override
    public void updateUser(User user) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(UPDATE_USER_QUERY)) {

            prepareStatement.setString(1, user.getName());
            prepareStatement.setString(2, user.getPassword());
            prepareStatement.setString(3, user.getPhone());
            prepareStatement.setString(4, user.getAddress());
            prepareStatement.setString(5, user.getRole());
            prepareStatement.setInt(6, user.getUserId());

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void deleteUser(int userId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(DELETE_USER_QUERY)) {

            prepareStatement.setInt(1, userId);

            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<User> getAllUsers() {

        List<User> userList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement prepareStatement =
                     connection.prepareStatement(GET_ALL_USERS_QUERY);
             ResultSet res = prepareStatement.executeQuery()) {

            while (res.next()) {

                User user = extractUser(res);

                userList.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }


    private User extractUser(ResultSet res) throws SQLException {

        int userId = res.getInt("userId");
        String name = res.getString("name");
        String username = res.getString("username");
        String password = res.getString("password");
        String email = res.getString("email");
        String phone = res.getString("phone");
        String address = res.getString("address");
        String role = res.getString("role");

        java.sql.Timestamp createDate =
                res.getTimestamp("createDate");

        java.sql.Timestamp lastLoginDate =
                res.getTimestamp("lastLoginDate");

        User user = new User(
                userId,
                name,
                username,
                password,
                email,
                phone,
                address,
                role,
                createDate,
                lastLoginDate
        );

        return user;
    }
}