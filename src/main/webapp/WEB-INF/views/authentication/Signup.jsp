<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #667eea, #764ba2);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .signup-card {
        border-radius: 15px;
        padding: 30px;
        background: #ffffff;
        width: 100%;
        max-width: 520px;
    }
</style>
</head>
<body>

<div class="signup-card shadow">
    <h3 class="text-center mb-4">Create Account</h3>

    <form action="${pageContext.request.contextPath}/register"
      method="post"
      enctype="multipart/form-data">

        <!-- First Name -->
        <div class="mb-3">
            <label class="form-label">First Name</label>
            <input type="text" name="firstName" class="form-control" required>
        </div>

        <!-- Last Name -->
        <div class="mb-3">
            <label class="form-label">Last Name</label>
            <input type="text" name="lastName" class="form-control" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <!-- Gender -->
        <div class="mb-3">
            <label class="form-label">Gender</label>
            <select name="gender" class="form-select">
                <option value="">Select</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <!-- Contact Number -->
        <div class="mb-3">
            <label class="form-label">Contact Number</label>
            <input type="text" name="contactNum" class="form-control">
        </div>

        <!-- Birth Year -->
        <div class="mb-3">
            <label class="form-label">Birth Year</label>
            <input type="number" name="birthYear"
                   class="form-control"
                   min="1950" max="2026">
        </div>

        <!-- Profile Picture URL -->
        <div class="mb-3">
            <label class="form-label">Profile Picture </label>
            <input type="file" name="profilePic"
                   class="form-control">
        </div>

       

        <!-- Submit -->
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">
                Sign Up
            </button>
        </div>

        <p class="text-center mt-3 mb-0">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </p>

    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
