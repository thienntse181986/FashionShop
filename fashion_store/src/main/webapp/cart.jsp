<%-- 
    Document   : cart
    Created on : Mar 8, 2025, 8:57:28 AM
    Author     : ADMIN
--%>

<%@page import="user.UserDTO"%>
<%@page import="product.CartItem"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/cart.css" rel="stylesheet">

        <title>Document</title>
    </head>

    <body>
        <header>
            <nav class="navbar">
                <ul class="nav-left">
                    <li><a href="index.jsp">Home</a></li>
                    <li class="dropdown">
                        <a href="./product?action=all">Product▼</a>
                        <ul class="dropdown-menu">
                            <li><a href="./product?categoryID=1">T-Shirt</a></li>
                            <li><a href="./product?categoryID=2">Shorts</a></li>
                        </ul>
                    </li>
                </ul>

                <div class="logo">
                    <img src="img/logoThuongHieu.jpg" alt="">
                </div>

                <div class="nav-right">
                    <input type="text" placeholder="Search..." class="search-box">
                    <% if (session.getAttribute("usersession") != null) {%>
                    <span><a href="order?action=orderHistory">👤 <%= ((UserDTO) session.getAttribute("usersession")).getUsername()%></a></span>
                    <a href="./login?action=logout">Logout</a>
                    <% } else { %>
                    <a href="./login">Login</a>
                    <% } %>
                    <a href="cart.jsp">Bag</a>
                </div>
            </nav>
        </header>

        


        <%
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            double totalAmount = 0;
            if (cart != null && !cart.isEmpty()) {
                for (CartItem item : cart) {
                    totalAmount += item.getProduct().getPrice() * item.getQuantity();
        %>
        <div class="cart-item">
            <div class="item-image">
                <img src="<%= item.getProduct().getImg()%>" alt="<%= item.getProduct().getProductName()%>">
            </div>
            <div class="item-details">
                <h3 class="item-name"><%= item.getProduct().getProductName()%></h3>
                <p class="item-size">Size: <%= item.getSize().getSizeName()%></p>
                <p class="item-price">Price: <span class="price"><%= String.format("%,.0f₫", item.getProduct().getPrice())%></span></p>
            </div>
            <div class="quantity-control">
                <div class="quantity-control">
                    <a href="./product?action=decrease&productID=<%= item.getProduct().getProductID()%>&size=<%= item.getSize().getSizeName()%>" class="decrease">-</a>
                    <a class="border"><%= item.getQuantity()%></a>
                    <a href="./product?action=increase&productID=<%= item.getProduct().getProductID()%>&size=<%= item.getSize().getSizeName()%>" class="increase">+</a>
                </div>

            </div>
            <div class="subtotal">
                <p>Thành tiền: <span class="subtotal-price"><%= String.format("%,.0f₫", item.getProduct().getPrice() * item.getQuantity())%></span></p>
            </div>
        </div>
        <%}%>
        <div class="cart-total">
            <h2>TOTAL: <span class="total-amount"><%= String.format("%,.0f₫", totalAmount)%></span></h2>
            <a href="checkout.jsp" class="checkout-button">CHECKOUT</a>
        </div>

        <%}%>


















        <!--Footer -->
        <div class="footer">
            <div class="footer_text">
                <ul>
                    <li>Phone : 0913538249</li>
                    <li>Address : 68 Bui Vien Street, Pham Ngu Lao Ward, District 1, Ho Chi Minh City</li>
                    <li>Copyright - Vietnamese Brand.</li>
                </ul>
            </div>

            <div>
                <div class="footer_img">
                    <a href="#"><img src="img/facebook_1.png" /></a>
                    <a href="#"><img src="img/link_xahoi.png" /></a>
                    <a href="#"><img src="img/Twiter.png" /></a>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const dropdownToggle = document.querySelector(".dropdown-toggle");
                const dropdownMenu = document.querySelector(".dropdown-menu");

                dropdownToggle.addEventListener("click", function (event) {
                    event.preventDefault();
                    dropdownMenu.classList.toggle("show");
                });

                document.addEventListener("click", function (event) {
                    if (!dropdownToggle.contains(event.target) && !dropdownMenu.contains(event.target)) {
                        dropdownMenu.classList.remove("show");
                    }
                });
            });
        </script>
    </body>

</html>
