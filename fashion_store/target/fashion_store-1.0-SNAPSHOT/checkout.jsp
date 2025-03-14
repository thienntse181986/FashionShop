<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.CartItem"%>
<%@page import="user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Kiểm tra đăng nhập
    UserDTO user = (UserDTO) session.getAttribute("usersession");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy giỏ hàng từ session
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    // Tính tổng tiền
    double totalAmount = 0;
    for (CartItem item : cart) {
        totalAmount += item.getProduct().getPrice() * item.getQuantity();
    }

    // Kiểm tra giảm giá
    Double discountAmount = (Double) session.getAttribute("discountAmount");
    if (discountAmount == null) {
        discountAmount = 0.0;
    }

    double finalAmount = totalAmount - discountAmount;
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout</title>
        <link href="css/checkout.css" rel="stylesheet">
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

        <div style="display: flex;">
            <form action="checkout" method="get">
            <div class="customer-info">
                <h2>Thông tin người dùng</h2>
                
                    <input type="text" name="fullName" placeholder="Full Name"><br>
                    <input type="text" name="email" placeholder="Email"><br>
                    <input type="text" name="phone" placeholder="Phone"><br>
                    <input type="text" name="address" placeholder="Address"><br>
                    <input type="hidden" name="totalAmount" value="<%= finalAmount%>"><br>
                    <button type="submit">CHECKOUT</button>
               
            </div>

            <div class="order-info">
                <h2>Thông tin sản phẩm</h2>
                <% if (!cart.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Size</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                        <th>Thành tiền</th>
                    </tr>
                    <% for (CartItem item : cart) {%>
                    <tr>
                        <td><%= item.getProduct().getProductName()%></td>
                        <td><%= item.getSize().getSizeName()%></td>
                        <td><%= item.getQuantity()%></td>
                        <td><%= String.format("%,.0f₫", item.getProduct().getPrice())%></td>
                        <td><%= String.format("%,.0f₫", item.getProduct().getPrice() * item.getQuantity())%></td>
                    </tr>
                    <% } %>
                </table>
                <% }%>

                <!-- Form nhập mã giảm giá -->
                <!--form action="checkout" method="POST">
                    <input type="hidden" name="action" value="discount">
                    <input type="text" name="discountCode" placeholder="Nhập mã giảm giá">
                    <button type="submit">Apply</button>
                </form-->
                <input type="text" name="discountCode" placeholder="Nhập mã giảm giá">


                <!-- Hiển thị tổng tiền -->
                <%
                    Double sessionTotalPrice = (Double) session.getAttribute("totalPrice");
                    if (sessionTotalPrice == null) {
                        sessionTotalPrice = finalAmount;
                    }
                %>
                <h2>TỔNG: <span class="total-amount"><%= String.format("%,.0f₫", sessionTotalPrice)%></span></h2>


            </div>
                 </form>
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
