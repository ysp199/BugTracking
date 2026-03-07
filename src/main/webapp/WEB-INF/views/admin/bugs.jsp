<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <jsp:include page="../common/header.jsp" />
    </head>

    <body>
      <div class="container-fluid">
        <div class="row">
          <jsp:include page="../common/sidebar-admin.jsp">
            <jsp:param name="page" value="bugs" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="Bug Overview" />
            </jsp:include>
            <div class="card shadow-sm border-0 mt-3 rounded-4">
              <div
                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4 flex-wrap gap-3">
                <h6 class="mb-0 fw-bold"><i class="bi bi-bug text-danger me-2"></i>All Bugs</h6>
                <!-- Filter Form -->
                <form action="${pageContext.request.contextPath}/admin/bugs" method="GET"
                  class="d-flex gap-2 flex-wrap">
                  <select name="severity" class="form-select form-select-sm rounded-pill" style="width: auto;">
                    <option value="">All Severities</option>
                    <option value="CRITICAL" ${selectedSeverity=='CRITICAL' ? 'selected' : '' }>CRITICAL</option>
                    <option value="HIGH" ${selectedSeverity=='HIGH' ? 'selected' : '' }>HIGH</option>
                    <option value="MEDIUM" ${selectedSeverity=='MEDIUM' ? 'selected' : '' }>MEDIUM</option>
                    <option value="LOW" ${selectedSeverity=='LOW' ? 'selected' : '' }>LOW</option>
                  </select>
                  <select name="priority" class="form-select form-select-sm rounded-pill" style="width: auto;">
                    <option value="">All Priorities</option>
                    <option value="HIGH" ${selectedPriority=='HIGH' ? 'selected' : '' }>HIGH</option>
                    <option value="MEDIUM" ${selectedPriority=='MEDIUM' ? 'selected' : '' }>MEDIUM</option>
                    <option value="LOW" ${selectedPriority=='LOW' ? 'selected' : '' }>LOW</option>
                  </select>
                  <select name="status" class="form-select form-select-sm rounded-pill" style="width: auto;">
                    <option value="">All Statuses</option>
                    <option value="OPEN" ${selectedStatus=='OPEN' ? 'selected' : '' }>Open</option>
                    <option value="IN_PROGRESS" ${selectedStatus=='IN_PROGRESS' ? 'selected' : '' }>In Progress</option>
                    <option value="RESOLVED" ${selectedStatus=='RESOLVED' ? 'selected' : '' }>Resolved</option>
                    <option value="CLOSED" ${selectedStatus=='CLOSED' ? 'selected' : '' }>Closed</option>
                  </select>
                  <select name="assignedToId" class="form-select form-select-sm rounded-pill" style="width: auto;">
                    <option value="">All Assignees</option>
                    <c:forEach var="dev" items="${developers}">
                      <option value="${dev.userId}" ${selectedAssignedToId==dev.userId ? 'selected' : '' }>
                        ${dev.firstName} ${dev.lastName}</option>
                    </c:forEach>
                  </select>
                  <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                  <a href="${pageContext.request.contextPath}/admin/bugs"
                    class="btn btn-outline-secondary btn-sm rounded-pill px-3">Reset</a>
                </form>
              </div>
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                      <tr>
                        <th class="ps-4">ID</th>
                        <th>Title</th>
                        <th>Priority</th>
                        <th>Severity</th>
                        <th>Status</th>
                        <th>Assigned To</th>
                        <th class="pe-4">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="b" items="${bugs}">
                        <tr class="transition-hover">
                          <td class="ps-4 fw-medium text-muted">#${b.bugId}</td>
                          <td class="fw-bold text-dark">${b.title}</td>
                          <td><span
                              class="badge rounded-pill bg-${b.priority == 'HIGH' ? 'danger-subtle text-danger' : b.priority == 'MEDIUM' ? 'warning-subtle text-warning' : 'secondary-subtle text-secondary'}">${b.priority}</span>
                          </td>
                          <td><span
                              class="badge rounded-pill bg-${b.severity == 'CRITICAL' ? 'danger' : b.severity == 'HIGH' ? 'danger-subtle text-danger' : 'info-subtle text-info'} shadow-sm">${b.severity}</span>
                          </td>
                          <td><span
                              class="badge rounded-pill bg-${b.status == 'CLOSED' || b.status == 'RESOLVED' ? 'success' : 'primary'}">${b.status}</span>
                          </td>
                          <td>
                            ${b.task != null && b.task.assignedTo != null ? b.task.assignedTo.firstName : '-'}
                            ${b.task != null && b.task.assignedTo != null ? b.task.assignedTo.lastName : ''}
                          </td>
                          <td class="pe-4">
                            <a href="${pageContext.request.contextPath}/admin/bugs/view/${b.bugId}"
                              class="btn btn-sm btn-outline-primary rounded-pill px-3">View</a>
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <style>
              .transition-hover:hover {
                background-color: #f8f9fa !important;
              }
            </style>
          </main>
        </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>