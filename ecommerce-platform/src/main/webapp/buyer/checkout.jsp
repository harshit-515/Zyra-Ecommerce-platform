<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout | Zyra</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #0f172a, #020617 70%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .checkout-box {
            max-width: 1050px;
            margin: 60px auto;
            background: rgba(15, 23, 42, 0.88);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            box-shadow: 0 30px 70px rgba(0, 0, 0, 0.6);
            padding: 30px 36px 36px;
            border: 1px solid rgba(255,255,255,0.06);
        }

        .checkout-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .checkout-header h3 {
            margin: 0;
            color: #f8fafc;
            font-weight: 600;
        }

        .checkout-header small {
            color: #94a3b8;
        }

        h5 {
            color: #f8fafc;
            margin-bottom: 12px;
            font-weight: 600;
        }

        .table {
            --bs-table-bg: transparent;
            --bs-table-color: #e5e7eb;
            --bs-table-border-color: rgba(255,255,255,0.1);
        }

        thead th {
            color: #cbd5f5;
            font-weight: 600;
            border-bottom: 1px solid rgba(255,255,255,0.15);
        }

        tbody tr:hover {
            background: rgba(255,255,255,0.04);
        }

        .form-control {
            background: #020617;
            border: 1px solid rgba(255,255,255,0.12);
            color: #e5e7eb;
            border-radius: 12px;
        }

        .form-control:focus {
            background: #020617;
            color: #ffffff;
            border-color: #2563eb;
            box-shadow: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            border: none;
            border-radius: 999px;
            font-weight: 600;
            padding: 10px;
            box-shadow: 0 14px 35px rgba(37,99,235,.45);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
        }

        .btn-outline-secondary {
            border-radius: 999px;
            color: #e5e7eb;
            border-color: rgba(255,255,255,0.2);
        }

        .btn-outline-secondary:hover {
            background: rgba(255,255,255,0.08);
            color: #fff;
        }

        .total-row {
            margin-top: 18px;
            padding-top: 12px;
            border-top: 1px solid rgba(255,255,255,0.15);
        }

        .text-muted {
            color: #94a3b8 !important;
        }

        .text-primary {
            color: #60a5fa !important;
        }
    </style>
</head>

<body>

<div class="checkout-box">

    <!-- Header -->
    <div class="checkout-header">
        <div>
            <h3>Checkout</h3>
            <small>Review your items and complete payment.</small>
        </div>
        <a href="${pageContext.request.contextPath}/buyer/cart"
           class="btn btn-outline-secondary btn-sm">
            Back to Cart
        </a>
    </div>

    <c:if test="${itemCount == 0}">
        <p class="text-muted mb-0">Your cart is empty.</p>
    </c:if>

    <c:if test="${itemCount > 0}">
        <div class="row g-4">

            <!-- Order Summary -->
            <div class="col-md-6">
                <h5>Order Summary</h5>
                <table class="table table-sm align-middle mt-3">
                    <thead>
                    <tr>
                        <th>Product</th>
                        <th style="width:60px;">Qty</th>
                        <th class="text-end" style="width:100px;">Price</th>
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
                            <td class="text-end">₹ ${item.subtotal}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="d-flex justify-content-between total-row">
                    <span><strong>Items:</strong> ${itemCount}</span>
                    <span><strong>Total:</strong>
                        <span class="text-primary">₹ ${totalAmount}</span>
                    </span>
                </div>
            </div>

            <!-- Payment -->
            <div class="col-md-6">
                <h5>Shipping Address</h5>

                <!-- MANUAL ADDRESS (no auto-filled data) -->
                <textarea name="shippingAddress"
                          class="form-control mb-3"
                          rows="4"
                          placeholder="House no, street, city, state, pincode"
                          required></textarea>

                <h5>Payment</h5>

                <!-- PAYPAL -->
                <form action="${pageContext.request.contextPath}/paypal/create"
                      method="post">

                    <input type="hidden" name="amount" value="${totalAmount}" />

                    <button type="submit"
                            class="btn btn-primary w-100 mt-3">
                        Pay with PayPal
                    </button>
                </form>

                <p class="text-muted text-center mt-3" style="font-size:13px">
                    Secure payment powered by PayPal Sandbox
                </p>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
