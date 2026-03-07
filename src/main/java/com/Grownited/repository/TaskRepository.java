package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.TaskEntity;
import com.Grownited.entity.ModuleEntity;

public interface TaskRepository extends JpaRepository<TaskEntity, Integer> {

    List<TaskEntity> findByModule_ModuleId(Integer moduleId);

    List<TaskEntity> findByModuleIn(List<ModuleEntity> modules);
}
