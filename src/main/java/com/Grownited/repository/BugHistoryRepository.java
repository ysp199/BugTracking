package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.BugHistoryEntity;

public interface BugHistoryRepository extends JpaRepository<BugHistoryEntity, Integer>{

}
