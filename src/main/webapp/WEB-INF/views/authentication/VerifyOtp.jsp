<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>

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
        .otp-card {
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

<div class="otp-card shadow">
    <h3 class="text-center mb-3">Verify OTP</h3>
    <p class="text-center text-muted text-small mb-4">
        Enter the OTP sent to your email address.
    </p>

    <!-- Success Message -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
        <!-- Hidden Email -->
        <input type="hidden" name="email" value="${email}">

        <!-- OTP -->
        <div class="mb-3">
            <label class="form-label">OTP</label>
            <input type="text" name="otp" class="form-control"
                   maxlength="6" placeholder="Enter 6-digit OTP" required>
        </div>

        <!-- Submit -->
        <div class="d-grid mb-3">
            <button type="submit" class="btn btn-primary">
                Verify OTP
            </button>
        </div>

        <!-- Navigation -->
        <div class="text-center">
            <p class="mb-0 text-small">
                <a href="${pageContext.request.contextPath}/forgetPassword">Resend OTP</a>
                &nbsp;|&nbsp;
                <a href="${pageContext.request.contextPath}/login">Back to Login</a>
            </p>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
