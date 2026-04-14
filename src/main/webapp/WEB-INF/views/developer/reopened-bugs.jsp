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
          <jsp:include page="../common/sidebar-developer.jsp">
            <jsp:param name="page" value="reopened-bugs" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="Reopened Bugs" />
            </jsp:include>
            <c:if test="${success != null}">
              <div class="alert alert-success">${success}</div>
            </c:if>
            <div class="card shadow-sm border-0 mt-3 rounded-4">
              <div
                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                <h6 class="mb-0 fw-bold"><i class="bi bi-arrow-return-left text-danger me-2"></i>Bugs Reassigned by
                  Tester</h6>
                <a href="${pageContext.request.contextPath}/developer/bugs/add"
                  class="btn btn-primary btn-sm rounded-pill px-3">
                  <i class="bi bi-plus-lg me-1"></i>Report New Bug
                </a>
              </div>
              <div class="table-responsive">
                <table class="table table-hover mb-0">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Title</th>
                      <th>Priority</th>
                      <th>Status</th>
                      <th>Relation</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="b" items="${bugs}">
                      <tr>
                        <td>#${b.bugId}</td>
                        <td>${b.title}</td>
                        <td><span
                            class="badge bg-${b.priority == 'HIGH' ? 'danger' : b.priority == 'MEDIUM' ? 'warning' : 'secondary'}">${b.priority}</span>
                        </td>
                        <td><span class="badge bg-${b.status == 'CLOSED' ? 'success' : 'primary'}">${b.status}</span>
                        </td>
                        <td>
                          <c:choose>
                            <c:when
                              test="${b.reportedBy != null && b.reportedBy.userId == loggedInUser.userId && b.assignedTo != null && b.assignedTo.userId == loggedInUser.userId}">
                              <span class="badge bg-info-subtle text-info">Both</span>
                            </c:when>
                            <c:when test="${b.reportedBy != null && b.reportedBy.userId == loggedInUser.userId}">
                              <span class="badge bg-primary-subtle text-primary">Reported</span>
                            </c:when>
                            <c:when test="${b.assignedTo != null && b.assignedTo.userId == loggedInUser.userId}">
                              <span class="badge bg-success-subtle text-success">Assigned</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-secondary-subtle text-secondary">-</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <a href="${pageContext.request.contextPath}/developer/bugs/${b.bugId}"
                            class="btn btn-sm btn-outline-primary">View</a>
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