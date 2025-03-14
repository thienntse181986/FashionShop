<%@page import="order.OrderDTO"%>
<%@page import="user.UserDTO"%>
<%@page import="order.OrderDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch sử đơn hàng</title>
        <link href="css/order_history.css" rel="stylesheet">
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

        <div class="order-history">
            <h2>Lịch sử đơn hàng</h2>
            <% List<OrderDTO> orders = (List<OrderDTO>) request.getAttribute("list"); %>
            <% if (orders != null && !orders.isEmpty()) { %>
            <table>
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Địa chỉ</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết</th>
                </tr>
                <% for (OrderDTO order : orders) {%>
                <tr>
                    <td><%= order.getOrderID()%></td>
                    <td><%= order.getOrderDate()%></td>
                    <td><%= String.format("%,.0f₫", order.getTotalPrice())%></td>
                    <td><%= order.getAddress()%></td>
                    <td><%= order.getStatus()%></td>
                    <td>
                        <form action="order" method="GET">
                            <input type="hidden" name="action" value="orderDetails">
                            <input type="hidden" name="orderID" value="<%= order.getOrderID()%>">
                            <button type="submit">Xem chi tiết</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
            <% }%>
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
