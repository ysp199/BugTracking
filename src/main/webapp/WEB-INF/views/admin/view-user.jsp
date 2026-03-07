<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../common/header.jsp"/>
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <jsp:include page="../common/sidebar-admin.jsp">
            <jsp:param name="page" value="users"/>
        </jsp:include>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-4 py-3">

            <jsp:include page="../common/topbar.jsp">
                <jsp:param name="title" value="View User"/>
            </jsp:include>

            <div class="card shadow-sm mt-3">
                <div class="card-header">
                    <h6 class="mb-0">User Details</h6>
                </div>

                <div class="card-body">
                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">User ID</div>
                        <div class="col-md-8">${user.userId}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Name</div>
                        <div class="col-md-8">${user.firstName} ${user.lastName}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Email</div>
                        <div class="col-md-8">${user.email}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Gender</div>
                        <div class="col-md-8">${user.gender}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Contact Number</div>
                        <div class="col-md-8">${user.contactNum}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Birth Year</div>
                        <div class="col-md-8">${user.birthYear}</div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Role</div>
                        <div class="col-md-8">
                            <span class="badge bg-info">${roleName}</span>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Status</div>
                        <div class="col-md-8">
                            <span class="badge bg-${user.active ? 'success' : 'secondary'}">
                                ${user.active ? 'Active' : 'Inactive'}
                            </span>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Created At</div>
                        <div class="col-md-8">${user.createdAt}</div>
                    </div>
                </div>

                <div class="card-footer text-end">
                    <a href="${pageContext.request.contextPath}/admin/users"
                       class="btn btn-secondary btn-sm">
                        Back
                    </a>
                </div>
            </div>

        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>