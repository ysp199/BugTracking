<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Forgot Password - Bug Tracker</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'DM Sans', sans-serif; background: linear-gradient(135deg, #1a1d24 0%, #252932 50%, #0d6efd 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
    .forgot-card { background: #fff; border-radius: 16px; padding: 2.5rem; width: 100%; max-width: 420px; box-shadow: 0 25px 50px -12px rgba(0,0,0,.25); }
  </style>
</head>
<body>
<div class="forgot-card">
  <div class="text-center mb-3">
    <i class="bi bi-key-fill text-primary" style="font-size: 2rem;"></i>
    <h3 class="mt-2">Forgot Password</h3>
    <p class="text-muted small">Enter your email to receive a reset link.</p>
  </div>
  <form action="${pageContext.request.contextPath}/forgetPassword" method="post">
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" name="email" class="form-control" required>
    </div>
    <div class="d-grid mb-3">
      <button type="submit" class="btn btn-primary">Send Reset Link</button>
    </div>
    <div class="text-center">
      <p class="mb-1 small"><a href="${pageContext.request.contextPath}/login">Back to Login</a></p>
      <p class="mb-0 small text-muted"><a href="${pageContext.request.contextPath}/signup">Sign Up</a></p>
    </div>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
