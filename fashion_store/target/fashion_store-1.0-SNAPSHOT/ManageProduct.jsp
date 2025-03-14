<%@page import="java.util.List"%>
<%@page import="product.ProductDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Quản lý sản phẩm</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="mt-4">Quản lý sản phẩm</h2>

            <% if (request.getAttribute("message") != null) {%>
            <div class="alert alert-success"><%= request.getAttribute("message")%></div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
            <% } %>

            <%
                ProductDTO editProduct = (ProductDTO) request.getAttribute("product");
                boolean isEditing = (editProduct != null);
            %>

            <form action="admin" method="post">
                <input type="hidden" name="action" value="<%= isEditing ? "update" : "add"%>">
                <% if (isEditing) {%>
                <input type="hidden" name="productID" value="<%= editProduct.getProductID()%>">
                <% }%>

                <input type="text" name="productName" placeholder="Tên sản phẩm" value="<%= isEditing ? editProduct.getProductName() : ""%>" required>
                <input type="number" name="price" step="0.01" placeholder="Giá" value="<%= isEditing ? editProduct.getPrice() : ""%>" required>
                <input type="text" name="color" placeholder="Color" value="<%= isEditing ? editProduct.getColor() : ""%>" required>
                <input type="text" name="img" placeholder="URL hình ảnh" value="<%= isEditing ? editProduct.getImg() : ""%>" required>
                <input type="text" name="description" placeholder="Mô tả" value="<%= isEditing ? editProduct.getDescription() : ""%>" required>
                <input type="number" name="categoryID" placeholder="ID danh mục" value="<%= isEditing ? editProduct.getCategoryID() : ""%>" required>
                <button type="submit"><%= isEditing ? "Cập nhật sản phẩm" : "Thêm sản phẩm"%></button>
            </form>

            <table class="table mt-3">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Giá</th>
                        <th>Màu</th>
                        <th>Ảnh</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
                        for (ProductDTO p : products) {
                    %>
                    <tr>
                        <td><%= p.getProductID()%></td>
                        <td><%= p.getProductName()%></td>
                        <td><%= p.getPrice()%></td>
                        <td><%= p.getColor()%></td>
                        <td><img src="<%= p.getImg() %>" width="50"></td>
                        <td><%= p.getDescription()%></td>
                        <td><%= p.getCategoryID() %></td>
                        <td>
                            <a href="admin?action=edit&productID=<%= p.getProductID()%>" class="btn btn-warning">Chỉnh sửa</a>
                            <a href="admin?action=delete&productID=<%= p.getProductID()%>" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>