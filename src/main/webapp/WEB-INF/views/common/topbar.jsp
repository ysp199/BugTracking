<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="d-flex justify-content-between align-items-center py-3 px-4 bg-white border-bottom">
  <h5 class="mb-0">${param.title != null ? param.title : 'Dashboard'}</h5>
  <div class="d-flex align-items-center gap-3">
    <c:if test="${sessionScope.user != null}">
      <span class="text-muted small">${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-secondary btn-sm"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
    </c:if>
  </div>
</div>
