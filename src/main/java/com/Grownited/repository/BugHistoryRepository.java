package com.Grownited.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.BugHistoryEntity;

public interface BugHistoryRepository extends JpaRepository<BugHistoryEntity, Integer> {
    List<BugHistoryEntity> findByBug_BugId(Integer bugId);
}
