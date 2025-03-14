/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import discount.DiscountDAO;
import discount.DiscountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import order.OrderDAO;
import order.OrderDTO;
import product.CartItem;
import product.ProductDAO;
import user.UserDAO;
import user.UserDTO;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("usersession");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // Tính tổng tiền đơn hàng
        double totalPrice = 0;
        for (CartItem item : cart) {
            totalPrice += item.getProduct().getPrice() * item.getQuantity();
        }

//        if ("discount".equals(action)) {

            //if (discountCode != null && !discountCode.trim().isEmpty()) {
                

                //if (discount != null && !discount.isUsed()) {
                    //double discountValue = discount.getDiscountValue();
                   // totalPrice = totalPrice - (discountValue * 1000);

                    // Lưu mã giảm giá vào session
//                    session.setAttribute("discountAmount", discountValue);
//                    session.setAttribute("discountCode", discountCode);
//                    session.setAttribute("discountMessage", "Mã giảm giá áp dụng thành công!");

//                    session.setAttribute("totalPrice", totalPrice);

                    //discountDAO.updateUseDiscount(discount.getDiscountID());
                //} else {
                    //session.setAttribute("discountMessage", "Mã giảm giá không hợp lệ hoặc đã sử dụng!");
                //}
            //}

            //response.sendRedirect("checkout.jsp");
//            return;
//        }

        // Lưu thông tin đơn hàng
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String totalAmountStr = request.getParameter("totalAmount");
        String discountCode = request.getParameter("discountCode");


        UserDAO userDAO = new UserDAO();
        boolean update = userDAO.updateUser(user.getUserID(), fullName, email, address, phone);

        if (update) {
            user.setFullName(fullName);
            user.setEmail(email);
            user.setAddress(address);
            user.setPhone(phone);
            session.setAttribute("usersession", user);
        }

// Nếu session không có giá trị, lấy tổng tiền gốc
//        Double discountAmount = (Double) session.getAttribute("discountAmount");
        DiscountDAO discountDAO = new DiscountDAO();
                DiscountDTO discount = discountDAO.getDiscountCode(discountCode);
              double discountAmount = 0.0;
        if (discount != null) {
             discountAmount = discount.getDiscountValue() * 1000;
          
        }
        double finalPrice = totalPrice - discountAmount;

// Cập nhật lại session trước khi lưu đơn hàng
        session.setAttribute("totalPrice", finalPrice);

        OrderDTO order = new OrderDTO();
        order.setUserID(user.getUserID());
        order.setOrderDate(new Date(System.currentTimeMillis()));
        order.setAddress(address);
        order.setTotalPrice(finalPrice);
        order.setStatus("Processing");

        OrderDAO orderDAO = new OrderDAO();
        int orderID = orderDAO.saveOrder(order, cart);

        if (orderID != -1) {
            boolean success = orderDAO.saveOrderDetails(orderID, cart);
            if (success) {
                ProductDAO productDAO = new ProductDAO();
                boolean updateQuantityProduct_Size = true;

                for (CartItem item : cart) {
                    boolean updated = productDAO.updateProductQuantity(
                            item.getProduct().getProductID(),
                            item.getSize().getSizeID(),
                            item.getQuantity());
                    if (!updated) {
                        updateQuantityProduct_Size = false;
                        break;
                    }
                }

                if (updateQuantityProduct_Size) {
                    session.removeAttribute("cart");
                    response.sendRedirect("order_success.jsp");
                    return;
                }
            }
        }

        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
