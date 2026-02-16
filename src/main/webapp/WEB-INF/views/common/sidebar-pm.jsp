<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="sidebar col-md-3 col-lg-2 d-md-block">
  <div class="brand"><i class="bi bi-bug-fill me-2"></i>Bug Tracker</div>
  <ul class="nav flex-column">
    <li class="nav-item"><a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/pm/dashboard"><i class="bi bi-grid-1x2 me-2"></i>Dashboard</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'projects' ? 'active' : ''}" href="${pageContext.request.contextPath}/pm/projects"><i class="bi bi-folder me-2"></i>Projects</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'modules' ? 'active' : ''}" href="${pageContext.request.contextPath}/pm/modules"><i class="bi bi-collection me-2"></i>Modules</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'tasks' ? 'active' : ''}" href="${pageContext.request.contextPath}/pm/tasks"><i class="bi bi-check2-square me-2"></i>Tasks</a></li>
  </ul>
</nav>
