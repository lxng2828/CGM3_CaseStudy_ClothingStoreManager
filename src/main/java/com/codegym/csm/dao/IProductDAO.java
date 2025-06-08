package com.codegym.csm.dao;

import com.codegym.csm.model.ProductDetail;
import java.util.List;

public interface IProductDAO {
    List<ProductDetail> findAllProductDetails();

    ProductDetail findProductDetailById(int id);
}