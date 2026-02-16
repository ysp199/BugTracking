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
        <jsp:param name="title" value="Add Module"/>
      </jsp:include>
      <div class="table-card mt-3 p-4" style="max-width: 600px;">
        <form action="${pageContext.request.contextPath}/pm/modules/save" method="post">
          <div class="mb-3">
            <label class="form-label">Project</label>
            <select name="projectId" class="form-select" required>
              <option value="">Select Project</option>
              <c:forEach var="p" items="${projects}">
                <option value="${p.projectId}" ${selectedProjectId == p.projectId ? 'selected' : ''}>${p.projectName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">Module Name</label>
            <input type="text" name="moduleName" class="form-control" required value="${module.moduleName}">
          </div>
          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3">${module.description}</textarea>
          </div>
          <button type="submit" class="btn btn-primary">Save</button>
          <a href="${pageContext.request.contextPath}/pm/modules" class="btn btn-outline-secondary">Cancel</a>
        </form>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
