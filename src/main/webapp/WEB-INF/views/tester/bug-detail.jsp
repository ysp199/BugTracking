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
                        <jsp:param name="page" value="bugs" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Bug #${bug.bugId}" />
                        </jsp:include>
                        <div class="table-card mt-3 p-4">
                            <c:if test="${param.success != null}">
                                <div class="alert alert-success">${param.success}</div>
                            </c:if>
                            <h5>${bug.title}</h5>
                            <div class="mt-3">
                                <span class="text-muted fw-bold">Description</span>
                                <p class="mt-1">${bug.description}</p>
                            </div>
                            <c:if test="${not empty bug.attachment}">
                                <div class="mt-3">
                                    <span class="text-muted fw-bold">Attachment</span><br />
                                    <a href="${bug.attachment}" target="_blank"
                                        class="btn btn-sm btn-outline-info mt-1"><i class="bi bi-paperclip"></i> View
                                        Attachment</a>
                                </div>
                            </c:if>

                            <hr />
                            <div class="row mb-3">
                                <div class="col"><strong>Priority:</strong> <span
                                        class="badge bg-warning">${bug.priority}</span></div>
                                <div class="col"><strong>Severity:</strong> <span
                                        class="badge bg-info">${bug.severity}</span></div>
                                <div class="col"><strong>Status:</strong> <span
                                        class="badge bg-primary">${bug.status}</span></div>
                                <div class="col"><strong>Assigned to:</strong> ${bug.assignedTo != null ?
                                    bug.assignedTo.firstName : '-'}</div>
                            </div>
                            <c:if test="${bug.status == 'FIXED'}">
                                <hr />
                                <h6>Verify Fix</h6>
                                <p class="text-muted small">The developer has marked this bug as fixed. Please verify
                                    the fix and update accordingly.</p>
                                <form action="${pageContext.request.contextPath}/tester/bugs/${bug.bugId}/status"
                                    method="post">
                                    <div class="d-flex gap-2">
                                        <select name="status" class="form-select form-select-sm"
                                            style="max-width:180px">
                                            <option value="CLOSED">Closed (Fix is verified & correct)</option>
                                            <option value="REOPENED">Reopened (Fix is incorrect)</option>
                                        </select>
                                        <button type="submit" class="btn btn-primary btn-sm">Submit
                                            Verification</button>
                                    </div>
                                    <textarea name="notes" class="form-control form-control-sm mt-2" rows="2"
                                        placeholder="Add testing comments or notes..."></textarea>
                                </form>
                            </c:if>
                            <hr />
                            <h6>History</h6>
                            <ul class="list-group list-group-flush">
                                <c:forEach var="h" items="${history}">
                                    <li class="list-group-item d-flex justify-content-between">
                                        <div>
                                            <span>${h.oldStatus} &rarr; ${h.newStatus}</span>
                                            <c:if test="${not empty h.notes}">
                                                <div class="text-muted small mt-1"><em>Notes:</em> ${h.notes}</div>
                                            </c:if>
                                        </div>
                                        <span class="text-muted small">${h.changedBy != null ? h.changedBy.firstName :
                                            ''} - ${h.changedAt}</span>
                                    </li>
                                </c:forEach>
                                <c:if test="${empty history}">
                                    <li class="list-group-item text-muted">No history yet.</li>
                                </c:if>
                            </ul>
                            <a href="${pageContext.request.contextPath}/tester/bugs"
                                class="btn btn-outline-secondary mt-3">Back</a>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>