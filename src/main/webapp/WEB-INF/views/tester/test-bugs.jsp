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
                    <jsp:include page="../common/sidebar-tester.jsp">
                        <jsp:param name="page" value="testBugs" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Test Bugs (Ready for Verification)" />
                        </jsp:include>
                        <div class="table-card mt-3">
                            <c:if test="${param.success != null}">
                                <div class="alert alert-success">${param.success}</div>
                            </c:if>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Severity</th>
                                            <th>Status</th>
                                            <th>Developer (Assigned)</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="b" items="${bugs}">
                                            <tr>
                                                <td>#${b.bugId}</td>
                                                <td>${b.title}</td>
                                                <td><span class="badge bg-info">${b.severity}</span></td>
                                                <td><span class="badge bg-info">${b.status}</span></td>
                                                <td>${b.assignedTo != null ? b.assignedTo.firstName : '-'}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/tester/bugs/${b.bugId}"
                                                        class="btn btn-sm btn-outline-primary">Verify</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty bugs}">
                                            <tr>
                                                <td colspan="6" class="text-center text-muted py-4">No bugs waiting for
                                                    verification.</td>
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