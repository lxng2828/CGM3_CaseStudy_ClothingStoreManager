package com.codegym.csm.controller.web;

import com.codegym.csm.model.CartItem;
import com.codegym.csm.model.ProductDetail;
import com.codegym.csm.service.IProductService;
import com.codegym.csm.service.impl.ProductServiceImpl;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CartController", urlPatterns = "/cart")
public class CartController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/web/cart.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }
        try {
            int productDetailId = Integer.parseInt(request.getParameter("productDetailId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            ProductDetail product = productService.findProductDetailById(productDetailId);
            if (product != null && quantity > 0) {
                if (cart.containsKey(productDetailId)) {
                    CartItem existingItem = cart.get(productDetailId);
                    existingItem.setQuantity(existingItem.getQuantity() + quantity);
                } else {
                    CartItem newItem = new CartItem(product, quantity);
                    cart.put(productDetailId, newItem);
                }
            }
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}