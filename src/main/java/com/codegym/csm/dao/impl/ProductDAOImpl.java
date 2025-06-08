package com.codegym.csm.dao.impl;

import com.codegym.csm.dao.IProductDAO;
import com.codegym.csm.db.DBContext;
import com.codegym.csm.exception.DataAccessException;
import com.codegym.csm.model.ProductDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements IProductDAO {
    @Override
    public List<ProductDetail> findAllProductDetails() {
        List<ProductDetail> productDetails = new ArrayList<>();
        String sql = "SELECT pd.id, p.id as product_id, p.name, p.description, pd.price, pd.image_url, " +
                "pd.color, pd.size, pd.stock_quantity, c.name as category_name " +
                "FROM product_details pd " +
                "JOIN products p ON pd.product_id = p.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "ORDER BY p.created_at DESC;";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductDetail product = new ProductDetail();
                product.setId(rs.getInt("id"));
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setColor(rs.getString("color"));
                product.setSize(rs.getString("size"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setCategoryName(rs.getString("category_name"));
                productDetails.add(product);
            }
        } catch (SQLException e) {
            throw new DataAccessException("Error fetching all product details.", e);
        }
        return productDetails;
    }

    @Override
    public ProductDetail findProductDetailById(int id) {
        ProductDetail product = null;
        String sql = "SELECT pd.id, p.id as product_id, p.name, p.description, pd.price, pd.image_url, " +
                "pd.color, pd.size, pd.stock_quantity, c.name as category_name " +
                "FROM product_details pd " +
                "JOIN products p ON pd.product_id = p.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE pd.id = ?;";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new ProductDetail();
                    product.setId(rs.getInt("id"));
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setColor(rs.getString("color"));
                    product.setSize(rs.getString("size"));
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setCategoryName(rs.getString("category_name"));
                }
            }
        } catch (SQLException e) {
            throw new DataAccessException("Error finding product detail by ID: " + id, e);
        }
        return product;
    }
}