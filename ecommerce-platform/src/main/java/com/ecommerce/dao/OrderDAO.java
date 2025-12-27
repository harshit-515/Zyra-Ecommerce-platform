package com.ecommerce.dao;

import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import java.util.List;

public interface OrderDAO {
    
    /**
     * Create a new order with order items
     * @param order Order object
     * @param orderItems List of order items
     * @return Order ID if successful, -1 otherwise
     */
    int createOrder(Order order, List<OrderItem> orderItems);
    double getTotalRevenue();
    List<Order> getRecentOrders(int limit);

    /**
     * Get order by ID
     * @param orderId Order ID
     * @return Order object with items or null
     */
    Order getOrderById(int orderId);
    
    /**
     * Get all orders
     * @return List of all orders
     */
    List<Order> getAllOrders();
    
    /**
     * Get orders by buyer
     * @param buyerId Buyer ID
     * @return List of buyer's orders
     */
    List<Order> getOrdersByBuyer(int buyerId);
    
    /**
     * Get orders by seller (orders containing seller's products)
     * @param sellerId Seller ID
     * @return List of orders with seller's products
     */
    List<Order> getOrdersBySeller(int sellerId);
    
    /**
     * Get order items for an order
     * @param orderId Order ID
     * @return List of order items
     */
    List<OrderItem> getOrderItems(int orderId);
    
    /**
     * Update order status
     * @param orderId Order ID
     * @param status New status
     * @return true if successful, false otherwise
     */
    boolean updateOrderStatus(int orderId, String status);
    
    /**
     * Cancel order
     * @param orderId Order ID
     * @return true if successful, false otherwise
     */
    boolean cancelOrder(int orderId);
    
    /**
     * Get orders by status
     * @param status Order status
     * @return List of orders with specified status
     */
    List<Order> getOrdersByStatus(String status);
}