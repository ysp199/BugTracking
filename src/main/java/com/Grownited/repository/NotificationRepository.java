package com.Grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.NotificationEntity;

public interface NotificationRepository extends JpaRepository<NotificationEntity, Integer>{

}
