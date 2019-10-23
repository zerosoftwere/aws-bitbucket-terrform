package me.xerosoft.pagedemo.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

@RestController
@RequestMapping("/")
public class IndexController {
    @GetMapping
    public Map<String, String> checkHealth() {
        return Collections.singletonMap("Status", "UP");
    }
}
