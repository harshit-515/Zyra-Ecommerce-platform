package com.ecommerce.dao;

import com.ecommerce.model.Product;
import java.util.List;

public interface ProductDAO {
    
    /**
     * Add a new product
     * @param product Product object
     * @return Product ID if successful, -1 otherwise
     */
    int addProduct(Product product);
    
    /**
     * Update product details
     * @param product Product object with updated details
     * @return true if successful, false otherwise
     */
    boolean updateProduct(Product product);
    
    /**
     * Delete product (mark as inactive)
     * @param productId Product ID
     * @return true if successful, false otherwise
     */
    boolean deleteProduct(int productId);
    
    /**
     * Get product by ID
     * @param productId Product ID
     * @return Product object or null
     */
    Product getProductById(int productId);
    
    /**
     * Get all active products
     * @return List of all active products
     */
    List<Product> getAllProducts();
    boolean updateProductStatus(int productId, boolean active);
    /**
     * Get products by seller
     * @param sellerId Seller ID
     * @return List of products by seller
     */
    List<Product> getProductsBySeller(int sellerId);
    
    /**
     * Get products by category
     * @param category Category name
     * @return List of products in category
     */
    List<Product> getProductsByCategory(String category);
    
    /**
     * Search products by keyword
     * @param keyword Search keyword
     * @return List of matching products
     */
    List<Product> searchProducts(String keyword);
    
    /**
     * Get all categories
     * @return List of unique categories
     */
    List<String> getAllCategories();
    
    /**
     * Update product stock
     * @param productId Product ID
     * @param quantity New quantity
     * @return true if successful, false otherwise
     */
    boolean updateStock(int productId, int quantity);
    
    /**
     * Decrease stock (used during order placement)
     * @param productId Product ID
     * @param quantity Quantity to decrease
     * @return true if successful, false otherwise
     */
    boolean decreaseStock(int productId, int quantity);
}