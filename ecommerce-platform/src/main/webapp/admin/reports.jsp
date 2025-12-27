<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reports & Stats</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        body {
            background: radial-gradient(circle at top, #0f1b3d, #050714);
            color: #e5e7eb;
            font-family: system-ui;
        }
        .box {
            background: rgba(15,23,42,0.95);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 20px 40px rgba(0,0,0,.6);
        }
        .stat {
            font-size: 1.8rem;
            font-weight: 700;
        }
        .label {
            color: #94a3b8;
            font-size: .85rem;
        }
        table th { color: #9ca3af; }
    </style>
</head>
<body>

<div class="container mt-5">

    <div class="mb-4">
        <h2>📊 Reports & Statistics</h2>
        <p class="text-muted">Platform insights overview</p>
    </div>

    <!-- STATS -->
    <div class="row g-4">
        <div class="col-md-3"><div class="box"><div class="stat">${totalUsers}</div><div class="label">Total Users</div></div></div>
        <div class="col-md-3"><div class="box"><div class="stat">${totalSellers}</div><div class="label">Sellers</div></div></div>
        <div class="col-md-3"><div class="box"><div class="stat">${totalBuyers}</div><div class="label">Buyers</div></div></div>
        <div class="col-md-3"><div class="box"><div class="stat">${totalProducts}</div><div class="label">Products</div></div></div>
    </div>

    <div class="row g-4 mt-3">
        <div class="col-md-6">
            <div class="box">
                <div class="stat">₹ ${totalRevenue}</div>
                <div class="label">Total Revenue</div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box">
                <div class="stat">${totalOrders}</div>
                <div class="label">Total Orders</div>
            </div>
        </div>
    </div>

    <!-- RECENT ORDERS -->
    <div class="box mt-5">
        <h5 class="mb-3">🕒 Recent Orders</h5>
        <table class="table table-dark table-borderless">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Buyer</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="o" items="${recentOrders}">
                <tr>
                    <td>#${o.orderId}</td>
                    <td>${o.buyerName}</td>
                    <td>₹ ${o.totalAmount}</td>
                    <td>${o.status}</td>
                    <td>${o.createdAt}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
       class="text-decoration-none text-secondary mt-4 d-inline-block">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>
