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
                        <jsp:param name="page" value="bugs" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="Report New Bug" />
                        </jsp:include>

                        <div class="card shadow-sm border-0 mt-4 rounded-4">
                            <div class="card-header bg-white border-bottom p-3">
                                <h6 class="mb-0 fw-bold"><i class="bi bi-bug text-primary me-2"></i>Bug Details</h6>
                            </div>
                            <div class="card-body p-4">
                                <form action="${pageContext.request.contextPath}/developer/bugs/save" method="POST"
                                    enctype="multipart/form-data">
                                    <div class="row g-3">
                                        <div class="col-md-12">
                                            <label class="form-label fw-bold">Bug Title <span
                                                    class="text-danger">*</span></label>
                                            <input type="text" name="title" class="form-control rounded-pill px-3"
                                                required placeholder="Short descriptive title">
                                        </div>

                                        <div class="col-md-12">
                                            <label class="form-label fw-bold">Description <span
                                                    class="text-danger">*</span></label>
                                            <textarea name="description" class="form-control" rows="4" required
                                                placeholder="Provide detailed steps to reproduce the bug"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Attachment (Optional)</label>
                                            <input type="file" name="file" class="form-control">
                                            <div class="form-text">You can optionally upload a screenshot or log file.
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Related Task <span
                                                    class="text-danger">*</span></label>
                                            <select name="taskId" class="form-select rounded-pill px-3" required>
                                                <option value="" disabled selected>Select an assigned task</option>
                                                <c:forEach var="t" items="${tasks}">
                                                    <option value="${t.taskId}">${t.title} (Project:
                                                        ${t.module.project.projectName})</option>
                                                </c:forEach>
                                            </select>
                                            <small class="text-muted">Only tasks assigned to you are shown.</small>
                                        </div>

                                        <div class="col-md-3">
                                            <label class="form-label fw-bold">Severity</label>
                                            <select name="severity" class="form-select rounded-pill px-3">
                                                <option value="LOW">Low</option>
                                                <option value="MEDIUM" selected>Medium</option>
                                                <option value="HIGH">High</option>
                                                <option value="CRITICAL">Critical</option>
                                            </select>
                                        </div>

                                        <div class="col-md-3">
                                            <label class="form-label fw-bold">Priority</label>
                                            <select name="priority" class="form-select rounded-pill px-3">
                                                <option value="LOW">Low</option>
                                                <option value="MEDIUM" selected>Medium</option>
                                                <option value="HIGH">High</option>
                                            </select>
                                        </div>

                                        <div class="col-12 mt-4 pt-2">
                                            <button type="submit" class="btn btn-primary rounded-pill px-4 me-2">
                                                <i class="bi bi-check2-circle me-1"></i>Report Bug
                                            </button>
                                            <a href="${pageContext.request.contextPath}/developer/bugs"
                                                class="btn btn-outline-secondary rounded-pill px-4">
                                                Cancel
                                            </a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>