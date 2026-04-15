package com.Grownited.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Grownited.entity.ProjectEntity;
import com.Grownited.entity.TaskEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.ModuleEntity;
import com.Grownited.repository.BugRepository;
import com.Grownited.repository.ProjectRepository;
import com.Grownited.repository.TaskRepository;
import com.Grownited.repository.ModuleRepository;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/pm/api/charts")
public class PmChartApiController {

    @Autowired
    private BugRepository bugRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository;

    private UserEntity getLoggedInUser(HttpSession session) {
        return (UserEntity) session.getAttribute("loggedInUser");
    }

    @GetMapping("/bugs-by-status")
    public Map<String, Long> getBugsByStatus(HttpSession session) {
        UserEntity user = getLoggedInUser(session);
        if (user == null || !"PROJECT_MANAGER".equals(session.getAttribute("role")))
            return Map.of();

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<Integer> pmProjectIds = pmProjects.stream().map(ProjectEntity::getProjectId).collect(Collectors.toList());

        return bugRepository.findAll().stream()
                .filter(b -> b.getTask() != null
                        && b.getTask().getModule() != null
                        && b.getTask().getModule().getProject() != null
                        && pmProjectIds.contains(b.getTask().getModule().getProject().getProjectId()))
                .collect(Collectors.groupingBy(
                        b -> b.getStatus() != null ? b.getStatus() : "UNKNOWN",
                        Collectors.counting()));
    }

    @GetMapping("/tasks-by-status")
    public Map<String, Long> getTasksByStatus(HttpSession session) {
        UserEntity user = getLoggedInUser(session);
        if (user == null || !"PROJECT_MANAGER".equals(session.getAttribute("role")))
            return Map.of();

        List<ProjectEntity> pmProjects = projectRepository.findByCreatedBy_UserId(user.getUserId());
        List<ModuleEntity> pmModules = pmProjects.isEmpty() ? List.of() : moduleRepository.findByProjectIn(pmProjects);
        List<TaskEntity> tasks = pmModules.isEmpty() ? List.of() : taskRepository.findByModuleIn(pmModules);

        return tasks.stream()
                .collect(Collectors.groupingBy(
                        t -> t.getStatus() != null ? t.getStatus() : "OPEN",
                        Collectors.counting()));
    }

    @GetMapping("/projects-by-status")
    public Map<String, Long> getProjectsByStatus(HttpSession session) {
        UserEntity user = getLoggedInUser(session);
        if (user == null || !"PROJECT_MANAGER".equals(session.getAttribute("role")))
            return Map.of();

        return projectRepository.findByCreatedBy_UserId(user.getUserId()).stream()
                .collect(Collectors.groupingBy(
                        p -> p.getStatus() != null ? p.getStatus() : "UNKNOWN",
                        Collectors.counting()));
    }
}
