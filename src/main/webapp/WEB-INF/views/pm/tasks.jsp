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
      <jsp:param name="page" value="tasks"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Tasks"/>
      </jsp:include>
      <c:if test="${success != null}"><div class="alert alert-success">${success}</div></c:if>
      <div class="d-flex gap-2 mt-3 mb-2">
        <form class="d-flex gap-2" action="${pageContext.request.contextPath}/pm/tasks" method="get">
          <select name="moduleId" class="form-select form-select-sm" style="max-width:220px" onchange="this.form.submit()">
            <option value="">All Modules</option>
            <c:forEach var="m" items="${modules}">
              <option value="${m.moduleId}" ${param.moduleId == m.moduleId || selectedModule != null && selectedModule.moduleId == m.moduleId ? 'selected' : ''}>${m.moduleName} (${m.project != null ? m.project.projectName : ''})</option>
            </c:forEach>
          </select>
        </form>
        <a href="${pageContext.request.contextPath}/pm/tasks/add<c:if test='${selectedModule != null}'>?moduleId=${selectedModule.moduleId}</c:if>" class="btn btn-primary btn-sm"><i class="bi bi-plus-lg me-1"></i>Add Task</a>
      </div>
      <div class="table-card">
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Title</th><th>Status</th><th>Priority</th><th>Assigned To</th><th>Est. Hours</th></tr></thead>
            <tbody>
              <c:forEach var="t" items="${tasks}">
                <tr>
                  <td>${t.taskId}</td>
                  <td>${t.title}</td>
                  <td><span class="badge bg-${t.status == 'DONE' ? 'success' : 'primary'}">${t.status != null ? t.status : 'OPEN'}</span></td>
                  <td><span class="badge bg-warning">${t.priority != null ? t.priority : '-'}</span></td>
                  <td>${t.assignedTo != null ? t.assignedTo.firstName : '-'}</td>
                  <td>${t.estimatedHours != null ? t.estimatedHours : '-'}</td>
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
