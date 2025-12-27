package com.ecommerce.api;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.dao.UserDAOImpl;
import com.ecommerce.model.User;
import com.ecommerce.util.PasswordUtil;
import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/register")
public class RegisterApiServlet extends HttpServlet {

    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
        gson = new Gson();
        System.out.println("[API] RegisterApiServlet initialized");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("application/json");
        resp.getWriter().write("{\"message\":\"Use POST method\"}");
    }
    @Override
    protected void doOptions(
            HttpServletRequest req,
            HttpServletResponse resp
    ) {
        resp.setStatus(HttpServletResponse.SC_OK);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            BufferedReader reader = request.getReader();
            Map<String, String> data = gson.fromJson(reader, Map.class);

            
            System.out.println("REGISTER DATA => " + data);

            String fullName = data.get("fullName");   
            String username = data.get("username");
            String email    = data.get("email");
            String phone    = data.get("phone");
            String address  = data.get("address");
            String role     = data.get("role");
            String password = data.get("password");

            if (fullName == null || username == null ||
                email == null || password == null || role == null) {

                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                result.put("status", "error");
                result.put("message", "Missing required fields");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            if (userDAO.usernameExists(username)) {
                result.put("status", "error");
                result.put("message", "Username already exists");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            if (userDAO.emailExists(email)) {
                result.put("status", "error");
                result.put("message", "Email already exists");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            User user = new User();
            user.setFullName(fullName);
            user.setUsername(username);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);
            user.setPassword(PasswordUtil.hashPassword(password));
            user.setActive(true);

            boolean success = userDAO.registerUser(user);

            if (success) {
                result.put("status", "success");
                result.put("message", "Registration successful");
            } else {
                result.put("status", "error");
                result.put("message", "Database insert failed");
            }

            response.getWriter().write(gson.toJson(result));

        } catch (Exception e) {
            
            System.out.println("REGISTER API ERROR ↓↓↓");
            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            result.put("status", "error");
            result.put("message", e.getMessage());

            response.getWriter().write(gson.toJson(result));
        }
    }
}