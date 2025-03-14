<%@page import="user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/register.css" rel="stylesheet">

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
        
        <div class="form">
            <div>
                <h2>REGISTER</h2>
            </div>

            <div>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) {%>
                <h3 style="color: red"> <%= error%> </h3>
                <% }%>
                <form class="form2" action="./register" method="POST">
                    <input type="text" placeholder="Phone" name="phone"> <br> <br>
                    <input type="text" placeholder="Username" name="username"> <br> <br>
                    <input type="password" placeholder="Password" name="password"> <br> <br>
                    <input type="password" placeholder="Repeat Password" name="repeatPass"> <br> <br>
                    <input class="buttonLogin" type="submit" value="Register"> <br> <br>
                </form>
            </div>
            <div class="form_text">
                <a href="login.jsp">RETURN</a><br> <br>
            </div>
        </div>

























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

            document.addEventListener("DOMContentLoaded", function () {
                const cart = document.getElementById("cart");
                const bagButton = document.querySelector(".nav-right a[href='#']");
                const closeButton = document.querySelector(".close-btn");

                // Khi bấm vào "Bag", giỏ hàng hiện ra
                bagButton.addEventListener("click", function (event) {
                    event.preventDefault();
                    cart.classList.add("show");
                });

                // Khi bấm nút "X", giỏ hàng ẩn đi
                closeButton.addEventListener("click", function () {
                    cart.classList.remove("show");
                });

                // Bấm ra ngoài thì ẩn giỏ hàng
                document.addEventListener("click", function (event) {
                    if (!cart.contains(event.target) && !bagButton.contains(event.target)) {
                        cart.classList.remove("show");
                    }
                });
            });
        </script>

    </body>
</html>