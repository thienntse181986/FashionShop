<%@page import="user.UserDTO"%>
<%@page import="category.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Fashion Store</title>
        <link rel="stylesheet" href="./css/t-shirt.css">
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

        <div >  <!--content services title -->
            <h1 class="title"><%= request.getAttribute("categoryName") == null ? "ALL PRODUCT" : request.getAttribute("categoryName")%></h1>
        </div> 

        <% List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("list"); %>
        <div class="flex">
            <% for (ProductDTO product : list) {%>
            <div class="titile_img">
                <img src="<%= product.getImg()%>" alt="<%= product.getProductName()%>">
                <p><%= product.getProductName()%></p>
                <form action="product" method="GET">
                    <input type="hidden" name="action" value="details" >
                    <input type="hidden" name="productID" value="<%= product.getProductID()%>">
                    <button type="submit" class="button">View Detail &nbsp; &nbsp; &gt;</button>
                </form>
            </div>
            <% }%>
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

                // áº¨n menu khi click ra ngoÃ i
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