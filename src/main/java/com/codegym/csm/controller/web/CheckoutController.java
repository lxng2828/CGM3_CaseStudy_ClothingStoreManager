package com.codegym.csm.controller.web;

import com.codegym.csm.model.CartItem;
import com.codegym.csm.model.Order;
import com.codegym.csm.model.User;
import com.codegym.csm.service.IOrderService;
import com.codegym.csm.service.impl.OrderServiceImpl;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CheckoutController", urlPatterns = "/checkout")
public class CheckoutController extends HttpServlet {
    private final IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/web/checkout.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        String customerName = request.getParameter("customerName");
        String shippingPhone = request.getParameter("shippingPhone");
        String shippingAddress = request.getParameter("shippingAddress");
        Order shippingInfo = new Order();
        shippingInfo.setCustomerName(customerName);
        shippingInfo.setShippingPhone(shippingPhone);
        shippingInfo.setShippingAddress(shippingAddress);
        boolean success = orderService.placeOrder(user, cart, shippingInfo);
        if (success) {
            session.removeAttribute("cart");
            response.sendRedirect(request.getContextPath() + "/order-success");
        } else {
            request.setAttribute("errorMessage", "Đã có lỗi xảy ra trong quá trình đặt hàng. Vui lòng thử lại.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/web/checkout.jsp");
            dispatcher.forward(request, response);
        }
    }
}