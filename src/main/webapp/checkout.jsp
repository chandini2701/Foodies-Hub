<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.dao.implementation.MenuDAOImpl" %>

<%

    String savedAddress = (String) session.getAttribute("address");

    if (savedAddress == null) {

        savedAddress = "";

    }

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Checkout - Foodies Hub</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f8f6ef;
            color: #303621;
        }

        nav {
            background: white;
            padding: 18px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #59652d;
        }

        nav a {
            text-decoration: none;
            color: #303621;
            margin-left: 25px;
            font-weight: 600;
        }

        .checkout-container {
            width: 85%;
            max-width: 1100px;
            margin: 45px auto;
        }

        h1 {
            margin-bottom: 30px;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 18px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
        }

        .card h2 {
            margin-top: 0;
            margin-bottom: 20px;
        }

        .item {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .item-name {
            font-weight: 600;
        }

        .item-quantity {
            color: #777;
            font-size: 14px;
            margin-top: 5px;
        }

        .item-price {
            font-weight: bold;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
        }

        .discount-row {
            color: #e86f51;
            font-weight: bold;
        }

        .total-row {
            border-top: 1px solid #ddd;
            padding-top: 18px;
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
        }

        .coupon-section {
            margin-top: 22px;
            padding: 18px;
            background: #f1f2e9;
            border-radius: 15px;
        }

        .coupon-section h3 {
            font-size: 17px;
            color: #303621;
            margin-top: 0;
            margin-bottom: 12px;
        }

        .available-coupons {
            margin-bottom: 10px;
        }

        .coupon-option {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }

        .coupon-option:last-child {
            border-bottom: none;
        }

        .coupon-details {
            color: #59652d;
        }

        .coupon-code {
            font-weight: bold;
        }

        .coupon-apply-btn {
            border: none;
            background: #59652d;
            color: white;
            padding: 8px 14px;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
        }

        .coupon-apply-btn:hover {
            background: #485324;
        }

        .coupon-message {
            margin-top: 12px;
            font-size: 14px;
            font-weight: bold;
            color: #59652d;
        }

        /* DELIVERY ADDRESS */

        .address-section {
            margin-top: 25px;
            padding: 18px;
            background: #f1f2e9;
            border-radius: 15px;
        }

        .address-section h3 {
            margin-top: 0;
            margin-bottom: 12px;
            font-size: 17px;
            color: #303621;
        }

        .address-section textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #d5d8c9;
            border-radius: 10px;
            font-family: Arial, sans-serif;
            font-size: 15px;
            resize: vertical;
            outline: none;
        }

        .address-section textarea:focus {
            border-color: #59652d;
        }

        .payment-option {
            margin: 15px 0;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }

        .payment-option input {
            margin-right: 10px;
        }

        .place-order-btn {
            width: 100%;
            border: none;
            background: #e86f51;
            color: white;
            padding: 15px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
        }

        .place-order-btn:hover {
            background: #d95f43;
        }

        .back-cart {
            display: inline-block;
            margin-top: 20px;
            color: #59652d;
            text-decoration: none;
            font-weight: bold;
        }

        footer {
            background: #303621;
            color: white;
            padding: 30px 60px;
            margin-top: 60px;
        }

        footer a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
        }

        @media (max-width: 700px) {

            nav {
                padding: 18px 25px;
            }

            .checkout-container {
                width: 90%;
            }

            .checkout-grid {
                grid-template-columns: 1fr;
            }

            .coupon-option {
                gap: 10px;
            }

        }

    </style>

</head>

