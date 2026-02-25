package com.Grownited.service;

import java.security.SecureRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Grownited.entity.UserEntity;
import com.Grownited.repository.UserRepository;

@Service
public class OtpService {

    @Autowired
    private UserRepository userRepository;

    private static final SecureRandom random = new SecureRandom();

    
   
     
    public String generateOtp() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    
 
     
    public void saveOtp(UserEntity user, String otp) {
        user.setOtp(otp);
        userRepository.save(user);
    }

    
     
     
    public void clearOtp(UserEntity user) {
        user.setOtp(null);
        userRepository.save(user);
    }

    
    public boolean validateOtp(String email, String otp) {
        UserEntity user = userRepository.findByEmail(email).orElse(null);

        if (user == null || user.getOtp() == null) {
            return false;
        }

        return user.getOtp().equals(otp);
    }
}
