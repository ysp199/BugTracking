<%@ taglib prefix="c" uri="jakarta.tags.core" %>

  <div class="d-flex justify-content-between align-items-center py-3 px-4 bg-white border-bottom shadow-sm">

    <!-- LEFT SIDE WITH MOBILE TOGGLE -->
    <div class="d-flex align-items-center gap-3">
      <!-- Offcanvas Toggle Button (visible only on mobile) -->
      <button class="btn btn-outline-secondary d-md-none" type="button" data-bs-toggle="offcanvas"
        data-bs-target="#sidebarMenu" aria-controls="sidebarMenu">
        <i class="bi bi-list"></i>
      </button>

      <!-- PAGE TITLE -->
      <h5 class="mb-0 fw-bold text-dark">
        ${param.title != null ? param.title : 'Dashboard'}
      </h5>
    </div>

    <!-- RIGHT SIDE -->
    <div class="d-flex align-items-center gap-3">

      <c:if test="${sessionScope.loggedInUser != null || sessionScope.user != null}">
        <c:set var="currentUser"
          value="${sessionScope.loggedInUser != null ? sessionScope.loggedInUser : sessionScope.user}" />

        <!-- PROFILE IMAGE (Triggers Modal) -->
        <a href="#" data-bs-toggle="modal" data-bs-target="#profileModal" title="View Profile">
          <img
            src="${not empty currentUser.profilePicURl ? currentUser.profilePicURl : 'https://ui-avatars.com/api/?name=' += currentUser.firstName += '+' += currentUser.lastName += '&background=random'}"
            alt="Profile" class="rounded-circle" style="width:38px;height:38px;object-fit:cover;cursor:pointer;" />
        </a>

        <!-- USER NAME -->
        <span class="text-muted small">
          ${currentUser.firstName} ${currentUser.lastName}
        </span>

        <!-- LOGOUT -->
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-secondary btn-sm">
          <i class="bi bi-box-arrow-right me-1"></i>Logout
        </a>

        <!-- PROFILE MODAL -->
        <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="profileModalLabel">User Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body text-center">
                <img
                  src="${not empty currentUser.profilePicURl ? currentUser.profilePicURl : 'https://ui-avatars.com/api/?name=' += currentUser.firstName += '+' += currentUser.lastName += '&background=random'}"
                  class="rounded-circle mb-3"
                  style="width: 100px; height: 100px; object-fit: cover; border: 2px solid #ddd;" />
                <h5>${currentUser.firstName} ${currentUser.lastName}</h5>
                <p class="text-muted mb-4">${currentUser.email}</p>

                <form action="${pageContext.request.contextPath}/update-profile-pic" method="POST"
                  enctype="multipart/form-data">
                  <div class="mb-3 text-start">
                    <label for="profilePic" class="form-label">Update Profile Picture</label>
                    <input class="form-control" type="file" id="profilePic" name="profilePic" accept="image/*" required>
                  </div>
                  <!-- Optional inputs if you need them -->
                  <button type="submit" class="btn btn-primary w-100">Upload and Save</button>
                </form>
              </div>
            </div>
          </div>
        </div>

      </c:if>

    </div>
  </div>