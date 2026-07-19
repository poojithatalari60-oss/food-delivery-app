<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - YourOrders</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #282c3f; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 20px; font-weight: 800; color: #fff; }
        .navbar nav a { color: #ddd; text-decoration: none; margin-left: 24px; font-weight: 600; font-size: 14px; }
        .navbar nav a:hover { color: #fc8019; }
        .container { max-width: 1100px; margin: 0 auto; padding: 30px 20px; }
        .stats-row { display: flex; gap: 20px; margin-bottom: 30px; }
        .stat-card { flex: 1; background: #fff; border-radius: 12px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.06); }
        .stat-label { font-size: 13px; color: #686b78; text-transform: uppercase; font-weight: 700; }
        .stat-value { font-size: 26px; font-weight: 800; margin-top: 6px; }
        .section-title { font-size: 19px; font-weight: 800; margin: 30px 0 14px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.06); }
        th, td { text-align: left; padding: 12px 14px; font-size: 14px; border-bottom: 1px solid #f0f0f0; }
        th { background: #fafafa; font-weight: 700; color: #686b78; text-transform: uppercase; font-size: 12px; }
        select { padding: 6px 8px; border-radius: 6px; border: 1px solid #ddd; font-size: 13px; }
        .save-btn { padding: 6px 14px; background: #fc8019; color: #fff; border: none; border-radius: 6px; font-size: 12px; font-weight: 700; cursor: pointer; margin-left: 6px; }
        .rating { color: #48c479; font-weight: 700; }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">YourOrders Admin</div>
        <nav>
            <a href="../restaurant">Customer Site</a>
            <a href="../logout">Logout</a>
        </nav>
    </div>

    <div class="container">
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
            Double revenue = (Double) request.getAttribute("revenue");
        %>

        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-label">Total Orders</div>
                <div class="stat-value"><%= orders != null ? orders.size() : 0 %></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Total Revenue</div>
                <div class="stat-value">&#8377;<%= revenue != null ? String.format("%.2f", revenue) : "0.00" %></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Restaurants</div>
                <div class="stat-value"><%= restaurants != null ? restaurants.size() : 0 %></div>
            </div>
        </div>

        <div class="section-title">All Orders</div>
        <table>
            <tr>
                <th>Order ID</th><th>User ID</th><th>Total</th><th>Address</th><th>Date</th><th>Status</th><th></th>
            </tr>
            <%
                if (orders != null) {
                    for (Order o : orders) {
            %>
            <tr>
                <td>#<%= o.getOrderId() %></td>
                <td><%= o.getUserId() %></td>
                <td>&#8377;<%= o.getTotalAmount() %></td>
                <td><%= o.getDeliveryAddress() %></td>
                <td><%= o.getOrderDate() %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/admin/updateOrder" method="post" style="display:flex; align-items:center;">
                        <input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
                        <select name="status">
                            <option value="PLACED" <%= "PLACED".equals(o.getStatus()) ? "selected" : "" %>>PLACED</option>
                            <option value="PREPARING" <%= "PREPARING".equals(o.getStatus()) ? "selected" : "" %>>PREPARING</option>
                            <option value="OUT_FOR_DELIVERY" <%= "OUT_FOR_DELIVERY".equals(o.getStatus()) ? "selected" : "" %>>OUT_FOR_DELIVERY</option>
                            <option value="DELIVERED" <%= "DELIVERED".equals(o.getStatus()) ? "selected" : "" %>>DELIVERED</option>
                            <option value="CANCELLED" <%= "CANCELLED".equals(o.getStatus()) ? "selected" : "" %>>CANCELLED</option>
                        </select>
                        <button type="submit" class="save-btn">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <div class="section-title">Restaurants</div>
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Cuisine</th><th>Address</th><th>Rating</th>
            </tr>
            <%
                if (restaurants != null) {
                    for (Restaurant r : restaurants) {
            %>
            <tr>
                <td><%= r.getRestaurantId() %></td>
                <td><%= r.getName() %></td>
                <td><%= r.getCuisineType() %></td>
                <td><%= r.getAddress() %></td>
                <td class="rating">&#9733; <%= r.getRating() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</body>
</html>