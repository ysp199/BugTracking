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
                        <jsp:param name="page" value="tasks" />
                    </jsp:include>
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">
                        <jsp:include page="../common/topbar.jsp">
                            <jsp:param name="title" value="New Task" />
                        </jsp:include>
                        <div class="table-card mt-3 p-4" style="max-width: 600px;">
                            <form action="${pageContext.request.contextPath}/admin/tasks/save" method="post">
                                <div class="mb-3">
                                    <label class="form-label text-danger fw-bold">Select Module</label>
                                    <select name="moduleId" class="form-select" required>
                                        <option value="" disabled selected>Choose a Module...</option>
                                        <c:forEach items="${modules}" var="m">
                                            <option value="${m.moduleId}" ${selectedModuleId==m.moduleId ? 'selected'
                                                : '' }>${m.moduleName} (Project: ${m.project.projectName})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Task Title</label>
                                    <input type="text" name="title" class="form-control" required value="${task.title}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea name="description" class="form-control"
                                        rows="3">${task.description}</textarea>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Status</label>
                                        <select name="status" class="form-select">
                                            <option value="NEW" ${task.status=='NEW' ? 'selected' : '' }>New</option>
                                            <option value="IN_PROGRESS" ${task.status=='IN_PROGRESS' ? 'selected' : ''
                                                }>In Progress</option>
                                            <option value="COMPLETED" ${task.status=='COMPLETED' ? 'selected' : '' }>
                                                Completed</option>
                                            <option value="ON_HOLD" ${task.status=='ON_HOLD' ? 'selected' : '' }>On Hold
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Priority</label>
                                        <select name="priority" class="form-select">
                                            <option value="LOW" ${task.priority=='LOW' ? 'selected' : '' }>Low</option>
                                            <option value="MEDIUM" ${task.priority=='MEDIUM' ? 'selected' : '' }>Medium
                                            </option>
                                            <option value="HIGH" ${task.priority=='HIGH' ? 'selected' : '' }>High
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Estimated Hours</label>
                                        <input type="number" name="estimatedHours" class="form-control"
                                            value="${task.estimatedHours}">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label text-primary fw-bold">Assign To Developer</label>
                                        <select name="assignedToId" class="form-select">
                                            <option value="">Unassigned</option>
                                            <c:forEach items="${developers}" var="dev">
                                                <option value="${dev.userId}" ${task.assignedTo !=null &&
                                                    task.assignedTo.userId==dev.userId ? 'selected' : '' }>
                                                    ${dev.firstName} ${dev.lastName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary">Save Task</button>
                                <a href="${pageContext.request.contextPath}/admin/tasks"
                                    class="btn btn-outline-secondary">Cancel</a>
                            </form>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>