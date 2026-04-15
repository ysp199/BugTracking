package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Grownited.entity.BugEntity;

@Repository
public interface BugRepository extends JpaRepository<BugEntity, Integer> {
        List<BugEntity> findByPriority(String priority);

        List<BugEntity> findBySeverity(String severity);

        List<BugEntity> findByPriorityAndSeverity(String priority, String severity);

        List<BugEntity> findByTask_TaskId(Integer taskId);

        @org.springframework.data.jpa.repository.Query("SELECT b FROM BugEntity b LEFT JOIN b.task t LEFT JOIN t.assignedTo a WHERE "
                        +
                        "(:priority IS NULL OR :priority = '' OR b.priority = :priority) AND " +
                        "(:severity IS NULL OR :severity = '' OR b.severity = :severity) AND " +
                        "(:status IS NULL OR :status = '' OR b.status = :status) AND " +
                        "(:assignedToId IS NULL OR a.userId = :assignedToId)")
        List<BugEntity> findMultiFilter(@org.springframework.data.repository.query.Param("priority") String priority,
                        @org.springframework.data.repository.query.Param("severity") String severity,
                        @org.springframework.data.repository.query.Param("status") String status,
                        @org.springframework.data.repository.query.Param("assignedToId") Integer assignedToId);

}
