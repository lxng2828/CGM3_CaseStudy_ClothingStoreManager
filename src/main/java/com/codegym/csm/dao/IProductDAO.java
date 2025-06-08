package com.codegym.csm.dao;

import com.codegym.csm.model.ProductDetail;
import java.sql.Connection;
import java.util.List;

public interface IProductDAO {
    List<ProductDetail> findAllProductDetails();

    ProductDetail findProductDetailById(int id);

    void updateStock(int productDetailId, int quantityToDecrease, Connection conn);
}