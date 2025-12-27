<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #16a34a, #22c55e);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: system-ui, -apple-system, BlinkMacSystemFont,
                         "Segoe UI", sans-serif;
        }

        .success-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 40px 36px;
            max-width: 460px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .check-icon {
            width: 90px;
            height: 90px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #22c55e;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 44px;
        }

        .btn-primary {
            background-color: #2563eb;
            border-color: #2563eb;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
            border-color: #1d4ed8;
        }

        .order-info {
            background: #f8fafc;
            border-radius: 12px;
            padding: 14px;
            font-size: 14px;
            margin-top: 16px;
        }
    </style>
</head>
<body>

<div class="success-card">
    <div class="check-icon">
        ✓
    </div>

    <h3 class="fw-bold mb-2">Payment Successful</h3>
    <p class="text-muted">
        Thank you! Your payment has been processed successfully.
    </p>

    <div class="order-info text-start">
        <p class="mb-1">
            <b>Status:</b> Approved
        </p>
        <p class="mb-1">
            <b>Payment Method:</b> PayPal
        </p>
        <p class="mb-0">
            <b>Order:</b> Confirmed
        </p>
    </div>

    <div class="d-grid gap-2 mt-4">
        <a href="${pageContext.request.contextPath}/buyer/dashboard.jsp"
           class="btn btn-primary">
            Go to Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/buyer/orders"
           class="btn btn-outline-secondary">
            View My Orders
        </a>
    </div>

    <p class="text-muted mt-4 small">
        You will receive an order confirmation shortly.
    </p>
</div>

</body>
</html>
