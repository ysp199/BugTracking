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
                    <jsp:include page="../common/sidebar-developer.jsp">
                        <jsp:param name="page" value="projects" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Developer Portal - My Projects" />
                        </jsp:include>
                        <div class="card shadow-sm border-0 mt-3 rounded-4">
                            <div
                                class="card-header bg-white d-flex justify-content-between align-items-center p-3 border-bottom rounded-top-4">
                                <h6 class="mb-0 fw-bold"><i class="bi bi-folder text-primary me-2"></i>Projects I'm
                                    Working On (Developer View)</h6>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Project Name</th>
                                                <th>Description</th>
                                                <th>Status</th>
                                                <th class="pe-4">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${projects}">
                                                <tr class="transition-hover">
                                                    <td class="ps-4 fw-medium text-muted">#${p.projectId}</td>
                                                    <td class="fw-bold text-dark">${p.projectName}</td>
                                                    <td class="text-muted text-truncate" style="max-width: 250px;">
                                                        ${p.description}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${p.status == 'ACTIVE'}"><span
                                                                    class="badge bg-success-subtle text-success rounded-pill px-3">Active</span>
                                                            </c:when>
                                                            <c:when test="${p.status == 'COMPLETED'}"><span
                                                                    class="badge bg-primary-subtle text-primary rounded-pill px-3">Completed</span>
                                                            </c:when>
                                                            <c:otherwise><span
                                                                    class="badge bg-secondary-subtle text-secondary rounded-pill px-3">${p.status
                                                                    != null ? p.status : 'N/A'}</span></c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="pe-4">
                                                        <a href="${pageContext.request.contextPath}/developer/my-projects/${p.projectId}"
                                                            class="btn btn-sm btn-outline-primary rounded-pill px-3">View
                                                            Details</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <c:if test="${empty projects}">
                                        <div class="p-4 text-center text-muted">You are not assigned to any tasks in any
                                            projects yet.</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <style>
                            .transition-hover:hover {
                                background-color: #f8f9fa !important;
                            }
                        </style>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>