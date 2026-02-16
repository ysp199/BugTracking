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
      <jsp:param name="page" value="dashboard"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Developer Dashboard"/>
      </jsp:include>
      <div class="row g-4 mt-2">
        <div class="col-md-6">
          <div class="stat-card">
            <h3>${assignedBugs}</h3>
            <p><i class="bi bi-bug text-warning"></i> Bugs Assigned to Me</p>
            <a href="${pageContext.request.contextPath}/developer/bugs" class="btn btn-sm btn-outline-primary mt-2">View Bugs</a>
          </div>
        </div>
        <div class="col-md-6">
          <div class="stat-card">
            <h3>${assignedTasks}</h3>
            <p><i class="bi bi-check2-square text-primary"></i> Tasks Assigned to Me</p>
            <a href="${pageContext.request.contextPath}/developer/tasks" class="btn btn-sm btn-outline-primary mt-2">View Tasks</a>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
