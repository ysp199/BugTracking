package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.TimeLogEntity;

public interface TimeLogRepository extends JpaRepository<TimeLogEntity, Integer> {
    java.util.List<TimeLogEntity> findByTask_TaskId(Integer taskId);
}
