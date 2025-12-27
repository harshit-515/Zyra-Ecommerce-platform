<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Buyer Dashboard</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top,
                    #0b1220,
                    #020617 70%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .page-wrapper {
            max-width: 1200px;
            margin: 50px auto;
        }

        /* Header */
        .page-header {
            background: rgba(15, 23, 42, 0.75);
            backdrop-filter: blur(12px);
            border-radius: 18px;
            padding: 22px 26px;
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.45);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            border: 1px solid rgba(255, 255, 255, 0.06);
        }

        .page-title {
            font-size: 1.6rem;
            font-weight: 600;
            margin: 0;
            color: #f8fafc;
        }

        .page-subtitle {
            margin: 4px 0 0;
            color: #94a3b8;
            font-size: 0.95rem;
        }

        .btn-logout {
            border-radius: 999px;
            font-weight: 500;
            color: #e5e7eb;
            border-color: rgba(255, 255, 255, 0.18);
        }

        .btn-logout:hover {
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
        }

        /* Dashboard tiles */
        .card-tile {
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.06);
            background: linear-gradient(
                    180deg,
                    rgba(15, 23, 42, 0.9),
                    rgba(2, 6, 23, 0.9)
            );
            box-shadow: 0 18px 45px rgba(0, 0, 0, 0.5);
            transition: transform .18s ease, box-shadow .18s ease;
            height: 100%;
        }

        .card-tile:hover {
            transform: translateY(-6px);
            box-shadow: 0 26px 65px rgba(37, 99, 235, 0.25);
        }

        .card-icon {
            width: 54px;
            height: 54px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.9rem;
            margin-bottom: 14px;
        }

        .icon-browse {
            background: rgba(37, 99, 235, 0.15);
            color: #60a5fa;
        }

        .icon-cart {
            background: rgba(22, 163, 74, 0.15);
            color: #4ade80;
        }

        .icon-orders {
            background: rgba(249, 115, 22, 0.15);
            color: #fb923c;
        }

        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 6px;
            color: #f8fafc;
        }

        .card-text {
            font-size: 0.92rem;
            color: #9ca3af;
        }

        a.tile-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>

<div class="page-wrapper">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h1 class="page-title">Buyer Dashboard</h1>
            <p class="page-subtitle">
                Welcome,
                <strong>
                    <c:out value="${sessionScope.currentUser.username}" />
                </strong>
            </p>
        </div>

        <a href="${pageContext.request.contextPath}/logout"
           class="btn btn-outline-secondary btn-sm btn-logout">
            Logout
        </a>
    </div>

    <!-- Tiles -->
    <div class="row g-4">

        <!-- Browse Products -->
        <div class="col-12 col-md-4">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/products">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-browse">🛒</div>
                        <h5 class="card-title">Browse Products</h5>
                        <p class="card-text">
                            Explore items from all sellers and add them to your cart.
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <!-- My Cart -->
        <div class="col-12 col-md-4">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/buyer/cart">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-cart">🛍️</div>
                        <h5 class="card-title">My Cart</h5>
                        <p class="card-text">
                            View and manage items currently in your shopping cart.
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <!-- My Orders -->
        <div class="col-12 col-md-4">
            <a class="tile-link"
               href="${pageContext.request.contextPath}/buyer/orders">
                <div class="card card-tile">
                    <div class="card-body">
                        <div class="card-icon icon-orders">📦</div>
                        <h5 class="card-title">My Orders</h5>
                        <p class="card-text">
                            Track your past orders and delivery status in one place.
                        </p>
                    </div>
                </div>
            </a>
        </div>

    </div>
</div>

</body>
</html>
