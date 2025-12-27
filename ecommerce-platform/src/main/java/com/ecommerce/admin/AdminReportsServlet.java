package com.ecommerce.admin;

import com.ecommerce.dao.*;
import com.ecommerce.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reports")
public class AdminReportsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAOImpl();
        ProductDAO productDAO = new ProductDAOImpl();
        OrderDAO orderDAO = new OrderDAOImpl();

        // USER STATS
        request.setAttribute("totalUsers", userDAO.getAllUsers().size());
        request.setAttribute("totalSellers", userDAO.getUsersByRole("SELLER").size());
        request.setAttribute("totalBuyers", userDAO.getUsersByRole("BUYER").size());

        // PRODUCT STATS
        request.setAttribute("totalProducts", productDAO.getAllProducts().size());

        // ORDER STATS
        request.setAttribute("totalOrders", orderDAO.getAllOrders().size());
        request.setAttribute("totalRevenue", orderDAO.getTotalRevenue());

        // RECENT ORDERS
        List<Order> recentOrders = orderDAO.getRecentOrders(5);
        request.setAttribute("recentOrders", recentOrders);

        request.getRequestDispatcher("/admin/reports.jsp")
               .forward(request, response);
    }
}
