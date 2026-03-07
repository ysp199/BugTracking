<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <jsp:include page="../common/header.jsp" />
    </head>

    <body>
      <div class="container-fluid">
        <div class="row">
          <jsp:include page="../common/sidebar-admin.jsp">
            <jsp:param name="page" value="users" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="User Management" />
            </jsp:include>
            <c:if test="${success != null}">
              <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${error != null}">
              <div class="alert alert-danger">${error}</div>
            </c:if>
            <div class="card shadow-sm border-0 mt-3 rounded-4">
              <div
                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4 flex-wrap gap-2">
                <h6 class="mb-0 fw-bold"><i class="bi bi-people text-primary me-2"></i>All Users</h6>
                <!-- Filter Form -->
                <form action="${pageContext.request.contextPath}/admin/users" method="GET"
                  class="d-flex gap-2 flex-wrap">
                  <select name="roleId" class="form-select form-select-sm rounded-pill" style="width: auto;">
                    <option value="">All Roles</option>
                    <c:forEach var="r" items="${roles}">
                      <option value="${r.roleId}" ${selectedRoleId==r.roleId ? 'selected' : '' }>${r.roleName}</option>
                    </c:forEach>
                  </select>
                  <select name="projectId" class="form-select form-select-sm rounded-pill" style="width: auto;">
                    <option value="">All Projects</option>
                    <c:forEach var="p" items="${projects}">
                      <option value="${p.projectId}" ${selectedProjectId==p.projectId ? 'selected' : '' }>
                        ${p.projectName}</option>
                    </c:forEach>
                  </select>
                  <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                  <a href="${pageContext.request.contextPath}/admin/users"
                    class="btn btn-outline-secondary btn-sm rounded-pill px-3">Reset</a>
                </form>
                <a href="${pageContext.request.contextPath}/admin/users/add"
                  class="btn btn-primary btn-sm rounded-pill px-4"><i class="bi bi-plus-lg me-1"></i>Add User</a>
              </div>
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                      <tr>
                        <th class="ps-4">ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="u" items="${users}">
                        <tr class="transition-hover">
                          <td class="ps-4 fw-medium text-muted">#${u.userId}</td>
                          <td class="fw-bold text-dark">${u.firstName} ${u.lastName}</td>
                          <td class="text-muted">${u.email}</td>
                          <td><span
                              class="badge rounded-pill bg-${u.active ? 'success-subtle text-success' : 'secondary-subtle text-secondary'} px-3 border border-${u.active ? 'success' : 'secondary'} border-opacity-25 shadow-sm">${u.active
                              ? 'Active' :
                              'Inactive'}</span></td>
                          <td class="text-end pe-4">
                            <a href="${pageContext.request.contextPath}/admin/users/view/${u.userId}"
                              class="btn btn-sm btn-outline-info rounded-pill px-3 me-1">
                              View
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users/edit/${u.userId}"
                              class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1">
                              Edit
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/users/toggle-active/${u.userId}"
                              class="btn btn-sm btn-outline-${u.active ? 'warning' : 'success'} rounded-pill px-3 me-1">
                              ${u.active ? 'Deactivate' : 'Activate'}
                            </a>

                            <c:if test="${!u.active}">
                              <a href="${pageContext.request.contextPath}/admin/users/delete/${u.userId}"
                                class="btn btn-sm btn-danger rounded-pill px-3 shadow-sm"
                                onclick="return confirm('Delete this user permanently?');">
                                Delete
                              </a>
                            </c:if>
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <style>
              .transition-hover:hover {
                background-color: #f8f9fa !important;
              }
            </style>
          </main>
        </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>