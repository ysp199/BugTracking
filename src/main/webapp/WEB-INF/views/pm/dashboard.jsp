<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <jsp:include page="../common/header.jsp" />
    </head>

    <body class="bg-light">
      <div class="container-fluid">
        <div class="row">
          <jsp:include page="../common/sidebar-pm.jsp">
            <jsp:param name="page" value="dashboard" />
          </jsp:include>
          <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
            <jsp:include page="../common/topbar.jsp">
              <jsp:param name="title" value="Project Manager Dashboard" />
            </jsp:include>
            <c:if test="${success != null}">
              <div class="alert alert-success">${success}</div>
            </c:if>

            <div class="row mt-4">
              <div class="col-md-4 mb-4">
                <div class="card shadow-sm border-0 rounded-4 h-100">
                  <div class="card-header bg-white border-bottom p-3">
                    <h6 class="mb-0 fw-bold"><i class="bi bi-folder-fill text-primary me-2"></i>Projects Overview</h6>
                  </div>
                  <div class="card-body">
                    <canvas id="pmProjectsChart" height="250"></canvas>
                  </div>
                </div>
              </div>
              <div class="col-md-4 mb-4">
                <div class="card shadow-sm border-0 rounded-4 h-100">
                  <div class="card-header bg-white border-bottom p-3">
                    <h6 class="mb-0 fw-bold"><i class="bi bi-bug-fill text-danger me-2"></i>Bugs Status</h6>
                  </div>
                  <div class="card-body">
                    <canvas id="pmBugsChart" height="250"></canvas>
                  </div>
                </div>
              </div>
              <div class="col-md-4 mb-4">
                <div class="card shadow-sm border-0 rounded-4 h-100">
                  <div class="card-header bg-white border-bottom p-3">
                    <h6 class="mb-0 fw-bold"><i class="bi bi-check2-square text-success me-2"></i>Tasks Status</h6>
                  </div>
                  <div class="card-body">
                    <canvas id="pmTasksChart" height="250"></canvas>
                  </div>
                </div>
              </div>
            </div>

            <div class="card shadow-sm border-0 rounded-4 mt-2">
              <div class="card-header bg-white p-3 border-bottom d-flex justify-content-between align-items-center">
                <h6 class="mb-0 fw-bold"><i class="bi bi-briefcase text-secondary me-2"></i>My Projects</h6>
                <a href="${pageContext.request.contextPath}/pm/projects/add"
                  class="btn btn-primary btn-sm rounded-pill"><i class="bi bi-plus-lg me-1"></i>New Project</a>
              </div>
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                      <tr>
                        <th>ID</th>
                        <th>Project Name</th>
                        <th>Status</th>
                        <th>Start</th>
                        <th>End</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="p" items="${projects}">
                        <tr>
                          <td>${p.projectId}</td>
                          <td><a href="${pageContext.request.contextPath}/pm/modules?projectId=${p.projectId}"
                              class="text-decoration-none fw-medium">${p.projectName}</a></td>
                          <td><span class="badge bg-secondary">${p.status != null ? p.status : 'N/A'}</span></td>
                          <td>${p.startDate != null ? p.startDate : '-'}</td>
                          <td>${p.endDate != null ? p.endDate : '-'}</td>
                        </tr>
                      </c:forEach>
                      <c:if test="${empty projects}">
                        <tr>
                          <td colspan="5" class="text-center text-muted py-4">No projects found.</td>
                        </tr>
                      </c:if>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </main>
        </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
      <script>
        document.addEventListener("DOMContentLoaded", () => {
          const fetchChartData = async (url, canvasId, chartType, labelPrefix, bgColors) => {
            try {
              const response = await fetch(url);
              const data = await response.json();

              const labels = Object.keys(data);
              const values = Object.values(data);

              if (values.length === 0) {
                labels.push('No Data');
                values.push(1);
                bgColors = ['#e9ecef'];
              }

              new Chart(document.getElementById(canvasId), {
                type: chartType,
                data: {
                  labels: labels,
                  datasets: [{
                    label: labelPrefix,
                    data: values,
                    backgroundColor: bgColors,
                    borderWidth: 0
                  }]
                },
                options: {
                  responsive: true,
                  maintainAspectRatio: false,
                  plugins: {
                    legend: { position: 'bottom' }
                  }
                }
              });
            } catch (err) {
              console.error("Error fetching chart data for " + canvasId, err);
            }
          };

          const bugsColors = ['#ff6384', '#36a2eb', '#ffce56', '#4bc0c0', '#9966ff', '#ff9f40', '#343a40'];
          const tasksColors = ['#4bc0c0', '#ff9f40', '#ff6384', '#36a2eb', '#e83e8c'];
          const projectsColors = ['#36a2eb', '#ff6384', '#ffce56'];

          fetchChartData('${pageContext.request.contextPath}/pm/api/charts/bugs-by-status', 'pmBugsChart', 'doughnut', 'Bugs', bugsColors);
          fetchChartData('${pageContext.request.contextPath}/pm/api/charts/tasks-by-status', 'pmTasksChart', 'pie', 'Tasks', tasksColors);
          fetchChartData('${pageContext.request.contextPath}/pm/api/charts/projects-by-status', 'pmProjectsChart', 'doughnut', 'Projects', projectsColors);
        });
      </script>
    </body>

    </html>