package com.ecommerce.dao;

import com.ecommerce.model.User;
import java.util.List;

public interface UserDAO {
    
    /**
     * Register a new user
     * @param user User object with details
     * @return true if successful, false otherwise
     */
    boolean registerUser(User user);

    /**
     * Authenticate user login
     * @param username Username
     * @param password Plain text password
     * @return User object if authentication successful, null otherwise
     */
    User authenticateUser(String username, String password);
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object or null
     */
    User getUserById(int userId);
    
    /**
     * Get user by username
     * @param username Username
     * @return User object or null
     */
    User getUserByUsername(String username);
    
    /**
     * Get user by email
     * @param email Email address
     * @return User object or null
     */
    User getUserByEmail(String email);
    
    /**
     * Get all users
     * @return List of all users
     */
    List<User> getAllUsers();
    public boolean updateUserStatus(int userId, boolean status);


    /**
     * Get users by role
     * @param role Role (ADMIN, SELLER, BUYER)
     * @return List of users with specified role
     */
    List<User> getUsersByRole(String role);
    
    /**
     * Update user details
     * @param user User object with updated details
     * @return true if successful, false otherwise
     */
    boolean updateUser(User user);
    
    /**
     * Delete user (or mark as inactive)
     * @param userId User ID
     * @return true if successful, false otherwise
     */
    boolean deleteUser(int userId);
    
    /**
     * Change user password
     * @param userId User ID
     * @param newPassword New plain text password
     * @return true if successful, false otherwise
     */
    boolean changePassword(int userId, String newPassword);
    
    /**
     * Check if username exists
     * @param username Username to check
     * @return true if exists, false otherwise
     */
    boolean usernameExists(String username);
    
    /**
     * Check if email exists
     * @param email Email to check
     * @return true if exists, false otherwise
     */
    boolean emailExists(String email);
}