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
                        <jsp:param name="page" value="triage" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Bug Triage" />
                        </jsp:include>
                        <c:if test="${param.success != null}">
                            <div class="alert alert-success">${param.success}</div>
                        </c:if>
                        <div class="d-flex justify-content-between align-items-center mt-3 mb-2">
                            <h6 class="mb-0">Bugs Awaiting Triage</h6>
                        </div>
                        <div class="table-card">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Severity</th>
                                            <th>Reported By</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="b" items="${bugs}">
                                            <tr>
                                                <td>#${b.bugId}</td>
                                                <td>${b.title}</td>
                                                <td><span class="badge bg-info">${b.severity}</span></td>
                                                <td>${b.reportedBy != null ? b.reportedBy.firstName : '-'}</td>
                                                <td><a href="${pageContext.request.contextPath}/pm/bugs/${b.bugId}"
                                                        class="btn btn-sm btn-outline-primary">Triage</a></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty bugs}">
                                            <tr>
                                                <td colspan="5" class="text-muted text-center py-4">No bugs waiting for
                                                    triage.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>