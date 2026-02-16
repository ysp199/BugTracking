package com.Grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.RoleEntity;

public interface RoleRepository extends JpaRepository<RoleEntity, Integer>{
	List<RoleEntity> findByRoleNameNot(String roleName);

}
