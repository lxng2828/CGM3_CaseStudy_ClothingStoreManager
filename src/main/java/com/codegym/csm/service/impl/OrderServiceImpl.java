package com.codegym.csm.service.impl;

import com.codegym.csm.dao.IOrderDAO;
import com.codegym.csm.dao.IProductDAO;
import com.codegym.csm.dao.impl.OrderDAOImpl;
import com.codegym.csm.dao.impl.ProductDAOImpl;
import com.codegym.csm.db.DBContext;
import com.codegym.csm.exception.DataAccessException;
import com.codegym.csm.model.CartItem;
import com.codegym.csm.model.Order;
import com.codegym.csm.model.OrderDetail;
import com.codegym.csm.model.User;
import com.codegym.csm.service.IOrderService;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

public class OrderServiceImpl implements IOrderService {
    private final IOrderDAO orderDAO = new OrderDAOImpl();
    private final IProductDAO productDAO = new ProductDAOImpl();

    @Override
    public boolean placeOrder(User user, Map<Integer, CartItem> cart, Order shippingInfo) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            BigDecimal totalAmount = cart.values().stream()
                    .map(CartItem::getSubtotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            shippingInfo.setTotalAmount(totalAmount);
            shippingInfo.setStatus("Pending");
            if (user != null) {
                shippingInfo.setUserId(user.getId());
            }
            int orderId = orderDAO.saveOrder(shippingInfo, conn);
            for (CartItem item : cart.values()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setProductDetailId(item.getProduct().getId());
                detail.setQuantity(item.getQuantity());
                detail.setPriceAtPurchase(item.getProduct().getPrice());
                orderDAO.saveOrderDetail(detail, conn);
                productDAO.updateStock(item.getProduct().getId(), item.getQuantity(), conn);
            }
            conn.commit();
            return true;
        } catch (SQLException | DataAccessException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}