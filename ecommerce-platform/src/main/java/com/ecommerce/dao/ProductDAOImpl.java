package com.ecommerce.dao;

import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public int addProduct(Product product) {
        String sql = "INSERT INTO products " +
                "(seller_id, product_name, description, price, stock_quantity, category, image_url, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, product.getSellerId());
            pstmt.setString(2, product.getProductName());
            pstmt.setString(3, product.getDescription());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setInt(5, product.getStockQuantity());
            pstmt.setString(6, product.getCategory());
            pstmt.setString(7, product.getImageUrl());
            pstmt.setBoolean(8, product.isActive());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
            return -1;

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    @Override
    public boolean updateProductStatus(int productId, boolean active) {
        String sql = "UPDATE products SET is_active = ? WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setBoolean(1, active);
            pstmt.setInt(2, productId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET product_name=?, description=?, price=?, " +
                "stock_quantity=?, category=?, image_url=?, is_active=? WHERE product_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, product.getProductName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setInt(4, product.getStockQuantity());
            pstmt.setString(5, product.getCategory());
            pstmt.setString(6, product.getImageUrl());
            pstmt.setBoolean(7, product.isActive());
            pstmt.setInt(8, product.getProductId());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteProduct(int productId) {
        String sql = "UPDATE products SET is_active = FALSE WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Product getProductById(int productId) {
        String sql = "SELECT p.*, u.full_name AS seller_name " +
                "FROM products p " +
                "LEFT JOIN users u ON p.seller_id = u.user_id " +
                "WHERE p.product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractProduct(rs);
                }
            }
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT p.*, u.full_name AS seller_name " +
                "FROM products p " +
                "LEFT JOIN users u ON p.seller_id = u.user_id " +
                "WHERE p.is_active = TRUE " +
                "ORDER BY p.created_at DESC";

        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                products.add(extractProduct(rs));
            }
            return products;

        } catch (SQLException e) {
            e.printStackTrace();
            return products;
        }
    }

    @Override
    public List<Product> getProductsBySeller(int sellerId) {
        String sql = "SELECT p.*, u.full_name AS seller_name " +
                "FROM products p " +
                "LEFT JOIN users u ON p.seller_id = u.user_id " +
                "WHERE p.seller_id = ? " +
                "ORDER BY p.created_at DESC";

        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, sellerId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProduct(rs));
                }
            }
            return products;

        } catch (SQLException e) {
            e.printStackTrace();
            return products;
        }
    }

    @Override
    public List<Product> getProductsByCategory(String category) {
        String sql = "SELECT p.*, u.full_name AS seller_name " +
                "FROM products p " +
                "LEFT JOIN users u ON p.seller_id = u.user_id " +
                "WHERE p.category = ? AND p.is_active = TRUE " +
                "ORDER BY p.created_at DESC";

        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProduct(rs));
                }
            }
            return products;

        } catch (SQLException e) {
            e.printStackTrace();
            return products;
        }
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT p.*, u.full_name AS seller_name " +
                "FROM products p " +
                "LEFT JOIN users u ON p.seller_id = u.user_id " +
                "WHERE (p.product_name LIKE ? OR p.description LIKE ?) " +
                "AND p.is_active = TRUE " +
                "ORDER BY p.created_at DESC";

        List<Product> products = new ArrayList<>();
        String pattern = "%" + keyword + "%";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, pattern);
            pstmt.setString(2, pattern);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    products.add(extractProduct(rs));
                }
            }
            return products;

        } catch (SQLException e) {
            e.printStackTrace();
            return products;
        }
    }

    @Override
    public List<String> getAllCategories() {
        String sql = "SELECT DISTINCT category FROM products " +
                "WHERE is_active = TRUE ORDER BY category";

        List<String> categories = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
            return categories;

        } catch (SQLException e) {
            e.printStackTrace();
            return categories;
        }
    }

    @Override
    public boolean updateStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock_quantity = ? WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, quantity);
            pstmt.setInt(2, productId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean decreaseStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock_quantity = stock_quantity - ? " +
                "WHERE product_id = ? AND stock_quantity >= ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, quantity);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantity);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Product extractProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setSellerId(rs.getInt("seller_id"));
        p.setProductName(rs.getString("product_name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setCategory(rs.getString("category"));
        p.setImageUrl(rs.getString("image_url"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        p.setActive(rs.getBoolean("is_active"));

        try {
            p.setSellerName(rs.getString("seller_name"));
        } catch (SQLException ignored) {}

        return p;
    }
}
