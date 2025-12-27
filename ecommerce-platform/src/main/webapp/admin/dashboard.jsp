<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>

    <style>
        body {
            background: #0f172a; /* dark gradient background */
            background: radial-gradient(circle at top, #1e293b 0, #020617 55%);
            min-height: 100vh;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        .page-wrapper {
            max-width: 1200px;
            margin: 40px auto;
        }

        .page-header {
            background: rgba(15, 23, 42, 0.9);
            border-radius: 18px;
            padding: 22px 28px;
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.7);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            backdrop-filter: blur(10px);
            color: #e5e7eb;
        }

        .page-title {
            font-size: 1.7rem;
            font-weight: 600;
            margin: 0;
        }

        .page-subtitle {
            margin: 4px 0 0;
            color: #9ca3af;
            font-size: 0.94rem;
        }

        .btn-logout {
            border-radius: 999px;
            font-weight: 500;
        }

        .card-tile {
            border: none;
            border-radius: 18px;
            box-shadow: 0 18px 38px rgba(15, 23, 42, 0.9);
            transition: transform .15s ease, box-shadow .15s ease, border .15s ease;
            cursor: pointer;
            height: 100%;
            background: linear-gradient(145deg, #020617, #0b1120);
            border: 1px solid rgba(148, 163, 184, 0.25);
            color: #e5e7eb;
        }

        .card-tile:hover {
            transform: translateY(-4px);
            box-shadow: 0 26px 55px rgba(15, 23, 42, 1);
            border-color: #4f46e5;
        }

        .card-icon {
            width: 52px;
            height: 52px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 16px;
        }

        .icon-users   { background: rgba(59, 130, 246, 0.1); color: #60a5fa; }
        .icon-products{ background: rgba(34, 197, 94, 0.1);  color: #4ade80; }
        .icon-orders  { background: rgba(249, 115, 22, 0.1); color: #fb923c; }
        .icon-report  { background: rgba(236, 72, 153, 0.1); color: #fb7185; }

        .card-title {
            font-size: 1.06rem;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .card-text {
            font-size: 0.9rem;
            color: #9ca3af;
            margin-bottom: 10px;
        }

        .card-meta {
            font-size: 0.8rem;
            color: #6b7280;
        }

        a.tile-link {
            text-decoration: none;
            color: inherit;
        }

        .badge-pill {
            border-radius: 999px;
            font-size: 0.78rem;
            padding: 4px 10px;
        }
    </style>
</head>
<body>

<div class="page-wrapper">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h1 class="page-title">
                Admin Panel
                <span style="font-size:0.9rem; font-weight:400; color:#9ca3af;">
                    – <c:out value="${sessionScope.currentUser.username}" />
                </span>
            </h1>
            <p class="page-subtitle">
                Monitor users, products & orders across the platform.
            </p>
        </div>

        <a href="${pageContext.request.contextPath}/logout"
           class="btn btn-outline-light btn-sm btn-logout">
            Logout
        </a>
    </div>

    <!-- Tiles -->
    <div class="row g-4">

        <!-- Manage Users -->
        <div class="col-12 col-md-6 col-lg-3">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/admin/users">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-users">
                            👥
                        </div>
                        <h5 class="card-title">User Management</h5>
                        <p class="card-text">
                            View, activate / deactivate and manage all buyers & sellers.
                        </p>
                        <div class="card-meta">
                            <span class="badge bg-sky-500 bg-primary badge-pill">
                                Admin only
                            </span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Manage Products -->
        <div class="col-12 col-md-6 col-lg-3">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/admin/products">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-products">
                            📦
                        </div>
                        <h5 class="card-title">Product Catalogue</h5>
                        <p class="card-text">
                            Review all listed products, flag or disable suspicious items.
                        </p>
                        <div class="card-meta">
                            <span class="badge bg-success badge-pill">
                                Global products
                            </span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Orders Overview -->
        <div class="col-12 col-md-6 col-lg-3">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/admin/orders">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-orders">
                            🧾
                        </div>
                        <h5 class="card-title">Orders Overview</h5>
                        <p class="card-text">
                            Track all platform orders, statuses and basic analytics.
                        </p>
                        <div class="card-meta">
                            <span class="badge bg-warning text-dark badge-pill">
                                All buyers
                            </span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Reports / System -->
        <div class="col-12 col-md-6 col-lg-3">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/admin/reports">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-report">
                            📊
                        </div>
                        <h5 class="card-title">Reports & Stats</h5>
                        <p class="card-text">
                            Placeholder for future dashboards: revenue, top sellers & more.
                        </p>
                        <div class="card-meta">
                            <span class="badge bg-danger badge-pill">
                                Reports
                            </span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

    </div>
</div>

</body>
</html>