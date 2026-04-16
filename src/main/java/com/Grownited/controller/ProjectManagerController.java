package com.Grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Grownited.entity.ModuleEntity;
import com.Grownited.entity.ProjectEntity;
import com.Grownited.entity.RoleEntity;
import com.Grownited.entity.TaskEntity;
import com.Grownited.entity.TimeLogEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.ModuleRepository;
import com.Grownited.repository.ProjectRepository;
import com.Grownited.repository.RoleRepository;
import com.Grownited.repository.TaskRepository;
import com.Grownited.repository.TimeLogRepository;
import com.Grownited.service.UserService;

import com.Grownited.entity.BugEntity;
import com.Grownited.entity.BugHistoryEntity;
import com.Grownited.repository.BugRepository;
import com.Grownited.repository.BugHistoryRepository;

import jakarta.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/pm")
public class ProjectManagerController {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private BugRepository bugRepository;

    @Autowired
    private TimeLogRepository timeLogRepository;

    @Autowired
    private BugHistoryRepository bugHistoryRepository;

    private UserEntity getLoggedInUser(HttpSession session) {
        return (UserEntity) session.getAttribute("loggedInUser");
    }

    // =====================================
    // DASHBOARD
    // =====================================
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> projects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        model.addAttribute("projects", projects);

