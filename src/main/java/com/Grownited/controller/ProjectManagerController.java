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
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.ModuleRepository;
import com.Grownited.repository.ProjectRepository;
import com.Grownited.repository.RoleRepository;
import com.Grownited.repository.TaskRepository;
import com.Grownited.service.UserService;

import jakarta.servlet.http.HttpSession;

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
    public String listProjects(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("PROJECT_MANAGER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        List<ProjectEntity> projects = projectRepository.findByCreatedBy_UserId(user.getUserId());
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

    // =====================================
    // TASKS
    // =====================================
    @GetMapping("/tasks")
    public String listTasks(@RequestParam(value = "moduleId", required = false) Integer moduleId, HttpSession session,
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
}
