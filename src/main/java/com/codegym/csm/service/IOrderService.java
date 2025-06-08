package com.codegym.csm.service;

import com.codegym.csm.model.CartItem;
import com.codegym.csm.model.Order;
import com.codegym.csm.model.User;
import java.util.Map;

public interface IOrderService {
    boolean placeOrder(User user, Map<Integer, CartItem> cart, Order shippingInfo);
}