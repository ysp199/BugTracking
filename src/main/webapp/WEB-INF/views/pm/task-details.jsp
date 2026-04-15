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
                    <jsp:include page="../common/sidebar-pm.jsp">
                        <jsp:param name="page" value="tasks" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Task Details" />
                        </jsp:include>
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 rounded-4 mb-4">
                                    <div
                                        class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold"><i class="bi bi-info-circle text-primary me-2"></i>Task
                                            Info</h6>
                                        <div class="dropdown">
                                            <button
                                                class="btn btn-sm btn-outline-secondary dropdown-toggle rounded-pill"
                                                type="button" data-bs-toggle="dropdown">
                                                Change Status
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0"
                                                style="z-index: 1050;">
                                                <li><a class="dropdown-item fw-medium text-success"
                                                        href="${pageContext.request.contextPath}/pm/tasks/status/${task.taskId}?action=IN_PROGRESS"><i
                                                            class="bi bi-play-circle me-2"></i>Set to In Progress</a>
                                                </li>
                                                <li><a class="dropdown-item fw-medium text-warning"
                                                        href="${pageContext.request.contextPath}/pm/tasks/status/${task.taskId}?action=ON_HOLD"><i
                                                            class="bi bi-pause-circle me-2"></i>Set to On Hold</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item fw-medium text-danger"
                                                        href="${pageContext.request.contextPath}/pm/tasks/status/${task.taskId}?action=REVOKED"><i
                                                            class="bi bi-x-circle me-2"></i>Revoke</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Title</label>
                                            <span class="fw-bold fs-5 text-dark">${task.title}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Module / Project</label>
                                            <span class="text-dark">${task.module.moduleName} /
                                                ${task.module.project.projectName}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Assigned To</label>
                                            <span class="text-dark">${task.assignedTo != null ?
                                                task.assignedTo.firstName += ' ' += task.assignedTo.lastName :
                                                'Unassigned'}</span>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label class="text-muted small d-block mb-1">Priority</label>
                                                <span class="badge rounded-pill bg-primary px-3">${task.priority}</span>
                                            </div>
                                            <div class="col">
                                                <label class="text-muted small d-block mb-1">Status</label>
                                                <span class="badge rounded-pill bg-warning px-3">${task.status}</span>
                                            </div>
                                        </div>
                                        <div class="mb-0">
                                            <label class="text-muted small d-block mb-1">Description</label>
                                            <p class="text-dark mb-0">${task.description}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card shadow-sm border-0 rounded-4 mb-4">
                                    <div class="card-header bg-white border-bottom p-3">
                                        <h6 class="mb-0 fw-bold"><i class="bi bi-bug text-danger me-2"></i>Associated
                                            Bugs</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">Bug Title</th>
                                                        <th>Priority</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="b" items="${taskBugs}">
                                                        <tr>
                                                            <td class="ps-4 fw-bold text-dark">${b.title}</td>
                                                            <td><span
                                                                    class="badge bg-danger rounded-pill">${b.priority}</span>
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="badge rounded-pill bg-${b.status == 'CLOSED' ? 'success' : 'warning'} px-3">${b.status}</span>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty taskBugs}">
                                                        <tr>
                                                            <td colspan="3" class="p-4 text-center text-muted">No bugs
                                                                associated with this task.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <div class="card shadow-sm border-0 rounded-4">
                                    <div class="card-header bg-white border-bottom p-3">
                                        <h6 class="mb-0 fw-bold"><i
                                                class="bi bi-clock-history text-primary me-2"></i>Task Time Logs</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">User</th>
                                                        <th>Hours</th>
                                                        <th>Date</th>
                                                        <th class="pe-4">Description</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="l" items="${logs}">
                                                        <tr>
                                                            <td class="ps-4 fw-bold">${l.user.firstName}
                                                                ${l.user.lastName}</td>
                                                            <td><span
                                                                    class="fw-bold text-primary">${l.hoursSpent}</span>
                                                                hrs</td>
                                                            <td>${l.logDate}</td>
                                                            <td class="pe-4 text-muted small">${l.description}</td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty logs}">
                                                        <tr>
                                                            <td colspan="4" class="p-4 text-center text-muted">No time
                                                                logs for this task.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/pm/tasks"
                                class="btn btn-outline-secondary rounded-pill px-4">
                                <i class="bi bi-arrow-left me-2"></i>Back to Tasks
                            </a>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>