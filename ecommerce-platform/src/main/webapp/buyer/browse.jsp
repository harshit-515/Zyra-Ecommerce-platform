<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Browse Products | Zyra</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #0f172a 0%, #020617 60%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .page-wrapper {
            max-width: 1200px;
            margin: 40px auto;
        }

        /* Header */
        .page-header {
            background: rgba(2, 6, 23, 0.9);
            border-radius: 18px;
            padding: 22px 26px;
            box-shadow: 0 25px 60px rgba(15, 23, 42, 0.55);
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            border: 1px solid rgba(255,255,255,0.05);
        }

        .page-title {
            font-size: 1.7rem;
            font-weight: 700;
            margin: 0;
            color: #ffffff;
        }

        .page-subtitle {
            margin-top: 6px;
            color: #9ca3af;
            font-size: 0.95rem;
        }

        .logout-link {
            color: #f87171;
            font-weight: 500;
            text-decoration: none;
        }

        .logout-link:hover {
            text-decoration: underline;
            color: #ef4444;
        }

        /* Product cards */
        .product-card {
            background: rgba(2, 6, 23, 0.95);
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.05);
            box-shadow: 0 20px 50px rgba(15, 23, 42, 0.5);
            transition: transform .18s ease, box-shadow .18s ease;
            height: 100%;
            overflow: hidden;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 30px 70px rgba(37, 99, 235, .35);
        }

        .product-image-placeholder {
            background: linear-gradient(135deg, #2563eb, #0ea5e9);
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-weight: 600;
            font-size: 1.1rem;
            text-align: center;
            padding: 12px;
        }

        .card-body {
            display: flex;
            flex-direction: column;
        }

        .card-title {
            font-weight: 600;
            color: #f9fafb;
        }

        .card-text {
            color: #9ca3af;
        }

        .price-tag {
            font-size: 1.1rem;
            font-weight: 700;
            color: #60a5fa;
        }

        .category-badge {
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: .08em;
            background: rgba(37,99,235,0.15);
            color: #93c5fd;
            border-radius: 999px;
            padding: 4px 10px;
        }

        .stock-badge {
            font-size: 0.75rem;
            background: rgba(34,197,94,0.15);
            color: #86efac;
        }

        .quantity-input {
            max-width: 80px;
            background: #020617;
            border: 1px solid rgba(255,255,255,0.08);
            color: #e5e7eb;
        }

        .quantity-input:focus {
            background: #020617;
            color: #ffffff;
            border-color: #2563eb;
            box-shadow: none;
        }

        .btn-add-cart {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            border-radius: 999px;
            font-weight: 600;
            box-shadow: 0 12px 30px rgba(37,99,235,.4);
        }

        .btn-add-cart:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
        }

        /* Empty state */
        .empty-state {
            background: rgba(2, 6, 23, 0.95);
            border-radius: 18px;
            box-shadow: 0 25px 60px rgba(15, 23, 42, 0.55);
            padding: 70px 30px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.05);
        }

        .empty-state h4 {
            font-weight: 600;
            color: #f9fafb;
        }

        .empty-state p {
            color: #9ca3af;
        }
    </style>
</head>
<body>

<div class="page-wrapper">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h1 class="page-title">Browse Products</h1>
            <p class="page-subtitle">
                Discover handpicked products from trusted sellers on Zyra.
            </p>
        </div>

        <div class="text-end mt-3 mt-sm-0">
            <div class="small text-muted mb-1">
                Logged in as
                <strong class="text-white">${sessionScope.currentUser.username}</strong>
                (<c:out value="${sessionScope.currentUser.role}" />)
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                Logout
            </a>
        </div>
    </div>

    <!-- Products -->
    <c:if test="${empty products}">
        <div class="empty-state">
            <h4>No products available</h4>
            <p>Once sellers add products, they will appear here.</p>
        </div>
    </c:if>

    <c:if test="${not empty products}">
        <div class="row g-4">
            <c:forEach var="p" items="${products}">
                <div class="col-12 col-sm-6 col-lg-4">
                    <div class="card product-card">

                        <div class="product-image-placeholder">
                            <c:out value="${p.productName}" />
                        </div>

                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h5 class="card-title mb-0">
                                    <c:out value="${p.productName}" />
                                </h5>
                                <span class="category-badge">
                                    <c:out value="${p.category}" />
                                </span>
                            </div>

                            <p class="card-text small mb-2">
                                <c:out value="${p.description}" />
                            </p>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="price-tag">$<c:out value="${p.price}" /></span>
                                <span class="badge stock-badge">
                                    In stock: <c:out value="${p.stockQuantity}" />
                                </span>
                            </div>

                            <!-- Add to Cart -->
                            <form action="${pageContext.request.contextPath}/buyer/cart"
                                  method="post" class="mt-auto">

                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${p.productId}">

                                <div class="d-flex justify-content-between align-items-end">
                                    <div>
                                        <label class="form-label mb-1 small text-muted">Qty</label>
                                        <input type="number"
                                               name="quantity"
                                               value="1"
                                               min="1"
                                               max="${p.stockQuantity}"
                                               class="form-control form-control-sm quantity-input">
                                    </div>

                                    <button type="submit"
                                            class="btn btn-add-cart px-4">
                                        Add to Cart
                                    </button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
