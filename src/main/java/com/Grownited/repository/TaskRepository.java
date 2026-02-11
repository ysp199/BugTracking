package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.TaskEntity;

public interface TaskRepository extends JpaRepository<TaskEntity, Integer>{

}
