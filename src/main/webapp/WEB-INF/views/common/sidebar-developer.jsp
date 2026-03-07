<%@ taglib prefix="c" uri="jakarta.tags.core" %>
  <!-- Sidebar Wrapper (Handles both Desktop Column and Mobile Offcanvas) -->
  <nav id="sidebarMenu" class="sidebar col-md-3 col-lg-2 d-md-block offcanvas-md offcanvas-start bg-dark"
    data-bs-theme="dark" tabindex="-1" aria-labelledby="sidebarMenuLabel"
    style="background-color: var(--sidebar-bg) !important;">
    <div class="offcanvas-header pb-0 pb-md-3">
      <div class="brand fs-5 fw-bold" id="sidebarMenuLabel"><i class="bi bi-bug-fill me-2 text-primary"></i>Bug Tracker
      </div>
      <button type="button" class="btn-close btn-close-white d-md-none" data-bs-dismiss="offcanvas" aria-label="Close"
        data-bs-target="#sidebarMenu"></button>
    </div>
    <div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
      <ul class="nav flex-column w-100">
        <li class="nav-item">
          <a class="nav-link ${param.page == 'dashboard' ? 'active' : ''}"
            href="${pageContext.request.contextPath}/developer/dashboard">
            <i class="bi bi-grid-1x2 me-2"></i>Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${param.page == 'my-projects' ? 'active' : ''}"
            href="${pageContext.request.contextPath}/developer/my-projects">
            <i class="bi bi-folder me-2"></i>Projects
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${param.page == 'bugs' ? 'active' : ''}"
            href="${pageContext.request.contextPath}/developer/bugs">
            <i class="bi bi-bug me-2"></i>My Bugs
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${param.page == 'tasks' ? 'active' : ''}"
            href="${pageContext.request.contextPath}/developer/tasks">
            <i class="bi bi-check2-square me-2"></i>My Tasks
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${param.page == 'timelog' ? 'active' : ''}"
            href="${pageContext.request.contextPath}/developer/timelog">
            <i class="bi bi-clock-history me-2"></i>Time Log
          </a>
        </li>
      </ul>
    </div>
  </nav>