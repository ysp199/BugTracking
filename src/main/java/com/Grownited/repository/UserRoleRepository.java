package com.Grownited.repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.Grownited.entity.UserRoleEntity;

public interface UserRoleRepository extends JpaRepository<UserRoleEntity, Integer> {

    boolean existsByUser_UserIdAndRole_RoleId(Integer userId, Integer roleId);
    UserRoleEntity findByUser_UserId(Integer userId);


}
