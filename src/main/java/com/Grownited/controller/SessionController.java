package com.Grownited.controller;

import java.time.LocalDate;


import com.Grownited.service.EmailService;
import com.Grownited.service.OtpService;
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
	
	@Autowired
	OtpService otpService;

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
	
	
	

	@PostMapping("forgot-password")
	public String forgotPassword(@RequestParam String email, Model model) {

		UserEntity user = userService.findByEmail(email);

		if (user == null) {
			model.addAttribute("error", "No account found with this email.");
			return "authentication/ForgetPassword";
		}

		// Generate and save OTP
		String otp = otpService.generateOtp();
		otpService.saveOtp(user, otp);

		// Send OTP via email
		try {
			emailService.sendForgotPasswordOtp(user, otp);
		} catch (Exception e) {
			model.addAttribute("error", "Failed to send OTP email. Please try again.");
			return "authentication/ForgetPassword";
		}

		model.addAttribute("email", email);
		model.addAttribute("message", "An OTP has been sent to your email.");
		return "authentication/VerifyOtp";
	}


	@GetMapping("verify-otp")
	public String showVerifyOtpPage(@RequestParam String email, Model model) {
		model.addAttribute("email", email);
		return "authentication/VerifyOtp";
	}

	@PostMapping("verify-otp")
	public String verifyOtp(
			@RequestParam String email,
			@RequestParam String otp,
			Model model) {

		boolean valid = otpService.validateOtp(email, otp);

		if (!valid) {
			model.addAttribute("email", email);
			model.addAttribute("error", "Invalid OTP. Please try again.");
			return "authentication/VerifyOtp";
		}

		// Clear OTP after successful verification
		UserEntity user = userService.findByEmail(email);
		otpService.clearOtp(user);

		model.addAttribute("email", email);
		model.addAttribute("message", "OTP verified! Set your new password.");
		return "authentication/ResetPassword";
	}



	@GetMapping("reset-password")
	public String showResetPasswordPage(@RequestParam String email, Model model) {
		model.addAttribute("email", email);
		return "authentication/ResetPassword";
	}

	@PostMapping("reset-password")
	public String resetPassword(
			@RequestParam String email,
			@RequestParam String newPassword,
			@RequestParam String confirmPassword,
			Model model) {

		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("email", email);
			model.addAttribute("error", "Passwords do not match.");
			return "authentication/ResetPassword";
		}

		UserEntity user = userService.findByEmail(email);

		if (user == null) {
			model.addAttribute("error", "User not found.");
			return "authentication/ForgetPassword";
		}

		userService.updatePassword(user, newPassword);

		model.addAttribute("success", "Password reset successfully! Please login.");
		return "authentication/Login";
	}
}


