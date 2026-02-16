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
      <jsp:param name="page" value="dashboard"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Admin Dashboard"/>
      </jsp:include>
      <c:if test="${success != null}"><div class="alert alert-success">${success}</div></c:if>
      <div class="row g-4 mt-2">
        <div class="col-md-6 col-xl-3">
          <div class="stat-card">
            <h3>${totalUsers}</h3>
            <p><i class="bi bi-people text-primary"></i> Total Users</p>
          </div>
        </div>
        <div class="col-md-6 col-xl-3">
          <div class="stat-card">
            <h3>${totalProjects}</h3>
            <p><i class="bi bi-folder text-primary"></i> Total Projects</p>
          </div>
        </div>
        <div class="col-md-6 col-xl-3">
          <div class="stat-card">
            <h3>${openBugs}</h3>
            <p><i class="bi bi-bug text-warning"></i> Open Bugs</p>
          </div>
        </div>
        <div class="col-md-6 col-xl-3">
          <div class="stat-card">
            <h3>${closedBugs}</h3>
            <p><i class="bi bi-check-circle text-success"></i> Closed Bugs</p>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
