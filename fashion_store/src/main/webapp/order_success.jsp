<%@page import="user.UserDTO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt hàng thành công</title>
        <link href="css/order_success.css" rel="stylesheet">
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
                    <% }%>
                    <a href="cart.jsp">Bag</a>
                </div>
            </nav>
        </header>
        <div class="container">
            <div class="container order-success">
                <h2>🎉 Đặt hàng thành công!</h2>
                <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đang được xử lý.</p>
                <a href="order?action=orderHistory" class="btn">Xem lịch sử mua hàng</a>
                <a href="index.jsp" class="btn btn-secondary">Return Home</a>
            </div>









            <footer class="footer">
                <div class="footer_text">
                    <ul>
                        <li>Phone: 0913538249</li>
                        <li>Address: 68 Bùi Viện, P. Phạm Ngũ Lão, Q1, TP.HCM</li>
                        <li>Copyright - Vietnamese Brand.</li>
                    </ul>
                </div>
                <div class="footer_img">
                    <a href="#"><img src="img/facebook_1.png" /></a>
                    <a href="#"><img src="img/link_xahoi.png" /></a>
                    <a href="#"><img src="img/Twiter.png" /></a>
                </div>
            </footer>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const cart = document.getElementById("cart");
                    const bagButton = document.querySelector(".nav-right a[href='#']");
                    const closeButton = document.querySelector(".close-btn");

                    bagButton.addEventListener("click", function (event) {
                        event.preventDefault();
                        cart.classList.add("show");
                    });

                    closeButton.addEventListener("click", function () {
                        cart.classList.remove("show");
                    });

                    document.addEventListener("click", function (event) {
                        if (!cart.contains(event.target) && !bagButton.contains(event.target)) {
                            cart.classList.remove("show");
                        }
                    });
                });
            </script>

    </body>
</html>
