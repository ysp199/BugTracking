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
      <jsp:param name="page" value="projects"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Edit Project"/>
      </jsp:include>
      <div class="table-card mt-3 p-4" style="max-width: 600px;">
        <form action="${pageContext.request.contextPath}/pm/projects/save" method="post">
          <input type="hidden" name="projectId" value="${project.projectId}">
          <div class="mb-3">
            <label class="form-label">Project Name</label>
            <input type="text" name="projectName" class="form-control" required value="${project.projectName}">
          </div>
          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3">${project.description}</textarea>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Status</label>
              <select name="status" class="form-select">
                <option value="ACTIVE" ${project.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                <option value="INACTIVE" ${project.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                <option value="COMPLETED" ${project.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
              </select>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Start Date</label>
              <input type="date" name="startDate" class="form-control" value="${project.startDate}">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">End Date</label>
              <input type="date" name="endDate" class="form-control" value="${project.endDate}">
            </div>
          </div>
          <button type="submit" class="btn btn-primary">Update</button>
          <a href="${pageContext.request.contextPath}/pm/projects" class="btn btn-outline-secondary">Cancel</a>
        </form>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
