<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            border-radius: 15px;
            padding: 30px;
            background: #ffffff;
            width: 100%;
            max-width: 400px;
        }
        .link-small {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="login-card shadow">
    <h3 class="text-center mb-4">Login</h3>

    <form action="login" method="post">
        <!-- Username / Email -->
        <div class="mb-3">
            <label class="form-label">Username or Email</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <!-- Login Button -->
        <div class="d-grid mb-3">
            <button type="submit" class="btn btn-primary">
                Login
            </button>
        </div>

        <!-- Links -->
        <div class="text-center">
            <p class="mb-1 link-small">
                Don’t have an account?
                <a href="${pageContext.request.contextPath}/signup">Sign Up</a>
            </p>
            <p class="mb-0 link-small">
                <a href="${pageContext.request.contextPath}/forgetPassword">Forgot Password?</a>
            </p>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
