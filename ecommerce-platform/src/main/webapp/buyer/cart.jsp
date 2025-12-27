<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart | Zyra</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            margin: 0;
            background: radial-gradient(1200px at top left, #0f172a, #020617);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .cart-box {
            max-width: 1000px;
            margin: 60px auto;
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.6);
            padding: 28px 36px 32px;
        }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .cart-header h3 {
            margin: 0;
            font-weight: 600;
            color: #f8fafc;
        }

        .cart-header small {
            color: #94a3b8;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            border: none;
            border-radius: 999px;
            font-weight: 500;
            padding: 8px 20px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
        }

        .btn-outline-secondary,
        .btn-outline-danger {
            border-radius: 999px;
        }

        .table {
            --bs-table-bg: transparent;
            --bs-table-color: #e5e7eb;
            --bs-table-border-color: rgba(255,255,255,0.08);
        }

        thead th {
            color: #cbd5f5;
            font-weight: 600;
            border-bottom: 1px solid rgba(255,255,255,0.15);
        }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.04);
        }

        .text-muted {
            color: #94a3b8 !important;
        }

        .text-primary {
            color: #60a5fa !important;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.12);
            border: 1px solid rgba(239, 68, 68, 0.4);
            color: #fecaca;
            border-radius: 12px;
        }

        .remove-link {
            color: #f87171;
            font-weight: 500;
            text-decoration: none;
        }

        .remove-link:hover {
            text-decoration: underline;
            color: #ef4444;
        }

        .total-box {
            margin-top: 28px;
            padding-top: 18px;
            border-top: 1px solid rgba(255,255,255,0.12);
        }
    </style>
</head>
<body>

<div class="cart-box">

    <!-- HEADER -->
    <div class="cart-header">
        <div>
            <h3>Your Cart</h3>
            <small>
                <c:choose>
                    <c:when test="${itemCount > 0}">
                        ${itemCount} item(s) in cart
                    </c:when>
                    <c:otherwise>No items in cart</c:otherwise>
                </c:choose>
            </small>
        </div>

        <div class="d-flex gap-2">
            <a class="btn btn-outline-secondary btn-sm"
               href="${pageContext.request.contextPath}/products">
                Continue Shopping
            </a>

            <c:if test="${itemCount > 0}">
                <form action="${pageContext.request.contextPath}/buyer/cart"
                      method="post">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn btn-outline-danger btn-sm">
                        Clear Cart
                    </button>
                </form>
            </c:if>
        </div>
    </div>

    <!-- ERROR -->
    <c:if test="${not empty sessionScope.cartError}">
        <div class="alert alert-danger py-2">
            ${sessionScope.cartError}
        </div>
        <c:remove var="cartError" scope="session"/>
    </c:if>

    <!-- EMPTY -->
    <c:if test="${itemCount == 0}">
        <p class="text-muted mb-0">Your cart is empty.</p>
    </c:if>

    <!-- TABLE -->
    <c:if test="${itemCount > 0}">
        <table class="table align-middle">
            <thead>
            <tr>
                <th>Product</th>
                <th width="120">Quantity</th>
                <th width="120">Price</th>
                <th width="120">Subtotal</th>
                <th width="80"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${cartItems}">
                <tr>
                    <td>
                        <strong>${item.productName}</strong><br>
                        <small class="text-muted">${item.category}</small>
                    </td>
                    <td>${item.quantity}</td>
                    <td>₹ ${item.productPrice}</td>
                    <td>₹ ${item.subtotal}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/buyer/cart"
                              method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="cartId" value="${item.cartId}">
                            <button type="submit"
                                    class="btn btn-link remove-link p-0">
                                Remove
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="d-flex justify-content-between align-items-center total-box">
            <h5 class="mb-0">
                Total:
                <span class="text-primary">₹ ${totalAmount}</span>
            </h5>

            <a href="${pageContext.request.contextPath}/buyer/checkout"
               class="btn btn-primary">
                Proceed to Checkout
            </a>
        </div>
    </c:if>

</div>

</body>
</html>
