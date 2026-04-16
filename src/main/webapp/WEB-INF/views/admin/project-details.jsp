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
                            <jsp:param name="title" value="Project Details" />
                        </jsp:include>
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 rounded-4 mb-4">
                                    <div
                                        class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold"><i
                                                class="bi bi-info-circle text-primary me-2"></i>Project Info</h6>
                                        <div class="dropdown">
                                            <button
                                                class="btn btn-sm btn-outline-secondary dropdown-toggle rounded-pill"
                                                type="button" data-bs-toggle="dropdown">
                                                Change Status
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0"
                                                style="z-index: 1050;">
                                                <li><a class="dropdown-item fw-medium text-success"
                                                        href="${pageContext.request.contextPath}/admin/projects/status/${project.projectId}?action=ACTIVE"><i
                                                            class="bi bi-play-circle me-2"></i>Set to Active</a></li>
                                                <li><a class="dropdown-item fw-medium text-warning"
                                                        href="${pageContext.request.contextPath}/admin/projects/status/${project.projectId}?action=STOPPED"><i
                                                            class="bi bi-pause-circle me-2"></i>Set to Stopped</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item fw-medium text-danger"
                                                        href="${pageContext.request.contextPath}/admin/projects/status/${project.projectId}?action=REVOKED"><i
                                                            class="bi bi-x-circle me-2"></i>Revoke</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Project Name</label>
                                            <span class="fw-bold fs-5 text-dark">${project.projectName}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Status</label>
                                            <c:choose>
                                                <c:when test="${project.status == 'ACTIVE'}"><span
                                                        class="badge bg-success-subtle text-success rounded-pill px-3">Active</span>
                                                </c:when>
                                                <c:when test="${project.status == 'COMPLETED'}"><span
                                                        class="badge bg-primary-subtle text-primary rounded-pill px-3">Completed</span>
                                                </c:when>
                                                <c:otherwise><span
                                                        class="badge bg-secondary-subtle text-secondary rounded-pill px-3">${project.status
                                                        != null ? project.status : 'N/A'}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Description</label>
                                            <p class="text-dark mb-0">${project.description}</p>
                                        </div>
                                        <div class="mb-0">
                                            <label class="text-muted small d-block mb-1">Created By</label>
                                            <span class="text-dark">${project.createdBy.firstName}
                                                ${project.createdBy.lastName}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card shadow-sm border-0 rounded-4">
                                    <div
                                        class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold"><i class="bi bi-stack text-primary me-2"></i>Project
                                            Modules</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">ID</th>
                                                        <th>Module Name</th>
                                                        <th>Description</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="m" items="${modules}">
                                                        <tr>
                                                            <td class="ps-4 text-muted">#${m.moduleId}</td>
                                                            <td class="fw-bold text-dark">${m.moduleName}</td>
                                                            <td class="text-muted text-truncate"
                                                                style="max-width: 250px;">${m.description}</td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/admin/modules/view/${m.moduleId}"
                                                                    class="btn btn-sm btn-outline-primary rounded-pill px-3">View
                                                                    Details</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty modules}">
                                                        <tr>
                                                            <td colspan="4" class="p-4 text-center text-muted">No
                                                                modules defined.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <!-- Project Tasks Card -->
                                <div class="card shadow-sm border-0 rounded-4 mt-4">
                                    <div
                                        class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold"><i
                                                class="bi bi-list-task text-primary me-2"></i>Project Tasks</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">ID</th>
                                                        <th>Task Name</th>
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
                                                            <td class="text-muted">
                                                                <c:if test="${t.assignedTo != null}">
                                                                    ${t.assignedTo.firstName} ${t.assignedTo.lastName}
                                                                </c:if>
                                                                <c:if test="${t.assignedTo == null}">Unassigned</c:if>
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="badge rounded-pill bg-${t.status == 'COMPLETED' ? 'success' : (t.status == 'IN_PROGRESS' ? 'primary' : 'warning')}-subtle text-${t.status == 'COMPLETED' ? 'success' : (t.status == 'IN_PROGRESS' ? 'primary' : 'warning')} px-3">${t.status}</span>
                                                            </td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/admin/tasks/view/${t.taskId}"
                                                                    class="btn btn-sm btn-outline-primary rounded-pill px-3">View</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty tasks}">
                                                        <tr>
                                                            <td colspan="5" class="p-4 text-center text-muted">No tasks
                                                                exist in these modules.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <!-- Project Users Card -->
                                <div class="card shadow-sm border-0 rounded-4 mt-4 mb-4">
                                    <div
                                        class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0 fw-bold"><i class="bi bi-people text-primary me-2"></i>Project
                                            Users</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">ID</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Role</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="u" items="${users}">
                                                        <tr>
                                                            <td class="ps-4 text-muted">#${u.userId}</td>
                                                            <td class="fw-bold text-dark">${u.firstName} ${u.lastName}
                                                            </td>
                                                            <td class="text-muted">${u.email}</td>
                                                            <td><span
                                                                    class="badge bg-secondary rounded-pill px-3 shadow-sm">${u.roleName
                                                                    != null ? u.roleName : 'N/A'}</span></td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/admin/users/view/${u.userId}"
                                                                    class="btn btn-sm btn-outline-info rounded-pill px-3">Profile</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty users}">
                                                        <tr>
                                                            <td colspan="5" class="p-4 text-center text-muted">No users
                                                                found.</td>
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
                            <a href="${pageContext.request.contextPath}/admin/all-projects"
                                class="btn btn-outline-secondary rounded-pill px-4">
                                <i class="bi bi-arrow-left me-2"></i>Back to All Projects
                            </a>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>