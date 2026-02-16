<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="sidebar col-md-3 col-lg-2 d-md-block">
  <div class="brand"><i class="bi bi-bug-fill me-2"></i>Bug Tracker</div>
  <ul class="nav flex-column">
    <li class="nav-item"><a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/tester/dashboard"><i class="bi bi-grid-1x2 me-2"></i>Dashboard</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'report' ? 'active' : ''}" href="${pageContext.request.contextPath}/tester/report-bug"><i class="bi bi-plus-circle me-2"></i>Report Bug</a></li>
    <li class="nav-item"><a class="nav-link ${param.page == 'bugs' ? 'active' : ''}" href="${pageContext.request.contextPath}/tester/bugs"><i class="bi bi-bug me-2"></i>My Bugs</a></li>
  </ul>
</nav>
