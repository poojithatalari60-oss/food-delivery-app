<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YourOrders - Order food online</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; margin: 0; color: #282c3f; }
        .hero { min-height: 100vh; display: flex; flex-direction: column; align-items: center; justify-content: center; background: linear-gradient(135deg, #fc8019, #ff5722); color: #fff; text-align: center; padding: 20px; }
        .logo { font-size: 40px; font-weight: 800; margin-bottom: 10px; }
        .tagline { font-size: 17px; opacity: 0.9; margin-bottom: 40px; }
        .btn-group { display: flex; gap: 16px; }
        .btn { padding: 14px 34px; border-radius: 8px; text-decoration: none; font-weight: 700; font-size: 15px; }
        .btn-primary { background: #fff; color: #fc8019; }
        .btn-primary:hover { background: #f2f2f2; }
        .btn-outline { border: 2px solid #fff; color: #fff; }
        .btn-outline:hover { background: rgba(255,255,255,0.15); }
    </style>
</head>
<body>
    <div class="hero">
        <div class="logo">YourOrders</div>
        <div class="tagline">Order food from your favorite restaurants, delivered fast.</div>
        <div class="btn-group">
            <a class="btn btn-primary" href="register.html">Register</a>
            <a class="btn btn-outline" href="login.html">Login</a>
        </div>
    </div>
</body>
</html>