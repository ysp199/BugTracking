package com.Grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.BugRepository;
import com.Grownited.repository.TaskRepository;
import com.Grownited.repository.ProjectRepository;
import com.Grownited.entity.ProjectEntity;
import com.Grownited.entity.ModuleEntity;
import com.Grownited.entity.TimeLogEntity;
import com.Grownited.repository.ModuleRepository;
import com.Grownited.repository.TimeLogRepository;
import com.Grownited.repository.BugHistoryRepository;
import com.Grownited.entity.BugHistoryEntity;
import com.Grownited.entity.BugEntity;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/developer")
public class DeveloperController {

    @Autowired
    private BugRepository bugRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private TimeLogRepository timeLogRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    @Autowired
    private BugHistoryRepository bugHistoryRepository;

    private UserEntity getLoggedInUser(HttpSession session) {
        return (UserEntity) session.getAttribute("loggedInUser");
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        long assignedBugs = bugRepository.findAll().stream()
                .filter(b -> b.getAssignedTo() != null && b.getAssignedTo().getUserId().equals(user.getUserId()))
                .count();

        long assignedTasks = taskRepository.findAll().stream()
                .filter(t -> t.getAssignedTo() != null && t.getAssignedTo().getUserId().equals(user.getUserId()))
                .count();

        model.addAttribute("assignedBugs", assignedBugs);
        model.addAttribute("assignedTasks", assignedTasks);
        model.addAttribute("page", "dashboard");

        return "developer/dashboard";
    }

    @GetMapping("/my-projects")
    public String myProjects(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        // Collect unique projects from tasks assigned to this developer
        List<ProjectEntity> developerProjects = taskRepository.findAll().stream()
                .filter(t -> t.getAssignedTo() != null && t.getAssignedTo().getUserId().equals(user.getUserId()))
                .map(t -> t.getModule() != null ? t.getModule().getProject() : null)
                .filter(p -> p != null)
                .distinct()
                .collect(Collectors.toList());

        model.addAttribute("projects", developerProjects);
        model.addAttribute("page", "my-projects");
        return "developer/my-projects";
    }

    @GetMapping("/my-projects/{id}")
    public String viewProjectDetails(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        ProjectEntity project = projectRepository.findById(id).orElse(null);
        if (project == null) {
            return "redirect:/developer/my-projects";
        }

        // Only show modules related to this project
        List<ModuleEntity> modules = moduleRepository.findByProject_ProjectId(id);

        model.addAttribute("project", project);
        model.addAttribute("modules", modules);
        model.addAttribute("page", "my-projects");
        return "developer/project-details";
    }

    @GetMapping("/bugs")
    public String bugs(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        var myBugs = bugRepository.findAll().stream()
                .filter(b -> (b.getAssignedTo() != null && b.getAssignedTo().getUserId().equals(user.getUserId()))
                        || (b.getReportedBy() != null && b.getReportedBy().getUserId().equals(user.getUserId())))
                .collect(Collectors.toList());

        model.addAttribute("bugs", myBugs);
        model.addAttribute("page", "bugs");
        return "developer/bugs";
    }

    @GetMapping("/bugs/{id}")
    public String viewBugDetail(@PathVariable Integer id, HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug == null) {
            return "redirect:/developer/bugs";
        }

        List<BugHistoryEntity> history = bugHistoryRepository.findByBug_BugId(id);

        model.addAttribute("bug", bug);
        model.addAttribute("history", history);
        model.addAttribute("page", "bugs");
        return "developer/bug-detail";
    }

    @PostMapping("/bugs/{id}/status")
    public String updateBugStatus(@PathVariable Integer id, @RequestParam("status") String status,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        BugEntity bug = bugRepository.findById(id).orElse(null);
        if (bug != null) {
            String oldStatus = bug.getStatus();
            bug.setStatus(status);
            bugRepository.save(bug);

            // Record History
            BugHistoryEntity history = new BugHistoryEntity();
            history.setBug(bug);
            history.setOldStatus(oldStatus);
            history.setNewStatus(status);
            history.setChangedBy(user);
            bugHistoryRepository.save(history);
        }

        return "redirect:/developer/bugs?success=Status+Updated";
    }

    @GetMapping("/bugs/add")
    public String showAddBug(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        // Developer can only link bugs to tasks assigned to them
        var myTasks = taskRepository.findAll().stream()
                .filter(t -> t.getAssignedTo() != null && t.getAssignedTo().getUserId().equals(user.getUserId()))
                .collect(Collectors.toList());

        model.addAttribute("tasks", myTasks);
        model.addAttribute("page", "bugs");
        return "developer/add-bug";
    }

    @PostMapping("/bugs/save")
    public String saveBug(@ModelAttribute com.Grownited.entity.BugEntity bug,
            @RequestParam("taskId") Integer taskId,
            HttpSession session) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        var task = taskRepository.findById(taskId).orElse(null);
        bug.setTask(task);
        bug.setReportedBy(user);
        bug.setStatus("OPEN");
        // AssignedTo can be left null initially or assigned to PM/Tester etc., we leave
        // it null for picking up or assign back to dev.
        bugRepository.save(bug);

        return "redirect:/developer/bugs?success=Bug+Reported+Successfully";
    }

    @GetMapping("/tasks")
    public String tasks(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        var myTasks = taskRepository.findAll().stream()
                .filter(t -> t.getAssignedTo() != null && t.getAssignedTo().getUserId().equals(user.getUserId()))
                .collect(Collectors.toList());

        model.addAttribute("tasks", myTasks);
        model.addAttribute("page", "tasks");
        return "developer/tasks";
    }

    @GetMapping("/timelog")
    public String timelog(HttpSession session, Model model) {
        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        var myTasks = taskRepository.findAll().stream()
                .filter(t -> t.getAssignedTo() != null && t.getAssignedTo().getUserId().equals(user.getUserId()))
                .collect(Collectors.toList());

        var myLogs = timeLogRepository.findAll().stream()
                .filter(l -> l.getUser() != null && l.getUser().getUserId().equals(user.getUserId()))
                .collect(Collectors.toList());

        model.addAttribute("tasks", myTasks);
        model.addAttribute("logs", myLogs);
        model.addAttribute("page", "timelog");
        return "developer/timelog";
    }

    @PostMapping("/timelog/save")
    public String saveTimelog(@ModelAttribute TimeLogEntity timeLog,
            @RequestParam("taskId") Integer taskId,
            HttpSession session) {

        String sessionRole = (String) session.getAttribute("role");
        if (sessionRole == null || !sessionRole.equals("DEVELOPER")) {
            return "redirect:/login";
        }
        UserEntity user = getLoggedInUser(session);
        if (user == null)
            return "redirect:/login";

        var task = taskRepository.findById(taskId).orElse(null);
        timeLog.setTask(task);
        timeLog.setUser(user);
        timeLogRepository.save(timeLog);

        return "redirect:/developer/timelog?success=Time+logged+successfully";
    }
}