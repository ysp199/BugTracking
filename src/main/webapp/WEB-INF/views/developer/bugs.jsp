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
      <jsp:param name="page" value="bugs"/>
    </jsp:include>
    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
      <jsp:include page="../common/topbar.jsp">
        <jsp:param name="title" value="My Bugs"/>
      </jsp:include>
      <c:if test="${success != null}"><div class="alert alert-success">${success}</div></c:if>
      <div class="table-card mt-3">
        <div class="p-3 border-bottom"><h6 class="mb-0">Assigned Bugs</h6></div>
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Title</th><th>Priority</th><th>Status</th><th>Reported By</th><th>Actions</th></tr></thead>
            <tbody>
              <c:forEach var="b" items="${bugs}">
                <tr>
                  <td>#${b.bugId}</td>
                  <td>${b.title}</td>
                  <td><span class="badge bg-${b.priority == 'HIGH' ? 'danger' : b.priority == 'MEDIUM' ? 'warning' : 'secondary'}">${b.priority}</span></td>
                  <td><span class="badge bg-${b.status == 'CLOSED' ? 'success' : 'primary'}">${b.status}</span></td>
                  <td>${b.reportedBy != null ? b.reportedBy.firstName : '-'}</td>
                  <td>
                    <a href="${pageContext.request.contextPath}/developer/bugs/${b.bugId}" class="btn btn-sm btn-outline-primary">View</a>
                    <c:if test="${b.status != 'CLOSED' && b.status != 'VERIFIED'}">
                      <div class="btn-group btn-group-sm">
                        <form action="${pageContext.request.contextPath}/developer/bugs/${b.bugId}/status" method="post" class="d-inline">
                          <input type="hidden" name="status" value="IN_PROGRESS">
                          <button type="submit" class="btn btn-outline-info">In Progress</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/developer/bugs/${b.bugId}/status" method="post" class="d-inline">
                          <input type="hidden" name="status" value="FIXED">
                          <button type="submit" class="btn btn-outline-success">Fixed</button>
                        </form>
                      </div>
                    </c:if>
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
