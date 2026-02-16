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
    <jsp:include page="../common/sidebar-developer.jsp">
      <jsp:param name="page" value="tasks"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="My Tasks"/>
      </jsp:include>
      <div class="table-card mt-3">
        <div class="p-3 border-bottom"><h6 class="mb-0">Assigned Tasks</h6></div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Title</th><th>Module</th><th>Status</th><th>Priority</th><th>Est. Hours</th></tr></thead>
            <tbody>
              <c:forEach var="t" items="${tasks}">
                <tr>
                  <td>${t.taskId}</td>
                  <td>${t.title}</td>
                  <td>${t.module != null ? t.module.moduleName : '-'}</td>
                  <td><span class="badge bg-${t.status == 'DONE' ? 'success' : 'primary'}">${t.status != null ? t.status : 'OPEN'}</span></td>
                  <td><span class="badge bg-warning">${t.priority != null ? t.priority : '-'}</span></td>
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
