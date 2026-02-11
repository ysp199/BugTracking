package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.BugEntity;

public interface BugRepository extends JpaRepository<BugEntity, Integer>{

}
