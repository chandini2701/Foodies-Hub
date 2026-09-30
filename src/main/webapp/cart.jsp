<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.dao.implementation.MenuDAOImpl" %>
<%@ page import="com.food.dao.MenuDAO" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Foodies Hub - Cart</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        .navbar {
            background: #ffffff;
            padding: 18px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #ff5a1f;
        }

        .nav-links a {
            text-decoration: none;
            margin-left: 25px;
            color: #333;
            font-weight: 500;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        h1 {
            margin-bottom: 25px;
        }

        .cart-item {
            background: white;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .cart-item img {
            width: 120px;
            height: 100px;
            object-fit: cover;
            border-radius: 10px;
        }

        .item-details {
            flex: 1;
        }

        .item-details h3 {
            margin: 0 0 8px;
        }

        .price {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .quantity {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity a {
            text-decoration: none;
            background: #ff5a1f;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .remove {
            text-decoration: none;
            color: red;
            font-weight: bold;
        }

        .summary {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-top: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 12px 0;
        }

        .total {
            font-size: 20px;
            font-weight: bold;
            border-top: 1px solid #ddd;
            padding-top: 15px;
        }

        .checkout-btn {
            display: block;
            text-align: center;
            text-decoration: none;
            background: #ff5a1f;
            color: white;
            padding: 14px;
            border-radius: 8px;
            margin-top: 20px;
            font-weight: bold;
        }

        .empty {
            background: white;
            padding: 50px;
            text-align: center;
            border-radius: 12px;
        }

    </style>

</head>

<body>

    <div class="navbar">

        <div class="logo">
            Foodies Hub
        </div>

        <div class="nav-links">

            <a href="index.html">Home</a>

            <a href="UserRestaurantServlet">Restaurants</a>

            <a href="UserMenuServlet">Menu</a>

            <a href="OrderHistoryServlet">Orders</a>

        </div>

    </div>


    <div class="container">

        <h1>Your Cart</h1>

        <%

            List<CartItem> cartItems =
                    (List<CartItem>) request.getAttribute("cartItems");

            if (cartItems == null || cartItems.isEmpty()) {

        %>

            <div class="empty">

                <h2>Your cart is empty</h2>

                <p>Add some delicious food to your cart.</p>

                <a href="UserRestaurantServlet">
                    Browse Restaurants
                </a>

            </div>

        <%

            } else {

                MenuDAO menuDAO = new MenuDAOImpl();

                double subtotal = 0;

                Set<Integer> restaurantIds = new HashSet<>();

                for (CartItem cartItem : cartItems) {

                    Menu menu =
                            menuDAO.getMenu(cartItem.getMenuId());

                    if (menu == null) {

                        continue;
                    }

                    double itemTotal =
                            menu.getPrice() * cartItem.getQuantity();

                    subtotal += itemTotal;

                    restaurantIds.add(menu.getRestaurantId());

                    String imageUrl = menu.getImageUrl();

                    if (menu.getMenuId() == 3) {

                        imageUrl = "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/4/3/ea657516-d730-487b-a4ab-0358095b60df_745cafb8-f6ff-41a7-9592-f13f4a665275.jpg";

                    } else if (menu.getMenuId() == 5) {

                        imageUrl = "https://rgonuzemdlvliqvpketn.supabase.co/storage/v1/object/public/menu-items/butter-chicken.jpg";

                    } else if (menu.getMenuId() == 6) {

                        imageUrl = "https://b.zmtcdn.com/data/dish_photos/824/f488f9a9217b5848609e96b414b29824.jpeg";

                    } else if (menu.getMenuId() == 7) {

                        imageUrl = "https://catalogue.bikanervala.com/cdn/shop/files/ButterNaan.jpg?v=1733814342";

                    } else if (menu.getMenuId() == 8) {

                        imageUrl = "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=800&q=80";

                    } else if (menu.getMenuId() == 9) {

                        imageUrl = "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=800&q=80";

                    } else if (menu.getMenuId() == 10) {

                        imageUrl = "https://b.zmtcdn.com/data/pictures/1/19485611/8416c6690d8d8de08143d1f8c2d929d6.jpg";

                    } else if (menu.getMenuId() == 11) {

                        imageUrl = "https://athammaskitchen.com/cdn/shop/files/Pongal.jpg?v=1747121186&width=1500";

                    } else if (menu.getMenuId() == 12) {

                        imageUrl = "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto/ja1e6z6sfnrk8hlsq9uy";

                    } else if (menu.getMenuId() == 14) {

                        imageUrl = "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2024/8/17/6ef3bc62-4f39-496a-be1c-b8aed97a1a97_1216075d-5c80-46fd-ac6a-d2f7c774d891.jpeg";

                    }

        %>

            <div class="cart-item">

                <img src="<%= imageUrl %>"
                     alt="<%= menu.getName() %>">

                <div class="item-details">

                    <h3>
                        <%= menu.getName() %>
                    </h3>

                    <div class="price">
                        ₹<%= menu.getPrice() %>
                    </div>

                    <div class="quantity">

                        <a href="CartServlet?action=decrease&cartItemId=<%= cartItem.getCartItemId() %>">
                            -
                        </a>

                        <span>
                            <%= cartItem.getQuantity() %>
                        </span>

                        <a href="CartServlet?action=increase&cartItemId=<%= cartItem.getCartItemId() %>">
                            +
                        </a>

                    </div>

                </div>

                <div>

                    <strong>
                        ₹<%= itemTotal %>
                    </strong>

                    <br><br>

                    <a class="remove"
                       href="CartServlet?action=remove&cartItemId=<%= cartItem.getCartItemId() %>">
                        Remove
                    </a>

                </div>

            </div>

        <%

                }

                double deliveryFee = restaurantIds.size() * 65;

                double tax = 0;

                double total =
                        subtotal + deliveryFee + tax;

        %>


            <div class="summary">

                <h2>Bill Details</h2>

                <div class="summary-row">

                    <span>Item Total</span>

                    <span>₹<%= subtotal %></span>

                </div>

                <div class="summary-row">

                    <span>Delivery Fee</span>

                    <span>₹<%= deliveryFee %></span>

                </div>

                <div class="summary-row">

                    <span>Tax</span>

                    <span>₹<%= tax %></span>

                </div>

                <div class="summary-row total">

                    <span>Total</span>

                    <span>₹<%= total %></span>

                </div>

                <a class="checkout-btn"
                   href="CheckoutServlet">
                    Proceed to Checkout
                </a>

            </div>

        <%

            }

        %>

    </div>

</body>

</html>