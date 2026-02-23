package com.Grownited.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Grownited.entity.UserEntity;
import com.Grownited.service.RoleService;
import com.Grownited.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private RoleService roleService;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    /* =========================
       LIST ALL USERS
       ========================= */
    @GetMapping("users")
    public String listUsers(Model model) {

        List<UserEntity> users = userService.findAllUsers();
        model.addAttribute("users", users);

        return "admin/users";
    }

    /* =========================
       SHOW ADD USER FORM
       ========================= */
    @GetMapping("users/add")
    public String showAddUserForm(Model model) {

        model.addAttribute("user", new UserEntity());
        model.addAttribute("roles", roleService.findAssignableRoles());
        return "admin/add-user";
    }

    /* =========================
       SAVE USER (CREATE / UPDATE)
       ========================= */
    @PostMapping("users/save")
    public String saveUser(@ModelAttribute UserEntity user,
                           @RequestParam Integer roleId) {

        UserEntity existingUser = null;

        // 🔎 CHECK IF EDIT MODE
        if (user.getUserId() != null) {
            existingUser = userService.findById(user.getUserId());
        }

        // ✅ PASSWORD HANDLING
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            // keep old password on edit
            if (existingUser != null) {
                user.setPassword(existingUser.getPassword());
            }
        } else {
            // hash new password
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        // metadata
        user.setActive(true);

        if (existingUser == null) {
            user.setCreatedAt(LocalDate.now());
        } else {
            user.setCreatedAt(existingUser.getCreatedAt());
        }

        userService.saveUser(user);
        userService.assignRole(user.getUserId(), roleId);

        return "redirect:/admin/users";
    }

    

    /* =========================
       SHOW EDIT USER FORM
       ========================= */
    @GetMapping("users/edit/{id}")
    public String editUser(@PathVariable Integer id, Model model) {

        UserEntity user = userService.findById(id);

        // Get current role id
        Integer currentRoleId = userService.getUserRoleId(id);

        model.addAttribute("user", user);
        model.addAttribute("roles", roleService.findAssignableRoles());
        model.addAttribute("currentRoleId", currentRoleId);

        return "admin/edit-user";
    }

    /* =========================
       DEACTIVATE USER
       ========================= */
    @GetMapping("users/deactivate/{id}")
    public String deactivateUser(@PathVariable("id") Integer userId) {

        userService.deactivateUser(userId);
        return "redirect:/admin/users";
    }

    /* =========================
       ACTIVATE USER
       ========================= */
    @GetMapping("users/activate/{id}")
    public String activateUser(@PathVariable("id") Integer userId) {

        userService.activateUser(userId);
        return "redirect:/admin/users";
    }
    
    @GetMapping("dashboard")
    public String dashboard(Model model) {

        model.addAttribute("totalUsers", userService.findAllUsers().size());
        model.addAttribute("totalProjects", 12);
        model.addAttribute("openBugs", 11);
        model.addAttribute("closedBugs", 8);

        return "admin/dashboard";
    }
    @GetMapping("users/toggle-active/{id}")
    public String toggleUserStatus(@PathVariable Integer id) {

        UserEntity user = userService.findById(id);

        if (user != null) {
            user.setActive(!user.getActive());   // toggle
            userService.saveUser(user);
        }

        return "redirect:/admin/users";
    }
    
    
    
	@GetMapping("projects")
	public String showProjects(Model model) {
		model.addAttribute("page", "projects");
		return "admin/projects";
    }


}
