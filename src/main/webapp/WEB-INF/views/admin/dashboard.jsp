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
            <jsp:param name="page" value="dashboard" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="Admin Dashboard" />
            </jsp:include>
            <c:if test="${success != null}">
              <div class="alert alert-success">${success}</div>
            </c:if>
            <div class="row g-4 mt-2">
              <div class="col-md-6 col-xl-3">
                <a href="${pageContext.request.contextPath}/admin/users" class="text-decoration-none text-dark">
                  <div
                    class="stat-card shadow-sm h-100 bg-white border-0 rounded-4 p-4 d-flex flex-column align-items-center justify-content-center transition-hover">
                    <h3 class="display-6 font-weight-bold text-primary mb-1">${totalUsers}</h3>
                    <p class="mb-0 text-muted font-weight-bold text-uppercase" style="font-size:0.85rem;"><i
                        class="bi bi-people text-primary me-1"></i> Total Users</p>
                  </div>
                </a>
              </div>
              <div class="col-md-6 col-xl-3">
                <a href="${pageContext.request.contextPath}/admin/all-projects" class="text-decoration-none text-dark">
                  <div
                    class="stat-card shadow-sm h-100 bg-white border-0 rounded-4 p-4 d-flex flex-column align-items-center justify-content-center transition-hover">
                    <h3 class="display-6 font-weight-bold text-secondary mb-1">${totalProjects}</h3>
                    <p class="mb-0 text-muted font-weight-bold text-uppercase" style="font-size:0.85rem;"><i
                        class="bi bi-folder text-secondary me-1"></i> Total Projects</p>
                  </div>
                </a>
              </div>
              <div class="col-md-6 col-xl-3">
                <a href="${pageContext.request.contextPath}/admin/bugs" class="text-decoration-none text-dark">
                  <div
                    class="stat-card shadow-sm h-100 bg-white border-0 rounded-4 p-4 d-flex flex-column align-items-center justify-content-center transition-hover">
                    <h3 class="display-6 font-weight-bold text-warning mb-1">${openBugs}</h3>
                    <p class="mb-0 text-muted font-weight-bold text-uppercase" style="font-size:0.85rem;"><i
                        class="bi bi-bug text-warning me-1"></i> Open Bugs</p>
                  </div>
                </a>
              </div>
              <div class="col-md-6 col-xl-3">
                <a href="${pageContext.request.contextPath}/admin/closed-bugs" class="text-decoration-none text-dark">
                  <div
                    class="stat-card shadow-sm h-100 bg-white border-0 rounded-4 p-4 d-flex flex-column align-items-center justify-content-center transition-hover">
                    <h3 class="display-6 font-weight-bold text-success mb-1">${closedBugs}</h3>
                    <p class="mb-0 text-muted font-weight-bold text-uppercase" style="font-size:0.85rem;"><i
                        class="bi bi-check-circle text-success me-1"></i> Closed Bugs</p>
                  </div>
                </a>
              </div>
            </div>

            <div class="row g-4 mt-3">
              <!-- Recent Bugs / Github Style Tracker -->
              <div class="col-md-5">
                <div class="card shadow-sm h-100 border-0">
                  <div class="card-header bg-white border-bottom pt-3 pb-2">
                    <h6 class="m-0 fw-bold"><i class="bi bi-activity text-primary me-2"></i>Recent Activity Tracker</h6>
                  </div>
                  <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                      <c:forEach items="${recentBugs}" var="bug">
                        <li class="list-group-item d-flex justify-content-between align-items-center py-3">
                          <div>
                            <c:choose>
                              <c:when test="${bug.status == 'CLOSED' || bug.status == 'RESOLVED'}">
                                <span class="badge bg-success rounded-circle d-inline-block align-middle me-2"
                                  style="width: 12px; height: 12px; padding: 0;">&nbsp;</span>
                              </c:when>
                              <c:otherwise>
                                <span class="badge bg-danger rounded-circle d-inline-block align-middle me-2"
                                  style="width: 12px; height: 12px; padding: 0;">&nbsp;</span>
                              </c:otherwise>
                            </c:choose>
                            <span class="fw-bold align-middle">${bug.title}</span>
                            <small class="text-muted d-block ms-4" style="font-size: 0.8rem;">Sev: <span
                                class="badge bg-light text-dark border">${bug.severity}</span> | Pri: <span
                                class="badge bg-light text-dark border">${bug.priority}</span></small>
                          </div>
                          <span
                            class="badge rounded-pill ${bug.status == 'CLOSED' || bug.status == 'RESOLVED' ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'}">${bug.status}</span>
                        </li>
                      </c:forEach>
                      <c:if test="${empty recentBugs}">
                        <p class="text-muted text-center my-4 pb-2">No bugs tracked yet.</p>
                      </c:if>
                    </ul>
                  </div>
                </div>
              </div>

              <!-- Total Users Table -->
              <div class="col-md-7">
                <div class="card shadow-sm h-100 border-0">
                  <div class="card-header bg-white border-bottom pt-3 pb-2">
                    <h6 class="m-0 fw-bold"><i class="bi bi-people-fill text-primary me-2"></i>Total Users</h6>
                  </div>
                  <div class="card-body p-0">
                    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                      <table class="table table-hover align-middle mb-0">
                        <thead class="table-light sticky-top">
                          <tr>
                            <th class="ps-3 border-0">User</th>
                            <th class="border-0">Email</th>
                            <th class="border-0 text-center">Status</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach items="${usersList}" var="u">
                            <tr>
                              <td class="ps-3 border-bottom-0 pb-2 pt-2">
                                <div class="d-flex align-items-center">
                                  <img
                                    src="${not empty u.profilePicURl ? u.profilePicURl : pageContext.request.contextPath += '/assets/images/default-user.png'}"
                                    class="rounded-circle me-3 shadow-sm" alt="Avatar"
                                    style="width: 36px; height: 36px; object-fit: cover;">
                                  <span class="fw-medium">${u.firstName} ${u.lastName}</span>
                                </div>
                              </td>
                              <td class="text-muted border-bottom-0">${u.email}</td>
                              <td class="text-center border-bottom-0">
                                <c:choose>
                                  <c:when test="${u.active}">
                                    <span class="badge bg-success-subtle text-success rounded-pill px-3">Active</span>
                                  </c:when>
                                  <c:otherwise>
                                    <span
                                      class="badge bg-secondary-subtle text-secondary rounded-pill px-3">Inactive</span>
                                  </c:otherwise>
                                </c:choose>
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <style>
              /* Custom hover effect */
              .transition-hover {
                transition: transform 0.2s, box-shadow 0.2s;
              }

              .transition-hover:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1) !important;
              }
            </style>
          </main>
        </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>