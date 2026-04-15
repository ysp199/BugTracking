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
                        <jsp:param name="page" value="bugs" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Bugs" />
                        </jsp:include>
                        <c:if test="${param.success != null}">
                            <div class="alert alert-success">${param.success}</div>
                        </c:if>
                        <div class="d-flex gap-2 mt-3 mb-2">
                            <form action="${pageContext.request.contextPath}/pm/bugs" method="GET" class="d-flex gap-2">
                                <select name="status" class="form-select form-select-sm" style="width: auto;">
                                    <option value="">All Statuses</option>
                                    <option value="NEW" ${selectedStatus=='NEW' ? 'selected' : '' }>NEW</option>
                                    <option value="ASSIGNED" ${selectedStatus=='ASSIGNED' ? 'selected' : '' }>ASSIGNED
                                    </option>
                                    <option value="IN_PROGRESS" ${selectedStatus=='IN_PROGRESS' ? 'selected' : '' }>
                                        IN_PROGRESS</option>
                                    <option value="RESOLVED" ${selectedStatus=='RESOLVED' ? 'selected' : '' }>RESOLVED
                                    </option>
                                    <option value="VERIFIED" ${selectedStatus=='VERIFIED' ? 'selected' : '' }>VERIFIED
                                    </option>
                                    <option value="REOPENED" ${selectedStatus=='REOPENED' ? 'selected' : '' }>REOPENED
                                    </option>
                                    <option value="CLOSED" ${selectedStatus=='CLOSED' ? 'selected' : '' }>CLOSED
                                    </option>
                                </select>
                                <select name="priority" class="form-select form-select-sm" style="width: auto;">
                                    <option value="">All Priorities</option>
                                    <option value="LOW" ${selectedPriority=='LOW' ? 'selected' : '' }>Low</option>
                                    <option value="NORMAL" ${selectedPriority=='NORMAL' ? 'selected' : '' }>Normal
                                    </option>
                                    <option value="HIGH" ${selectedPriority=='HIGH' ? 'selected' : '' }>High</option>
                                    <option value="URGENT" ${selectedPriority=='URGENT' ? 'selected' : '' }>Urgent
                                    </option>
                                </select>
                                <button type="submit" class="btn btn-primary btn-sm">Filter</button>
                                <a href="${pageContext.request.contextPath}/pm/bugs"
                                    class="btn btn-outline-secondary btn-sm">Reset</a>
                            </form>
                        </div>
                        <div class="table-card">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Severity</th>
                                            <th>Status</th>
                                            <th>Reported By</th>
                                            <th>Assigned To</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="b" items="${bugs}">
                                            <tr>
                                                <td>#${b.bugId}</td>
                                                <td>${b.title}</td>
                                                <td><span class="badge bg-info">${b.severity}</span></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${b.status == 'NEW'}"><span
                                                                class="badge bg-secondary">${b.status}</span></c:when>
                                                        <c:when test="${b.status == 'ASSIGNED'}"><span
                                                                class="badge bg-primary">${b.status}</span></c:when>
                                                        <c:when test="${b.status == 'IN_PROGRESS'}"><span
                                                                class="badge bg-warning text-dark">${b.status}</span>
                                                        </c:when>
                                                        <c:when test="${b.status == 'RESOLVED'}"><span
                                                                class="badge bg-info">${b.status}</span></c:when>
                                                        <c:when test="${b.status == 'VERIFIED'}"><span
                                                                class="badge bg-success">${b.status}</span></c:when>
                                                        <c:when test="${b.status == 'CLOSED'}"><span
                                                                class="badge bg-dark">${b.status}</span></c:when>
                                                        <c:when test="${b.status == 'REOPENED'}"><span
                                                                class="badge bg-danger">${b.status}</span></c:when>
                                                        <c:otherwise><span class="badge bg-secondary">${b.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${b.reportedBy != null ? b.reportedBy.firstName : '-'}</td>
                                                <td>${b.assignedTo != null ? b.assignedTo.firstName : '-'}</td>
                                                <td><a href="${pageContext.request.contextPath}/pm/bugs/${b.bugId}"
                                                        class="btn btn-sm btn-outline-primary">View</a></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty bugs}">
                                            <tr>
                                                <td colspan="7" class="text-muted text-center py-4">No bugs found.</td>
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