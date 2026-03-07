package com.Grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {

    Optional<UserEntity> findByEmail(String email);

    boolean existsByEmail(String email);

    // Filter by Role Id
    @org.springframework.data.jpa.repository.Query("SELECT u FROM UserEntity u JOIN u.roles ur WHERE ur.role.roleId = :roleId")
    List<UserEntity> findByRoleId(@org.springframework.data.repository.query.Param("roleId") Integer roleId);

    // Filter by Project Id (User created it OR is assigned to a task in it OR is
    // assigned/reported a bug in a task of that project)
    @org.springframework.data.jpa.repository.Query("SELECT DISTINCT u FROM UserEntity u " +
            "LEFT JOIN ProjectEntity p ON p.createdBy = u AND p.projectId = :projectId " +
            "LEFT JOIN TaskEntity t ON t.assignedTo = u AND t.module.project.projectId = :projectId " +
            "LEFT JOIN BugEntity b1 ON b1.assignedTo = u AND b1.task.module.project.projectId = :projectId " +
            "LEFT JOIN BugEntity b2 ON b2.reportedBy = u AND b2.task.module.project.projectId = :projectId " +
            "WHERE p.projectId = :projectId OR t.taskId IS NOT NULL OR b1.bugId IS NOT NULL OR b2.bugId IS NOT NULL")
    List<UserEntity> findByProjectId(@org.springframework.data.repository.query.Param("projectId") Integer projectId);

    // Filter by both Role Id and Project Id
    @org.springframework.data.jpa.repository.Query("SELECT DISTINCT u FROM UserEntity u JOIN u.roles ur " +
            "LEFT JOIN ProjectEntity p ON p.createdBy = u AND p.projectId = :projectId " +
            "LEFT JOIN TaskEntity t ON t.assignedTo = u AND t.module.project.projectId = :projectId " +
            "LEFT JOIN BugEntity b1 ON b1.assignedTo = u AND b1.task.module.project.projectId = :projectId " +
            "LEFT JOIN BugEntity b2 ON b2.reportedBy = u AND b2.task.module.project.projectId = :projectId " +
            "WHERE ur.role.roleId = :roleId AND " +
            "(p.projectId = :projectId OR t.taskId IS NOT NULL OR b1.bugId IS NOT NULL OR b2.bugId IS NOT NULL)")
    List<UserEntity> findByRoleIdAndProjectId(@org.springframework.data.repository.query.Param("roleId") Integer roleId,
            @org.springframework.data.repository.query.Param("projectId") Integer projectId);
}
