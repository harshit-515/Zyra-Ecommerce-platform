package com.ecommerce.api;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.ProductDAOImpl;
import com.ecommerce.model.Product;
import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/products")
public class ProductApiServlet extends HttpServlet {

    private ProductDAO productDAO;
    private Gson gson;

    @Override
    public void init() {
        productDAO = new ProductDAOImpl();
        gson = new Gson();
        System.out.println("[API] ProductApiServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<Product> products = productDAO.getAllProducts();

        String json = gson.toJson(products);
        response.getWriter().write(json);
    }
}
