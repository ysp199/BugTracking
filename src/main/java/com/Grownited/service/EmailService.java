package com.Grownited.service;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.Grownited.entity.UserEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javamailSender;

    @Autowired
    private ResourceLoader resourceLoader;

    public void sendWelcomeMail(UserEntity user) {

        try {
            MimeMessage message = javamailSender.createMimeMessage();

            Resource resource =
                    resourceLoader.getResource("classpath:templates/welcome-email.html");

            String html;
            try (InputStream is = resource.getInputStream()) {
                html = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            }

            String fullName = user.getFirstName();
            if (user.getLastName() != null && !user.getLastName().isBlank()) {
                fullName += " " + user.getLastName();
            }

            String body = html
                    .replace("{{fullName}}", fullName)
                    .replace("{{email}}", user.getEmail())
                    .replace("{{loginUrl}}", "http://localhost:9999/login");

            MimeMessageHelper helper =
                    new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(user.getEmail());
            helper.setSubject("Welcome to Bug Tracker 🚀");
            helper.setText(body, true);

            javamailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
    public void sendForgotPasswordOtp(UserEntity user, String otp) {

        try {
            MimeMessage message = javamailSender.createMimeMessage();

            
            Resource resource =
                    resourceLoader.getResource("classpath:templates/forgot-password.html");

            String html;
            try (InputStream is = resource.getInputStream()) {
                html = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            }

           
            String fullName = user.getFirstName();
            if (user.getLastName() != null && !user.getLastName().isBlank()) {
                fullName += " " + user.getLastName();
            }

           
            String body = html
                    .replace("{{fullName}}", fullName)
                    .replace("{{email}}", user.getEmail())
                    .replace("{{otp}}", otp);

            MimeMessageHelper helper =
                    new MimeMessageHelper(message, true, "UTF-8");

            //helper.setFrom(FROM_EMAIL);
            helper.setTo(user.getEmail());
            helper.setSubject("BTracker - Password Reset OTP");
            helper.setText(body, true); // HTML

            javamailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace(); 
        }
    }
  
}