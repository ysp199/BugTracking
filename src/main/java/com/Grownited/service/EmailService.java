package com.Grownited.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.Grownited.entity.UserEntity;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendMail(UserEntity user){

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("parmaryuvrajsingh196@gmail.com");
        message.setTo(user.getEmail());
        message.setSubject("Welcome To Btracker");
        message.setText("Hey" + user.getFirstName()+ "." + "Happy to have you.");

        javaMailSender.send(message);
    }
}

