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
                        <jsp:param name="page" value="tasks" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Task Management" />
                        </jsp:include>
                        <div class="card shadow-sm border-0 mt-3 rounded-4">
                            <div
                                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                                <h6 class="mb-0 fw-bold"><i class="bi bi-check2-square text-primary me-2"></i>All Tasks
                                </h6>
                                <!-- Filter Form -->
                                <form action="${pageContext.request.contextPath}/admin/tasks" method="GET"
                                    class="d-flex gap-2">
                                    <select name="moduleId" class="form-select form-select-sm rounded-pill"
                                        style="width: auto;">
                                        <option value="">All Modules</option>
                                        <c:forEach var="m" items="${modules}">
                                            <option value="${m.moduleId}" ${selectedModuleId==m.moduleId ? 'selected'
                                                : '' }>${m.moduleName} (${m.project.projectName})</option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit"
                                        class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                                    <a href="${pageContext.request.contextPath}/admin/tasks"
                                        class="btn btn-outline-secondary btn-sm rounded-pill px-3">Reset</a>
                                </form>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Task Title</th>
                                                <th>Module</th>
                                                <th>Assigned To</th>
                                                <th>Status</th>
                                                <th>Priority</th>
                                                <th class="pe-4">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="t" items="${tasks}">
                                                <tr class="transition-hover">
                                                    <td class="ps-4 fw-medium text-muted">#${t.taskId}</td>
                                                    <td class="fw-bold text-dark">${t.title}</td>
                                                    <td><span
                                                            class="badge bg-info-subtle text-info rounded-pill px-3">${t.module.moduleName}</span>
                                                    </td>
                                                    <td>${t.assignedTo != null ? t.assignedTo.firstName += ' ' +=
                                                        t.assignedTo.lastName : '<span
                                                            class="text-danger">Unassigned</span>'}</td>
                                                    <td>
                                                        <span
                                                            class="badge ${t.status == 'COMPLETED' ? 'bg-success' : 'bg-warning'} text-white rounded-pill px-3">${t.status
                                                            != null ? t.status : 'N/A'}</span>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${t.priority == 'HIGH' ? 'bg-danger' : 'bg-primary'} rounded-pill px-3">${t.priority
                                                            != null ? t.priority : 'NORMAL'}</span>
                                                    </td>
                                                    <td class="pe-4">
                                                        <a href="${pageContext.request.contextPath}/admin/tasks/view/${t.taskId}"
                                                            class="btn btn-sm btn-outline-primary rounded-pill px-3">View</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty tasks}">
                                                <tr>
                                                    <td colspan="6" class="text-center py-4 text-muted">No tasks found.
                                                    </td>
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