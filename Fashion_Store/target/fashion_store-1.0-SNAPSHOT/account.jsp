<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fashion Store</title>
    <link rel="stylesheet" href="./css/account.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <ul class="nav-left">
                <li><a href="index.html">Home</a></li>
                <li class="dropdown">
                    <a href="#">Product?</a>
                    <ul class="dropdown-menu">
                        <li><a href="#">ALL</a></li>
                        <li><a href="t-shirt.html">T-Shirt</a></li>
                        <li><a href="#">Short</a></li>
                    </ul>
                </li>
            </ul>

            <div class="logo">
                <img src="img/logoThuongHieu.jpg" alt="">
            </div>
            
            <div class="nav-right">
                <input type="text" placeholder="Search..." class="search-box">
                <a href="./login.html">Login</a>
                <a href="#">Bag</a>
            </div>
        </nav>
    </header>
  
    <div class="form">
		<div>
			<h2>ACCOUNT MEMBER</h2>
		</div>

		<div>
			<form class="form2" action="" method="">
				<input type="text" placeholder="First Name" name="firstname"> <br> <br>
				<input type="password" placeholder="Last Name" name="lastname"> <br> <br>
                <input type="text" placeholder="Phone" name="phone"> <br> <br>
                <input type="text" placeholder="Email" name="email"> <br> <br>
                <input type="text" placeholder="Address" name="address"> <br> <br>
				<input class="buttonLogin" type="submit" value="UPDATE"> <br> <br>
			</form>
		</div>
        <div class="form_text">
			<a href="index.html">TR? V?</a><br> <br>
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

    // ?n menu khi click ra ngoài
    document.addEventListener("click", function (event) {
        if (!dropdownToggle.contains(event.target) && !dropdownMenu.contains(event.target)) {
            dropdownMenu.classList.remove("show");
        }
    });
});
</script>
</body>
</html>
