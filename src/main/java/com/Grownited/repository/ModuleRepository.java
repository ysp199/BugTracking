package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.ModuleEntity;
import com.Grownited.entity.ProjectEntity;

public interface ModuleRepository extends JpaRepository<ModuleEntity, Integer> {

    List<ModuleEntity> findByProject_ProjectId(Integer projectId);

    List<ModuleEntity> findByProjectIn(List<ProjectEntity> projects);
}
