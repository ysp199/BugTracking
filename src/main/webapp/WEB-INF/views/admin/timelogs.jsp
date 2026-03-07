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
                        <jsp:param name="page" value="timelogs" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Time Log Overview" />
                        </jsp:include>
                        <div class="card shadow-sm border-0 mt-3 rounded-4">
                            <div
                                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                                <h6 class="mb-0 fw-bold"><i class="bi bi-clock-history text-primary me-2"></i>All Time
                                    Logs</h6>
                                <!-- Filter Form -->
                                <form action="${pageContext.request.contextPath}/admin/timelogs" method="GET"
                                    class="d-flex gap-2">
                                    <select name="userId" class="form-select form-select-sm rounded-pill"
                                        style="width: auto;">
                                        <option value="">All Users</option>
                                        <c:forEach var="u" items="${users}">
                                            <option value="${u.userId}" ${selectedUserId==u.userId ? 'selected' : '' }>
                                                ${u.firstName} ${u.lastName}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="taskId" class="form-select form-select-sm rounded-pill"
                                        style="width: auto;">
                                        <option value="">All Tasks</option>
                                        <c:forEach var="t" items="${tasks}">
                                            <option value="${t.taskId}" ${selectedTaskId==t.taskId ? 'selected' : '' }>
                                                ${t.title}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit"
                                        class="btn btn-primary btn-sm rounded-pill px-3">Filter</button>
                                    <a href="${pageContext.request.contextPath}/admin/timelogs"
                                        class="btn btn-outline-secondary btn-sm rounded-pill px-3">Reset</a>
                                </form>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>User</th>
                                                <th>Task</th>
                                                <th>Hours</th>
                                                <th>Date</th>
                                                <th class="pe-4">Description</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="l" items="${logs}">
                                                <tr class="transition-hover">
                                                    <td class="ps-4 fw-medium text-muted">#${l.logId}</td>
                                                    <td class="fw-bold text-dark">
                                                        ${l.user != null ? l.user.firstName : 'N/A'}
                                                        ${l.user != null ? l.user.lastName : ''}
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge bg-secondary-subtle text-secondary rounded-pill px-3">
                                                            ${l.task != null ? l.task.title : 'N/A'}
                                                        </span>
                                                    </td>
                                                    <td><span class="fw-bold">${l.hoursSpent}</span> hrs</td>
                                                    <td>${l.logDate}</td>
                                                    <td class="pe-4 text-muted small text-truncate"
                                                        style="max-width: 300px;">${l.description != null ?
                                                        l.description : '-'}</td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty logs}">
                                                <tr>
                                                    <td colspan="6" class="text-center py-4 text-muted">No time logs
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