<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="sidebar col-md-3 col-lg-2 d-md-block">
  <div class="brand"><i class="bi bi-bug-fill me-2"></i>Bug Tracker</div>
  <ul class="nav flex-column">
    <li class="nav-item"><a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/developer/dashboard"><i class="bi bi-grid-1x2 me-2"></i>Dashboard</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'bugs' ? 'active' : ''}" href="${pageContext.request.contextPath}/developer/bugs"><i class="bi bi-bug me-2"></i>My Bugs</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'tasks' ? 'active' : ''}" href="${pageContext.request.contextPath}/developer/tasks"><i class="bi bi-check2-square me-2"></i>My Tasks</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'timelog' ? 'active' : ''}" href="${pageContext.request.contextPath}/developer/timelog"><i class="bi bi-clock-history me-2"></i>Time Log</a></li>
  </ul>
</nav>
