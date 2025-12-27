<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Products | Zyra</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #0f172a, #020617 70%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .page-wrapper {
            max-width: 1100px;
            margin: 60px auto;
        }

        /* Header */
        .page-header {
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(14px);
            border-radius: 22px;
            padding: 22px 26px;
            box-shadow: 0 28px 60px rgba(0, 0, 0, 0.6);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            border: 1px solid rgba(255,255,255,0.06);
        }
		/* Make table text white for dark theme */
table,
thead,
tbody,
tr,
th,
td {
    color: #e5e7eb !important; /* soft white */
}

/* Table headers slightly brighter */
thead th {
    color: #f9fafb !important;
    font-weight: 600;
}

/* Optional: lighter row text */
tbody td {
    color: #e5e7eb !important;
}
		
        .page-header h3 {
            color: #f8fafc;
            font-weight: 700;
        }

        .page-header small {
            color: #94a3b8;
        }
		tbody tr {
    background: rgba(255, 255, 255, 0.02);
}

tbody tr:hover {
    background: rgba(255, 255, 255, 0.05);
}
		table {
    background: transparent !important;
}

thead, tbody, tr, td, th {
    background: transparent !important;
}
		
        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            font-weight: 500;
        }

        .btn-primary:hover {
            opacity: 0.9;
        }

        /* Alerts */
        .alert {
            border-radius: 14px;
            border: none;
        }

        /* Table */
        .table-wrapper {
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(14px);
            border-radius: 20px;
            padding: 12px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
            border: 1px solid rgba(255,255,255,0.05);
        }

        table {
            margin-bottom: 0;
            color: #e5e7eb;
        }

        thead th {
            color: #94a3b8;
            font-weight: 600;
            font-size: 0.85rem;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }

        tbody tr:hover {
            background: rgba(255,255,255,0.03);
        }

        tbody td {
            border-top: 1px solid rgba(255,255,255,0.05);
        }

        /* Badges */
        .badge {
            border-radius: 999px;
            padding: 6px 12px;
            font-weight: 500;
        }

        /* Back link */
        .back-link {
            color: #60a5fa;
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            color: #3b82f6;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="page-wrapper">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h3 class="mb-1">My Products</h3>
            <small>Manage products you are selling.</small>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/seller/products?action=new"
               class="btn btn-primary btn-sm">
                + Add Product
            </a>
            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-outline-danger btn-sm ms-2">
                Logout
            </a>
        </div>
    </div>

    <!-- Error -->
    <c:if test="${not empty sessionScope.sellerProductError}">
        <div class="alert alert-danger">
            ${sessionScope.sellerProductError}
        </div>
        <c:remove var="sellerProductError" scope="session"/>
    </c:if>

    <!-- Empty -->
    <c:if test="${empty products}">
        <div class="alert alert-info">
            You have not added any products yet. Click <b>Add Product</b> to get started.
        </div>
    </c:if>

    <!-- Products Table -->
    <c:if test="${not empty products}">
        <div class="table-wrapper">
            <table class="table align-middle table-borderless">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Category</th>
                    <th class="text-end">Price (₹)</th>
                    <th class="text-end">Stock</th>
                    <th class="text-center">Status</th>
                    <th class="text-end">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td>${p.productName}</td>
                        <td>${p.category}</td>
                        <td class="text-end">${p.price}</td>
                        <td class="text-end">${p.stockQuantity}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${p.active}">
                                    <span class="badge bg-success-subtle text-success">
                                        Active
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary-subtle text-secondary">
                                        Inactive
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/seller/products?action=edit&id=${p.productId}"
                               class="btn btn-sm btn-outline-primary">
                                Edit
                            </a>

                            <form action="${pageContext.request.contextPath}/seller/products"
                                  method="post"
                                  style="display:inline-block"
                                  onsubmit="return confirm('Delete this product?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="productId" value="${p.productId}">
                                <button type="submit"
                                        class="btn btn-sm btn-outline-danger ms-1">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/seller/dashboard.jsp"
       class="back-link d-inline-block mt-4">
        &larr; Back to Dashboard
    </a>

</div>

</body>
</html>
