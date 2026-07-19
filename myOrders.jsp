<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - YourOrders</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #fff; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 4px rgba(0,0,0,0.08); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 22px; font-weight: 800; color: #fc8019; text-decoration: none; }
        .navbar nav a { color: #3d4152; text-decoration: none; margin-left: 26px; font-weight: 600; font-size: 15px; }
        .navbar nav a:hover { color: #fc8019; }
        .container { max-width: 700px; margin: 0 auto; padding: 35px 20px; }
        .page-title { font-size: 24px; font-weight: 800; margin-bottom: 20px; }
        .order-card { background: #fff; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); padding: 20px 22px; margin-bottom: 16px; }
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
        .empty-state { text-align: center; padding: 80px 20px; }
        .empty-state .icon { font-size: 60px; margin-bottom: 10px; }
        .empty-state p { color: #999; font-size: 16px; margin-bottom: 20px; }
        .browse-btn { display: inline-block; padding: 12px 28px; background: #fc8019; color: #fff; border-radius: 8px; text-decoration: none; font-weight: 700; }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="restaurant" class="logo">YourOrders</a>
        <nav>
            <a href="restaurant">Restaurants</a>
            <a href="cart">Cart</a>
            <a href="logout">Logout</a>
        </nav>
    </div>

    <div class="container">
        <div class="page-title">My Orders</div>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders == null || orders.isEmpty()) {
        %>
            <div class="empty-state">
                <div class="icon">📦</div>
                <p>You haven't placed any orders yet.</p>
                <a class="browse-btn" href="restaurant">Order Now</a>
            </div>
        <%
            } else {
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
            }
        %>
    </div>
</body>
</html>