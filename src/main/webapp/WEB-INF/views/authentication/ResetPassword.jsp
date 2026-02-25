<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Reset Password</title>

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

                .reset-card {
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

            <div class="reset-card shadow">
                <h3 class="text-center mb-3">Reset Password</h3>
                <p class="text-center text-muted text-small mb-4">
                    Enter your new password below.
                </p>

                <!-- Success Message -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <!-- Hidden Email -->
                    <input type="hidden" name="email" value="${email}">

                    <!-- New Password -->
                    <div class="mb-3">
                        <label class="form-label">New Password</label>
                        <input type="password" name="newPassword" class="form-control" minlength="6" required>
                    </div>

                    <!-- Confirm Password -->
                    <div class="mb-3">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" minlength="6" required>
                    </div>

                    <!-- Submit -->
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary">
                            Reset Password
                        </button>
                    </div>

                    <!-- Navigation -->
                    <div class="text-center">
                        <p class="mb-0 text-small">
                            <a href="${pageContext.request.contextPath}/login">Back to Login</a>
                        </p>
                    </div>
                </form>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        </body>

        </html>