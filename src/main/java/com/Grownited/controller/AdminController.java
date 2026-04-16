package com.Grownited.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import com.Grownited.entity.UserEntity;
import com.Grownited.entity.ProjectEntity;
import com.Grownited.entity.BugEntity;
import com.Grownited.entity.BugHistoryEntity;
import com.Grownited.repository.BugHistoryRepository;
import com.Grownited.repository.ProjectRepository;
import com.Grownited.repository.BugRepository;
import com.Grownited.repository.TaskRepository;
import com.Grownited.repository.ModuleRepository;
import com.Grownited.repository.TimeLogRepository;
import com.Grownited.entity.TimeLogEntity;
import com.Grownited.entity.ModuleEntity;
import com.Grownited.entity.TaskEntity;
import com.Grownited.service.RoleService;
import com.Grownited.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private BugRepository bugRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private TimeLogRepository timeLogRepository;

    @Autowired
    private BugHistoryRepository bugHistoryRepository;

    /*
     * =========================
     * LIST ALL USERS
     * =========================
     */
    @GetMapping("users")
    public String listUsers(
            @RequestParam(required = false) Integer roleId,
            @RequestParam(required = false) Integer projectId,
            HttpSession session,
            Model model) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<UserEntity> users;

        boolean hasRole = roleId != null;
        boolean hasProject = projectId != null;

        if (hasRole && hasProject) {
            users = userService.findUsersByRoleAndProject(roleId, projectId);
        } else if (hasRole) {
            users = userService.findUsersByRole(roleId);
        } else if (hasProject) {
            users = userService.findUsersByProject(projectId);
        } else {
            users = userService.findAllUsers();
        }

        for (UserEntity u : users) {
            u.setRoleName(userService.getUserRoleName(u.getUserId()));
        }

        model.addAttribute("users", users);
        model.addAttribute("roles", roleService.findAssignableRoles());
        model.addAttribute("projects", projectRepository.findAll());
        model.addAttribute("selectedRoleId", roleId);
        model.addAttribute("selectedProjectId", projectId);

        return "admin/users";
    }

    /*
     * =========================
     * SHOW ADD USER FORM
     * =========================
     */
    @GetMapping("users/add")
    public String showAddUserForm(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        model.addAttribute("user", new UserEntity());
        model.addAttribute("roles", roleService.findAssignableRoles());
        return "admin/add-user";
    }

    /*
     * =========================
     * SAVE USER (CREATE / UPDATE)
     * =========================
     */
    @PostMapping("users/save")
    public String saveUser(@ModelAttribute UserEntity user,
            @RequestParam Integer roleId, HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        UserEntity existingUser = null;

        // 🔎 CHECK IF EDIT MODE
        if (user.getUserId() != null) {
            existingUser = userService.findById(user.getUserId());
        }

        // ✅ PASSWORD HANDLING
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            // keep old password on edit
            if (existingUser != null) {
                user.setPassword(existingUser.getPassword());
            }
        } else {
            // hash new password
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        if (existingUser != null) {
            user.setCreatedAt(existingUser.getCreatedAt());
            user.setActive(existingUser.getActive());
            user.setProfilePicURl(existingUser.getProfilePicURl());
            user.setOtp(existingUser.getOtp());
        } else {
            user.setActive(true);
            user.setCreatedAt(LocalDate.now());
        }

        userService.saveUser(user);
        userService.assignRole(user.getUserId(), roleId);

        return "redirect:/admin/users";
    }

    /*
     * =========================
     * SHOW EDIT USER FORM
     * =========================
     */
    @GetMapping("users/edit/{id}")
    public String editUser(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        UserEntity user = userService.findById(id);

        // Get current role id
        Integer currentRoleId = userService.getUserRoleId(id);

        model.addAttribute("user", user);
        model.addAttribute("roles", roleService.findAssignableRoles());
        model.addAttribute("currentRoleId", currentRoleId);

        return "admin/edit-user";
    }

    /*
     * =========================
     * DEACTIVATE USER
     * =========================
     */
    @GetMapping("users/deactivate/{id}")
    public String deactivateUser(@PathVariable("id") Integer userId, HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        userService.deactivateUser(userId);
        return "redirect:/admin/users";
    }

    /*
     * =========================
     * ACTIVATE USER
     * =========================
     */
    @GetMapping("users/activate/{id}")
    public String activateUser(@PathVariable("id") Integer userId, HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        userService.activateUser(userId);
        return "redirect:/admin/users";
    }

    @GetMapping("dashboard")
    public String dashboard(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<UserEntity> users = userService.findAllUsers();
        List<ProjectEntity> projects = projectRepository.findAll();
        List<BugEntity> bugs = bugRepository.findAll();

        long openBugs = bugs.stream()
                .filter(b -> !"CLOSED".equalsIgnoreCase(b.getStatus())
                        && !"RESOLVED".equalsIgnoreCase(b.getStatus())
                        && !"FIXED".equalsIgnoreCase(b.getStatus())
                        && !"VERIFIED".equalsIgnoreCase(b.getStatus()))
                .count();
        long closedBugs = bugs.size() - openBugs;

        model.addAttribute("totalUsers", users.size());
        model.addAttribute("usersList", users);
        model.addAttribute("projectsList", projects);
        model.addAttribute("totalProjects", projects.size());
        model.addAttribute("openBugs", openBugs);
        model.addAttribute("closedBugs", closedBugs);
        model.addAttribute("recentBugs", bugs.stream().limit(10).toList());

        return "admin/dashboard";
    }

    @GetMapping("users/toggle-active/{id}")
    public String toggleUserStatus(@PathVariable Integer id, HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        UserEntity user = userService.findById(id);

        if (user != null) {
            user.setActive(!user.getActive()); // toggle
            userService.saveUser(user);
        }

        return "redirect:/admin/users";
    }

    // DELETE USER

    @GetMapping("users/delete/{id}")
    public String deleteUser(@PathVariable Integer id, Model model, HttpSession session,
            RedirectAttributes redirectAttributes) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        try {
            userService.deleteUserById(id);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } catch (RuntimeException e) {
            if ("ADMIN_DELETE_NOT_ALLOWED".equals(e.getMessage())) {
                redirectAttributes.addFlashAttribute(
                        "error",
                        "Admin user cannot be deleted");
            } else {
                redirectAttributes.addFlashAttribute(
                        "error",
                        "Unable to delete user");
            }
        }

        return "redirect:/admin/users";
    }

    // VIEW USER DETAILS
    @GetMapping("users/view/{id}")
    public String viewUser(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        UserEntity user = userService.findById(id);
        String roleName = userService.getUserRoleName(id);

        model.addAttribute("user", user);
        model.addAttribute("roleName", roleName);

        return "admin/view-user";
    }

    @GetMapping("all-projects")
    public String showProjects(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Integer createdById,
            HttpSession session,
            Model model) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<ProjectEntity> projects = projectRepository.findMultiFilter(status, createdById);

        model.addAttribute("projects", projects);
        model.addAttribute("creators", userService.findAllUsers());
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedCreatorId", createdById);
        model.addAttribute("page", "projects");
        return "admin/projects";
    }

    @GetMapping("projects/add")
    public String addProject(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<UserEntity> pmUsers = userService.findAllUsers().stream()
                .filter(u -> "PROJECT_MANAGER".equalsIgnoreCase(userService.getUserRoleName(u.getUserId())))
                .toList();

        model.addAttribute("project", new ProjectEntity());
        model.addAttribute("pmUsers", pmUsers);
        model.addAttribute("page", "projects");
        return "admin/add-project";
    }

    @PostMapping("projects/save")
    public String saveProject(@ModelAttribute ProjectEntity project, @RequestParam("createdById") Integer createdById,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        UserEntity pm = userService.findById(createdById);
        project.setCreatedBy(pm);
        projectRepository.save(project);

        return "redirect:/admin/all-projects";
    }

    @GetMapping("projects/status/{id}")
    public String changeProjectStatus(@PathVariable Integer id, @RequestParam("action") String action,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        ProjectEntity project = projectRepository.findById(id).orElse(null);
        if (project != null && action != null && !action.isEmpty()) {
            project.setStatus(action.toUpperCase());
            projectRepository.save(project);
        }
        return "redirect:/admin/all-projects";
    }

    @GetMapping("bugs")
    public String showBugs(
            @RequestParam(required = false) String severity,
            @RequestParam(required = false) String priority,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Integer assignedToId,
            HttpSession session,
            Model model) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<BugEntity> bugs = bugRepository.findMultiFilter(priority, severity, status, assignedToId);

        model.addAttribute("bugs", bugs);
        // Filter for users who are actually developers
        List<UserEntity> developers = userService.findAllUsers().stream()
                .filter(u -> "DEVELOPER".equalsIgnoreCase(userService.getUserRoleName(u.getUserId())))
                .toList();
        model.addAttribute("developers", developers);
        model.addAttribute("selectedSeverity", severity);
        model.addAttribute("selectedPriority", priority);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedAssignedToId", assignedToId);
        model.addAttribute("page", "bugs");
        return "admin/bugs";
    }

    @GetMapping("closed-bugs")
    public String showClosedBugs(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<BugEntity> bugs = bugRepository.findAll().stream()
                .filter(b -> "CLOSED".equalsIgnoreCase(b.getStatus())
                        || "RESOLVED".equalsIgnoreCase(b.getStatus())
                        || "FIXED".equalsIgnoreCase(b.getStatus())
                        || "VERIFIED".equalsIgnoreCase(b.getStatus()))
                .toList();

        model.addAttribute("bugs", bugs);
        model.addAttribute("page", "bugs"); // Keep 'bugs' highlighted in sidebar
        return "admin/closed-bugs";
    }

    @GetMapping("modules")
    public String showModules(
            @RequestParam(required = false) Integer projectId,
            HttpSession session,
            Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<ModuleEntity> modules;
        if (projectId != null && projectId > 0) {
            modules = moduleRepository.findByProject_ProjectId(projectId);
        } else {
            modules = moduleRepository.findAll();
        }

        model.addAttribute("modules", modules);
        model.addAttribute("projects", projectRepository.findAll());
        model.addAttribute("selectedProjectId", projectId);
        model.addAttribute("page", "modules");
        return "admin/modules";
    }

    @GetMapping("modules/add")
    public String addModule(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN"))
            return "redirect:/login";

        model.addAttribute("module", new ModuleEntity());
        model.addAttribute("projects", projectRepository.findAll());
        model.addAttribute("page", "modules");
        return "admin/add-module";
    }

    @PostMapping("modules/save")
    public String saveModule(@ModelAttribute ModuleEntity module, @RequestParam("projectId") Integer projectId,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN"))
            return "redirect:/login";

        ProjectEntity project = projectRepository.findById(projectId).orElse(null);
        module.setProject(project);
        moduleRepository.save(module);

        return "redirect:/admin/modules";
    }

    @GetMapping("modules/status/{id}")
    public String changeModuleStatus(@PathVariable Integer id, @RequestParam("action") String action,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN"))
            return "redirect:/login";

        ModuleEntity module = moduleRepository.findById(id).orElse(null);
        if (module != null && action != null && !action.isEmpty()) {
            module.setStatus(action.toUpperCase());
            moduleRepository.save(module);
        }
        return "redirect:/admin/modules";
    }

    @GetMapping("tasks")
    public String showTasks(
            @RequestParam(required = false) Integer moduleId,
            HttpSession session,
            Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<TaskEntity> tasks;
        if (moduleId != null && moduleId > 0) {
            tasks = taskRepository.findByModule_ModuleId(moduleId);
        } else {
            tasks = taskRepository.findAll();
        }

        model.addAttribute("tasks", tasks);
        model.addAttribute("modules", moduleRepository.findAll());
        model.addAttribute("selectedModuleId", moduleId);
        model.addAttribute("page", "tasks");
        return "admin/tasks";
    }

    @GetMapping("tasks/add")
    public String addTask(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN"))
            return "redirect:/login";

        List<UserEntity> developers = userService.findAllUsers().stream()
                .filter(u -> "DEVELOPER".equalsIgnoreCase(userService.getUserRoleName(u.getUserId())))
                .toList();

        model.addAttribute("task", new TaskEntity());
        model.addAttribute("modules", moduleRepository.findAll());
        model.addAttribute("developers", developers);
        model.addAttribute("page", "tasks");
        return "admin/add-task";
    }

    @PostMapping("tasks/save")
    public String saveTask(@ModelAttribute TaskEntity task,
            @RequestParam("moduleId") Integer moduleId,
            @RequestParam(value = "assignedToId", required = false) Integer assignedToId,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN"))
            return "redirect:/login";

        ModuleEntity module = moduleRepository.findById(moduleId).orElse(null);
        task.setModule(module);

        if (assignedToId != null) {
            UserEntity dev = userService.findById(assignedToId);
            task.setAssignedTo(dev);
        }

        if (task.getStatus() == null || task.getStatus().isEmpty()) {
            task.setStatus("NEW");
        }

        taskRepository.save(task);
        return "redirect:/admin/tasks";
    }

    @GetMapping("tasks/status/{id}")
    public String changeTaskStatus(@PathVariable Integer id, @RequestParam("action") String action,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN"))
            return "redirect:/login";

        TaskEntity task = taskRepository.findById(id).orElse(null);
        if (task != null && action != null && !action.isEmpty()) {
            task.setStatus(action.toUpperCase());
            taskRepository.save(task);
        }
        return "redirect:/admin/tasks";
    }

    @GetMapping("timelogs")
    public String showTimeLogs(
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) Integer taskId,
            HttpSession session,
            Model model) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        List<TimeLogEntity> logs = timeLogRepository.findAll();

        if (userId != null) {
            logs = logs.stream().filter(l -> l.getUser() != null && l.getUser().getUserId().equals(userId)).toList();
        }
        if (taskId != null) {
            logs = logs.stream().filter(l -> l.getTask() != null && l.getTask().getTaskId().equals(taskId)).toList();
        }

        model.addAttribute("logs", logs);
        model.addAttribute("users", userService.findAllUsers());
        model.addAttribute("tasks", taskRepository.findAll());
        model.addAttribute("selectedUserId", userId);
        model.addAttribute("selectedTaskId", taskId);
        model.addAttribute("page", "timelogs");
        return "admin/timelogs";
    }

    @GetMapping("projects/view/{id}")
    public String viewProjectDetails(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }
        ProjectEntity project = projectRepository.findById(id).orElse(null);
        if (project == null) {
            return "redirect:/admin/all-projects";
        }
        List<ModuleEntity> modules = moduleRepository.findByProject_ProjectId(id);

        List<TaskEntity> tasks = new java.util.ArrayList<>();
        if (modules != null && !modules.isEmpty()) {
            tasks = taskRepository.findByModuleIn(modules);
        }

        List<UserEntity> users = userService.findUsersByProject(id);
        for (UserEntity u : users) {
            u.setRoleName(userService.getUserRoleName(u.getUserId()));
        }

        model.addAttribute("project", project);
        model.addAttribute("modules", modules);
        model.addAttribute("tasks", tasks);
        model.addAttribute("users", users);
        model.addAttribute("page", "projects");
        return "admin/project-details";
    }

    @GetMapping("modules/view/{id}")
    public String viewModuleDetails(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }
        ModuleEntity module = moduleRepository.findById(id).orElse(null);
        if (module == null) {
            return "redirect:/admin/modules";
        }
        List<TaskEntity> tasks = taskRepository.findByModule_ModuleId(id);
        model.addAttribute("module", module);
        model.addAttribute("tasks", tasks);
        model.addAttribute("page", "modules");
        return "admin/module-details";
    }

    @GetMapping("tasks/view/{id}")
    public String viewTaskDetails(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }
        TaskEntity task = taskRepository.findById(id).orElse(null);
        if (task == null) {
            return "redirect:/admin/tasks";
        }
        List<TimeLogEntity> logs = timeLogRepository.findAll().stream()
                .filter(l -> l.getTask() != null && l.getTask().getTaskId().equals(id))
                .toList();
        model.addAttribute("task", task);
        model.addAttribute("logs", logs);
        model.addAttribute("page", "tasks");
        return "admin/task-details";
    }

    @GetMapping("bugs/view/{id}")
    public String viewBugDetails(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("ADMIN")) {
            return "redirect:/login";
        }
        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug == null) {
            return "redirect:/admin/bugs";
        }
        List<BugHistoryEntity> history = bugHistoryRepository.findByBug_BugId(id);

        model.addAttribute("bug", bug);
        model.addAttribute("history", history);
        model.addAttribute("page", "bugs");
        return "admin/bug-details";
    }

}
