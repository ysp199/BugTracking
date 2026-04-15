<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>BugTracker - Sign Up</title>

        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

        <style>
            body {
                background: url('https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1920&auto=format&fit=crop') center center / cover no-repeat fixed;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

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

            .signup-card {
                border-radius: 15px;
                padding: 30px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
                width: 100%;
                max-width: 600px;
                position: relative;
                z-index: 1;
                margin: 40px 0;
            }

            .brand-icon {
                font-size: 2rem;
                color: #4f46e5;
            }

            .form-control:focus,
            .form-select:focus {
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

            .text-primary {
                color: #4f46e5 !important;
            }
        </style>
    </head>

    <body>

        <div class="signup-card">
            <div class="text-center mb-4">
                <i class="bi bi-bug-fill brand-icon"></i>
                <h3 class="fw-bold mt-2 text-dark">Join BugTracker</h3>
                <p class="text-muted small">Collaborate and manage projects effectively</p>
            </div>

            <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-medium text-dark small">First Name <span
                                class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                            <input type="text" name="firstName" class="form-control bg-light" placeholder="John"
                                required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-medium text-dark small">Last Name <span
                                class="text-danger">*</span></label>
                        <input type="text" name="lastName" class="form-control bg-light" placeholder="Doe" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-medium text-dark small">Email Address <span
                            class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                        <input type="email" name="email" class="form-control bg-light" placeholder="example@company.com"
                            required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-medium text-dark small">Password <span
                            class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="bi bi-shield-lock"></i></span>
                        <input type="password" name="password" class="form-control bg-light"
                            placeholder="Create a password" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-medium text-dark small">Account Role <span
                                class="text-danger">*</span></label>
                        <select name="selectedRole" class="form-select bg-light border-primary" required>
                            <option value="" disabled selected>-- Select Role --</option>
                            <option value="DEVELOPER">Developer</option>
                            <option value="PROJECT_MANAGER">Project Manager</option>
                            <option value="TESTER">Tester</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-medium text-dark small">Contact Number</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-telephone"></i></span>
                            <input type="text" name="contactNum" class="form-control bg-light"
                                placeholder="(555) 000-0000">
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-medium text-dark small">Gender</label>
                        <select name="gender" class="form-select bg-light">
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-medium text-dark small">Birth Year</label>
                        <input type="number" name="birthYear" class="form-control bg-light" min="1950" max="2026"
                            placeholder="YYYY">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-medium text-dark small">Profile Avatar</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="bi bi-image"></i></span>
                        <input type="file" name="profilePic" class="form-control bg-light">
                    </div>
                </div>

                <div class="d-grid mt-2">
                    <button type="submit" class="btn btn-primary py-2 fw-medium shadow-sm">
                        Create Account
                    </button>
                </div>

                <p class="text-center mt-4 mb-0 text-muted small">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login"
                        class="text-primary fw-medium text-decoration-none">Sign In</a>
                </p>

            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>