<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        body {
            background: radial-gradient(circle at top, #0f1b3d, #050714);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: #e5e7eb;
        }

        .page-wrapper {
            max-width: 1200px;
            margin: 40px auto;
        }

        .page-header {
            background: rgba(15, 23, 42, 0.95);
            padding: 20px 26px;
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
            margin-bottom: 28px;
        }

        .page-title {
            font-size: 1.6rem;
            font-weight: 600;
            color: #f9fafb;
        }

        .subtitle {
            color: #94a3b8;
            font-size: 0.9rem;
        }

        table {
            background: rgba(15, 23, 42, 0.95);
            border-radius: 16px;
            overflow: hidden;
        }

        th, td {
            color: #1B1212 !important;
            vertical-align: middle;
        }

        thead th {
            background: rgba(2, 6, 23, 0.9);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: .08em;
            border-bottom: none;
        }

        tbody tr:hover {
            background: rgba(255,255,255,0.03);
        }

        .badge-role {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 0.75rem;
        }

        .role-ADMIN { background: #1e40af; }
        .role-SELLER { background: #047857; }
        .role-BUYER { background: #7c2d12; }

        .status-active {
            color: #22c55e;
            font-weight: 500;
        }

        .status-inactive {
            color: #ef4444;
            font-weight: 500;
        }

        .btn-toggle {
            border-radius: 999px;
            font-size: 0.75rem;
            padding: 6px 14px;
        }

        .back-link {
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="page-wrapper">

    <!-- HEADER -->
    <div class="page-header">
        <h1 class="page-title mb-1">👥 User Management</h1>
        <div class="subtitle">
            View, activate / deactivate and manage buyers & sellers
        </div>
    </div>

    <!-- USERS TABLE -->
    <div class="table-responsive">
        <table class="table table-borderless align-middle mb-0">
            <thead>
            <tr>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th class="text-end">Action</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="u" items="${users}">
                <tr>
                    <td>${u.username}</td>
                    <td>${u.fullName}</td>
                    <td>${u.email}</td>

                    <td>
                        <span class="badge badge-role role-${u.role}">
                            ${u.role}
                        </span>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${u.active}">
                                <span class="status-active">Active</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-inactive">Inactive</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td class="text-end">
                        <form action="${pageContext.request.contextPath}/admin/users"
                              method="post">

                            <input type="hidden" name="userId" value="${u.userId}">
                            <input type="hidden" name="action" value="toggle">

                            <button type="submit"
                                    class="btn btn-sm btn-toggle
                                    ${u.active ? 'btn-outline-danger' : 'btn-outline-success'}">

                                ${u.active ? 'Deactivate' : 'Activate'}

                            </button>
                        </form>
                    </td>
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
