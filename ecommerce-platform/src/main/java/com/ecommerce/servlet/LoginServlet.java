package com.ecommerce.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.dao.UserDAOImpl;
import com.ecommerce.model.User;
import org.mindrot.jbcrypt.BCrypt;   // ✅ ADD THIS

@WebServlet("/login") 
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
        System.out.println("[LoginServlet] init() called – UserDAOImpl ready.");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String enteredPassword = request.getParameter("password");

        System.out.println("[LoginServlet] Username: " + username);

        // 1️⃣ Empty field validation
        if (username == null || username.trim().isEmpty()
                || enteredPassword == null || enteredPassword.trim().isEmpty()) {

            request.setAttribute("errorMessage",
                    "Username and password both required.");
            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
            return;
        }

        // 2️⃣ Fetch user by username ONLY
        User user = userDAO.getUserByUsername(username.trim());

        // 3️⃣ Validate password using bcrypt
        if (user == null || !BCrypt.checkpw(enteredPassword, user.getPassword())) {

            System.out.println("[LoginServlet] Login FAILED for: " + username);

            request.setAttribute("errorMessage",
                    "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
            return;
        }

        // 4️⃣ SUCCESS → create session
        System.out.println("[LoginServlet] Login SUCCESS for: "
                + user.getUsername() + " (role = " + user.getRole() + ")");

        HttpSession session = request.getSession(true);
        session.setAttribute("currentUser", user);
        session.setAttribute("role", user.getRole());

        String role = user.getRole();
        String contextPath = request.getContextPath();
        String target;

        if ("ADMIN".equalsIgnoreCase(role)) {
            target = contextPath + "/admin/dashboard.jsp";
        } else if ("SELLER".equalsIgnoreCase(role)) {
            target = contextPath + "/seller/dashboard.jsp";
        } else {
            target = contextPath + "/buyer/dashboard.jsp";
        }

        response.sendRedirect(target);
    }
}
