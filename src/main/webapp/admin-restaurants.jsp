<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>

<%

    List<Restaurant> restaurantList =
            (List<Restaurant>) request.getAttribute("restaurantList");

    String message =
            (String) request.getAttribute("message");

%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>TapFoods | Restaurant Management</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f8f4e9;
            color: #292d22;
        }

        a {
            text-decoration: none;
        }

        /* NAVBAR */

        .navbar {
            height: 76px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 7%;
            box-shadow: 0 2px 15px rgba(0,0,0,0.06);
        }

        .logo {
            font-size: 30px;
            font-weight: 800;
            color: #59652d;
        }

        .logo span {
            color: #e96d4c;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .nav-links a {
            color: #35392e;
            font-size: 14px;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #e96d4c;
        }

        .back-btn {
            border: 1px solid #59652d;
            color: #59652d !important;
            padding: 10px 18px;
            border-radius: 25px;
        }

        /* HEADER */

        .page-header {
            background: #59652d;
            color: white;
            padding: 48px 7%;
        }

        .page-header h1 {
            font-size: 38px;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #e4e8d8;
            font-size: 15px;
        }

        /* MAIN */

        .container {
            max-width: 1100px;
            margin: auto;
            padding: 55px 7%;
        }

        .section-title {
            margin-bottom: 25px;
        }

        .section-title h2 {
            color: #303621;
            font-size: 24px;
            margin-bottom: 7px;
        }

        .section-title p {
            color: #777a70;
            font-size: 14px;
        }

        /* SUCCESS MESSAGE */

        .success-message {
            background: #eef0e5;
            color: #59652d;
            border: 1px solid #59652d;
            border-radius: 12px;
            padding: 14px 18px;
            margin-bottom: 25px;
            font-size: 14px;
            font-weight: 700;
        }

        /* FORM CARD */

        .form-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 7px 25px rgba(0,0,0,0.06);
            margin-bottom: 35px;
        }

        .form-card h2 {
            color: #303621;
            font-size: 20px;
            margin-bottom: 25px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            color: #59652d;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .form-group input,
        .form-group select {
            padding: 12px 14px;
            border: 1px solid #ddd9cc;
            border-radius: 10px;
            font-size: 14px;
            outline: none;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #59652d;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        /* BUTTONS */

        .button-row {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .btn {
            border: none;
            cursor: pointer;
            padding: 12px 22px;
            border-radius: 25px;
            font-size: 13px;
            font-weight: 700;
        }

        .add-btn {
            background: #59652d;
            color: white;
        }

        .update-btn {
            background: #e9a23b;
            color: white;
        }

        .delete-btn {
            background: #e96d4c;
            color: white;
        }

        /* RESTAURANT CARDS */

        .restaurant-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .restaurant-item {
            background: white;
            border: 1px solid #ddd9cc;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
            transition: 0.3s;
        }

        .restaurant-item:hover {
            transform: translateY(-5px);
        }

        .restaurant-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .restaurant-content {
            padding: 20px;
        }

        .restaurant-item h3 {
            color: #59652d;
            font-size: 20px;
            margin-bottom: 8px;
        }

        .restaurant-cuisine {
            color: #e96d4c !important;
            font-weight: bold;
            margin-bottom: 12px !important;
        }

        .restaurant-item p {
            color: #666a60;
            font-size: 13px;
            margin-bottom: 7px;
        }

        .restaurant-id {
            color: #888 !important;
            font-size: 12px !important;
        }

        .restaurant-info-row {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 15px;
        }

        .restaurant-tag {
            background: #eef0e5;
            color: #59652d;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .active-tag {
            background: #dcefd8;
            color: #3d7035;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .inactive-tag {
            background: #f8dede;
            color: #a33b3b;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        /* INFO */

        .info-box {
            background: #eef0e5;
            border-radius: 15px;
            padding: 18px;
            margin-bottom: 35px;
        }

        .info-box h3 {
            color: #59652d;
            font-size: 15px;
            margin-bottom: 7px;
        }

        .info-box p {
            color: #666a60;
            font-size: 13px;
            line-height: 1.6;
        }

        /* FOOTER */

        footer {
            background: #303620;
            color: white;
            padding: 45px 7% 25px;
            margin-top: 20px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 40px;
            padding-bottom: 30px;
        }

        .footer-logo {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 15px;
        }

        .footer-logo span {
            color: #ff8a68;
        }

        .footer-about {
            color: #cdd0c2;
            max-width: 350px;
            line-height: 1.7;
            font-size: 14px;
        }

        footer h4 {
            margin-bottom: 17px;
        }

        footer a {
            display: block;
            color: #cdd0c2;
            margin-bottom: 10px;
            font-size: 13px;
        }

        footer a:hover {
            color: #ff9675;
        }

        .copyright {
            border-top: 1px solid rgba(255,255,255,0.12);
            padding-top: 20px;
            text-align: center;
            color: #aeb2a3;
            font-size: 12px;
        }

        /* RESPONSIVE */

        @media (max-width: 900px) {

            .restaurant-list {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            .navbar {
                height: auto;
                padding: 18px 6%;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 13px;
            }

            .page-header {
                padding: 42px 6%;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .container {
                padding: 45px 6%;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: auto;
            }

            .restaurant-list {
                grid-template-columns: 1fr;
            }

            .footer-grid {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>


    <!-- NAVBAR -->

    <nav class="navbar">

        <a href="admin.html" class="logo">

            Tap<span>Foods</span>

        </a>

        <div class="nav-links">

            <a href="admin.html">
                Dashboard
            </a>

            <a href="RestaurantServlet">
                Restaurants
            </a>

            <a href="MenuServlet">
                Menu
            </a>

            <a href="OrderHistoryServlet">
                Orders
            </a>

            <a href="admin.html" class="back-btn">
                Back to Dashboard
            </a>

        </div>

    </nav>


    <!-- HEADER -->

    <section class="page-header">

        <h1>
            Restaurant Management
        </h1>

        <p>
            Add, update and delete restaurants from the TapFoods system.
        </p>

    </section>


    <!-- MAIN -->

    <main class="container">


        <!-- SUCCESS MESSAGE -->

        <% if (message != null && !message.isEmpty()) { %>

            <div class="success-message">

                <%= message %>

            </div>

        <% } %>


        <!-- TITLE -->

        <div class="section-title">

            <h2>
                Manage Restaurants
            </h2>

            <p>
                Use the forms below to manage restaurant information.
            </p>

        </div>


        <!-- ADD RESTAURANT -->

        <div class="form-card">

            <h2>
                Add Restaurant
            </h2>

            <form action="RestaurantServlet" method="post">

                <input
                    type="hidden"
                    name="action"
                    value="add">

                <div class="form-grid">


                    <div class="form-group">

                        <label>
                            Restaurant Name
                        </label>

                        <input
                            type="text"
                            name="name"
                            placeholder="Enter restaurant name"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Phone
                        </label>

                        <input
                            type="text"
                            name="phone"
                            placeholder="Enter phone number"
                            required>

                    </div>


                    <div class="form-group full-width">

                        <label>
                            Address
                        </label>

                        <input
                            type="text"
                            name="address"
                            placeholder="Enter restaurant address"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Cuisine Type
                        </label>

                        <input
                            type="text"
                            name="cuisineType"
                            placeholder="Example: Bakery & Cakes"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Rating
                        </label>

                        <input
                            type="number"
                            name="rating"
                            placeholder="Example: 4.5"
                            step="0.1"
                            min="0"
                            max="5"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Delivery Time
                        </label>

                        <input
                            type="text"
                            name="deliveryTime"
                            placeholder="Example: 25 mins"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Image URL
                        </label>

                        <input
                            type="url"
                            name="imageUrl"
                            placeholder="Paste restaurant image URL"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Active
                        </label>

                        <select name="active">

                            <option value="true">
                                Active
                            </option>

                            <option value="false">
                                Inactive
                            </option>

                        </select>

                    </div>

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="btn add-btn">

                        Add Restaurant

                    </button>

                </div>

            </form>

        </div>


        <!-- UPDATE RESTAURANT -->

        <div class="form-card">

            <h2>
                Update Restaurant
            </h2>

            <form action="RestaurantServlet" method="post">

                <input
                    type="hidden"
                    name="action"
                    value="update">

                <div class="form-grid">


                    <div class="form-group">

                        <label>
                            Restaurant ID
                        </label>

                        <input
                            type="number"
                            name="restaurantId"
                            placeholder="Enter restaurant ID"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Restaurant Name
                        </label>

                        <input
                            type="text"
                            name="name"
                            placeholder="Enter restaurant name"
                            required>

                    </div>


                    <div class="form-group full-width">

                        <label>
                            Address
                        </label>

                        <input
                            type="text"
                            name="address"
                            placeholder="Enter restaurant address"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Phone
                        </label>

                        <input
                            type="text"
                            name="phone"
                            placeholder="Enter phone number"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Cuisine Type
                        </label>

                        <input
                            type="text"
                            name="cuisineType"
                            placeholder="Enter cuisine type"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Rating
                        </label>

                        <input
                            type="number"
                            name="rating"
                            step="0.1"
                            min="0"
                            max="5"
                            placeholder="Example: 4.5"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Delivery Time
                        </label>

                        <input
                            type="text"
                            name="deliveryTime"
                            placeholder="Example: 30-40 mins"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Image URL
                        </label>

                        <input
                            type="url"
                            name="imageUrl"
                            placeholder="Paste restaurant image URL"
                            required>

                    </div>


                    <div class="form-group">

                        <label>
                            Active
                        </label>

                        <select name="active">

                            <option value="true">
                                Active
                            </option>

                            <option value="false">
                                Inactive
                            </option>

                        </select>

                    </div>

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="btn update-btn">

                        Update Restaurant

                    </button>

                </div>

            </form>

        </div>


        <!-- DELETE RESTAURANT -->

        <div class="form-card">

            <h2>
                Delete Restaurant
            </h2>

            <form action="RestaurantServlet" method="post">

                <input
                    type="hidden"
                    name="action"
                    value="delete">

                <div class="form-grid">

                    <div class="form-group">

                        <label>
                            Restaurant ID
                        </label>

                        <input
                            type="number"
                            name="restaurantId"
                            placeholder="Enter restaurant ID"
                            required>

                    </div>

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="btn delete-btn">

                        Delete Restaurant

                    </button>

                </div>

            </form>

        </div>


        <!-- ALL RESTAURANTS -->

        <div class="form-card">

            <h2>
                All Restaurants
            </h2>

            <div class="restaurant-list">

                <% if (restaurantList != null && !restaurantList.isEmpty()) { %>

                    <% for (Restaurant restaurant : restaurantList) { %>

                        <%

                            String adminImageUrl =
                                    restaurant.getImageUrl();

                            if (adminImageUrl == null ||
                                adminImageUrl.trim().isEmpty()) {

                                adminImageUrl =
                                    "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1000&q=85";

                            }

                        %>


                        <div class="restaurant-item">

                            <img
                                src="<%= adminImageUrl %>"
                                alt="<%= restaurant.getName() %>"
                                class="restaurant-image"
                                onerror="this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1000&q=85';">


                            <div class="restaurant-content">

                                <h3>

                                    <%= restaurant.getName() %>

                                </h3>


                                <p class="restaurant-cuisine">

                                    <%= restaurant.getCuisineType() %>

                                </p>


                                <p>

                                    <strong>Restaurant ID:</strong>

                                    <%= restaurant.getRestaurantId() %>

                                </p>


                                <p>

                                    <strong>Address:</strong>

                                    <%= restaurant.getAddress() %>

                                </p>


                                <p>

                                    <strong>Phone:</strong>

                                    <%= restaurant.getPhone() %>

                                </p>


                                <div class="restaurant-info-row">

                                    <span class="restaurant-tag">

                                        &#9733;

                                        <%= restaurant.getRating() %>

                                    </span>


                                    <span class="restaurant-tag">

                                        <%= restaurant.getDeliveryTime() %>

                                    </span>


                                    <% if (restaurant.isActive()) { %>

                                        <span class="active-tag">

                                            Active

                                        </span>

                                    <% } else { %>

                                        <span class="inactive-tag">

                                            Inactive

                                        </span>

                                    <% } %>

                                </div>

                            </div>

                        </div>


                    <% } %>

                <% } else { %>

                    <p>

                        No restaurants found.

                    </p>

                <% } %>

            </div>

        </div>


        <!-- INFO -->

        <div class="info-box">

            <h3>

                Admin Note

            </h3>

            <p>

                Restaurant ID is required for update and delete operations.
                Make sure the restaurant ID exists in the database before
                performing these operations.

            </p>

        </div>

    </main>


    <!-- FOOTER -->

    <footer>

        <div class="footer-grid">


            <div>

                <div class="footer-logo">

                    Tap<span>Foods</span>

                </div>

                <p class="footer-about">

                    Delicious food from your favourite restaurants,
                    brought closer to you with a simple ordering experience.

                </p>

            </div>


            <div>

                <h4>
                    Management
                </h4>

                <a href="admin.html">
                    Dashboard
                </a>

                <a href="RestaurantServlet">
                    Restaurants
                </a>

                <a href="MenuServlet">
                    Menu
                </a>

            </div>


            <div>

                <h4>
                    Account
                </h4>

                <a href="login.html">
                    Login
                </a>

                <a href="register.html">
                    Register
                </a>

                <a href="admin.html">
                    Admin
                </a>

            </div>

        </div>


        <div class="copyright">

            © 2026 TapFoods. All rights reserved.

        </div>

    </footer>

</body>

</html>