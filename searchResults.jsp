<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Restaurant" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - YourOrders</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #fff; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 4px rgba(0,0,0,0.08); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 24px; font-weight: 800; color: #fc8019; text-decoration: none; }
        .navbar nav a { color: #3d4152; text-decoration: none; margin-left: 28px; font-weight: 600; font-size: 15px; }
        .navbar nav a:hover { color: #fc8019; }
        .container { max-width: 1200px; margin: 0 auto; padding: 35px 40px; }
        .section-title { font-size: 22px; font-weight: 800; margin-bottom: 20px; }
        .subsection-title { font-size: 18px; font-weight: 700; margin: 30px 0 16px; padding-top: 20px; border-top: 1px solid #eee; }
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
        .no-results { text-align: center; padding: 40px 20px; color: #999; font-size: 15px; grid-column: 1 / -1; }
        .order-card { background: #fff; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); padding: 20px 22px; margin-bottom: 16px; max-width: 700px; }
        .order-top { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 10px; }
        .order-id { font-weight: 800; font-size: 16px; }
        .order-date { color: #686b78; font-size: 13px; margin-top: 2px; }
        .status-badge { padding: 5px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.3px; }
        .status-PLACED { background: #fff4e5; color: #fc8019; }
        .status-PREPARING { background: #fff4e5; color: #fc8019; }
        .status-OUT_FOR_DELIVERY { background: #e5f0ff; color: #1565c0; }
        .status-DELIVERED { background: #e6f7ec; color: #0f8a45; }
        .status-CANCELLED { background: #fde8e8; color: #c1121f; }
        .order-meta { display: flex; justify-content: space-between; align-items: center; padding-top: 12px; border-top: 1px dashed #eee; margin-top: 10px; }
        .order-address { color: #686b78; font-size: 13px; max-width: 70%; }
        .order-total { font-weight: 800; font-size: 16px; }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="restaurant" class="logo">YourOrders</a>
        <nav>
            <a href="restaurant">Restaurants</a>
            <a href="cart">Cart</a>
            <a href="myorders">My Orders</a>
            <a href="logout">Logout</a>
        </nav>
    </div>

    <div class="container">
        <%
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            String keyword = request.getParameter("keyword");
        %>
        <div class="section-title">Search results for "<%= keyword %>"</div>

        <div class="subsection-title">Restaurants</div>
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
                <div class="no-results">No matching restaurants.</div>
            <% } %>
        </div>

        <div class="subsection-title">Your Orders</div>
        <%
            if (orders != null && !orders.isEmpty()) {
                for (Order o : orders) {
                    String statusClass = "status-" + o.getStatus();
        %>
            <div class="order-card">
                <div class="order-top">
                    <div>
                        <div class="order-id">Order #<%= o.getOrderId() %></div>
                        <div class="order-date"><%= o.getOrderDate() %></div>
                    </div>
                    <span class="status-badge <%= statusClass %>"><%= o.getStatus() %></span>
                </div>
                <div class="order-meta">
                    <div class="order-address">Delivered to: <%= o.getDeliveryAddress() %></div>
                    <div class="order-total">&#8377;<%= o.getTotalAmount() %></div>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <div class="no-results" style="text-align:left; padding: 10px 0;">No matching past orders.</div>
        <% } %>
    </div>
</body>
</html>