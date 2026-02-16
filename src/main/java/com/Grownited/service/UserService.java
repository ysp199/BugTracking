package com.Grownited.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Grownited.entity.RoleEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserRoleEntity;
import com.Grownited.repository.RoleRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.UserRoleRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRoleRepository userRoleRepository;


    /* =========================
       CREATE / UPDATE USER
       ========================= */

    public UserEntity saveUser(UserEntity user) {
        return userRepository.save(user);
    }

    /* =========================
       FIND USER
       ========================= */

    public UserEntity findByEmail(String email) {
        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        return userOpt.orElse(null);
    }

    public UserEntity findById(Integer userId) {
        return userRepository.findById(userId).orElse(null);
    }

    /* =========================
       LIST USERS (ADMIN)
       ========================= */

    public List<UserEntity> findAllUsers() {
        return userRepository.findAll();
    }

    /* =========================
       VALIDATIONS
       ========================= */

    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
        
    }

    public void assignRole(Integer userId, Integer roleId) {

        // Check if mapping already exists
        boolean alreadyAssigned =
                userRoleRepository.existsByUser_UserIdAndRole_RoleId(userId, roleId);

        if (alreadyAssigned) {
            return; // do nothing if already assigned
        }

        // Fetch user
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Fetch role
        RoleEntity role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Role not found"));

        // Create mapping
        UserRoleEntity userRole = new UserRoleEntity();
        userRole.setUser(user);
        userRole.setRole(role);

        userRoleRepository.save(userRole);
    }

    public Integer getUserRoleId(Integer userId) {

        UserRoleEntity userRole =
                userRoleRepository.findByUser_UserId(userId);

        if (userRole != null) {
            return userRole.getRole().getRoleId();
        }

        return null;
    }

    /* =========================
       ACCOUNT STATUS
       ========================= */

    public void deactivateUser(Integer userId) {
        UserEntity user = findById(userId);
        if (user != null) {
            user.setActive(false);
            userRepository.save(user);
        }
    }

    public void activateUser(Integer userId) {
        UserEntity user = findById(userId);
        if (user != null) {
            user.setActive(true);
            userRepository.save(user);
        }
    }
}
