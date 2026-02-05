package com.Grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.Grownited.entity.UserEntity;

@Controller
public class SessionController {
	@GetMapping("/signup")
	public String openSignupPage() {
		return "Signup"; //jspName
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login"; //jspName
	}
	
	@GetMapping("/forgetPassword")
	public String openForgetPassPage() {
		return "ForgetPassword"; //jspName
	}
	
	@PostMapping("/register")
	public String register(UserEntity userEntity) {
		System.out.println(userEntity.getFirstName());
		System.out.println(userEntity.getLastName());

		return "Login";
}
}