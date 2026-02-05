<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

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
        .forgot-card {
            border-radius: 15px;
            padding: 30px;
            background: #ffffff;
            width: 100%;
            max-width: 420px;
        }
        .text-small {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="forgot-card shadow">
    <h3 class="text-center mb-3">Forgot Password</h3>
    <p class="text-center text-muted text-small mb-4">
        Enter your registered email address to reset your password.
    </p>

    <form action="forgot-password" method="post">
        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <!-- Submit -->
        <div class="d-grid mb-3">
            <button type="submit" class="btn btn-primary">
                Send Reset Link
            </button>
        </div>

        <!-- Navigation -->
        <div class="text-center">
            <p class="mb-1 text-small">
                Remembered your password?
                <a href="${pageContext.request.contextPath}/login">Login</a>
            </p>
            <p class="mb-0 text-small">
                Don’t have an account?
                <a href="${pageContext.request.contextPath}/signup">Sign Up</a>
            </p>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
