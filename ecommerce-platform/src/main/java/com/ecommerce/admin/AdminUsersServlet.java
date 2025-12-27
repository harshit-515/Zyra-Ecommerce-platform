package com.ecommerce.admin;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.dao.UserDAOImpl;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
        System.out.println("[AdminUsersServlet] Initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<User> users = userDAO.getAllUsers();
        System.out.println("[AdminUsersServlet] Users found: " + users.size());
        System.out.println(">>> AdminUsersServlet HIT");

        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/manage-users.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        int userId = Integer.parseInt(req.getParameter("userId"));

        if ("toggle".equals(action)) {
            User user = userDAO.getUserById(userId);
            if (user != null) {
                user.setActive(!user.isActive());
                userDAO.updateUser(user);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
