package com.ecommerce.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Order {

    // Core fields
    private int orderId;
    private int buyerId;

    // NOTE: Stored as orderDate internally
    private Timestamp orderDate;

    private double totalAmount;
    private String status; // PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
    private String shippingAddress;
    private String paymentMethod;

    // Display / helper fields
    private String buyerName;
    private List<OrderItem> orderItems;

    // Default constructor
    public Order() {
        this.orderItems = new ArrayList<>();
    }

    // Constructor (new order)
    public Order(int buyerId, double totalAmount, String shippingAddress, String paymentMethod) {
        this.buyerId = buyerId;
        this.totalAmount = totalAmount;
        this.status = "PENDING";
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
        this.orderItems = new ArrayList<>();
    }

    // Full constructor
    public Order(int orderId, int buyerId, Timestamp orderDate, double totalAmount,
                 String status, String shippingAddress, String paymentMethod) {
        this.orderId = orderId;
        this.buyerId = buyerId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
        this.orderItems = new ArrayList<>();
    }

    // ======================
    // GETTERS & SETTERS
    // ======================

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(int buyerId) {
        this.buyerId = buyerId;
    }

    // Original getter
    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    // ✅ ALIAS FOR JSP / UI (THIS FIXES YOUR ERROR)
    public Timestamp getCreatedAt() {
        return orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    // Utility
    public void addOrderItem(OrderItem item) {
        this.orderItems.add(item);
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId +
                ", buyerId=" + buyerId +
                ", totalAmount=" + totalAmount +
                ", status=" + status +
                ", orderDate=" + orderDate + "]";
    }
}
