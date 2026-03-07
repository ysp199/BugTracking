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
                        <jsp:param name="page" value="bugs" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Closed Bugs Overview" />
                        </jsp:include>
                        <div class="card shadow-sm border-0 mt-3 rounded-4">
                            <div
                                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                                <h6 class="mb-0 fw-bold"><i class="bi bi-check-circle text-success me-2"></i>Resolved &
                                    Closed Bugs</h6>
                                <a href="${pageContext.request.contextPath}/admin/bugs"
                                    class="btn btn-sm btn-outline-primary rounded-pill px-3">Back to All Bugs</a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Title</th>
                                                <th>Severity</th>
                                                <th>Status</th>
                                                <th>Assigned To</th>
                                                <th class="pe-4">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="b" items="${bugs}">
                                                <tr class="transition-hover">
                                                    <td class="ps-4 fw-medium text-muted">#${b.bugId}</td>
                                                    <td class="fw-bold text-dark">${b.title}</td>
                                                    <td><span
                                                            class="badge rounded-pill bg-info-subtle text-info px-3">${b.severity}</span>
                                                    </td>
                                                    <td><span
                                                            class="badge rounded-pill bg-success px-3">${b.status}</span>
                                                    </td>
                                                    <td>
                                                        ${b.task != null && b.task.assignedTo != null ?
                                                        b.task.assignedTo.firstName : '-'}
                                                        ${b.task != null && b.task.assignedTo != null ?
                                                        b.task.assignedTo.lastName : ''}
                                                    </td>
                                                    <td class="pe-4">
                                                        <a href="${pageContext.request.contextPath}/admin/bugs/view/${b.bugId}"
                                                            class="btn btn-sm btn-outline-primary rounded-pill px-3">View</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty bugs}">
                                                <tr>
                                                    <td colspan="6" class="text-center py-4 text-muted">No closed bugs
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