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
                        <jsp:param name="page" value="modules" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Module Management" />
                        </jsp:include>
                        <div class="card shadow-sm border-0 mt-3 rounded-4">
                            <div
                                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                                <h6 class="mb-0 fw-bold"><i class="bi bi-layers text-primary me-2"></i>All Modules</h6>
                                <!-- Filter Form & Actions -->
                                <div class="d-flex gap-3 align-items-center">
                                    <a href="${pageContext.request.contextPath}/admin/modules/add"
                                        class="btn btn-success btn-sm rounded-pill px-3 shadow-sm">
                                        <i class="bi bi-plus-circle me-1"></i> Add Module
                                    </a>
                                    <form action="${pageContext.request.contextPath}/admin/modules" method="GET"
                                        class="d-flex gap-2">
                                        <select name="projectId" class="form-select form-select-sm rounded-pill"
                                            style="width: auto;">
                                            <option value="">All Projects</option>
                                            <c:forEach var="p" items="${projects}">
                                                <option value="${p.projectId}" ${selectedProjectId==p.projectId
                                                    ? 'selected' : '' }>${p.projectName}</option>
                                            </c:forEach>
                                        </select>
                                        <button type="submit"
                                            class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                                        <a href="${pageContext.request.contextPath}/admin/modules"
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
                                                <th>Module Name</th>
                                                <th>Project</th>
                                                <th>Description</th>
                                                <th>Est. Hours</th>
                                                <th class="pe-4">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="m" items="${modules}">
                                                <tr class="transition-hover">
                                                    <td class="ps-4 fw-medium text-muted">#${m.moduleId}</td>
                                                    <td class="fw-bold text-dark">${m.moduleName}</td>
                                                    <td><span
                                                            class="badge bg-info-subtle text-info rounded-pill px-3">${m.project.projectName}</span>
                                                    </td>
                                                    <td class="text-muted text-truncate" style="max-width: 250px;">
                                                        ${m.description}</td>
                                                    <td>${m.totalTaskHours} hrs</td>
                                                    <td class="pe-4">
                                                        <div class="btn-group">
                                                            <a href="${pageContext.request.contextPath}/admin/modules/view/${m.moduleId}"
                                                                class="btn btn-sm btn-outline-primary rounded-start px-3">View</a>
                                                            <button type="button"
                                                                class="btn btn-sm btn-outline-primary dropdown-toggle dropdown-toggle-split"
                                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                                <span class="visually-hidden">Toggle Dropdown</span>
                                                            </button>
                                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                                                <li>
                                                                    <h6 class="dropdown-header text-muted">Change Status
                                                                    </h6>
                                                                </li>
                                                                <li><a class="dropdown-item fw-medium text-success"
                                                                        href="${pageContext.request.contextPath}/admin/modules/status/${m.moduleId}?action=ACTIVE"><i
                                                                            class="bi bi-play-circle me-2"></i>Set to
                                                                        Active</a></li>
                                                                <li><a class="dropdown-item fw-medium text-warning"
                                                                        href="${pageContext.request.contextPath}/admin/modules/status/${m.moduleId}?action=STOPPED"><i
                                                                            class="bi bi-pause-circle me-2"></i>Set to
                                                                        Stopped</a></li>
                                                                <li>
                                                                    <hr class="dropdown-divider">
                                                                </li>
                                                                <li><a class="dropdown-item fw-medium text-danger"
                                                                        href="${pageContext.request.contextPath}/admin/modules/status/${m.moduleId}?action=REVOKED"><i
                                                                            class="bi bi-x-circle me-2"></i>Revoke</a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty modules}">
                                                <tr>
                                                    <td colspan="5" class="text-center py-4 text-muted">No modules
                                                        found.</td>
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
        </body>

        </html>