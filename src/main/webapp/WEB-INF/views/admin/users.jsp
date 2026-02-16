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
        <jsp:param name="title" value="User Management"/>
      </jsp:include>
      <c:if test="${success != null}"><div class="alert alert-success">${success}</div></c:if>
      <c:if test="${error != null}"><div class="alert alert-danger">${error}</div></c:if>
      <div class="table-card mt-3">
        <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
          <h6 class="mb-0">All Users</h6>
          <a href="${pageContext.request.contextPath}/admin/users/add" class="btn btn-primary btn-sm"><i class="bi bi-plus-lg me-1"></i>Add User</a>
        </div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Status</th><th>Actions</th></tr></thead>
            <tbody>
              <c:forEach var="u" items="${users}">
                <tr>
                  <td>${u.userId}</td>
                  <td>${u.firstName} ${u.lastName}</td>
                  <td>${u.email}</td>
                  <td><span class="badge bg-${u.active ? 'success' : 'secondary'}">${u.active ? 'Active' : 'Inactive'}</span></td>
                  <td>
                    <a href="${pageContext.request.contextPath}/admin/users/edit/${u.userId}" class="btn btn-sm btn-outline-primary">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/users/toggle-active/${u.userId}" class="btn btn-sm btn-outline-${u.active ? 'warning' : 'success'}">${u.active ? 'Deactivate' : 'Activate'}</a>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
