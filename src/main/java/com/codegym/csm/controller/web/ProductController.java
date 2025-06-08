package com.codegym.csm.controller.web;

import com.codegym.csm.exception.ResourceNotFoundException;
import com.codegym.csm.model.ProductDetail;
import com.codegym.csm.service.IProductService;
import com.codegym.csm.service.impl.ProductServiceImpl;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ProductController", urlPatterns = "/product")
public class ProductController extends HttpServlet {
    private final IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            int id = Integer.parseInt(idParam);
            ProductDetail product = productService.findProductDetailById(id);
            if (product == null) {
                throw new ResourceNotFoundException("Không tìm thấy sản phẩm với ID: " + id);
            }
            request.setAttribute("product", product);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/web/product-detail.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            throw new ResourceNotFoundException("ID sản phẩm không hợp lệ.");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/errors/500-general-error.jsp");
            dispatcher.forward(request, response);
        }
    }
}