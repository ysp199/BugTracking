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
      <jsp:param name="page" value="timelog"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Time Log"/>
      </jsp:include>
      <c:if test="${success != null}"><div class="alert alert-success">${success}</div></c:if>
      <div class="row">
        <div class="col-lg-5">
          <div class="table-card p-4 mt-3">
            <h6>Log Time</h6>
            <form action="${pageContext.request.contextPath}/developer/timelog/save" method="post">
              <div class="mb-3">
                <label class="form-label">Task</label>
                <select name="taskId" class="form-select" required>
                  <option value="">Select Task</option>
                  <c:forEach var="t" items="${tasks}">
                    <option value="${t.taskId}">${t.title} - ${t.module != null ? t.module.moduleName : ''}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="mb-3">
                <label class="form-label">Hours Spent</label>
                <input type="number" name="hoursSpent" class="form-control" step="0.5" min="0.5" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Date</label>
                <input type="date" name="logDate" class="form-control" value="${param.logDate}">
              </div>
              <button type="submit" class="btn btn-primary">Log</button>
            </form>
          </div>
        </div>
        <div class="col-lg-7">
          <div class="table-card mt-3">
            <div class="p-3 border-bottom"><h6 class="mb-0">My Time Logs</h6></div>
            <div class="table-responsive">
              <table class="table table-hover mb-0">
                <thead><tr><th>Date</th><th>Task</th><th>Hours</th></tr></thead>
                <tbody>
                  <c:forEach var="l" items="${logs}">
                    <tr>
                      <td>${l.logDate}</td>
                      <td>${l.task != null ? l.task.title : '-'}</td>
                      <td>${l.hoursSpent}</td>
                    </tr>
                  </c:forEach>
                  <c:if test="${empty logs}"><tr><td colspan="3" class="text-muted text-center">No logs yet.</td></tr></c:if>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
