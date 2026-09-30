<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food.model.Menu"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Menu - Foodies Hub</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background-color: #f8f8f8;
    color: #333;
}

/* NAVBAR */

.navbar {
    background-color: #ffffff;
    height: 70px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 60px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.logo {
    font-size: 28px;
    font-weight: bold;
    color: #e23744;
}

.nav-links {
    display: flex;
    gap: 30px;
}

.nav-links a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
    font-weight: 500;
}

.nav-links a:hover {
    color: #e23744;
}

/* HERO */

.hero {
    background:
        linear-gradient(
            rgba(0,0,0,0.45),
            rgba(0,0,0,0.45)
        ),
        url("https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1600&q=80");

    background-size: cover;
    background-position: center;
    height: 280px;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    text-align: center;
}

.hero h1 {
    font-size: 48px;
    margin-bottom: 10px;
}

.hero p {
    font-size: 18px;
}

/* MENU SECTION */

.menu-section {
    padding: 50px 70px;
}

.menu-section h2 {
    text-align: center;
    font-size: 32px;
    margin-bottom: 40px;
}

/* MENU GRID */

.menu-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
}

/* CARD */

.menu-card {
    background-color: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow:
        0 4px 15px rgba(0,0,0,0.1);
    transition:
        transform 0.3s ease,
        box-shadow 0.3s ease;
}

.menu-card:hover {
    transform: translateY(-6px);
    box-shadow:
        0 8px 20px rgba(0,0,0,0.15);
}

.menu-card img {
    width: 100%;
    height: 220px;
    object-fit: cover;
}

.menu-content {
    padding: 20px;
}

.menu-content h3 {
    font-size: 22px;
    margin-bottom: 8px;
}

.category {
    color: #e23744;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 10px;
}

.description {
    color: #666;
    font-size: 14px;
    line-height: 1.5;
    margin-bottom: 15px;
}

.price {
    font-size: 20px;
    font-weight: bold;
    color: #222;
    margin-bottom: 15px;
}

/* BUTTON */

.add-btn {
    display: block;
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 6px;
    background-color: #e23744;
    color: white;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
}

.add-btn:hover {
    background-color: #c82333;
}

/* NO MENU */

.no-menu {
    text-align: center;
    padding: 50px;
    color: #777;
    font-size: 18px;
}

/* FOOTER */

.footer {
    background-color: #222;
    color: white;
    text-align: center;
    padding: 25px;
    margin-top: 40px;
}

/* RESPONSIVE */

@media (max-width: 900px) {

    .menu-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .navbar {
        padding: 0 30px;
    }

    .menu-section {
        padding: 40px 30px;
    }

}

@media (max-width: 600px) {

    .menu-grid {
        grid-template-columns: 1fr;
    }

    .navbar {
        padding: 0 20px;
    }

    .nav-links {
        gap: 15px;
    }

    .hero h1 {
        font-size: 36px;
    }

    .menu-section {
        padding: 30px 20px;
    }

}

</style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">
        Foodies Hub
    </div>

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

        <a href="CartViewServlet">
            Cart
        </a>

    </div>

</div>


<!-- HERO -->

<div class="hero">

    <div>

        <h1>
            Our Menu
        </h1>

        <p>
            Delicious food made with love
        </p>

    </div>

</div>


<!-- MENU -->

<div class="menu-section">

    <h2>
        Explore Our Menu
    </h2>


    <div class="menu-grid">


<%

List<Menu> menuList =
        (List<Menu>) request.getAttribute("menuList");


