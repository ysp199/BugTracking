package com.Grownited.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    /*
     * =========================
     * CREATE / UPDATE USER
     * =========================
     */

    public UserEntity saveUser(UserEntity user) {
        return userRepository.save(user); // DO NOT encode here
    }

    @jakarta.persistence.PersistenceContext
    private jakarta.persistence.EntityManager entityManager;

    /*
     * =========================
     * DELETE USER (SAFE)
     * =========================
     */
    @org.springframework.transaction.annotation.Transactional
    public void deleteUserById(Integer userId) {

        UserRoleEntity userRole = userRoleRepository.findByUser_UserId(userId);

        if (userRole != null && "ADMIN".equalsIgnoreCase(userRole.getRole().getRoleName())) {
            throw new RuntimeException("ADMIN_DELETE_NOT_ALLOWED");
        }

        userRoleRepository.deleteByUser_UserId(userId);

        // Nullify foreign keys to prevent constraint violations
        entityManager.createQuery("UPDATE ProjectEntity p SET p.createdBy = null WHERE p.createdBy.userId = :userId")
                .setParameter("userId", userId).executeUpdate();
        entityManager.createQuery("UPDATE TaskEntity t SET t.assignedTo = null WHERE t.assignedTo.userId = :userId")
                .setParameter("userId", userId).executeUpdate();
        entityManager.createQuery("UPDATE BugEntity b SET b.assignedTo = null WHERE b.assignedTo.userId = :userId")
                .setParameter("userId", userId).executeUpdate();
        entityManager.createQuery("UPDATE BugEntity b SET b.reportedBy = null WHERE b.reportedBy.userId = :userId")
                .setParameter("userId", userId).executeUpdate();
        entityManager.createQuery("UPDATE TimeLogEntity t SET t.user = null WHERE t.user.userId = :userId")
                .setParameter("userId", userId).executeUpdate();
        entityManager.createQuery("UPDATE BugHistoryEntity h SET h.changedBy = null WHERE h.changedBy.userId = :userId")
                .setParameter("userId", userId).executeUpdate();

        // Delete associated notifications entirely Since they're only meant for that
        // user
        entityManager.createQuery("DELETE FROM NotificationEntity n WHERE n.user.userId = :userId")
                .setParameter("userId", userId).executeUpdate();

        userRepository.deleteById(userId);
    }

    /*
     * =========================
     * FIND USER
     * =========================
     */

    public UserEntity findByEmail(String email) {
        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        return userOpt.orElse(null);
    }

    public UserEntity findById(Integer userId) {
        return userRepository.findById(userId).orElse(null);
    }

    /*
     * =========================
     * LIST USERS (ADMIN)
     * =========================
     */

    public List<UserEntity> findAllUsers() {
        return userRepository.findAll();
    }

    public List<UserEntity> findUsersByRole(Integer roleId) {
        return userRepository.findByRoleId(roleId);
    }

    public List<UserEntity> findUsersByProject(Integer projectId) {
        return userRepository.findByProjectId(projectId);
    }

    public List<UserEntity> findUsersByRoleAndProject(Integer roleId, Integer projectId) {
        return userRepository.findByRoleIdAndProjectId(roleId, projectId);
    }

    public String getUserRoleName(Integer userId) {

        UserRoleEntity userRole = userRoleRepository.findByUser_UserId(userId);

        if (userRole != null && userRole.getRole() != null) {
            return userRole.getRole().getRoleName();
        }

        return "N/A";
    }

    /*
     * =========================
     * VALIDATIONS
     * =========================
     */

    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);

    }

    public void assignRole(Integer userId, Integer roleId) {

        // Check if mapping already exists
        boolean alreadyAssigned = userRoleRepository.existsByUser_UserIdAndRole_RoleId(userId, roleId);

        if (alreadyAssigned) {
            return; // do nothing if already assigned
        }

        // Fetch user
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Fetch role
        RoleEntity role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Role not found"));

        UserRoleEntity existingUserRole = userRoleRepository.findByUser_UserId(userId);

        if (existingUserRole != null) {
            existingUserRole.setRole(role);
            userRoleRepository.save(existingUserRole);
        } else {
            // Create mapping
            UserRoleEntity userRole = new UserRoleEntity();
            userRole.setUser(user);
            userRole.setRole(role);
            userRoleRepository.save(userRole);
        }
    }

    public Integer getUserRoleId(Integer userId) {

        UserRoleEntity userRole = userRoleRepository.findByUser_UserId(userId);

        if (userRole != null) {
            return userRole.getRole().getRoleId();
        }

        return null;
    }

    /*
     * =========================
     * ACCOUNT STATUS
     * =========================
     */

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

    /**
     * Encodes a raw password using BCrypt.
     */
    public String encodePassword(String rawPassword) {
        return passwordEncoder.encode(rawPassword);
    }

    /**
     * Updates a user's password (hashes it first).
     */
    public void updatePassword(UserEntity user, String newRawPassword) {
        user.setPassword(passwordEncoder.encode(newRawPassword));
        userRepository.save(user);
    }

    /**
     * Authenticates a user by email and password.
     * Returns the user entity if credentials are valid, null otherwise.
     */
    public UserEntity authenticate(String email, String password) {

        Optional<UserEntity> userOpt = userRepository.findByEmail(email);

        if (userOpt.isEmpty())
            return null;

        UserEntity user = userOpt.get();

        if (!user.getActive())
            return null;

        if (!passwordEncoder.matches(password, user.getPassword()))
            return null;

        return user;
    }
}
