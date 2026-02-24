package com.Grownited.controller;

import java.time.LocalDate;

import com.Grownited.service.EmailService;
import com.Grownited.service.UserService;

import org.springframework.ui.Model;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Grownited.entity.RoleEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.entity.UserRoleEntity;
import com.Grownited.repository.RoleRepository;
import com.Grownited.repository.UserRepository;
import com.Grownited.repository.UserRoleRepository;

@Controller
public class SessionController {
	
	@Autowired
    private final UserService userService;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	UserRoleRepository userRoleRepository;
	
	@Autowired
	RoleRepository roleRepository;
	
	@Autowired
	EmailService emailService;

    SessionController(UserService userService) {
        this.userService = userService;
    }
	@GetMapping("signup")
	public String openSignupPage() {
		return "authentication/Signup"; //jspName
	}
	
	@GetMapping("login")
	public String openLoginPage() {
		return "authentication/Login"; //jspName
	}
	
	@GetMapping("forgetPassword")
	public String openForgetPassPage() {
		return "authentication/ForgetPassword"; //jspName
	}
	
	@PostMapping("register")
	public String registerUser(@ModelAttribute UserEntity user, Model model) throws MessagingException {

	    if (userService.emailExists(user.getEmail())) {
	        model.addAttribute("error", "Email already registered");
	        return "authentication/Signup";
	    }

	    user.setActive(true);
	    user.setCreatedAt(LocalDate.now());

	    // password hashing happens inside service
	    userService.saveUser(user);

	    // ✅ FETCH ROLE CORRECTLY
	    RoleEntity role = roleRepository
	            .findByRoleName("DEVELOPER")
	            .orElseThrow(() -> new RuntimeException("Role not found"));

	    // ✅ ASSIGN ROLE
	    UserRoleEntity userRole = new UserRoleEntity();
	    userRole.setUser(user);
	    userRole.setRole(role);

	    userRoleRepository.save(userRole);
	    
	    emailService.sendWelcomeMail(user);

	    return "redirect:/login";
	}
	
	
		
	@PostMapping("authenticate")
	public String login(
	        @RequestParam String email,
	        @RequestParam String password,
	        HttpSession session,
	        Model model) {
		
		email = email.trim().toLowerCase();
		
	    UserEntity user = userService.authenticate(email, password);

	    if (user == null) {
	        model.addAttribute("error", "Invalid email or password");
	        return "authentication/Login";
	    }

	    if (user.getRoles() == null || user.getRoles().isEmpty()) {
	        session.invalidate();
	        model.addAttribute("error", "No role assigned to user");
	        return "authentication/Login";
	    }

	    UserRoleEntity userRole = user.getRoles().get(0);
	    String roleName = userRole.getRole().getRoleName();

	    session.setAttribute("loggedInUser", user);
	    session.setAttribute("role", roleName);

	    switch (roleName) {
	        case "ADMIN":
	            return "redirect:/admin/dashboard";
	        case "PROJECT_MANAGER":
	            return "redirect:/pm/dashboard";
	        case "DEVELOPER":
	            return "redirect:/developer/dashboard";
	        case "TESTER":
	            return "redirect:/tester/dashboard";
	        default:
	            session.invalidate();
	            model.addAttribute("error", "Role not supported");
	            return "authentication/Login";
	    }
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "authentication/Login";}
}

