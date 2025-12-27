<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Orders Overview</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            background: radial-gradient(circle at top, #0f1b3d, #050714);
            color: #e5e7eb;
            font-family: system-ui;
        }

        .container {
            max-width: 1200px;
            margin-top: 40px;
        }

        table {
            background: rgba(15, 23, 42, 0.95);
            border-radius: 16px;
            overflow: hidden;
        }

        th {
            background: #020617;
            color: #9ca3af;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: .08em;
        }

        td {
            color: #e5e7eb;
        }

        .status {
            font-weight: 600;
        }

        .status-PENDING { color: #facc15; }
        .status-PAID { color: #22c55e; }
        .status-CANCELLED { color: #ef4444; }

        .back-link {
            color: #9ca3af;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container">

    <h2 class="mb-1">🧾 Orders Overview</h2>
    <p class="text-muted mb-4">All orders placed across the platform</p>

    <div class="table-responsive">
        <table class="table table-borderless align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>Buyer</th>
                <th>Total (₹)</th>
                <th>Payment</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="o" items="${orders}">
                <tr>
                    <td>#${o.orderId}</td>
                    <td>${o.buyerName}</td>
                    <td>${o.totalAmount}</td>
                    <td>${o.paymentMethod}</td>
                    <td class="status status-${o.status}">
                        ${o.status}
                    </td>
                    <td>${o.createdAt}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
           class="back-link">
            ← Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
