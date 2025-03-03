<%@page import="user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fashion Store</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <ul class="nav-left">
                <li><a href="index.jsp">Home</a></li>
                <li class="dropdown">
                    <a href="#">Product</a>
                    <ul class="dropdown-menu">
                        <li><a href="#">ALL</a></li>
                        <li><a href="t-shirt.jsp">T-Shirt</a></li>
                        <li><a href="#">Short</a></li>
                    </ul>
                </li>
            </ul>

            <div class="logo">
                <img src="img/logoThuongHieu.jpg" alt="">
            </div>
            
            <div class="nav-right">
                <input type="text" placeholder="Search..." class="search-box">
                <a href="./login.jsp">Login</a>
                <a href="#">Bag</a>
            </div>
        </nav>
    </header>
    <div>
    <% if (session.getAttribute("usersession") != null) { %>
    <p>Login user: <%= ((UserDTO) session.getAttribute("usersession")).getUsername() %></p>
    <% } %>
    </div>
 
    <div class="img_home">	<!--Img Home-->
		<img src="img/home.jpg">
	</div>

      <div id="cart" class="cart">
    <div class="cart-content">
        <span class="close-btn">&times;</span>
        <h2>Your Bag</h2>
        <div class="cart-items">
            <p>Giỏ hàng của bạn đang trống</p>
        </div>
        <div class="cart-footer">
            <p>Subtotal: <span id="subtotal">0₫</span></p>
            <button class="checkout-btn">Checkout</button>
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

    // Ẩn menu khi click ra ngoài
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
