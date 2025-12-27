<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Product Form'}"/></title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(1200px circle at 10% 10%, #0f172a, #020617 65%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .form-box {
            max-width: 700px;
            margin: 60px auto;
            background: rgba(15, 23, 42, 0.75);
            border-radius: 20px;
            padding: 28px 32px 34px;
            backdrop-filter: blur(14px);
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.55);
        }

        h4 {
            color: #f9fafb;
            font-weight: 600;
        }

        /* Labels */
        .form-label {
            color: #e5e7eb;
            font-weight: 500;
        }

        /* Inputs */
        .form-control {
            background: rgba(2, 6, 23, 0.85);
            border: 1px solid rgba(255, 255, 255, 0.12);
            color: #f9fafb;
            border-radius: 12px;
        }

        .form-control::placeholder {
            color: #9ca3af;
        }

        .form-control:focus {
            background: rgba(2, 6, 23, 0.95);
            color: #fff;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
        }

        textarea.form-control {
            resize: none;
        }

        .form-text {
            color: #9ca3af;
        }

        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            border-radius: 999px;
            font-weight: 500;
            padding: 10px 26px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
        }

        .btn-outline-secondary {
            color: #e5e7eb;
            border-color: rgba(255, 255, 255, 0.25);
            border-radius: 999px;
        }

        .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.08);
            color: #fff;
            border-color: rgba(255, 255, 255, 0.4);
        }

        /* Fix number input arrows visibility */
        input[type=number]::-webkit-inner-spin-button {
            filter: invert(1);
        }
    </style>
</head>

<body>

<div class="form-box">
    <h4 class="mb-4">
        <c:out value="${pageTitle != null ? pageTitle : 'Product'}"/>
    </h4>

    <form action="${pageContext.request.contextPath}/seller/products" method="post">
        <input type="hidden" name="action" value="save">

        <c:if test="${not empty product}">
            <input type="hidden" name="productId" value="${product.productId}">
        </c:if>

        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" name="productName"
                   class="form-control"
                   required
                   value="<c:out value='${product.productName}'/>">
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description"
                      rows="4"
                      class="form-control"
                      required><c:out value='${product.description}'/></textarea>
        </div>

        <div class="row">
            <div class="mb-3 col-md-4">
                <label class="form-label">Price (₹)</label>
                <input type="number" step="0.01" min="0"
                       name="price"
                       class="form-control"
                       required
                       value="<c:out value='${product.price}'/>">
            </div>

            <div class="mb-3 col-md-4">
                <label class="form-label">Stock Quantity</label>
                <input type="number" min="0"
                       name="stockQuantity"
                       class="form-control"
                       required
                       value="<c:out value='${product.stockQuantity}'/>">
            </div>

            <div class="mb-3 col-md-4">
                <label class="form-label">Category</label>
                <input type="text"
                       name="category"
                       class="form-control"
                       value="<c:out value='${product.category}'/>">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Image URL (optional)</label>
            <input type="text" name="imageUrl"
                   class="form-control"
                   value="<c:out value='${product.imageUrl}'/>">
            <div class="form-text">
                Paste a public image URL (JPG / PNG).
            </div>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="${pageContext.request.contextPath}/seller/products"
               class="btn btn-outline-secondary">
                Cancel
            </a>
            <button type="submit" class="btn btn-primary">
                Save Product
            </button>
        </div>
    </form>
</div>

</body>
</html>
