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
                            <jsp:param name="title" value="Bug #${bug.bugId}" />
                        </jsp:include>
                        <div class="table-card mt-3 p-4">
                            <c:if test="${param.error != null}">
                                <div class="alert alert-danger">${param.error}</div>
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
                                <div class="col"><strong>Severity:</strong> <span
                                        class="badge bg-info">${bug.severity}</span></div>
                                <div class="col"><strong>Priority:</strong> <span
                                        class="badge bg-warning">${bug.priority}</span></div>
                                <div class="col"><strong>Status:</strong> <span
                                        class="badge bg-primary">${bug.status}</span></div>
                                <div class="col"><strong>Reported by:</strong> ${bug.reportedBy != null ?
                                    bug.reportedBy.firstName : '-'}</div>
                            </div>

                            <hr />
                            <h6>Determine Action</h6>
                            <form action="${pageContext.request.contextPath}/pm/bugs/${bug.bugId}/triage" method="post"
                                class="mt-3">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Set Status</label>
                                        <select name="status" id="statusSelect" class="form-select w-100" required>
                                            <option value="ASSIGNED" ${bug.status=='ASSIGNED' ? 'selected' : '' }>
                                                Assigned (Valid Bug)</option>
                                            <option value="REJECTED" ${bug.status=='REJECTED' ? 'selected' : '' }>
                                                Rejected (Not a Bug)</option>
                                            <option value="DUPLICATE" ${bug.status=='DUPLICATE' ? 'selected' : '' }>
                                                Duplicate</option>
                                            <option value="DEFERRED" ${bug.status=='DEFERRED' ? 'selected' : '' }>
                                                Deferred (Low Priority)</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3" id="priorityWrapper">
                                        <label class="form-label">Set Priority</label>
                                        <select name="priority" class="form-select w-100" required>
                                            <option value="LOW" ${bug.priority=='LOW' ? 'selected' : '' }>Low</option>
                                            <option value="MEDIUM" ${bug.priority=='MEDIUM' ? 'selected' : '' }>Medium
                                            </option>
                                            <option value="HIGH" ${bug.priority=='HIGH' ? 'selected' : '' }>High
                                            </option>
                                            <option value="CRITICAL" ${bug.priority=='CRITICAL' ? 'selected' : '' }>
                                                Critical</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-3" id="developerWrapper">
                                        <label class="form-label">Assign To Developer</label>
                                        <select name="assignedTo" class="form-select w-100">
                                            <option value="">-- Select Developer --</option>
                                            <c:forEach var="dev" items="${developers}">
                                                <option value="${dev.userId}" ${bug.assignedTo !=null &&
                                                    bug.assignedTo.userId==dev.userId ? 'selected' : '' }>
                                                    ${dev.firstName} ${dev.lastName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary">Process Triage</button>
                                <a href="${pageContext.request.contextPath}/pm/bugs"
                                    class="btn btn-outline-secondary">Go Back</a>
                            </form>

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
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', () => {
                    const statusSelect = document.getElementById('statusSelect');
                    const devWrapper = document.getElementById('developerWrapper');
                    const priorityWrapper = document.getElementById('priorityWrapper');

                    function toggleFields() {
                        if (statusSelect.value === 'ASSIGNED') {
                            devWrapper.style.display = 'block';
                            devWrapper.querySelector('select').setAttribute('required', 'required');
                        } else {
                            devWrapper.style.display = 'none';
                            devWrapper.querySelector('select').removeAttribute('required');
                            devWrapper.querySelector('select').value = '';
                        }
                    }

                    statusSelect.addEventListener('change', toggleFields);
                    toggleFields();
                });
            </script>
        </body>

        </html>