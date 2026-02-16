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
      <jsp:param name="page" value="bugs"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="Bug Overview"/>
      </jsp:include>
      <div class="table-card mt-3">
        <div class="p-3 border-bottom">
          <h6 class="mb-0">All Bugs</h6>
        </div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Title</th><th>Priority</th><th>Severity</th><th>Status</th><th>Assigned To</th></tr></thead>
            <tbody>
              <c:forEach var="b" items="${bugs}">
                <tr>
                  <td>#${b.bugId}</td>
                  <td>${b.title}</td>
                  <td><span class="badge bg-${b.priority == 'HIGH' ? 'danger' : b.priority == 'MEDIUM' ? 'warning' : 'secondary'}">${b.priority}</span></td>
                  <td><span class="badge bg-info">${b.severity}</span></td>
                  <td><span class="badge bg-${b.status == 'CLOSED' ? 'success' : 'primary'}">${b.status}</span></td>
                  <td>${b.assignedTo != null ? b.assignedTo.firstName : '-'}</td>
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
