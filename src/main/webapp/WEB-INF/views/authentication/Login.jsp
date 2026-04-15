<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>BugTracker - Login</title>

            <!-- Bootstrap 5 CDN -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

            <style>
                body {
                    /* Sleek coding/dev background image */
                    background: url('https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1920&auto=format&fit=crop') center center / cover no-repeat fixed;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                /* Dark overlay for readability */
                body::before {
                    content: "";
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(15, 23, 42, 0.75);
                    z-index: 0;
                }

                .login-card {
                    border-radius: 15px;
                    padding: 40px 30px;
                    /* Glassmorphism effect */
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                    box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
                    width: 100%;
                    max-width: 420px;
                    position: relative;
                    z-index: 1;
                }

                .brand-icon {
                    font-size: 2.5rem;
                    color: #4f46e5;
                }

                .form-control:focus {
                    border-color: #4f46e5;
                    box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.25);
                }

                .btn-primary {
                    background-color: #4f46e5;
                    border-color: #4f46e5;
                }

                .btn-primary:hover {
                    background-color: #4338ca;
                    border-color: #4338ca;
                }

                .link-small {
                    font-size: 0.9rem;
                }

                .text-primary {
                    color: #4f46e5 !important;
                }
            </style>
        </head>

        <body>

            <div class="login-card">
                <div class="text-center mb-4">
                    <i class="bi bi-bug-fill brand-icon"></i>
                    <h3 class="fw-bold mt-2 text-dark">BugTracker</h3>
                    <p class="text-muted small">Sign in to report and squash bugs</p>
                </div>

                <form action="${pageContext.request.contextPath}/authenticate" method="post">
                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 text-center small mb-3">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
                        </div>
                    </c:if>

                    <!-- Username / Email -->
                    <div class="mb-3">
                        <label class="form-label fw-medium text-dark small">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                            <input type="email" name="email" class="form-control bg-light"
                                placeholder="jane@example.com" required>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="mb-4">
                        <label class="form-label fw-medium text-dark small">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-lock"></i></span>
                            <input type="password" name="password" class="form-control bg-light" placeholder="••••••••"
                                required>
                        </div>
                    </div>

                    <!-- Login Button -->
                    <div class="d-grid mb-4">
                        <button type="submit" class="btn btn-primary py-2 fw-medium shadow-sm">
                            Sign In
                        </button>
                    </div>

                    <!-- Links -->
                    <div class="text-center">
                        <p class="mb-2 link-small text-muted">
                            Don’t have an account?
                            <a href="${pageContext.request.contextPath}/signup"
                                class="text-primary fw-medium text-decoration-none">Sign Up</a>
                        </p>
                        <p class="mb-0 link-small">
                            <a href="${pageContext.request.contextPath}/forgetPassword"
                                class="text-muted text-decoration-none hover-primary">Forgot Password?</a>
                        </p>
                    </div>
                </form>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        </body>

        </html>