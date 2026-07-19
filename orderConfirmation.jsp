<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmed - YourOrders</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; }
        .navbar { background: #e63946; color: #fff; padding: 15px 30px; display: flex; justify-content: space-between; }
        .navbar a { color: #fff; text-decoration: none; margin-left: 15px; }
        .container { max-width: 500px; margin: 60px auto; text-align: center; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .checkmark { font-size: 60px; color: #2a9d8f; }
        h2 { margin-top: 10px; }
        a.btn { display: inline-block; margin-top: 20px; padding: 10px 25px; background: #e63946; color: #fff; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="navbar">
        <div><strong>YourOrders</strong></div>
        <div>
            <a href="restaurant">Restaurants</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="checkmark">&#10003;</div>
        <h2>Order Placed Successfully!</h2>
        <%
            Order order = (Order) request.getAttribute("order");
            if (order != null) {
        %>
            <p>Order ID: #<%= order.getOrderId() %></p>
            <p>Total: &#8377;<%= order.getTotalAmount() %></p>
            <p>Status: <%= order.getStatus() %></p>
        <%
            }
        %>
        <a class="btn" href="myorders">View My Orders</a>
    </div>
</body>
</html>