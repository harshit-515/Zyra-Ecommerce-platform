package com.ecommerce.api;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.dao.UserDAOImpl;
import com.ecommerce.model.User;
import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/login")
public class LoginApiServlet extends HttpServlet {

    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
        gson = new Gson();
        System.out.println("[API] LoginApiServlet initialized");
    }

    // Allow preflight requests (CORS)
    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) {
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseData = new HashMap<>();

        try {
            BufferedReader reader = request.getReader();
            Map<String, String> requestData =
                    gson.fromJson(reader, Map.class);

            String username = requestData.get("username");
            String password = requestData.get("password");

            if (username == null || password == null) {
                responseData.put("status", "error");
                responseData.put("message", "Username and password required");
                response.getWriter().write(gson.toJson(responseData));
                return;
            }

            // Authenticate
            User user = userDAO.authenticateUser(username, password);

            if (user == null) {
                responseData.put("status", "error");
                responseData.put("message", "Invalid username or password");
            } else {

                // 🔥 VERY IMPORTANT FIX 🔥
                // Invalidate old session (prevents wrong user)
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }

                // Create fresh session
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());

                responseData.put("status", "success");
                responseData.put("role", user.getRole());
                responseData.put("username", user.getUsername());
            }

        } catch (Exception e) {
            e.printStackTrace();   // KEEP THIS
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseData.put("status", "error");
            responseData.put("message", "Internal server error");
        }

        response.getWriter().write(gson.toJson(responseData));
    }
}
