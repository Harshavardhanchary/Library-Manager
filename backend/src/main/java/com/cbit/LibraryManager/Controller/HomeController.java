package com.cbit.LibraryManager.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {

    @GetMapping("/homepage")
    public String showHomepage(HttpServletRequest request) {
        // Clear any old messages from the request
        request.setAttribute("message", null);
        return "/Homepage.jsp";  // This will forward to src/main/webapp/Homepage.jsp
    }
}
