# Food Delivery Web Application

A full-stack food ordering platform built with Java EE (Servlets + JSP), JDBC, and MySQL.

## Features
- User registration & login with jBCrypt password hashing
- Browse restaurants and view dynamic menus
- Add items to cart, update quantities, checkout
- Place orders and view order history
- Global search across restaurants/menu items
- Admin dashboard — add restaurants, update/delete orders

## Tech Stack
- Java, Servlets, JSP (Jakarta EE)
- JDBC + MySQL
- HTML5, CSS3
- jBCrypt (password hashing)
- Apache Tomcat

## Project Structure


src/                  → Java classes (servlets, DAOs, models)
WebContent/           → JSP/HTML pages
WebContent/WEB-INF/   → web.xml, lib/ (jars)

## Setup Instructions
1. Import as a Dynamic Web Project in Eclipse
2. Run `schema.sql` in MySQL to create the database and tables
3. Update DB credentials in `DBUtil.java`
4. Add `mysql-connector-j-9.7.0.jar` and `jbcrypt-0.4.jar` to `WEB-INF/lib`
5. Deploy on Apache Tomcat
6. Access via `http://localhost:8080/food-delivery-app/`

## Screenshots
_(add screenshots of home page, menu, cart, admin dashboard)_
