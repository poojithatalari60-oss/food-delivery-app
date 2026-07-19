<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YourOrders - Order food online</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #fff; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 4px rgba(0,0,0,0.08); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 24px; font-weight: 800; color: #fc8019; }
        .navbar nav a { color: #3d4152; text-decoration: none; margin-left: 28px; font-weight: 600; font-size: 15px; }
        .navbar nav a:hover { color: #fc8019; }
        .hero { background: linear-gradient(135deg, #fc8019, #ff5722); padding: 50px 40px; color: #fff; text-align: center; }
        .hero h1 { font-size: 34px; margin-bottom: 8px; }
        .hero p { font-size: 16px; opacity: 0.9; margin-bottom: 25px; }
        .search-bar { max-width: 600px; margin: 0 auto; display: flex; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 14px rgba(0,0,0,0.15); }
        .search-bar input { flex: 1; border: none; padding: 15px 18px; font-size: 15px; outline: none; }
        .search-bar button { padding: 15px 28px; background: #fc8019; color: #fff; border: none; font-weight: 700; cursor: pointer; font-size: 15px; }
        .search-bar button:hover { background: #e0710f; }
        .container { max-width: 1200px; margin: 0 auto; padding: 35px 40px; }
        .section-title { font-size: 22px; font-weight: 800; margin-bottom: 20px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(270px, 1fr)); gap: 24px; }
        .card { background: #fff; border-radius: 14px; overflow: hidden; text-decoration: none; color: #282c3f; box-shadow: 0 2px 10px rgba(0,0,0,0.07); transition: transform 0.2s, box-shadow 0.2s; }
        .card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.12); }
        .card-img-wrap { position: relative; }
        .card img { width: 100%; height: 170px; object-fit: cover; display: block; background: #eee; }
        .rating-badge { position: absolute; bottom: 10px; left: 10px; background: #fff; padding: 4px 9px; border-radius: 6px; font-size: 13px; font-weight: 700; display: flex; align-items: center; gap: 3px; box-shadow: 0 1px 4px rgba(0,0,0,0.2); }
        .rating-badge.good { color: #48c479; }
        .card-body { padding: 14px 16px; }
        .card-body h3 { margin: 0 0 6px; font-size: 17px; font-weight: 700; }
        .cuisine { color: #686b78; font-size: 13px; margin-bottom: 6px; }
        .meta-row { display: flex; justify-content: space-between; color: #686b78; font-size: 13px; margin-top: 8px; border-top: 1px dashed #e9e9eb; padding-top: 8px; }
        .no-results { text-align: center; padding: 60px 20px; color: #999; font-size: 16px; grid-column: 1 / -1; }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">YourOrders</div>
        <nav>
            <a href="restaurant">Restaurants</a>
            <a href="cart">Cart</a>
            <a href="myorders">My Orders</a>
            <a href="logout">Logout</a>
        </nav>
    </div>

    <div class="hero">
        <h1>Hungry? We've got you covered.</h1>
        <p>Order food from your favorite restaurants, delivered fast.</p>
     <form class="search-bar" action="globalSearch" method="get">
            <input type="text" name="keyword" placeholder="Search for restaurant, cuisine or a place...">
            <button type="submit">Search</button>
        </form>
    </div>

    <div class="container">
        <div class="section-title">
            <%
                List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
                String keyword = request.getParameter("keyword");
                if (keyword != null && !keyword.isEmpty()) {
            %>
                Results for "<%= keyword %>"
            <% } else { %>
                Restaurants near you
            <% } %>
        </div>

        <div class="grid">
            <%
                if (restaurants != null && !restaurants.isEmpty()) {
                    for (Restaurant r : restaurants) {
                        String ratingClass = r.getRating() >= 4.0 ? "good" : "";
            %>
                <a class="card" href="menu?restaurantId=<%= r.getRestaurantId() %>">
                    <div class="card-img-wrap">
                        <img src="<%= r.getImageUrl() %>" alt="<%= r.getName() %>" onerror="this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500'">
                        <div class="rating-badge <%= ratingClass %>">&#9733; <%= r.getRating() %></div>
                    </div>
                    <div class="card-body">
                        <h3><%= r.getName() %></h3>
                        <div class="cuisine"><%= r.getCuisineType() %></div>
                        <div class="cuisine"><%= r.getAddress() %></div>
                        <div class="meta-row">
                            <span><%= r.getDeliveryTime() %></span>
                            <span><%= r.getPriceForTwo() %> for two</span>
                        </div>
                    </div>
                </a>
            <%
                    }
                } else {
            %>
                <div class="no-results">No restaurants found. Try a different search.</div>
            <% } %>
        </div>
    </div>
</body>
</html>