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
        <jsp:param name="title" value="Bug #${bug.bugId}"/>
      </jsp:include>
      <div class="table-card mt-3 p-4">
        <h5>${bug.title}</h5>
        <p class="text-muted mb-3">${bug.description}</p>
        <div class="row mb-3">
          <div class="col"><strong>Priority:</strong> <span class="badge bg-warning">${bug.priority}</span></div>
          <div class="col"><strong>Severity:</strong> <span class="badge bg-info">${bug.severity}</span></div>
          <div class="col"><strong>Status:</strong> <span class="badge bg-primary">${bug.status}</span></div>
          <div class="col"><strong>Reported by:</strong> ${bug.reportedBy != null ? bug.reportedBy.firstName : '-'}</div>
        </div>
        <c:if test="${bug.status != 'CLOSED' && bug.status != 'VERIFIED'}">
          <hr/>
          <h6>Update Status</h6>
          <form action="${pageContext.request.contextPath}/developer/bugs/${bug.bugId}/status" method="post" class="d-flex gap-2">
            <select name="status" class="form-select form-select-sm" style="max-width:180px">
              <option value="IN_PROGRESS">In Progress</option>
              <option value="FIXED">Fixed</option>
              <option value="VERIFIED">Verified</option>
              <option value="CLOSED">Closed</option>
            </select>
            <button type="submit" class="btn btn-primary btn-sm">Update</button>
          </form>
        </c:if>
        <hr/>
        <h6>History</h6>
        <ul class="list-group list-group-flush">
          <c:forEach var="h" items="${history}">
            <li class="list-group-item d-flex justify-content-between">
              <span>${h.oldStatus} → ${h.newStatus}</span>
              <span class="text-muted small">${h.changedBy != null ? h.changedBy.firstName : ''} - ${h.changedAt}</span>
            </li>
          </c:forEach>
          <c:if test="${empty history}"><li class="list-group-item text-muted">No history yet.</li></c:if>
        </ul>
        <a href="${pageContext.request.contextPath}/developer/bugs" class="btn btn-outline-secondary mt-3">Back</a>
      </div>
    </main>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
