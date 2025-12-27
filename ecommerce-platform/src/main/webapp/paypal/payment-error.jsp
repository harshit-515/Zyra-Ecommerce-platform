<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Failed</title>
</head>
<body>
    <h2>❌ Payment Failed</h2>
    <p>Something went wrong during payment.</p>

    <a href="<%=request.getContextPath()%>/buyer/cart">
        Go back to Cart
    </a>
</body>
</html>
