<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up - Bug Tracker</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'DM Sans', sans-serif; background: linear-gradient(135deg, #1a1d24 0%, #252932 50%, #0d6efd 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2rem 0; }
    .signup-card { background: #fff; border-radius: 16px; padding: 2.5rem; width: 100%; max-width: 420px; box-shadow: 0 25px 50px -12px rgba(0,0,0,.25); }
    .signup-card h3 { font-weight: 600; }
  </style>
</head>
<body>
<div class="signup-card">
  <div class="text-center mb-4">
    <i class="bi bi-bug-fill text-primary" style="font-size: 2rem;"></i>
    <h3 class="mt-2">Create Account</h3>
  </div>
  <c:if test="${error != null}"><div class="alert alert-danger">${error}</div></c:if>
  <form action="${pageContext.request.contextPath}/register" method="post">
    <div class="row">
      <div class="col-6 mb-3">
        <label class="form-label">First Name</label>
        <input type="text" name="firstName" class="form-control" required>
      </div>
      <div class="col-6 mb-3">
        <label class="form-label">Last Name</label>
        <input type="text" name="lastName" class="form-control">
      </div>
    </div>
    <div class="mb-3">
      <label class="form-label">Email</label>
      <input type="email" name="email" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Password</label>
      <input type="password" name="password" class="form-control" required>
    </div>
    <div class="d-grid mb-3">
      <button type="submit" class="btn btn-primary">Sign Up</button>
    </div>
    <p class="text-center mb-0 small text-muted">Already have an account? <a href="${pageContext.request.contextPath}/login">Login</a></p>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
