<%-- 
    Document   : orders.jsp
    Created on : Mar 10, 2025, 4:53:37 PM
    Author     : ADMIN
--%>

<%@page import="order.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="order.OrderDAO"%>
<%@page import="user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    UserDTO user = (UserDTO) session.getAttribute("usersession");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<OrderDTO> orders = orderDAO.getOrdersByUser(user.getUserID());
%>

<html>
<head>
    <title>Lịch sử mua hàng</title>
    <link href="css/orders.css" rel="stylesheet">

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
    <h2>Đơn hàng của bạn</h2>
    
    <% if (!orders.isEmpty()) { %>
        <table border="1">
            <tr><th>Mã ĐH</th><th>Ngày đặt</th><th>Địa chỉ</th><th>Tổng tiền</th><th>Trạng thái</th></tr>
            <% for (OrderDTO order : orders) { %>
            <tr>
                <td><%= order.getOrderID() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getAddress() %></td>
                <td><%= String.format("%,.0f₫", order.getTotalPrice()) %></td>
                <td><%= order.getStatus() %></td>
            </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>Bạn chưa có đơn hàng nào.</p>
    <% } %>
</body>
</html>
