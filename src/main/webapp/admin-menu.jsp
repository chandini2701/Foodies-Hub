<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>

<%@ page import="com.food.model.Menu"%>
<%@ page import="com.food.model.Restaurant"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin - Menu Management</title>

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f5f5;
}

.navbar {
    background: #ff5722;
    color: white;
    padding: 18px 35px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar h2 {
    margin: 0;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin-left: 20px;
    font-weight: bold;
}

.container {
    width: 92%;
    margin: 30px auto;
}

.card {
    background: white;
    padding: 25px;
    margin-bottom: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

h2, h3 {
    color: #333;
}

input, select, textarea {
    width: 100%;
    padding: 10px;
    margin: 7px 0 15px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    background: #ff5722;
    color: white;
    border: none;
    padding: 11px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}

button:hover {
    background: #e64a19;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #ff5722;
    color: white;
}

.food-image {
    width: 110px;
    height: 85px;
    object-fit: cover;
    border-radius: 8px;
}

.delete-btn {
    background: #d32f2f;
}

.delete-btn:hover {
    background: #b71c1c;
}

.message {
    background: #dff0d8;
    color: #2e7d32;
    padding: 12px;
    border-radius: 5px;
    margin-bottom: 20px;
}

</style>

</head>

<body>

<div class="navbar">

    <h2>TapFoods Admin</h2>

    <div>

        <a href="admin.html">Home</a>

        <a href="RestaurantServlet">Restaurants</a>

        <a href="MenuServlet">Menus</a>

    </div>

</div>


<div class="container">


<%

String message = (String) request.getAttribute("message");

if (message != null && !message.trim().isEmpty()) {

%>

<div class="message">

    <%= message %>

</div>

<%

}

%>


<!-- ================= ADD MENU ================= -->

<div class="card">

<h2>Add Menu</h2>

<form action="MenuServlet" method="post">

<input type="hidden" name="action" value="add">


<label>Restaurant</label>

<select name="restaurantId" required>

<option value="">Select Restaurant</option>

<%

List<Restaurant> restaurantList =
        (List<Restaurant>) request.getAttribute("restaurantList");

if (restaurantList != null) {

    for (Restaurant restaurant : restaurantList) {

%>

<option value="<%= restaurant.getRestaurantId() %>">

    <%= restaurant.getName() %>

</option>

<%

    }

}

%>

</select>


<label>Food Name</label>

<input type="text"
       name="name"
       placeholder="Enter food name"
       required>


<label>Description</label>

<textarea name="description"
          placeholder="Enter description"
          required></textarea>


<label>Price</label>

<input type="number"
       name="price"
       step="0.01"
       required>


<label>Category</label>

<input type="text"
       name="category"
       placeholder="Enter category"
       required>


<label>Image URL</label>

<input type="text"
       name="imageUrl"
       placeholder="Enter image URL"
       required>


<label>Available</label>

<select name="available">

<option value="true">Available</option>

<option value="false">Not Available</option>

</select>


<button type="submit">

    Add Menu

</button>

</form>

</div>


<!-- ================= UPDATE MENU ================= -->

<div class="card">

<h2>Update Menu</h2>

<form action="MenuServlet" method="post">

<input type="hidden" name="action" value="update">


<label>Menu ID</label>

<input type="number"
       name="menuId"
       required>


<label>Restaurant</label>

<select name="restaurantId" required>

<option value="">Select Restaurant</option>

<%

if (restaurantList != null) {

    for (Restaurant restaurant : restaurantList) {

%>

<option value="<%= restaurant.getRestaurantId() %>">

    <%= restaurant.getName() %>

</option>

<%

    }

}

%>

</select>


<label>Food Name</label>

<input type="text"
       name="name"
       required>


<label>Description</label>

<textarea name="description"
          required></textarea>


<label>Price</label>

<input type="number"
       name="price"
       step="0.01"
       required>


<label>Category</label>

<input type="text"
       name="category"
       required>


<label>Image URL</label>

<input type="text"
       name="imageUrl"
       required>


<label>Available</label>

<select name="available">

<option value="true">Available</option>

<option value="false">Not Available</option>

</select>


<button type="submit">

    Update Menu

</button>

</form>

</div>


<!-- ================= DELETE MENU ================= -->

<div class="card">

<h2>Delete Menu</h2>

<form action="MenuServlet" method="post">

<input type="hidden" name="action" value="delete">


<label>Menu ID</label>

<input type="number"
       name="menuId"
       required>


<button type="submit"
        class="delete-btn">

    Delete Menu

</button>

</form>

</div>


<!-- ================= MENU TABLE ================= -->

<div class="card">

<h2>Menu List</h2>

<table>

<tr>

    <th>Image</th>

    <th>Menu ID</th>

    <th>Restaurant ID</th>

    <th>Food Name</th>

    <th>Description</th>

    <th>Price</th>

    <th>Category</th>

    <th>Status</th>

</tr>


<%

List<Menu> menuList =
        (List<Menu>) request.getAttribute("menuList");

if (menuList != null) {

    for (Menu menu : menuList) {

        int id = menu.getMenuId();

        String adminMenuImage = "";

        /*
         * ==========================================
         * EXISTING 10 MENU IMAGES
         * DO NOT CHANGE THESE
         * ==========================================
         */

        if (id == 3) {

            // Chicken 65

            adminMenuImage =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2025/4/3/ea657516-d730-487b-a4ab-0358095b60df_745cafb8-f6ff-41a7-9592-f13f4a665275.jpg";


        } else if (id == 5) {

            // Butter Chicken

            adminMenuImage =
                "https://rgonuzemdlvliqvpketn.supabase.co/storage/v1/object/public/menu-items/butter-chicken.jpg";


        } else if (id == 6) {

            // Chicken Tikka

            adminMenuImage =
                "https://b.zmtcdn.com/data/dish_photos/824/f488f9a9217b5848609e96b414b29824.jpeg";


        } else if (id == 7) {

            // Butter Naan

            adminMenuImage =
                "https://catalogue.bikanervala.com/cdn/shop/files/ButterNaan.jpg?v=1733814342";


        } else if (id == 8) {

            // Paneer Butter Masala

            adminMenuImage =
                "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=800&q=80";


        } else if (id == 9) {

            // Masala Dosa

            adminMenuImage =
                "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=800&q=80";


        } else if (id == 10) {

            // Idly Vada

            adminMenuImage =
                "https://b.zmtcdn.com/data/pictures/1/19485611/8416c6690d8d8de08143d1f8c2d929d6.jpg";


        } else if (id == 11) {

            // Pongal

            adminMenuImage =
                "https://athammaskitchen.com/cdn/shop/files/Pongal.jpg?v=1747121186&width=1500";


        } else if (id == 12) {

            // Veg Meals

            adminMenuImage =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto/ja1e6z6sfnrk8hlsq9uy";


        } else if (id == 14) {

            // Chicken Fry

            adminMenuImage =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/FOOD_CATALOG/IMAGES/CMS/2024/8/17/6ef3bc62-4f39-496a-be1c-b8aed97a1a97_1216075d-5c80-46fd-ac6a-d2f7c774d891.jpeg";


        } else {

            /*
             * ==========================================
             * NEW MENU ITEMS
             * ADMIN ENTERED IMAGE URL
             * ==========================================
             */

            adminMenuImage = menu.getImageUrl();

        }


        /*
         * Image URL empty ayithe placeholder
         */

        if (adminMenuImage == null ||
            adminMenuImage.trim().isEmpty()) {

            adminMenuImage =
                "https://via.placeholder.com/110x85?text=No+Image";

        }

%>


<tr>

<td>

<img src="<%= adminMenuImage %>"
     class="food-image"
     alt="<%= menu.getName() %>">

</td>


<td>

    <%= menu.getMenuId() %>

</td>


<td>

    <%= menu.getRestaurantId() %>

</td>


<td>

    <%= menu.getName() %>

</td>


<td>

    <%= menu.getDescription() %>

</td>


<td>

    ₹<%= menu.getPrice() %>

</td>


<td>

    <%= menu.getCategory() %>

</td>


<td>

<%

if (menu.isAvailable()) {

%>

<span style="color:green;font-weight:bold;">

    Available

</span>

<%

} else {

%>

<span style="color:red;font-weight:bold;">

    Not Available

</span>

<%

}

%>

</td>

</tr>


<%

    }

}

%>


</table>

</div>

</div>

</body>

</html>