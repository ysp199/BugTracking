package com.Grownited.controller;

import java.io.IOException;
import java.util.Map;

import com.cloudinary.Cloudinary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.Grownited.entity.UserEntity;
import com.Grownited.service.UserService;
import com.Grownited.repository.UserRepository;

@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private Cloudinary cloudinary;

    @PostMapping("/update-profile-pic")
    public String updateProfilePic(@RequestParam("profilePic") MultipartFile profilePic,
            HttpSession session, HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        UserEntity loggedInUser = (UserEntity) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            loggedInUser = (UserEntity) session.getAttribute("user");
        }

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        try {
            if (!profilePic.isEmpty()) {
                @SuppressWarnings("rawtypes")
                Map map = cloudinary.uploader().upload(profilePic.getBytes(), null);
                String profilePicURl = map.get("secure_url").toString();

                UserEntity user = userService.findById(loggedInUser.getUserId());
                if (user != null) {
                    user.setProfilePicURl(profilePicURl);
                    userRepository.save(user);

                    session.setAttribute("loggedInUser", user);
                    redirectAttributes.addFlashAttribute("success", "Profile picture updated successfully!");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error uploading profile picture.");
        }

        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/admin/dashboard");
    }
}
