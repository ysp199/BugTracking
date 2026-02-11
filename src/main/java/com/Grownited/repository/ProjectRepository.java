package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.ProjectEntity;

public interface ProjectRepository extends JpaRepository<ProjectEntity, Integer>{

}
