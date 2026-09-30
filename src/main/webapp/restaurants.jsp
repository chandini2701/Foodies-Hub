<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.food.model.Restaurant"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Restaurants</title>

<style>

body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background-color: #f8f8f8;
}

/* Main container */

.container {
    width: 90%;
    margin: 30px auto;
}

/* Heading */

h1 {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
}

/* Restaurant cards */

.restaurant-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
}

/* Card */

.restaurant-card {
    background-color: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
    transition: 0.3s;
}

.restaurant-card:hover {
    transform: translateY(-5px);
}

/* Restaurant image */

.restaurant-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

/* Details */

.restaurant-details {
    padding: 15px;
}

.restaurant-details h2 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 24px;
}

.restaurant-details p {
    margin: 6px 0;
    color: #555;
    font-size: 16px;
}

/* Rating */

.rating {
    color: #e6a800;
    font-weight: bold;
}

/* View menu button */

.view-menu-btn {
    display: block;
    text-align: center;
    background-color: #ff5200;
    color: white;
    padding: 10px;
    margin-top: 12px;
    text-decoration: none;
    border-radius: 6px;
    font-size: 16px;
}

.view-menu-btn:hover {
    background-color: #e64a00;
}

/* Responsive */

@media screen and (max-width: 1000px) {

    .restaurant-container {
        grid-template-columns: repeat(3, 1fr);
    }

}

@media screen and (max-width: 750px) {

    .restaurant-container {
        grid-template-columns: repeat(2, 1fr);
    }

}

@media screen and (max-width: 500px) {

    .restaurant-container {
        grid-template-columns: 1fr;
    }

}

</style>

</head>

<body>

<div class="container">

    <h1>Restaurants</h1>

    <div class="restaurant-container">

<%

/* Get restaurant list from UserRestaurantServlet */

List<Restaurant> restaurantList =
        (List<Restaurant>) request.getAttribute("restaurantList");


if (restaurantList != null && !restaurantList.isEmpty()) {

    for (Restaurant restaurant : restaurantList) {

        int id = restaurant.getRestaurantId();

        /*
         * IMPORTANT:
         *
         * ID 6 = Burger King
         * Display cheyyakudadhu.
         */

        if (id == 6) {
            continue;
        }

        String imageUrl = "";

        /*
         * OLD RESTAURANT IMAGES
         *
         * IDs 1-5 and 7-10
         * Existing images ni change cheyyakudadhu.
         */

        // ID 1 - Paradise Biryani

        if (id == 1) {

            imageUrl =
                "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_600%2Ch_468/v1691800546/a56a291ca2e7e2c0f8f880987c106481.jpg";


        // ID 2 - Empire Restaurant

        } else if (id == 2) {

            imageUrl =
                "https://enstore-app-storage.s3.ap-south-1.amazonaws.com/3985/item-92574871-b173d3afb911ea817e0c880ea746a49a-wLkSbzJNCK.png";


        // ID 3 - Udupi Garden

        } else if (id == 3) {

            imageUrl =
                "https://b.zmtcdn.com/data/dish_photos/923/f0407299cc66fb4b0e923382ef878923.jpg";


        // ID 4 - Meghana Foods

        } else if (id == 4) {

            imageUrl =
                "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_600%2Ch_468/DINEOUT_ALL_RESTAURANTS/IMAGES/RESTAURANT_IMAGE_SERVICE/2024/8/14/ad066eb2-1343-4d18-a978-f4ceaf061082_20240814T150123875.PNG";


        // ID 5 - Truffles

        } else if (id == 5) {

            imageUrl =
                "https://dineout-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_600,h_468/v1691569876/e06090ef25293dd3cc6710f191adcc43.jpg";


        // ID 7 - Wow Momo

        } else if (id == 7) {

            imageUrl =
                "https://b.zmtcdn.com/data/pictures/9/19941979/66f765dac49329c344bece8529f17835.jpg";


        // ID 8 - Pizza Hut

        } else if (id == 8) {

            imageUrl =
                "https://b.zmtcdn.com/data/pictures/5/15875/4d9ba90f122e854bd2d3428b9cd515d0_featured_v2.jpg";


        // ID 9 - Anjappar

        } else if (id == 9) {

            imageUrl =
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy%2Cf_auto%2Cq_auto%2Cw_300%2Ch_300%2Ce_grayscale%2Cc_fit/cxjyyl0vqbzxlv348eg9";


        // ID 10 - Namma Tiffin Center

        } else if (id == 10) {

            imageUrl =
                "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=900&q=80";


        /*
         * ID 11
         *
         * Testing purpose:
         * Fries
         */

        } else if (id == 11) {

            imageUrl =
                "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=80";


        /*
         * ID 12 onwards
         *
         * ADMIN ENTERED IMAGE URL
         *
         * No hardcoding.
         */

        } else {

            imageUrl = restaurant.getImageUrl();

        }

%>

        <!-- ========================= -->
        <!-- RESTAURANT CARD -->
        <!-- ========================= -->

        <div class="restaurant-card">

            <!-- Image -->

            <img
                src="<%= imageUrl %>"
                alt="<%= restaurant.getName() %>"
                onerror="this.src='https://via.placeholder.com/600x400?text=Restaurant+Image';"
            >

            <div class="restaurant-details">

                <!-- Restaurant Name -->

                <h2>

<%

if (id == 11) {

%>

                    Fries

<%

} else {

%>

                    <%= restaurant.getName() %>

<%

}

%>

                </h2>

                <!-- Address -->

                <p>

                    <strong>Address:</strong>

                    <%= restaurant.getAddress() %>

                </p>

                <!-- Phone -->

                <p>

                    <strong>Phone:</strong>

                    <%= restaurant.getPhone() %>

                </p>

                <!-- Cuisine -->

                <p>

                    <strong>Cuisine:</strong>

                    <%= restaurant.getCuisineType() %>

                </p>

                <!-- Rating -->

                <p class="rating">

                    ⭐ <%= restaurant.getRating() %>

                </p>

                <!-- Delivery -->

                <p>

                    <strong>Delivery:</strong>

                    <%= restaurant.getDeliveryTime() %>

                </p>

                <!-- View Menu -->

                <a
                    href="UserMenuServlet?restaurantId=<%= restaurant.getRestaurantId() %>"
                    class="view-menu-btn">

                    View Menu

                </a>

            </div>

        </div>

<%

    }

} else {

%>

        <p style="text-align:center;">

            No restaurants available.

        </p>

<%

}

%>

    </div>

</div>

</body>

</html>