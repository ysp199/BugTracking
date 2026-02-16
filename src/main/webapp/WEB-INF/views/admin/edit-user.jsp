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
    <jsp:include page="../common/sidebar-admin.jsp">
      <jsp:param name="page" value="users"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Edit User"/>
      </jsp:include>
      <c:if test="${error != null}"><div class="alert alert-danger">${error}</div></c:if>
      <div class="table-card mt-3 p-4" style="max-width: 500px;">
        <h6 class="mb-4">Edit User</h6>
        <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
          <input type="hidden" name="userId" value="${user.userId}">
          <div class="mb-3">
            <label class="form-label">First Name</label>
            <input type="text" name="firstName" class="form-control" required value="${user.firstName}">
          </div>
          <div class="mb-3">
            <label class="form-label">Last Name</label>
            <input type="text" name="lastName" class="form-control" value="${user.lastName}">
          </div>
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required value="${user.email}" readonly>
          </div>
          <div class="mb-3">
            <label class="form-label">Password <span class="text-muted">(leave blank to keep)</span></label>
            <input type="password" name="password" class="form-control">
          </div>
          <div class="mb-3">
            <label class="form-label">Assign Role</label>
            <select name="roleId" class="form-select">
  				<c:forEach var="r" items="${roles}">
    				<option value="${r.roleId}"
      				<c:if test="${r.roleId == currentRoleId}">
          			selected
      				</c:if>>
      				${r.roleName}
    </option>
  </c:forEach>
</select>

          </div>
          <button type="submit" class="btn btn-primary">Update</button>
          <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">Cancel</a>
        </form>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
