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
                            <jsp:param name="title" value="Bug Details" />
                        </jsp:include>
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <div class="card shadow-sm border-0 rounded-4 mb-4">
                                    <div class="card-header bg-white border-bottom p-3">
                                        <h6 class="mb-0 fw-bold"><i class="bi bi-info-circle text-primary me-2"></i>Bug
                                            Info</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Title</label>
                                            <span class="fw-bold fs-5 text-dark">${bug.title}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Task / Project</label>
                                            <span class="text-dark">${bug.task.title} /
                                                ${bug.task.module.project.projectName}</span>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <label class="text-muted small d-block mb-1">Severity</label>
                                                <span
                                                    class="badge rounded-pill bg-danger px-3 shadow-sm">${bug.severity}</span>
                                            </div>
                                            <div class="col">
                                                <label class="text-muted small d-block mb-1">Priority</label>
                                                <span
                                                    class="badge rounded-pill bg-warning px-3 shadow-sm">${bug.priority}</span>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Status</label>
                                            <span
                                                class="badge rounded-pill bg-primary px-3 shadow-sm">${bug.status}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Reported By</label>
                                            <span class="text-dark">${bug.reportedBy.firstName}
                                                ${bug.reportedBy.lastName}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="text-muted small d-block mb-1">Assigned To </label>
                                            <span class="fw-bold text-dark">
                                                <c:choose>
                                                    <c:when test="${bug.task != null && bug.task.assignedTo != null}">
                                                        ${bug.task.assignedTo.firstName} ${bug.task.assignedTo.lastName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="text-muted italic text-decoration-underline">Unassigned</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>

                                        <div class="mb-0">
                                            <label class="text-muted small d-block mb-1">Description</label>
                                            <p class="text-dark mb-0">${bug.description}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card shadow-sm border-0 rounded-4">
                                    <div class="card-header bg-white border-bottom p-3">
                                        <h6 class="mb-0 fw-bold"><i
                                                class="bi bi-clock-history text-primary me-2"></i>Bug Audit Trail
                                            (History)</h6>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="ps-4">Transition</th>
                                                        <th>Changed By</th>
                                                        <th class="pe-4">Changed At</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="h" items="${history}">
                                                        <tr>
                                                            <td class="ps-4">
                                                                <span class="text-muted">${h.oldStatus}</span>
                                                                <i class="bi bi-arrow-right mx-2 text-primary"></i>
                                                                <span class="fw-bold text-dark">${h.newStatus}</span>
                                                            </td>
                                                            <td>${h.changedBy.firstName} ${h.changedBy.lastName}</td>
                                                            <td class="pe-4 text-muted small">${h.changedAt}</td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty history}">
                                                        <tr>
                                                            <td colspan="3" class="p-4 text-center text-muted">No
                                                                history recorded for this bug.</td>
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
                            <a href="${pageContext.request.contextPath}/admin/bugs"
                                class="btn btn-outline-secondary rounded-pill px-4">
                                <i class="bi bi-arrow-left me-2"></i>Back to Bugs
                            </a>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>