package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer>{

}
