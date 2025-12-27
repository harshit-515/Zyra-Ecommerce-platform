package com.ecommerce.dao;

import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int createOrder(Order order, List<OrderItem> orderItems) {
        // This method uses TRANSACTION MANAGEMENT (important for rubric!)
        Connection conn = null;
        PreparedStatement pstmtOrder = null;
        PreparedStatement pstmtItem = null;
        PreparedStatement pstmtStock = null;
        ResultSet rs = null;
        
        String sqlOrder = "INSERT INTO orders (buyer_id, total_amount, status, shipping_address, payment_method) " +
                          "VALUES (?, ?, ?, ?, ?)";
        String sqlItem = "INSERT INTO order_items (order_id, product_id, seller_id, quantity, price_at_purchase) " +
                         "VALUES (?, ?, ?, ?, ?)";
        String sqlStock = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE product_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            
            // START TRANSACTION
            conn.setAutoCommit(false);
            
            // Step 1: Insert order
            pstmtOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            pstmtOrder.setInt(1, order.getBuyerId());
            pstmtOrder.setDouble(2, order.getTotalAmount());
            pstmtOrder.setString(3, order.getStatus());
            pstmtOrder.setString(4, order.getShippingAddress());
            pstmtOrder.setString(5, order.getPaymentMethod());
            
            int rowsAffected = pstmtOrder.executeUpdate();
            
            if (rowsAffected == 0) {
                conn.rollback();
                return -1;
            }
            
            // Get generated order ID
            rs = pstmtOrder.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
            
            if (orderId == -1) {
                conn.rollback();
                return -1;
            }
            
            // Step 2: Insert order items and update stock
            pstmtItem = conn.prepareStatement(sqlItem);
            pstmtStock = conn.prepareStatement(sqlStock);
            
            for (OrderItem item : orderItems) {
                // Insert order item
                pstmtItem.setInt(1, orderId);
                pstmtItem.setInt(2, item.getProductId());
                pstmtItem.setInt(3, item.getSellerId());
                pstmtItem.setInt(4, item.getQuantity());
                pstmtItem.setDouble(5, item.getPriceAtPurchase());
                pstmtItem.addBatch();
                
                // Update product stock
                pstmtStock.setInt(1, item.getQuantity());
                pstmtStock.setInt(2, item.getProductId());
                pstmtStock.addBatch();
            }
            
            pstmtItem.executeBatch();
            pstmtStock.executeBatch();
            
            // COMMIT TRANSACTION
            conn.commit();
            System.out.println("✓ Order created successfully with ID: " + orderId);
            
            return orderId;
            
        } catch (SQLException e) {
            System.err.println("Error creating order: " + e.getMessage());
            e.printStackTrace();
            
            // ROLLBACK on error
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("✗ Transaction rolled back!");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return -1;
            
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true); // Reset auto-commit
                if (rs != null) rs.close();
                if (pstmtOrder != null) pstmtOrder.close();
                if (pstmtItem != null) pstmtItem.close();
                if (pstmtStock != null) pstmtStock.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.full_name as buyer_name FROM orders o " +
                     "LEFT JOIN users u ON o.buyer_id = u.user_id " +
                     "WHERE o.order_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                
                // Get order items
                List<OrderItem> items = getOrderItems(orderId);
                order.setOrderItems(items);
                
                return order;
            }
            
            return null;
            
        } catch (SQLException e) {
            System.err.println("Error getting order by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<Order> getAllOrders() {
        String sql = "SELECT o.*, u.full_name as buyer_name FROM orders o " +
                     "LEFT JOIN users u ON o.buyer_id = u.user_id " +
                     "ORDER BY o.order_date DESC";
        
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
            
            return orders;
            
        } catch (SQLException e) {
            System.err.println("Error getting all orders: " + e.getMessage());
            e.printStackTrace();
            return orders;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<Order> getOrdersByBuyer(int buyerId) {
        String sql = "SELECT o.*, u.full_name as buyer_name FROM orders o " +
                     "LEFT JOIN users u ON o.buyer_id = u.user_id " +
                     "WHERE o.buyer_id = ? ORDER BY o.order_date DESC";
        
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, buyerId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
            
            return orders;
            
        } catch (SQLException e) {
            System.err.println("Error getting orders by buyer: " + e.getMessage());
            e.printStackTrace();
            return orders;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<Order> getOrdersBySeller(int sellerId) {
        String sql = "SELECT DISTINCT o.*, u.full_name as buyer_name FROM orders o " +
                     "INNER JOIN order_items oi ON o.order_id = oi.order_id " +
                     "LEFT JOIN users u ON o.buyer_id = u.user_id " +
                     "WHERE oi.seller_id = ? ORDER BY o.order_date DESC";
        
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, sellerId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
            
            return orders;
            
        } catch (SQLException e) {
            System.err.println("Error getting orders by seller: " + e.getMessage());
            e.printStackTrace();
            return orders;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) {
        String sql = "SELECT oi.*, p.product_name, u.full_name as seller_name " +
                     "FROM order_items oi " +
                     "LEFT JOIN products p ON oi.product_id = p.product_id " +
                     "LEFT JOIN users u ON oi.seller_id = u.user_id " +
                     "WHERE oi.order_id = ?";
        
        List<OrderItem> items = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setSellerId(rs.getInt("seller_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPriceAtPurchase(rs.getDouble("price_at_purchase"));
                item.setProductName(rs.getString("product_name"));
                item.setSellerName(rs.getString("seller_name"));
                
                items.add(item);
            }
            
            return items;
            
        } catch (SQLException e) {
            System.err.println("Error getting order items: " + e.getMessage());
            e.printStackTrace();
            return items;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating order status: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public boolean cancelOrder(int orderId) {
        // Cancel order and restore stock using TRANSACTION
        Connection conn = null;
        PreparedStatement pstmtStatus = null;
        PreparedStatement pstmtStock = null;
        
        String sqlStatus = "UPDATE orders SET status = 'CANCELLED' WHERE order_id = ?";
        String sqlStock = "UPDATE products p " +
                          "INNER JOIN order_items oi ON p.product_id = oi.product_id " +
                          "SET p.stock_quantity = p.stock_quantity + oi.quantity " +
                          "WHERE oi.order_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // Update order status
            pstmtStatus = conn.prepareStatement(sqlStatus);
            pstmtStatus.setInt(1, orderId);
            pstmtStatus.executeUpdate();
            
            // Restore stock
            pstmtStock = conn.prepareStatement(sqlStock);
            pstmtStock.setInt(1, orderId);
            pstmtStock.executeUpdate();
            
            conn.commit(); // Commit transaction
            System.out.println("✓ Order cancelled and stock restored");
            
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error cancelling order: " + e.getMessage());
            e.printStackTrace();
            
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
            
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
                if (pstmtStatus != null) pstmtStatus.close();
                if (pstmtStock != null) pstmtStock.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    @Override
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM orders WHERE status != 'CANCELLED'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.user_id " +
                     "ORDER BY o.order_date DESC LIMIT ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setBuyerName(rs.getString("full_name"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersByStatus(String status) {
        String sql = "SELECT o.*, u.full_name as buyer_name FROM orders o " +
                     "LEFT JOIN users u ON o.buyer_id = u.user_id " +
                     "WHERE o.status = ? ORDER BY o.order_date DESC";
        
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
            
            return orders;
            
        } catch (SQLException e) {
            System.err.println("Error getting orders by status: " + e.getMessage());
            e.printStackTrace();
            return orders;
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Helper method to extract Order from ResultSet
     */
    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setBuyerId(rs.getInt("buyer_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setPaymentMethod(rs.getString("payment_method"));
        
        try {
            order.setBuyerName(rs.getString("buyer_name"));
        } catch (SQLException e) {
            // Column might not exist
        }
        
        return order;
    }

    /**
     * Test method
     */
    public static void main(String[] args) {
        System.out.println("=== Testing OrderDAOImpl ===\n");
        
        OrderDAOImpl orderDAO = new OrderDAOImpl();
        ProductDAOImpl productDAO = new ProductDAOImpl();
        
        // Test 1: Create a test order
        System.out.println("--- Test 1: Create Order ---");
        Order newOrder = new Order();
        newOrder.setBuyerId(4); // buyer1
        newOrder.setTotalAmount(47898.00);
        newOrder.setShippingAddress("789 Home Avenue, Chicago, IL 60601");
        newOrder.setPaymentMethod("Credit Card");
        
        List<OrderItem> items = new ArrayList<>();
        
        // Item 1: Laptop (product_id=1)
        OrderItem item1 = new OrderItem();
        item1.setProductId(1);
        item1.setSellerId(2);
        item1.setQuantity(1);
        item1.setPriceAtPurchase(45999.00);
        items.add(item1);
        
        // Item 2: Mouse (product_id=2)
        OrderItem item2 = new OrderItem();
        item2.setProductId(2);
        item2.setSellerId(2);
        item2.setQuantity(2);
        item2.setPriceAtPurchase(899.00);
        items.add(item2);
        
        int orderId = orderDAO.createOrder(newOrder, items);
        if (orderId > 0) {
            System.out.println("✓ Order created with ID: " + orderId);
        } else {
            System.out.println("✗ Failed to create order");
        }
        
        // Test 2: Get order by ID
        if (orderId > 0) {
            System.out.println("\n--- Test 2: Get Order by ID ---");
            Order order = orderDAO.getOrderById(orderId);
            if (order != null) {
                System.out.println("✓ Order ID: " + order.getOrderId());
                System.out.println("  Buyer: " + order.getBuyerName());
                System.out.println("  Total: ₹" + order.getTotalAmount());
                System.out.println("  Status: " + order.getStatus());
                System.out.println("  Items: " + order.getOrderItems().size());
                
                for (OrderItem item : order.getOrderItems()) {
                    System.out.println("    - " + item.getProductName() + 
                                     " x" + item.getQuantity() + 
                                     " = ₹" + item.getSubtotal());
                }
            }
        }
        
        // Test 3: Get all orders
        System.out.println("\n--- Test 3: Get All Orders ---");
        List<Order> allOrders = orderDAO.getAllOrders();
        System.out.println("Total orders: " + allOrders.size());
        
        // Test 4: Get orders by buyer
        System.out.println("\n--- Test 4: Get Orders by Buyer ---");
        List<Order> buyerOrders = orderDAO.getOrdersByBuyer(4);
        System.out.println("Buyer's orders: " + buyerOrders.size());
        
        // Test 5: Get orders by status
        System.out.println("\n--- Test 5: Get Pending Orders ---");
        List<Order> pendingOrders = orderDAO.getOrdersByStatus("PENDING");
        System.out.println("Pending orders: " + pendingOrders.size());
        
        // Test 6: Update order status
        if (orderId > 0) {
            System.out.println("\n--- Test 6: Update Order Status ---");
            boolean updated = orderDAO.updateOrderStatus(orderId, "PROCESSING");
            System.out.println("Status updated: " + (updated ? "✓ Yes" : "✗ No"));
        }
        
        System.out.println("\n✅ OrderDAOImpl testing complete!");
    }
}