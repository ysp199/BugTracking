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
                        <jsp:param name="page" value="modules" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Module Details" />
                        </jsp:include>
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 rounded-4 mb-4">
                                    <div
                                        class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold"><i
                                                class="bi bi-info-circle text-primary me-2"></i>Module Info</h6>
                                        <div class="dropdown">
                                            <button
                                                class="btn btn-sm btn-outline-secondary dropdown-toggle rounded-pill"
                                                type="button" data-bs-toggle="dropdown">
                                                Change Status
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0"
                                                style="z-index: 1050;">
                                                <li><a class="dropdown-item fw-medium text-success"
                                                        href="${pageContext.request.contextPath}/pm/modules/status/${module.moduleId}?action=ACTIVE"><i
                                                            class="bi bi-play-circle me-2"></i>Set to Active</a></li>
                                                <li><a class="dropdown-item fw-medium text-warning"
                                                        href="${pageContext.request.contextPath}/pm/modules/status/${module.moduleId}?action=STOPPED"><i
                                                            class="bi bi-pause-circle me-2"></i>Set to Stopped</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item fw-medium text-danger"
                                                        href="${pageContext.request.contextPath}/pm/modules/status/${module.moduleId}?action=REVOKED"><i
                                                            class="bi bi-x-circle me-2"></i>Revoke</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Module Name</label>
                                            <span class="fw-bold fs-5 text-dark">${module.moduleName}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Status</label>
                                            <c:choose>
                                                <c:when test="${module.status == 'ACTIVE'}"><span
                                                        class="badge bg-success-subtle text-success rounded-pill px-3">Active</span>
                                                </c:when>
                                                <c:when test="${module.status == 'COMPLETED'}"><span
                                                        class="badge bg-primary-subtle text-primary rounded-pill px-3">Completed</span>
                                                </c:when>
                                                <c:otherwise><span
                                                        class="badge bg-secondary-subtle text-secondary rounded-pill px-3">${module.status
                                                        != null ? module.status : 'N/A'}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Project</label>
                                            <span
                                                class="badge bg-info-subtle text-info rounded-pill px-3">${module.project.projectName}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Description</label>
                                            <p class="text-dark mb-0">${module.description}</p>
                                        </div>
                                        <div class="mb-0">
                                            <label class="text-muted small d-block mb-1">Est. Hours</label>
                                            <span class="text-dark">${module.totalTaskHours} hrs</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card shadow-sm border-0 rounded-4">
                                    <div class="card-header bg-white border-bottom p-3">
                                        <h6 class="mb-0 fw-bold"><i
                                                class="bi bi-check2-square text-primary me-2"></i>Module Tasks</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">ID</th>
                                                        <th>Task Title</th>
                                                        <th>Assigned To</th>
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="t" items="${tasks}">
                                                        <tr>
                                                            <td class="ps-4 text-muted">#${t.taskId}</td>
                                                            <td class="fw-bold text-dark">${t.title}</td>
                                                            <td>
                                                                ${t.assignedTo != null ? t.assignedTo.firstName :
                                                                'Unassigned'}
                                                                ${t.assignedTo != null ? t.assignedTo.lastName : ''}
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="badge rounded-pill bg-${t.status == 'COMPLETED' ? 'success' : 'warning'} px-3">${t.status}</span>
                                                            </td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/pm/tasks/view/${t.taskId}"
                                                                    class="btn btn-sm btn-outline-primary rounded-pill px-3">View
                                                                    Details</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty tasks}">
                                                        <tr>
                                                            <td colspan="5" class="p-4 text-center text-muted">No tasks
                                                                in this module.</td>
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
                            <a href="${pageContext.request.contextPath}/pm/modules"
                                class="btn btn-outline-secondary rounded-pill px-4">
                                <i class="bi bi-arrow-left me-2"></i>Back to Modules
                            </a>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>