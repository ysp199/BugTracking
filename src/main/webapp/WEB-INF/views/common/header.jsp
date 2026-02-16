<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${pageTitle != null ? pageTitle : 'Bug Tracker'}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,400;0,9..40,500;0,9..40,600;0,9..40,700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
:root {
  --bs-primary: #0d6efd;
  --sidebar-bg: #1a1d24;
  --sidebar-hover: #252932;
  --content-bg: #f4f6f9;
  --card-shadow: 0 1px 3px rgba(0,0,0,.08);
}
body { font-family: 'DM Sans', sans-serif; background: var(--content-bg); }
.sidebar { background: var(--sidebar-bg); min-height: 100vh; }
.sidebar .nav-link { color: rgba(255,255,255,.8); padding: .6rem 1rem; }
.sidebar .nav-link:hover { background: var(--sidebar-hover); color: #fff; }
.sidebar .nav-link.active { background: rgba(13,110,253,.2); color: #fff; }
.sidebar .brand { padding: 1rem; color: #fff; font-weight: 600; font-size: 1.1rem; }
.stat-card { background: #fff; border-radius: 12px; box-shadow: var(--card-shadow); padding: 1.25rem; }
.stat-card h3 { font-size: 1.75rem; font-weight: 600; margin: 0; }
.stat-card p { margin: .25rem 0 0; color: #6c757d; font-size: .9rem; }
.table-card { background: #fff; border-radius: 12px; box-shadow: var(--card-shadow); overflow: hidden; }
</style>
