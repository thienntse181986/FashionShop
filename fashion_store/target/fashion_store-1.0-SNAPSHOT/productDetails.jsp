<%@page import="user.UserDTO"%>
<%@page import="product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="./css/productDetails.css" rel="stylesheet">

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

        <%ProductDTO product = (ProductDTO) request.getAttribute("product");%>
        <div class="product-container">
            <div class="product-image">
                <img src="<%=product.getImg()%>" alt="<%=product.getProductName()%>">
            </div>
            <div class="product-details">
                <h1><%=product.getProductName()%></h1>
                <p class="price"><%= String.format("%,.0f₫", product.getPrice())%></p>

                <form action="product" method="POST">
                    <input type="hidden" name="productID" value="<%=product.getProductID()%>">
                    <input type="hidden" name="action" value="add">
                    <div class="sizes">
                        <label>KÍCH THƯỚC</label>
                        <div class="size-options">
                            <div style="margin-right: 15px">
                                <input type="radio" id="sizeS" name="size" value="1">
                                <label for="sizeS">SIZE S</label> 
                            </div>
                            <div style="margin-right: 15px">
                                <input type="radio" id="sizeM" name="size" value="2">
                                <label for="sizeM">SIZE M</label>
                            </div>
                            <div>
                                <input type="radio" id="sizeL" name="size" value="3">
                                <label for="sizeL">SIZE L</label> 
                            </div>                           
                        </div>                      
                    </div>
                    <button type="submit" class="add-to-cart">Add to Cart</button>
                </form>
                <div>
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                    <h3 style="color: red"> <%= error%> </h3>
                    <%}%>
                </div>
                <div class="description">
                    <h2>MÔ TẢ SẢN PHẨM</h2>
                    <p><strong>FORM:</strong> REGULAR</p>
                    <p><strong>DETAIL:</strong> <%=product.getDescription()%></p>
                </div>
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