<body>

    <nav>

        <div class="logo">
            Foodies Hub
        </div>

        <div>

            <a href="index.html">Home</a>

            <a href="UserMenuServlet">Menu</a>

            <a href="CartViewServlet">Cart</a>

            <a href="OrderHistoryServlet">Orders</a>

        </div>

    </nav>


    <div class="checkout-container">

        <h1>Checkout</h1>

        <div class="checkout-grid">


            <!-- YOUR ORDER -->

            <div class="card">

                <h2>Your Order</h2>

                <%

                    List<CartItem> cartItemList =
                            (List<CartItem>) request.getAttribute("cartItems");

                    MenuDAOImpl menuDAO =
                            new MenuDAOImpl();

                    if (cartItemList != null) {

                        for (CartItem cartItem : cartItemList) {

                            Menu menu =
                                    menuDAO.getMenu(
                                            cartItem.getMenuId()
                                    );

                            String menuName =
                                    "Food Item";

                            if (menu != null) {

                                menuName =
                                        menu.getName();

                            }

                            double itemTotal =
                                    cartItem.getPrice()
                                    * cartItem.getQuantity();

                %>


                <div class="item">

                    <div>

                        <div class="item-name">

                            <%= menuName %>

                        </div>

                        <div class="item-quantity">

                            Quantity:

                            <%= cartItem.getQuantity() %>

                        </div>

                    </div>

                    <div class="item-price">

                        &#8377;<%= String.format("%.2f", itemTotal) %>

                    </div>

                </div>


                <%

                        }

                    }

                %>

            </div>


            <!-- ORDER SUMMARY -->

            <div class="card">

                <h2>Order Summary</h2>

                <%

                    Double subtotalObject =
                            (Double) request.getAttribute("subtotal");

                    Double deliveryFeeObject =
                            (Double) request.getAttribute("deliveryFee");

                    Double taxObject =
                            (Double) request.getAttribute("tax");

                    Double discountObject =
                            (Double) request.getAttribute("discount");

                    Double totalObject =
                            (Double) request.getAttribute("total");

                    String couponMessage =
                            (String) request.getAttribute("couponMessage");


                    double subtotal =
                            subtotalObject != null
                            ? subtotalObject
                            : 0;

                    double deliveryFee =
                            deliveryFeeObject != null
                            ? deliveryFeeObject
                            : 0;

                    double tax =
                            taxObject != null
                            ? taxObject
                            : 0;

                    double discount =
                            discountObject != null
                            ? discountObject
                            : 0;

                    double total =
                            totalObject != null
                            ? totalObject
                            : subtotal + deliveryFee + tax - discount;

                %>


                <div class="summary-row">

                    <span>
                        Subtotal
                    </span>

                    <span>
                        &#8377;<%= String.format("%.2f", subtotal) %>
                    </span>

                </div>


                <div class="summary-row">

                    <span>
                        Delivery Fee
                    </span>

                    <span>
                        &#8377;<%= String.format("%.2f", deliveryFee) %>
                    </span>

                </div>


                <div class="summary-row">

                    <span>
                        Tax
                    </span>

                    <span>
                        &#8377;<%= String.format("%.2f", tax) %>
                    </span>

                </div>


                <!-- COUPONS -->

                <div class="coupon-section">

                    <h3>
                        Available Coupons
                    </h3>

                    <div class="available-coupons">


                        <div class="coupon-option">

                            <div class="coupon-details">

                                <span class="coupon-code">
                                    MUTTON30
                                </span>

                                - &#8377;30 OFF on Mutton Biryani

                            </div>

                            <form
                                action="CouponServlet"
                                method="post">

                                <input
                                    type="hidden"
                                    name="couponCode"
                                    value="MUTTON30">

                                <button
                                    type="submit"
                                    class="coupon-apply-btn">

                                    Apply

                                </button>

                            </form>

                        </div>


                        <div class="coupon-option">

                            <div class="coupon-details">

                                <span class="coupon-code">
                                    PIZZA50
                                </span>

                                - &#8377;50 OFF on Margherita Pizza

                            </div>

                            <form
                                action="CouponServlet"
                                method="post">

                                <input
                                    type="hidden"
                                    name="couponCode"
                                    value="PIZZA50">

                                <button
                                    type="submit"
                                    class="coupon-apply-btn">

                                    Apply

                                </button>

                            </form>

                        </div>


                        <div class="coupon-option">

                            <div class="coupon-details">

                                <span class="coupon-code">
                                    BURGER20
                                </span>

                                - &#8377;20 OFF on Chicken Burger

                            </div>

                            <form
                                action="CouponServlet"
                                method="post">

                                <input
                                    type="hidden"
                                    name="couponCode"
                                    value="BURGER20">

                                <button
                                    type="submit"
                                    class="coupon-apply-btn">

                                    Apply

                                </button>

                            </form>

                        </div>


                        <div class="coupon-option">

                            <div class="coupon-details">

                                <span class="coupon-code">
                                    MOMOS25
                                </span>

                                - &#8377;25 OFF on Chicken Momos

                            </div>

                            <form
                                action="CouponServlet"
                                method="post">

                                <input
                                    type="hidden"
                                    name="couponCode"
                                    value="MOMOS25">

                                <button
                                    type="submit"
                                    class="coupon-apply-btn">

                                    Apply

                                </button>

                            </form>

                        </div>


                    </div>


                    <%

                        if (couponMessage != null
                                && !couponMessage.isEmpty()) {

                    %>

                    <div class="coupon-message">

                        <%= couponMessage %>

                    </div>

                    <%

                        }

                    %>

                </div>


                <% if (discount > 0) { %>

                <div class="summary-row discount-row">

                    <span>
                        Discount
                    </span>

                    <span>
                        -&#8377;<%= String.format("%.2f", discount) %>
                    </span>

                </div>

                <% } %>


                <div class="summary-row total-row">

                    <span>
                        Total
                    </span>

                    <span>
                        &#8377;<%= String.format("%.2f", total) %>
                    </span>

                </div>


                <!-- DELIVERY ADDRESS -->

                <div class="address-section">

                    <h3>
                        Delivery Address
                    </h3>

                    <textarea
                        name="address"
                        form="placeOrderForm"
                        rows="4"
                        placeholder="Enter your home delivery address"
                        required><%= savedAddress %></textarea>

                </div>


                <h2 style="margin-top: 30px;">

                    Payment Method

                </h2>


                <!-- PLACE ORDER FORM -->

                <form
                    id="placeOrderForm"
                    action="OrderServlet"
                    method="post">


                    <div class="payment-option">

                        <label>

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="UPI"
                                required>

                            UPI

                        </label>

                    </div>


                    <div class="payment-option">

                        <label>

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="CARD">

                            Credit / Debit Card

                        </label>

                    </div>


                    <div class="payment-option">

                        <label>

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="CASH">

                            Cash on Delivery

                        </label>

                    </div>


                    <button
                        type="submit"
                        class="place-order-btn">

                        Place Order

                    </button>


                </form>


                <a
                    href="CartViewServlet"
                    class="back-cart">

                    ← Back to Cart

                </a>


            </div>

        </div>

    </div>


    <footer>

        <a href="index.html">
            Home
        </a>

        <a href="UserMenuServlet">
            Menu
        </a>

        <a href="CartViewServlet">
            Cart
        </a>

        <a href="CheckoutServlet">
            Checkout
        </a>

        <a href="OrderHistoryServlet">
            Orders
        </a>

    </footer>

</body>

</html>