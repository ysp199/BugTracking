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
    <jsp:include page="../common/sidebar-tester.jsp">
      <jsp:param name="page" value="report"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Report Bug"/>
      </jsp:include>
      <div class="table-card mt-3 p-4" style="max-width: 600px;">
        <form action="${pageContext.request.contextPath}/tester/report-bug" method="post">
          <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required value="${bug.title}">
          </div>
          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="4" required>${bug.description}</textarea>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Severity</label>
              <select name="severity" class="form-select" required>
                <option value="LOW">Low</option>
                <option value="MEDIUM">Medium</option>
                <option value="HIGH">High</option>
                <option value="CRITICAL">Critical</option>
              </select>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Priority</label>
              <select name="priority" class="form-select" required>
                <option value="LOW">Low</option>
                <option value="MEDIUM">Medium</option>
                <option value="HIGH">High</option>
              </select>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Related Task (optional)</label>
            <select name="taskId" class="form-select">
              <option value="">-- None --</option>
              <c:forEach var="t" items="${tasks}">
                <option value="${t.taskId}">${t.title} - ${t.module != null ? t.module.moduleName : ''}</option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">Assign to Developer (optional)</label>
            <select name="assignedTo" class="form-select">
              <option value="">-- None --</option>
              <c:forEach var="d" items="${developers}">
                <option value="${d.userId}">${d.firstName} ${d.lastName}</option>
              </c:forEach>
            </select>
          </div>
          <button type="submit" class="btn btn-primary">Report Bug</button>
          <a href="${pageContext.request.contextPath}/tester/bugs" class="btn btn-outline-secondary">Cancel</a>
        </form>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
