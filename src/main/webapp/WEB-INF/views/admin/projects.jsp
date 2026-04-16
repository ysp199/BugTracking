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
            <jsp:param name="page" value="projects" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="Project Overview" />
            </jsp:include>
            <div class="card shadow-sm border-0 mt-3 rounded-4">
              <div
                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                <h6 class="mb-0 fw-bold"><i class="bi bi-folder text-primary me-2"></i>All Projects</h6>
                <!-- Filter Form & Actions -->
                <div class="d-flex gap-3 align-items-center">
                  <a href="${pageContext.request.contextPath}/admin/projects/add"
                    class="btn btn-success btn-sm rounded-pill px-3 shadow-sm">
                    <i class="bi bi-plus-circle me-1"></i> Add Project
                  </a>
                  <form action="${pageContext.request.contextPath}/admin/all-projects" method="GET"
                    class="d-flex gap-2">
                    <select name="status" class="form-select form-select-sm rounded-pill" style="width: auto;">
                      <option value="">All Statuses</option>
                      <option value="ACTIVE" ${selectedStatus=='ACTIVE' ? 'selected' : '' }>Active</option>
                      <option value="STOPPED" ${selectedStatus=='STOPPED' ? 'selected' : '' }>Stopped</option>
                      <option value="REVOKED" ${selectedStatus=='REVOKED' ? 'selected' : '' }>Revoked</option>
                    </select>
                    <select name="createdById" class="form-select form-select-sm rounded-pill" style="width: auto;">
                      <option value="">All Creators</option>
                      <c:forEach var="c" items="${creators}">
                        <option value="${c.userId}" ${selectedCreatorId==c.userId ? 'selected' : '' }>${c.firstName}
                          ${c.lastName}</option>
                      </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                    <a href="${pageContext.request.contextPath}/admin/all-projects"
                      class="btn btn-outline-secondary btn-sm rounded-pill px-3">Reset</a>
                  </form>
                </div>
              </div>
              <div class="card-body p-0">
                <div class="table-responsive" style="min-height: calc(100vh - 220px);">
                  <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                      <tr>
                        <th class="ps-4">ID</th>
                        <th>Project Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Created By</th>
                        <th class="pe-4">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="p" items="${projects}">
                        <tr class="transition-hover">
                          <td class="ps-4 fw-medium text-muted">#${p.projectId}</td>
                          <td class="fw-bold text-dark">${p.projectName}</td>
                          <td class="text-muted text-truncate" style="max-width: 250px;">${p.description}</td>
                          <td>
                            <c:choose>
                              <c:when test="${p.status == 'ACTIVE'}"><span
                                  class="badge bg-success-subtle text-success rounded-pill px-3">Active</span></c:when>
                              <c:when test="${p.status == 'COMPLETED'}"><span
                                  class="badge bg-primary-subtle text-primary rounded-pill px-3">Completed</span>
                              </c:when>
                              <c:otherwise><span
                                  class="badge bg-secondary-subtle text-secondary rounded-pill px-3">${p.status != null
                                  ? p.status : 'N/A'}</span></c:otherwise>
                            </c:choose>
                          </td>
                          <td>${p.createdBy != null ? p.createdBy.firstName += ' ' += p.createdBy.lastName
                            : '-'}</td>
                          <td class="pe-4">
                            <div class="btn-group">
                              <a href="${pageContext.request.contextPath}/admin/projects/view/${p.projectId}"
                                class="btn btn-sm btn-outline-primary rounded-start px-3">View</a>
                              <button type="button"
                                class="btn btn-sm btn-outline-primary dropdown-toggle dropdown-toggle-split"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="visually-hidden">Toggle Dropdown</span>
                              </button>
                              <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                <li>
                                  <h6 class="dropdown-header text-muted">Change Status</h6>
                                </li>
                                <li><a class="dropdown-item fw-medium text-success"
                                    href="${pageContext.request.contextPath}/admin/projects/status/${p.projectId}?action=ACTIVE"><i
                                      class="bi bi-play-circle me-2"></i>Set to Active (Start)</a></li>
                                <li><a class="dropdown-item fw-medium text-warning"
                                    href="${pageContext.request.contextPath}/admin/projects/status/${p.projectId}?action=STOPPED"><i
                                      class="bi bi-pause-circle me-2"></i>Set to Stopped</a></li>
                                <li>
                                  <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item fw-medium text-danger"
                                    href="${pageContext.request.contextPath}/admin/projects/status/${p.projectId}?action=REVOKED"><i
                                      class="bi bi-x-circle me-2"></i>Revoke Project</a></li>
                              </ul>
                            </div>
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