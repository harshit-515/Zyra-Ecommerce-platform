<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>Product Catalogue</title>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<style>
body {
    background: radial-gradient(circle at top, #0f1b3d, #050714);
    color: #e5e7eb;
}
.table {
    background: rgba(15,23,42,0.95);
    border-radius: 14px;
}
thead th {
    background: #020617;
    color: #c7d2fe;
    font-size: .75rem;
    text-transform: uppercase;
}
</style>
</head>

<body>
<div class="container mt-5">

<h3 class="mb-3">📦 Product Catalogue</h3>
<p class="text-muted">All products across the platform</p>

<table class="table table-borderless align-middle">
<thead>
<tr>
    <th>Name</th>
    <th>Seller</th>
    <th>Category</th>
    <th>Price (₹)</th>
    <th>Stock</th>
    <th>Status</th>
    <th class="text-end">Action</th>
</tr>
</thead>

<tbody>
<c:forEach var="p" items="${products}">
<tr>
    <td>${p.productName}</td>
    <td>${p.sellerName}</td>
    <td>${p.category}</td>
    <td>${p.price}</td>
    <td>${p.stockQuantity}</td>
    <td>
        <c:choose>
            <c:when test="${p.active}">
                <span class="text-success">Active</span>
            </c:when>
            <c:otherwise>
                <span class="text-danger">Inactive</span>
            </c:otherwise>
        </c:choose>
    </td>

    <td class="text-end">
        <form method="post"
              action="${pageContext.request.contextPath}/admin/products">
            <input type="hidden" name="productId" value="${p.productId}">
            <input type="hidden" name="active" value="${!p.active}">
            <button class="btn btn-sm
                ${p.active ? 'btn-outline-danger' : 'btn-outline-success'}">
                ${p.active ? 'Disable' : 'Enable'}
            </button>
        </form>
    </td>
</tr>
</c:forEach>
</tbody>
</table>

<a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
   class="text-light text-decoration-none">
← Back to Dashboard
</a>

</div>
</body>
</html>
