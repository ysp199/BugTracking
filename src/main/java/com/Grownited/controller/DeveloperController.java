package com.Grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DeveloperController {

    @GetMapping("/developer/dashboard")
    public String dashboard() {
        return "developer/dashboard";
    }
}