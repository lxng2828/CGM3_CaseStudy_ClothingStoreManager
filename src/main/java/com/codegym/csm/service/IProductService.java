package com.codegym.csm.service;

import com.codegym.csm.model.ProductDetail;
import java.util.List;

public interface IProductService {
    List<ProductDetail> findAllProductDetails();

    ProductDetail findProductDetailById(int id);
}