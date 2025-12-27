<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Zyra – Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #020617);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: system-ui, -apple-system, BlinkMacSystemFont,
                         "Segoe UI", sans-serif;
        }

        .login-card {
            background: #ffffff;
            width: 100%;
            max-width: 420px;
            border-radius: 18px;
            padding: 36px 32px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.35);
        }

        .brand {
            text-align: center;
            margin-bottom: 26px;
        }

        .brand h1 {
            font-weight: 800;
            font-size: 32px;
            letter-spacing: 1px;
            margin-bottom: 6px;
            color: #0f172a;
        }

        .brand p {
            font-size: 14px;
            color: #64748b;
        }

        .form-control {
            height: 48px;
            border-radius: 10px;
        }

        .btn-primary {
            background-color: #2563eb;
            border-color: #2563eb;
            height: 48px;
            font-weight: 600;
            border-radius: 10px;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
            border-color: #1d4ed8;
        }

        .divider {
            text-align: center;
            margin: 22px 0;
            position: relative;
            color: #94a3b8;
            font-size: 13px;
        }

        .divider::before,
        .divider::after {
            content: "";
            height: 1px;
            width: 40%;
            background: #e5e7eb;
            position: absolute;
            top: 50%;
        }

        .divider::before {
            left: 0;
        }

        .divider::after {
            right: 0;
        }

        .create-link {
            text-align: center;
        }

        .create-link a {
            text-decoration: none;
            font-weight: 600;
            color: #2563eb;
        }

        .create-link a:hover {
            text-decoration: underline;
        }

        .error {
            background: #fee2e2;
            color: #b91c1c;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 14px;
            text-align: center;
        }

        .footer-text {
            text-align: center;
            font-size: 13px;
            color: #94a3b8;
            margin-top: 18px;
        }
    </style>
</head>
<body>

<div class="login-card">

    <!-- Brand -->
    <div class="brand">
        <h1>Zyra</h1>
        <p>Your modern online shopping destination</p>
    </div>

    <!-- Error message -->
    <%
        String error = (String) request.getAttribute("errorMessage");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <!-- Login Form -->
    <form action="<%= request.getContextPath() %>/login" method="post">
        <div class="mb-3">
            <input type="text"
                   name="username"
                   class="form-control"
                   placeholder="Username"
                   required>
        </div>

        <div class="mb-3">
            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="Password"
                   required>
        </div>

        <button type="submit" class="btn btn-primary w-100">
            Sign In
        </button>
    </form>

    <!-- Divider -->
    <div class="divider">OR</div>

    <!-- Create Account -->
    <div class="create-link">
        New to Zyra?
        <a href="<%= request.getContextPath() %>/register">
            Create a new account
        </a>
    </div>

    <div class="footer-text">
        © 2025 Zyra Store • Secure Login
    </div>
</div>

</body>
</html>
