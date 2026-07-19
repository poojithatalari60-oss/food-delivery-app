<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - YourOrders</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #fff; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 4px rgba(0,0,0,0.08); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 22px; font-weight: 800; color: #fc8019; text-decoration: none; }
        .navbar nav a { color: #3d4152; text-decoration: none; margin-left: 26px; font-weight: 600; font-size: 15px; }
        .navbar nav a:hover { color: #fc8019; }
        .container { max-width: 550px; margin: 0 auto; padding: 35px 20px; }
        .page-title { font-size: 24px; font-weight: 800; margin-bottom: 20px; }
        .box { background: #fff; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); padding: 22px; }
        .section-label { font-size: 13px; font-weight: 700; color: #686b78; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 12px; }
        .item-row { display: flex; justify-content: space-between; padding: 8px 0; font-size: 14px; }
        .item-row span:first-child { color: #3d4152; }
        .divider { border: none; border-top: 1px dashed #e5e5e5; margin: 14px 0; }
        .total-row { display: flex; justify-content: space-between; font-weight: 800; font-size: 17px; padding-top: 4px; }
        .address-box { margin-top: 20px; }
        textarea, input[type=text] { width: 100%; padding: 13px 14px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px; font-family: inherit; resize: none; box-sizing: border-box; }
        textarea:focus, input[type=text]:focus { outline: none; border-color: #fc8019; }
        .place-order-btn { width: 100%; margin-top: 20px; padding: 15px; background: #fc8019; color: #fff; border: none; border-radius: 10px; cursor: pointer; font-size: 16px; font-weight: 700; box-shadow: 0 4px 12px rgba(252,128,25,0.3); }
        .place-order-btn:hover { background: #e0710f; }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="restaurant" class="logo">YourOrders</a>
        <nav>
            <a href="cart">Back to Cart</a>
            <a href="logout">Logout</a>
        </nav>
    </div>

    <div class="container">
        <div class="page-title">Checkout</div>
        <div class="box">
            <div class="section-label">Order Summary</div>
            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                Double total = (Double) request.getAttribute("total");
                Object restaurantIdAttr = request.getAttribute("restaurantId");
                if (cartItems != null) {
                    for (CartItem item : cartItems) {
            %>
                <div class="item-row">
                    <span><%= item.getItemName() %> &times; <%= item.getQuantity() %></span>
                    <span>&#8377;<%= item.getPrice() * item.getQuantity() %></span>
                </div>
            <%
                    }
                }
            %>
            <hr class="divider">
            <div class="total-row">
                <span>To Pay</span>
                <span>&#8377;<%= total %></span>
            </div>

            <div class="address-box">
                <div class="section-label">Delivery Address</div>
                <form action="placeOrder" method="post">
                    <input type="hidden" name="restaurantId" value="<%= restaurantIdAttr %>">
                    <textarea name="address" rows="3" placeholder="Enter your full delivery address" required></textarea>
                    <button type="submit" class="place-order-btn">Place Order &middot; &#8377;<%= total %></button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>