        return "pm/dashboard";
    }

    // =====================================
    // PROJECTS
    // =====================================
    @GetMapping("/projects")
    public String listProjects(@RequestParam(value = "status", required = false) String status, HttpSession session,
            Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> projects = projectRepository.findByCreatedBy_UserId(user.getUserId());

        if (status != null && !status.isEmpty()) {
            projects = projects.stream()
                    .filter(p -> status.equals(p.getStatus()))
                    .collect(Collectors.toList());
        }

        model.addAttribute("selectedStatus", status);
        model.addAttribute("projects", projects);
        return "pm/projects";
    }

    @GetMapping("/projects/add")
    public String addProject(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        model.addAttribute("project", new ProjectEntity());
        return "pm/add-project";
    }

    @PostMapping("/projects/save")
    public String saveProject(@ModelAttribute ProjectEntity project, HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        if (project.getProjectId() == null) {
            project.setCreatedBy(user);
        } else {
            ProjectEntity existing = projectRepository.findById(project.getProjectId()).orElse(null);
            if (existing != null) {
                project.setCreatedBy(existing.getCreatedBy());
            } else {
                project.setCreatedBy(user);
            }
        }

        projectRepository.save(project);
        return "redirect:/pm/projects";
    }

    @GetMapping("/projects/view/{id}")
    public String viewProjectDetail(@PathVariable("id") Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER"))
            return "redirect:/login";

        ProjectEntity project = projectRepository.findById(id).orElse(null);
        if (project == null)
            return "redirect:/pm/projects";

        List<ModuleEntity> modules = moduleRepository.findByProject_ProjectId(id);
        model.addAttribute("project", project);
        model.addAttribute("modules", modules);
        return "pm/project-details";
    }

    @GetMapping("/projects/status/{id}")
    public String updateProjectStatus(@PathVariable("id") Integer id, @RequestParam("action") String action,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER"))
            return "redirect:/login";

        ProjectEntity project = projectRepository.findById(id).orElse(null);
        if (project != null) {
            project.setStatus(action);
            projectRepository.save(project);
        }
        return "redirect:/pm/projects/view/" + id;
    }

    @GetMapping("/projects/edit/{id}")
    public String editProject(@PathVariable("id") Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        ProjectEntity project = projectRepository.findById(id).orElse(null);
        model.addAttribute("project", project);
        return "pm/edit-project";
    }

    // =====================================
    // MODULES
    // =====================================
    @GetMapping("/modules")
    public String listModules(@RequestParam(value = "projectId", required = false) Integer projectId,
            @RequestParam(value = "status", required = false) String status,
            HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<ModuleEntity> modules;

        if (projectId != null) {
            modules = moduleRepository.findByProject_ProjectId(projectId);
            ProjectEntity selectedProject = projectRepository.findById(projectId).orElse(null);
            model.addAttribute("selectedProject", selectedProject);
        } else {
            if (pmProjects.isEmpty()) {
                modules = List.of();
            } else {
                modules = moduleRepository.findByProjectIn(pmProjects);
            }
        }

        if (status != null && !status.isEmpty()) {
            modules = modules.stream()
                    .filter(m -> status.equals(m.getStatus()))
                    .collect(Collectors.toList());
        }

        model.addAttribute("selectedStatus", status);
        model.addAttribute("projects", pmProjects);
        model.addAttribute("modules", modules);
        return "pm/modules";
    }

    @GetMapping("/modules/add")
    public String addModule(@RequestParam(value = "projectId", required = false) Integer projectId, HttpSession session,
            Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());

        model.addAttribute("module", new ModuleEntity());
        model.addAttribute("projects", pmProjects);
        model.addAttribute("selectedProjectId", projectId);
        return "pm/add-module";
    }

    @PostMapping("/modules/save")
    public String saveModule(@ModelAttribute ModuleEntity module, @RequestParam("projectId") Integer projectId,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        ProjectEntity project = projectRepository.findById(projectId).orElse(null);
        module.setProject(project);
        moduleRepository.save(module);
        return "redirect:/pm/modules";
    }

    @GetMapping("/modules/view/{id}")
    public String viewModuleDetail(@PathVariable("id") Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER"))
            return "redirect:/login";

        ModuleEntity module = moduleRepository.findById(id).orElse(null);
        if (module == null)
            return "redirect:/pm/modules";

        List<TaskEntity> tasks = taskRepository.findByModule_ModuleId(id);
        model.addAttribute("module", module);
        model.addAttribute("tasks", tasks);
        return "pm/module-details";
    }

    @GetMapping("/modules/status/{id}")
    public String updateModuleStatus(@PathVariable("id") Integer id, @RequestParam("action") String action,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER"))
            return "redirect:/login";

        ModuleEntity module = moduleRepository.findById(id).orElse(null);
        if (module != null) {
            module.setStatus(action);
            moduleRepository.save(module);
        }
        return "redirect:/pm/modules/view/" + id;
    }

    // =====================================
    // TASKS
    // =====================================
    @GetMapping("/tasks")
    public String listTasks(@RequestParam(value = "moduleId", required = false) Integer moduleId,
            @RequestParam(value = "status", required = false) String status,
            HttpSession session,
            Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<ModuleEntity> pmModules;
        if (pmProjects.isEmpty()) {
            pmModules = List.of();
        } else {
            pmModules = moduleRepository.findByProjectIn(pmProjects);
        }

        List<TaskEntity> tasks;
        if (moduleId != null) {
            tasks = taskRepository.findByModule_ModuleId(moduleId);
            ModuleEntity selectedModule = moduleRepository.findById(moduleId).orElse(null);
            model.addAttribute("selectedModule", selectedModule);
        } else {
            if (pmModules.isEmpty()) {
                tasks = List.of();
            } else {
                tasks = taskRepository.findByModuleIn(pmModules);
            }
        }

        if (status != null && !status.isEmpty()) {
            tasks = tasks.stream()
                    .filter(t -> status.equals(t.getStatus()))
                    .collect(Collectors.toList());
        }

        model.addAttribute("selectedStatus", status);
        model.addAttribute("modules", pmModules);
        model.addAttribute("tasks", tasks);
        return "pm/tasks";
    }

    @GetMapping("/tasks/add")
    public String addTask(@RequestParam(value = "moduleId", required = false) Integer moduleId, HttpSession session,
            Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<ModuleEntity> pmModules;
        if (pmProjects.isEmpty()) {
            pmModules = List.of();
        } else {
            pmModules = moduleRepository.findByProjectIn(pmProjects);
        }

        RoleEntity devRole = roleRepository.findByRoleName("DEVELOPER").orElse(null);
        List<UserEntity> developers = List.of();
        if (devRole != null) {
            developers = userService.findUsersByRole(devRole.getRoleId());
        }

        model.addAttribute("task", new TaskEntity());
        model.addAttribute("modules", pmModules);
        model.addAttribute("developers", developers);
        model.addAttribute("selectedModuleId", moduleId);
        return "pm/add-task";
    }

    @PostMapping("/tasks/save")
    public String saveTask(@ModelAttribute TaskEntity task,
            @RequestParam("moduleId") Integer moduleId,
            @RequestParam(value = "assignedTo", required = false) Integer assignedToId,
            HttpSession session) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }

        ModuleEntity module = moduleRepository.findById(moduleId).orElse(null);
        task.setModule(module);

        if (assignedToId != null) {
            UserEntity assignee = userService.findById(assignedToId);
            task.setAssignedTo(assignee);
        } else {
            task.setAssignedTo(null);
        }

        taskRepository.save(task);
        return "redirect:/pm/tasks";
    }

    @GetMapping("/tasks/view/{id}")
    public String viewTaskDetail(@PathVariable("id") Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER"))
            return "redirect:/login";

        TaskEntity task = taskRepository.findById(id).orElse(null);
        if (task == null)
            return "redirect:/pm/tasks";

        List<TimeLogEntity> logs = timeLogRepository.findByTask_TaskId(id);
        List<BugEntity> taskBugs = bugRepository.findByTask_TaskId(id);

        if (taskBugs == null)
            taskBugs = List.of();

        model.addAttribute("task", task);
        model.addAttribute("logs", logs);
        model.addAttribute("taskBugs", taskBugs);
        return "pm/task-details";
    }

    @GetMapping("/tasks/status/{id}")
    public String updateTaskStatus(@PathVariable("id") Integer id, @RequestParam("action") String action,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER"))
            return "redirect:/login";

        TaskEntity task = taskRepository.findById(id).orElse(null);
        if (task != null) {
            task.setStatus(action);
            taskRepository.save(task);
        }
        return "redirect:/pm/tasks/view/" + id;
    }

    @GetMapping("/tasks/edit/{id}")
    public String editTask(@PathVariable("id") Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        TaskEntity task = taskRepository.findById(id).orElse(null);
        if (task == null) {
            return "redirect:/pm/tasks";
        }

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<ModuleEntity> pmModules;
        if (pmProjects.isEmpty()) {
            pmModules = List.of();
        } else {
            pmModules = moduleRepository.findByProjectIn(pmProjects);
        }

        RoleEntity devRole = roleRepository.findByRoleName("DEVELOPER").orElse(null);
        List<UserEntity> developers = List.of();
        if (devRole != null) {
            developers = userService.findUsersByRole(devRole.getRoleId());
        }

        model.addAttribute("task", task);
        model.addAttribute("modules", pmModules);
        model.addAttribute("developers", developers);
        return "pm/edit-task";
    }

    @PostMapping("/tasks/edit")
    public String updateTask(@ModelAttribute TaskEntity taskUpdate,
            @RequestParam("moduleId") Integer moduleId,
            @RequestParam(value = "assignedTo", required = false) Integer assignedToId,
            HttpSession session) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }

        TaskEntity existingTask = taskRepository.findById(taskUpdate.getTaskId()).orElse(null);
        if (existingTask == null) {
            return "redirect:/pm/tasks";
        }

        ModuleEntity module = moduleRepository.findById(moduleId).orElse(null);
        existingTask.setModule(module);
        existingTask.setTitle(taskUpdate.getTitle());
        existingTask.setDescription(taskUpdate.getDescription());
        existingTask.setStatus(taskUpdate.getStatus());
        existingTask.setPriority(taskUpdate.getPriority());
        existingTask.setEstimatedHours(taskUpdate.getEstimatedHours());

        if (assignedToId != null) {
            UserEntity assignee = userService.findById(assignedToId);
            existingTask.setAssignedTo(assignee);
        } else {
            existingTask.setAssignedTo(null);
        }

        taskRepository.save(existingTask);
        return "redirect:/pm/tasks?success=Task+Updated";
    }

    // =====================================
    // BUGS
    // =====================================
    @GetMapping("/bugs")
    public String allBugs(@RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "severity", required = false) String severity,
            HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<Integer> pmProjectIds = pmProjects.stream().map(ProjectEntity::getProjectId).collect(Collectors.toList());

        // PM sees bugs only from projects they manage, sorted newest first
        List<BugEntity> pmBugs = bugRepository.findAll().stream()
                .filter(b -> b.getTask() != null
                        && b.getTask().getModule() != null
                        && b.getTask().getModule().getProject() != null
                        && pmProjectIds.contains(b.getTask().getModule().getProject().getProjectId()))
                .sorted(Comparator.comparing(BugEntity::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                .collect(Collectors.toList());

        if (status != null && !status.isEmpty()) {
            pmBugs = pmBugs.stream().filter(b -> status.equals(b.getStatus())).collect(Collectors.toList());
        }
        if (severity != null && !severity.isEmpty()) {
            pmBugs = pmBugs.stream().filter(b -> severity.equals(b.getSeverity())).collect(Collectors.toList());
        }

        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSeverity", severity);
        model.addAttribute("bugs", pmBugs);
        model.addAttribute("page", "bugs");
        return "pm/bugs";
    }

    @GetMapping("/bugs/{id}")
    public String viewBugDetail(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }

        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug == null) {
            return "redirect:/pm/bugs";
        }

        List<BugHistoryEntity> history = bugHistoryRepository.findByBug_BugId(id);

        RoleEntity devRole = roleRepository.findByRoleName("DEVELOPER").orElse(null);
        List<UserEntity> developers = List.of();
        if (devRole != null) {
            developers = userService.findUsersByRole(devRole.getRoleId());
        }

        model.addAttribute("bug", bug);
        model.addAttribute("history", history);
        model.addAttribute("developers", developers);
        model.addAttribute("page", "bugs");
        return "pm/bug-detail";
    }

    @PostMapping("/bugs/{id}/triage")
    public String updateBugTriage(@PathVariable Integer id,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "priority", required = false) String priority,
            @RequestParam(value = "assignedTo", required = false) Integer assignedToId,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug != null) {
            String oldStatus = bug.getStatus();
            boolean changed = false;

            if (status != null && !status.isEmpty()) {
                bug.setStatus(status);
                changed = true;
            }
            if (priority != null && !priority.isEmpty()) {
                bug.setPriority(priority);
            }
            if (assignedToId != null) {
                UserEntity dev = userService.findById(assignedToId);
                bug.setAssignedTo(dev);
            } else if ("ASSIGNED".equals(status)) {
                // Cannot be assigned without a developer selected
                return "redirect:/pm/bugs/" + id + "?error=Must+select+a+developer+to+assign";
            }

            bugRepository.save(bug);

            if (changed) {
                BugHistoryEntity history = new BugHistoryEntity();
                history.setBug(bug);
                history.setOldStatus(oldStatus);
                history.setNewStatus(status);
                history.setChangedBy(user);
                bugHistoryRepository.save(history);
            }
        }

        return "redirect:/pm/bugs?success=Bug+Updated";
    }
}
