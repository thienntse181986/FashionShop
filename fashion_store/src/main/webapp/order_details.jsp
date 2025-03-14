<%@page import="user.UserDTO"%>
<%@page import="orderDetails.OrderDetailsDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Chi Tiết Đơn Hàng</title>
        <link href="css/order_details.css" rel="stylesheet">

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
        <div class="order-details">
            <h2>Chi Tiết Đơn Hàng</h2>

            <% List<OrderDetailsDTO> orderDetails = (List<OrderDetailsDTO>) request.getAttribute("list"); %>
            <% if (orderDetails != null && !orderDetails.isEmpty()) { %>
            <table>
                <tr>
                    <th>ProductID</th>
                    <th>Size</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
                <% for (OrderDetailsDTO detail : orderDetails) {%>
                <tr>
                    <td><%= detail.getProductID()%></td>
                    <td><%= detail.getSizeName()%></td>
                    <td><%= detail.getQuantity()%></td>
                    <td><%= String.format("%,.0f₫", detail.getPrice())%></td>
                    <td><%= String.format("%,.0f₫", detail.getPrice() * detail.getQuantity())%></td>
                </tr>
                <% } %>
            </table>
            <% }%>

            <a href="index.jsp">RETURN HOME</a>
        </div>



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
