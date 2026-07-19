<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Menu" %>
<%@ page import="model.Restaurant" %>
<%@ page import="com.food.dao.RestaurantDAO" %>
<%@ page import="com.food.dao.RestaurantDAOImpl" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - YourOrders</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f8f8f8; margin: 0; color: #282c3f; }
        .navbar { background: #fff; padding: 14px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 4px rgba(0,0,0,0.08); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 22px; font-weight: 800; color: #fc8019; text-decoration: none; }
        .navbar nav a { color: #3d4152; text-decoration: none; margin-left: 26px; font-weight: 600; font-size: 15px; }
        .restaurant-header { background: #fff; padding: 30px 40px; border-bottom: 1px solid #eee; }
        .restaurant-header h1 { margin: 0 0 6px; font-size: 28px; }
        .restaurant-header .meta { color: #686b78; font-size: 14px; }
        .rating-pill { display: inline-flex; align-items: center; gap: 4px; background: #48c479; color: #fff; padding: 3px 9px; border-radius: 5px; font-size: 13px; font-weight: 700; margin-right: 10px; }
        .container { max-width: 900px; margin: 0 auto; padding: 25px 40px; }
        .filter-tabs { display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; }
        .filter-tabs button { padding: 8px 18px; border-radius: 20px; border: 1px solid #ddd; background: #fff; cursor: pointer; font-weight: 600; font-size: 13px; }
        .filter-tabs button.active { background: #fc8019; color: #fff; border-color: #fc8019; }
        .category-block { margin-bottom: 30px; }
        .category-title { font-size: 19px; font-weight: 800; margin-bottom: 4px; padding-bottom: 10px; border-bottom: 2px solid #f0f0f0; }
        .item { background: #fff; border-radius: 10px; box-shadow: 0 1px 6px rgba(0,0,0,0.06); padding: 16px; margin-bottom: 14px; display: flex; justify-content: space-between; gap: 16px; }
        .item.non-veg-hide, .item.veg-hide { display: none; }
        .item-info { flex: 1; }
        .veg-tag { display: inline-block; width: 14px; height: 14px; border: 2px solid #0f8a45; border-radius: 3px; position: relative; margin-right: 8px; vertical-align: middle; }
        .veg-tag::after { content: ''; width: 6px; height: 6px; background: #0f8a45; border-radius: 50%; position: absolute; top: 2px; left: 2px; }
        .nonveg-tag { border-color: #c1121f; }
        .nonveg-tag::after { background: #c1121f; }
        .item h4 { margin: 0 0 6px; font-size: 16px; display: flex; align-items: center; }
        .item p { margin: 0 0 8px; color: #686b78; font-size: 13px; line-height: 1.4; }
        .price { font-weight: 700; font-size: 15px; }
        .item-img-wrap { position: relative; flex-shrink: 0; }
        .item img { width: 110px; height: 90px; object-fit: cover; border-radius: 8px; background: #eee; }
        .add-form { position: absolute; bottom: -12px; left: 50%; transform: translateX(-50%); display: flex; align-items: center; gap: 6px; }
        .add-form input[type=number] { width: 40px; padding: 5px; border: 1px solid #ddd; border-radius: 4px; text-align: center; }
        .add-btn { padding: 7px 16px; background: #fff; color: #fc8019; border: 1px solid #fc8019; border-radius: 6px; cursor: pointer; font-weight: 700; font-size: 13px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .add-btn:hover { background: #fff5ec; }
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

    <%
        List<Menu> menuItems = (List<Menu>) request.getAttribute("menuItems");
        Object restaurantIdAttr = request.getAttribute("restaurantId");
        int restId = (restaurantIdAttr != null) ? Integer.parseInt(restaurantIdAttr.toString()) : 0;

        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        Restaurant restaurant = restaurantDAO.getRestaurantById(restId);
    %>

    <div class="restaurant-header">
        <h1><%= restaurant != null ? restaurant.getName() : "Menu" %></h1>
        <div class="meta">
            <span class="rating-pill">&#9733; <%= restaurant != null ? restaurant.getRating() : "" %></span>
            <%= restaurant != null ? restaurant.getCuisineType() : "" %> &middot;
            <%= restaurant != null ? restaurant.getAddress() : "" %> &middot;
            <%= restaurant != null ? restaurant.getDeliveryTime() : "" %>
        </div>
    </div>

    <div class="container">
        <div class="filter-tabs">
            <button class="active" onclick="filterMenu('all', this)">All</button>
            <button onclick="filterMenu('veg', this)">🟢 Veg</button>
            <button onclick="filterMenu('nonveg', this)">🔴 Non-Veg</button>
        </div>

        <%
            // Group items by category, preserving order
            LinkedHashMap<String, List<Menu>> categorized = new LinkedHashMap<>();
            if (menuItems != null) {
                for (Menu m : menuItems) {
                    String cat = (m.getCategory() == null || m.getCategory().isEmpty()) ? "Other" : m.getCategory();
                    categorized.computeIfAbsent(cat, k -> new ArrayList<>()).add(m);
                }
            }

            for (Map.Entry<String, List<Menu>> entry : categorized.entrySet()) {
        %>
            <div class="category-block">
                <div class="category-title"><%= entry.getKey() %> (<%= entry.getValue().size() %>)</div>
                <%
                    for (Menu m : entry.getValue()) {
                        String vegClass = m.isVeg() ? "veg" : "nonveg";
                %>
                    <div class="item" data-veg="<%= vegClass %>">
                        <div class="item-info">
                            <h4>
                                <span class="veg-tag <%= m.isVeg() ? "" : "nonveg-tag" %>"></span>
                                <%= m.getItemName() %>
                            </h4>
                            <div class="price">&#8377;<%= m.getPrice() %></div>
                            <p><%= m.getDescription() %></p>
                        </div>
                        <div class="item-img-wrap">
                            <img src="<%= m.getImageUrl() %>" alt="<%= m.getItemName() %>" onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400'">
                            <form class="add-form" action="cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
                                <input type="hidden" name="restaurantId" value="<%= restId %>">
                                <input type="number" name="quantity" value="1" min="1">
                                <button type="submit" class="add-btn">ADD</button>
                            </form>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        <%
            }
        %>
    </div>

    <script>
        function filterMenu(type, btn) {
            document.querySelectorAll('.filter-tabs button').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            document.querySelectorAll('.item').forEach(item => {
                if (type === 'all') {
                    item.style.display = 'flex';
                } else {
                    item.style.display = (item.getAttribute('data-veg') === type) ? 'flex' : 'none';
                }
            });
            document.querySelectorAll('.category-block').forEach(block => {
                const visibleItems = block.querySelectorAll('.item[style="display: flex;"], .item:not([style])');
                let anyVisible = false;
                block.querySelectorAll('.item').forEach(i => { if (i.style.display !== 'none') anyVisible = true; });
                block.style.display = anyVisible ? 'block' : 'none';
            });
        }
    </script>
</body>
</html>