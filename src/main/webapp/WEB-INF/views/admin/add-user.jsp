<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <jsp:include page="../common/header.jsp"/>
</head>
<body>

<div class="container-fluid">
  <div class="row">

    <!-- Sidebar -->
    <jsp:include page="../common/sidebar-admin.jsp">
      <jsp:param name="page" value="users"/>
    </jsp:include>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">

      <!-- Topbar -->
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Add User"/>
      </jsp:include>

      <c:if test="${error != null}">
        <div class="alert alert-danger">${error}</div>
      </c:if>

      <div class="table-card mt-3 p-4" style="max-width: 650px;">
        <h6 class="mb-4">New User</h6>

        <form action="${pageContext.request.contextPath}/admin/users/save" method="post">

          <!-- First Name -->
          <div class="mb-3">
            <label class="form-label">First Name</label>
            <input type="text" name="firstName"
                   class="form-control"
                   required value="${user.firstName}">
          </div>

          <!-- Last Name -->
          <div class="mb-3">
            <label class="form-label">Last Name</label>
            <input type="text" name="lastName"
                   class="form-control"
                   value="${user.lastName}">
          </div>

          <!-- Email -->
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email"
                   class="form-control"
                   required value="${user.email}">
          </div>

          <!-- Password -->
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password"
                   class="form-control" required>
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
            <input type="text" name="contactNum"
                   class="form-control"
                   value="${user.contactNum}">
          </div>

          <!-- Birth Year -->
          <div class="mb-3">
            <label class="form-label">Birth Year</label>
            <input type="number" name="birthYear"
                   class="form-control"
                   min="1950" max="2026"
                   value="${user.birthYear}">
          </div>

          <!-- Profile Picture URL -->
          <div class="mb-3">
            <label class="form-label">Profile Picture URL</label>
            <input type="text" name="profilePicurl"
                   class="form-control"
                   value="${user.profilePicURl}">
          </div>

         

          <!-- Role -->
          <div class="mb-3">
            <label class="form-label">Role</label>
            <select name="roleId" class="form-select" required>
              <c:forEach var="r" items="${roles}">
                <option value="${r.roleId}">${r.roleName}</option>
              </c:forEach>
            </select>
          </div>

          

          <!-- Buttons -->
          <button type="submit" class="btn btn-primary">
            Save User
          </button>

          <a href="${pageContext.request.contextPath}/admin/users"
             class="btn btn-outline-secondary">
            Cancel
          </a>

        </form>
      </div>

    </main>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
