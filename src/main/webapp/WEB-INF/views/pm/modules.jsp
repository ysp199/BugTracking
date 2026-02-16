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
    <jsp:include page="../common/sidebar-pm.jsp">
      <jsp:param name="page" value="modules"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Modules"/>
      </jsp:include>
      <c:if test="${success != null}"><div class="alert alert-success">${success}</div></c:if>
      <div class="d-flex gap-2 mt-3 mb-2">
        <form class="d-flex gap-2" action="${pageContext.request.contextPath}/pm/modules" method="get">
          <select name="projectId" class="form-select form-select-sm" style="max-width:200px" onchange="this.form.submit()">
            <option value="">All Projects</option>
            <c:forEach var="p" items="${projects}">
              <option value="${p.projectId}" ${param.projectId == p.projectId || selectedProject != null && selectedProject.projectId == p.projectId ? 'selected' : ''}>${p.projectName}</option>
            </c:forEach>
          </select>
        </form>
        <a href="${pageContext.request.contextPath}/pm/modules/add<c:if test='${selectedProject != null}'>?projectId=${selectedProject.projectId}</c:if>" class="btn btn-primary btn-sm"><i class="bi bi-plus-lg me-1"></i>Add Module</a>
      </div>
      <div class="table-card">
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Module Name</th><th>Description</th><th>Project</th><th>Actions</th></tr></thead>
            <tbody>
              <c:forEach var="m" items="${modules}">
                <tr>
                  <td>${m.moduleId}</td>
                  <td>${m.moduleName}</td>
                  <td>${m.description}</td>
                  <td>${m.project != null ? m.project.projectName : '-'}</td>
                  <td>
                    <a href="${pageContext.request.contextPath}/pm/tasks?moduleId=${m.moduleId}" class="btn btn-sm btn-outline-secondary">Tasks</a>
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
