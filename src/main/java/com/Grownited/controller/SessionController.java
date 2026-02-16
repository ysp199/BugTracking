package com.Grownited.controller;

import java.time.LocalDate;

import com.Grownited.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import com.Grownited.entity.UserEntity;

@Controller
public class SessionController {

    private final UserService userService;

    SessionController(UserService userService) {
        this.userService = userService;
    }
	@GetMapping("/signup")
	public String openSignupPage() {
		return "authentication/Signup"; //jspName
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "authentication/Login"; //jspName
	}
	
	@GetMapping("/forgetPassword")
	public String openForgetPassPage() {
		return "authentication/ForgetPassword"; //jspName
	}
	
	@PostMapping("/register")
	public String registerUser(@ModelAttribute UserEntity user) {
		user.setActive(true);                // default active
	    user.setCreatedAt(LocalDate.now());  // set created date

	   userService.saveUser(user);
		
		return "redirect:/Login";
}
}