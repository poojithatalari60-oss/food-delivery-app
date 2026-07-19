<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - YourOrders</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #fff; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 4px rgba(0,0,0,0.08); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 22px; font-weight: 800; color: #fc8019; text-decoration: none; }
        .navbar nav a { color: #3d4152; text-decoration: none; margin-left: 26px; font-weight: 600; font-size: 15px; }
        .navbar nav a:hover { color: #fc8019; }
        .container { max-width: 650px; margin: 0 auto; padding: 35px 20px; }
        .page-title { font-size: 24px; font-weight: 800; margin-bottom: 20px; }
        .cart-box { background: #fff; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .item-row { display: flex; justify-content: space-between; align-items: center; padding: 18px 22px; border-bottom: 1px solid #f0f0f0; }
        .item-row:last-child { border-bottom: none; }
        .item-name { font-weight: 700; font-size: 15px; margin-bottom: 4px; }
        .item-qty { color: #686b78; font-size: 13px; }
        .item-right { display: flex; align-items: center; gap: 18px; }
        .item-price { font-weight: 700; font-size: 15px; min-width: 70px; text-align: right; }
        .remove-btn { background: none; border: 1px solid #ffdcc9; color: #fc8019; cursor: pointer; font-size: 12px; font-weight: 700; padding: 6px 12px; border-radius: 6px; }
        .remove-btn:hover { background: #fff5ec; }
        .total-box { background: #fff; padding: 20px 22px; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); margin-top: 20px; display: flex; justify-content: space-between; align-items: center; }
        .total-label { color: #686b78; font-size: 14px; }
        .total-value { font-weight: 800; font-size: 20px; }
        .checkout-btn { display: block; text-align: center; margin-top: 20px; padding: 15px; background: #fc8019; color: #fff; border: none; border-radius: 10px; cursor: pointer; font-size: 16px; font-weight: 700; text-decoration: none; box-shadow: 0 4px 12px rgba(252,128,25,0.3); }
        .checkout-btn:hover { background: #e0710f; }
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
            <a href="myorders">My Orders</a>
            <a href="logout">Logout</a>
        </nav>
    </div>

    <div class="container">
        <div class="page-title">Your Cart</div>
        <%
            List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
            Double total = (Double) request.getAttribute("total");
            if (cartItems == null || cartItems.isEmpty()) {
        %>
            <div class="empty-state">
                <div class="icon">🛒</div>
                <p>Your cart is empty. Add something tasty!</p>
                <a class="browse-btn" href="restaurant">Browse Restaurants</a>
            </div>
        <%
            } else {
                int checkoutRestaurantId = cartItems.get(0).getRestaurantId();
        %>
            <div class="cart-box">
                <%
                    for (CartItem item : cartItems) {
                %>
                    <div class="item-row">
                        <div>
                            <div class="item-name"><%= item.getItemName() %></div>
                            <div class="item-qty">Qty: <%= item.getQuantity() %> &times; &#8377;<%= item.getPrice() %></div>
                        </div>
                        <div class="item-right">
                            <div class="item-price">&#8377;<%= item.getPrice() * item.getQuantity() %></div>
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                <button type="submit" class="remove-btn">Remove</button>
                            </form>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>

            <div class="total-box">
                <span class="total-label">To Pay</span>
                <span class="total-value">&#8377;<%= total %></span>
            </div>

            <a class="checkout-btn" href="checkout?restaurantId=<%= checkoutRestaurantId %>">Proceed to Checkout</a>
        <%
            }
        %>
    </div>
</body>
</html>