package com.codegym.csm.service.impl;

import com.codegym.csm.dao.IProductDAO;
import com.codegym.csm.dao.impl.ProductDAOImpl;
import com.codegym.csm.model.ProductDetail;
import com.codegym.csm.service.IProductService;
import java.util.List;

public class ProductServiceImpl implements IProductService {
    private final IProductDAO productDAO = new ProductDAOImpl();

    @Override
    public List<ProductDetail> findAllProductDetails() {
        return productDAO.findAllProductDetails();
    }

    @Override
    public ProductDetail findProductDetailById(int id) {
        return productDAO.findProductDetailById(id);
    }
}