if (menuList != null && !menuList.isEmpty()) {


    for (Menu menu : menuList) {


        String menuImage = null;


        /*
         * =========================================
         * EXISTING 10 MENU IMAGES
         * DO NOT CHANGE THESE URLs
         * =========================================
         */


        // ID 3 - Chicken 65

        if (menu.getMenuId() == 3) {

            menuImage =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/4/3/ea657516-d730-487b-a4ab-0358095b60df_745cafb8-f6ff-41a7-9592-f13f4a665275.jpg";

        }


        // ID 5 - Butter Chicken

        else if (menu.getMenuId() == 5) {

            menuImage =
                "https://rgonuzemdlvliqvpketn.supabase.co/storage/v1/object/public/menu-items/butter-chicken.jpg";

        }


        // ID 6 - Chicken Tikka

        else if (menu.getMenuId() == 6) {

            menuImage =
                "https://b.zmtcdn.com/data/dish_photos/824/f488f9a9217b5848609e96b414b29824.jpeg";

        }


        // ID 7 - Butter Naan

        else if (menu.getMenuId() == 7) {

            menuImage =
                "https://catalogue.bikanervala.com/cdn/shop/files/ButterNaan.jpg?v=1733814342";

        }


        // ID 8 - Paneer Butter Masala

        else if (menu.getMenuId() == 8) {

            menuImage =
                "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=800&q=80";

        }


        // ID 9 - Masala Dosa

        else if (menu.getMenuId() == 9) {

            menuImage =
                "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=800&q=80";

        }


        // ID 10 - Idly Vada

        else if (menu.getMenuId() == 10) {

            menuImage =
                "https://b.zmtcdn.com/data/pictures/1/19485611/8416c6690d8d8de08143d1f8c2d929d6.jpg";

        }


        // ID 11 - Pongal

        else if (menu.getMenuId() == 11) {

            menuImage =
                "https://athammaskitchen.com/cdn/shop/files/Pongal.jpg?v=1747121186&width=1500";

        }


        // ID 12 - Veg Meals

        else if (menu.getMenuId() == 12) {

            menuImage =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto/ja1e6z6sfnrk8hlsq9uy";

        }


        // ID 14 - Chicken Fry

        else if (menu.getMenuId() == 14) {

            menuImage =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2024/8/17/6ef3bc62-4f39-496a-be1c-b8aed97a1a97_1216075d-5c80-46fd-ac6a-d2f7c774d891.jpeg";

        }


        /*
         * =========================================
         * NEW MENU ITEMS
         * =========================================
         *
         * Existing 10 IDs paina mapping untouched.
         *
         * New menu ID vaste:
         * Admin ichina imageUrl DB nundi vastundi.
         */

        else {

            menuImage = menu.getImageUrl();

        }


        /*
         * If Admin image URL empty,
         * placeholder use chestham.
         *
         * Existing 10 images ki idi apply avvadu,
         * because avi already mapping lo unnayi.
         */

        if (menuImage == null || menuImage.trim().isEmpty()) {

            menuImage =
                "https://via.placeholder.com/800x500?text=Menu+Image";

        }

%>


        <!-- MENU CARD -->

        <div class="menu-card">


            <img
                src="<%= menuImage %>"
                alt="<%= menu.getName() %>"
            >


            <div class="menu-content">


                <h3>

                    <%= menu.getName() %>

                </h3>


                <div class="category">

                    <%= menu.getCategory() %>

                </div>


                <div class="description">

                    <%= menu.getDescription() %>

                </div>


                <div class="price">

                    ₹<%= menu.getPrice() %>

                </div>


                <!-- ADD TO CART -->

                <form action="CartServlet" method="post">

                    <input
                        type="hidden"
                        name="menuId"
                        value="<%= menu.getMenuId() %>"
                    >

                    <input
                        type="hidden"
                        name="price"
                        value="<%= menu.getPrice() %>"
                    >

                    <button
                        type="submit"
                        class="add-btn"
                    >

                        Add to Cart

                    </button>

                </form>


            </div>

        </div>


<%

    }

} else {

%>


        <div class="no-menu">

            No menu items available.

        </div>


<%

}

%>


    </div>

</div>


<!-- FOOTER -->

<div class="footer">

    <p>

        © 2026 Foodies Hub. All Rights Reserved.

    </p>

</div>


</body>

</html>