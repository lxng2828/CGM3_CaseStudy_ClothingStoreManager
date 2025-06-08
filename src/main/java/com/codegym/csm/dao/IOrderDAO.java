package com.codegym.csm.dao;

import com.codegym.csm.model.Order;
import com.codegym.csm.model.OrderDetail;
import java.sql.Connection;

public interface IOrderDAO {
    int saveOrder(Order order, Connection conn);

    void saveOrderDetail(OrderDetail detail, Connection conn);
}