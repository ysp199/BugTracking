package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.ProjectEntity;

public interface ProjectRepository extends JpaRepository<ProjectEntity, Integer> {

    List<ProjectEntity> findByCreatedBy_UserId(Integer userId);

    @org.springframework.data.jpa.repository.Query("SELECT p FROM ProjectEntity p WHERE " +
            "(:status IS NULL OR :status = '' OR p.status = :status) AND " +
            "(:createdById IS NULL OR p.createdBy.userId = :createdById)")
    List<ProjectEntity> findMultiFilter(@org.springframework.data.repository.query.Param("status") String status,
            @org.springframework.data.repository.query.Param("createdById") Integer createdById);
}
