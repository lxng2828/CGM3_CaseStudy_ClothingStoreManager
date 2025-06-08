package com.codegym.csm.dao.impl;

import com.codegym.csm.dao.IOrderDAO;
import com.codegym.csm.exception.DataAccessException;
import com.codegym.csm.model.Order;
import com.codegym.csm.model.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OrderDAOImpl implements IOrderDAO {

    @Override
    public int saveOrder(Order order, Connection conn) {
        String sql = "INSERT INTO orders (user_id, total_amount, status, shipping_address, shipping_phone, customer_name) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            // userId có thể null
            if (order.getUserId() != null) {
                ps.setInt(1, order.getUserId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getShippingPhone());
            ps.setString(6, order.getCustomerName());

            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new DataAccessException("Creating order failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            throw new DataAccessException("Error saving order.", e);
        }
    }

    @Override
    public void saveOrderDetail(OrderDetail detail, Connection conn) {
        String sql = "INSERT INTO order_details (order_id, product_detail_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getProductDetailId());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getPriceAtPurchase());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new DataAccessException("Error saving order detail.", e);
        }
    }
}
