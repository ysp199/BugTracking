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
          <jsp:include page="../common/sidebar-pm.jsp">
            <jsp:param name="page" value="projects" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="Projects" />
            </jsp:include>
            <c:if test="${success != null}">
              <div class="alert alert-success">${success}</div>
            </c:if>
            <div class="table-card mt-3">
              <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
                <h6 class="mb-0">Projects</h6>
                <div class="d-flex gap-3 align-items-center">
                  <form action="${pageContext.request.contextPath}/pm/projects" method="GET" class="d-flex gap-2">
                    <select name="status" class="form-select form-select-sm" style="width: auto;">
                      <option value="">All Statuses</option>
                      <option value="ACTIVE" ${selectedStatus=='ACTIVE' ? 'selected' : '' }>Active</option>
                      <option value="STOPPED" ${selectedStatus=='STOPPED' ? 'selected' : '' }>Stopped</option>
                      <option value="REVOKED" ${selectedStatus=='REVOKED' ? 'selected' : '' }>Revoked</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">Filter</button>
                    <a href="${pageContext.request.contextPath}/pm/projects"
                      class="btn btn-outline-secondary btn-sm">Reset</a>
                  </form>
                  <a href="${pageContext.request.contextPath}/pm/projects/add" class="btn btn-primary btn-sm"><i
                      class="bi bi-plus-lg me-1"></i>Add Project</a>
                </div>
              </div>
              <div class="table-responsive">
                <table class="table table-hover mb-0">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Name</th>
                      <th>Description</th>
                      <th>Status</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="p" items="${projects}">
                      <tr>
                        <td>${p.projectId}</td>
                        <td>${p.projectName}</td>
                        <td>${p.description}</td>
                        <td><span class="badge bg-info">${p.status != null ? p.status : 'N/A'}</span></td>
                        <td>
                          <a href="${pageContext.request.contextPath}/pm/projects/view/${p.projectId}"
                            class="btn btn-sm btn-outline-info">View</a>
                          <a href="${pageContext.request.contextPath}/pm/projects/edit/${p.projectId}"
                            class="btn btn-sm btn-outline-primary">Edit</a>
                          <a href="${pageContext.request.contextPath}/pm/modules?projectId=${p.projectId}"
                            class="btn btn-sm btn-outline-secondary">Modules</a>
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