<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard | Zyra</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #0f172a, #020617 70%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .dashboard-wrapper {
            max-width: 1200px;
            margin: 60px auto;
        }

        /* Header card */
        .seller-card {
            background: rgba(15, 23, 42, 0.88);
            backdrop-filter: blur(14px);
            padding: 28px 32px;
            border-radius: 22px;
            box-shadow: 0 30px 70px rgba(0, 0, 0, 0.6);
            border: 1px solid rgba(255,255,255,0.06);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .seller-name {
            font-size: 1.9rem;
            font-weight: 700;
            color: #f8fafc;
        }

        .seller-sub {
            margin-top: 6px;
            color: #94a3b8;
            font-size: 0.95rem;
        }

        .logout-link {
            color: #f87171;
            font-weight: 500;
            text-decoration: none;
        }

        .logout-link:hover {
            color: #ef4444;
            text-decoration: underline;
        }

        /* Action cards */
        .action-card {
            background: rgba(15, 23, 42, 0.92);
            border-radius: 20px;
            padding: 28px;
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.55);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
            height: 100%;
            border: 1px solid rgba(255,255,255,0.06);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 28px 60px rgba(0, 0, 0, 0.75);
        }

        .action-card img {
            filter: drop-shadow(0 6px 14px rgba(0,0,0,.4));
        }

        .action-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-top: 12px;
            color: #f8fafc;
        }

        .action-card p {
            color: #9ca3af;
            font-size: 0.92rem;
            margin-top: 6px;
        }

        a.card-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>

<body>

<div class="dashboard-wrapper">

    <!-- Seller Profile -->
    <div class="seller-card mb-5">
        <div>
            <div class="seller-name">
                Welcome, <c:out value="${sessionScope.currentUser.username}"/>
            </div>
            <div class="seller-sub">
                Manage your store, products & orders from one place.
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/logout"
           class="logout-link">
            Logout
        </a>
    </div>

    <!-- Dashboard Options -->
    <div class="row g-4">

        <!-- Manage Products -->
        <div class="col-12 col-md-6 col-lg-4">
            <a href="${pageContext.request.contextPath}/seller/products"
               class="card-link">
                <div class="action-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/679/679720.png"
                         width="46" class="mb-3">
                    <div class="action-title">Manage My Products</div>
                    <p>
                        Add new products, update pricing, stock and listings.
                    </p>
                </div>
            </a>
        </div>

    </div>
</div>

</body>
</html>
