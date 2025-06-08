package com.codegym.csm.model;

import java.math.BigDecimal;

public class CartItem {
    private ProductDetail product;
    private int quantity;

    public CartItem() {
    }

    public CartItem(ProductDetail product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public ProductDetail getProduct() {
        return product;
    }

    public void setProduct(ProductDetail product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSubtotal() {
        if (product != null && product.getPrice() != null) {
            return product.getPrice().multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }
}