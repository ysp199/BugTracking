package com.Grownited.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Grownited.entity.BugEntity;
import com.Grownited.repository.BugRepository;
import com.Grownited.repository.ProjectRepository;
import com.Grownited.service.UserService;

@RestController
@RequestMapping("/admin/api/charts")
public class ChartApiController {

    @Autowired
    private BugRepository bugRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private UserService userService;

    @GetMapping("/bugs-by-status")
    public Map<String, Long> getBugsByStatus(@RequestParam(required = false) Integer projectId) {
        List<BugEntity> allBugs = bugRepository.findAll();

        if (projectId != null && projectId > 0) {
            allBugs = allBugs.stream()
                    .filter(b -> b.getTask() != null
                            && b.getTask().getModule() != null
                            && b.getTask().getModule().getProject() != null
                            && b.getTask().getModule().getProject().getProjectId().equals(projectId))
                    .collect(Collectors.toList());
        }

        return allBugs.stream()
                .collect(Collectors.groupingBy(
                        b -> b.getStatus() != null ? b.getStatus() : "UNKNOWN",
                        Collectors.counting()));
    }

    @GetMapping("/projects-by-status")
    public Map<String, Long> getProjectsByStatus() {
        return projectRepository.findAll().stream()
                .collect(Collectors.groupingBy(
                        p -> p.getStatus() != null ? p.getStatus() : "UNKNOWN",
                        Collectors.counting()));
    }

    @GetMapping("/users-by-role")
    public Map<String, Long> getUsersByRole() {
        return userService.findAllUsers().stream()
                .collect(Collectors.groupingBy(
                        u -> {
                            String roleName = userService.getUserRoleName(u.getUserId());
                            return roleName != null ? roleName : "UNKNOWN";
                        },
                        Collectors.counting()));
    }
}
