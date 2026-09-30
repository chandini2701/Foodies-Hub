<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.food.model.Order" %>
<%@ page import="com.food.model.OrderItem" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Foodies Hub | Order History</title>

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
            position: sticky;
            top: 0;
            z-index: 100;
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
            gap: 27px;
        }

        .nav-links a {
            color: #35392e;
            font-size: 15px;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #e96d4c;
        }

        .login-btn {
            border: 1px solid #59652d;
            color: #59652d !important;
            padding: 10px 19px;
            border-radius: 25px;
        }

        .register-btn {
            background: #e96d4c;
            color: white !important;
            padding: 11px 19px;
            border-radius: 25px;
        }

        /* PAGE HEADER */

        .page-header {
            background: #59652d;
            color: white;
            padding: 55px 7%;
        }

        .page-header h1 {
            font-size: 44px;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #e7eadc;
            font-size: 16px;
        }

        /* ORDERS */

        .orders-section {
            padding: 60px 7%;
        }

        .orders-container {
            max-width: 1100px;
            margin: auto;
        }

        .section-title {
            margin-bottom: 25px;
        }

        .section-title h2 {
            color: #303621;
            font-size: 25px;
            margin-bottom: 7px;
        }

        .section-title p {
            color: #777a70;
            font-size: 14px;
        }

        /* ORDER CARD */

        .order-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 7px 25px rgba(0,0,0,0.06);
        }

        .order-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding-bottom: 18px;
            border-bottom: 1px solid #ece9df;
        }

        .order-info h3 {
            font-size: 19px;
            color: #303621;
            margin-bottom: 7px;
        }

        .order-info p {
            color: #777a70;
            font-size: 13px;
        }

        .status {
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        .placed {
            background: #fff1df;
            color: #c56b23;
        }

        .confirmed {
            background: #e9f1dc;
            color: #59652d;
        }

        .preparing {
            background: #fff0e9;
            color: #d35e3e;
        }

        .delivered {
            background: #e5f3e8;
            color: #397348;
        }

        .order-middle {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 20px;
            padding: 20px 0;
        }

        .detail h4 {
            color: #777a70;
            font-size: 12px;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail p {
            color: #303621;
            font-size: 14px;
            font-weight: 600;
        }

        /* ORDER ITEMS */

        .items-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            background: #f8f6ef;
            padding: 10px 12px;
            border-radius: 10px;
        }

        .item-name {
            color: #303621;
            font-size: 14px;
            font-weight: 600;
        }

        .item-quantity {
            color: #777a70;
            font-size: 13px;
            margin-top: 4px;
        }

        .item-price {
            color: #59652d;
            font-size: 13px;
            font-weight: 700;
            white-space: nowrap;
        }

        .order-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #ece9df;
            padding-top: 18px;
        }

        .amount {
            color: #303621;
            font-size: 20px;
            font-weight: 800;
        }

        .payment {
            color: #777a70;
            font-size: 13px;
            margin-top: 5px;
        }

        .order-again {
            background: #59652d;
            color: white;
            padding: 11px 19px;
            border-radius: 24px;
            font-size: 13px;
            font-weight: 700;
        }

        .order-again:hover {
            background: #475223;
        }

        /* EMPTY / INFO */

        .info-box {
            margin-top: 35px;
            background: #eef0e5;
            border-radius: 18px;
            padding: 25px;
            text-align: center;
        }

        .info-box h3 {
            color: #59652d;
            margin-bottom: 8px;
        }

        .info-box p {
            color: #666a60;
            font-size: 14px;
        }

        /* FOOTER */

        footer {
            background: #303620;
            color: white;
            padding: 55px 7% 25px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            padding-bottom: 40px;
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
            margin-bottom: 18px;
        }

        footer a {
            display: block;
            color: #cdd0c2;
            margin-bottom: 11px;
            font-size: 14px;
        }

        footer a:hover {
            color: #ff9675;
        }

        .copyright {
            border-top: 1px solid rgba(255,255,255,0.12);
            padding-top: 22px;
            text-align: center;
            color: #aeb2a3;
            font-size: 13px;
        }

        /* RESPONSIVE */

        @media (max-width: 900px) {

            .order-middle {
                grid-template-columns: 1fr 1fr;
            }

            .footer-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 650px) {

            .navbar {
                height: auto;
                padding: 18px 5%;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 14px;
            }

            .page-header {
                padding: 45px 6%;
            }

            .page-header h1 {
                font-size: 36px;
            }

            .orders-section {
                padding: 45px 6%;
            }

            .order-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .order-middle {
                grid-template-columns: 1fr;
                gap: 17px;
            }

            .order-bottom {
                align-items: flex-start;
                flex-direction: column;
                gap: 18px;
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

        <a href="index.html" class="logo">
            Foodies<span>Hub</span>
        </a>

        <div class="nav-links">

            <a href="index.html">
                Home
            </a>

            <a href="UserRestaurantServlet">
                Restaurants
            </a>

            <a href="UserMenuServlet">
                Menu
            </a>

            <a href="OrderHistoryServlet">
                Orders
            </a>

            <a href="CartViewServlet">
                Cart
            </a>

            <a href="login.html" class="login-btn">
                Login
            </a>

            <a href="register.html" class="register-btn">
                Register
            </a>

        </div>

    </nav>


    <!-- PAGE HEADER -->

    <section class="page-header">

        <h1>
            My Orders
        </h1>

        <p>
            Track your previous orders and order again anytime.
        </p>

    </section>


    <!-- ORDER HISTORY -->

    <section class="orders-section">

        <div class="orders-container">

            <div class="section-title">

                <h2>
                    Order History
                </h2>

                <p>
                    Your recent Foodies Hub orders
                </p>

            </div>


            <%

                List<Order> orderList =
                        (List<Order>) request.getAttribute("orderList");

                Map<Integer, List<OrderItem>> orderItemsMap =
                        (Map<Integer, List<OrderItem>>)
                                request.getAttribute("orderItemsMap");

                Map<Integer, String> menuNamesMap =
                        (Map<Integer, String>)
                                request.getAttribute("menuNamesMap");

                Map<Integer, String> restaurantNamesMap =
                        (Map<Integer, String>)
                                request.getAttribute("restaurantNamesMap");


                if (orderList != null && !orderList.isEmpty()) {

                    for (Order order : orderList) {

                        List<OrderItem> orderItemList =
                                orderItemsMap.get(order.getOrderId());

                        String restaurantName =
                                restaurantNamesMap.get(
                                        order.getRestaurantId()
                                );

            %>


            <!-- DYNAMIC ORDER CARD -->

            <div class="order-card">

                <div class="order-top">

                    <div class="order-info">

                        <h3>

                            <%= restaurantName != null
                                    ? restaurantName
                                    : "Restaurant not found" %>

                        </h3>

                        <p>

                            Order #<%= order.getOrderId() %>

                            ·

                            <%= order.getOrderDate() %>

                        </p>

                    </div>


                    <span class="status placed">

                        <%= order.getStatus() %>

                    </span>

                </div>


                <div class="order-middle">


                    <!-- ITEMS -->

                    <div class="detail">

                        <h4>
                            Items
                        </h4>


                        <div class="items-list">

                            <%

                                if (orderItemList != null
                                        && !orderItemList.isEmpty()) {

                                    for (OrderItem orderItem :
                                            orderItemList) {

                                        String menuName =
                                                menuNamesMap.get(
                                                        orderItem.getMenuId()
                                                );

                            %>


                            <div class="item-row">

                                <div>

                                    <div class="item-name">

                                        <%= menuName %>

                                    </div>

                                    <div class="item-quantity">

                                        Quantity:

                                        <%= orderItem.getQuantity() %>

                                    </div>

                                </div>


                                <div class="item-price">

                                    &#8377;<%= orderItem.getPrice() %>

                                </div>

                            </div>


                            <%

                                    }

                                } else {

                            %>


                            <p>
                                No items found
                            </p>


                            <%

                                }

                            %>

                        </div>

                    </div>


                    <!-- PAYMENT -->

                    <div class="detail">

                        <h4>
                            Payment
                        </h4>

                        <p>

                            <%= order.getPaymentMethod() %>

                            ·

                            <%= order.getPaymentStatus() %>

                        </p>

                    </div>


                    <!-- DELIVERY -->

                    <div class="detail">

                        <h4>
                            Delivery
                        </h4>

                        <p>
                            30 mins
                        </p>

                    </div>

                </div>


                <!-- ORDER BOTTOM -->

                <div class="order-bottom">

                    <div>

                        <div class="amount">

                            &#8377;<%= order.getTotalAmount() %>

                        </div>

                        <div class="payment">

                            Total amount

                        </div>

                    </div>


                    <a
                        href="menu.html"
                        class="order-again"
                    >
                        Order Again
                    </a>

                </div>

            </div>


            <%

                    }

                } else {

            %>


            <!-- EMPTY ORDER HISTORY -->

            <div class="info-box">

                <h3>
                    No orders yet
                </h3>

                <p>
                    Your placed orders will appear here.
                </p>

                <a
                    href="restaurants.html"
                    class="order-again"
                    style="display:inline-block; margin-top:15px;"
                >
                    Browse Restaurants
                </a>

            </div>


            <%

                }

            %>


            <!-- INFO -->

            <div class="info-box">

                <h3>
                    Want to order something again?
                </h3>

                <p>
                    Browse our restaurants and choose your favourite dishes.
                </p>

                <a
                    href="restaurants.html"
                    class="order-again"
                    style="display:inline-block; margin-top:15px;"
                >
                    Browse Restaurants
                </a>

            </div>

        </div>

    </section>


    <!-- FOOTER -->

    <footer>

        <div class="footer-grid">

            <div>

                <div class="footer-logo">

                    Foodies<span>Hub</span>

                </div>

                <p class="footer-about">

                    Delicious food from your favourite restaurants,
                    brought closer to you with a simple ordering experience.

                </p>

            </div>


            <div>

                <h4>
                    Explore
                </h4>

                <a href="index.html">
                    Home
                </a>

                <a href="UserRestaurantServlet">
                    Restaurants
                </a>

                <a href="UserMenuServlet">
                    Menu
                </a>

            </div>


            <div>

                <h4>
                    Orders
                </h4>

                <a href="CartViewServlet">
                    Cart
                </a>

                <a href="CheckoutServlet">
                    Checkout
                </a>

                <a href="OrderHistoryServlet">
                    Orders
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

            &copy; 2026 Foodies Hub. All rights reserved.

        </div>

    </footer>

</body>

</html>