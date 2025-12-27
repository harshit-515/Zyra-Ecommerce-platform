package com.ecommerce.admin;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.ProductDAOImpl;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAOImpl();
        System.out.println("[AdminProductServlet] initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // 🔒 Security check (admin only)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Fetch ALL products (active + inactive)
        List<Product> products = productDAO.getAllProducts();

        // Debug
        System.out.println("[AdminProductServlet] Products loaded: " + products.size());

        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/manage-products.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        if ("toggle".equals(action)) {

            boolean isActive = Boolean.parseBoolean(
                    request.getParameter("currentStatus")
            );

            // Flip status
            boolean updated =
                    productDAO.updateProductStatus(productId, !isActive);

            System.out.println("[AdminProductServlet] Product "
                    + productId + " status updated: " + updated);
        }

        response.sendRedirect(
                request.getContextPath() + "/admin/products"
        );
    }
}
