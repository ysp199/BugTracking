<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="sidebar col-md-3 col-lg-2 d-md-block">
  <div class="brand"><i class="bi bi-bug-fill me-2"></i>Bug Tracker</div>
  <ul class="nav flex-column">
    <li class="nav-item"><a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-grid-1x2 me-2"></i>Dashboard</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'users' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people me-2"></i>User Management</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'projects' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/projects"><i class="bi bi-folder me-2"></i>Projects</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'bugs' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/bugs"><i class="bi bi-bug me-2"></i>Bug Overview</a></li>
  </ul>
</nav>
