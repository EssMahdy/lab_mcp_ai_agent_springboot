package com.example.agent.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Configuration
@Profile("ci")
public class CiChatModelConfig {

    @Bean
    public String ciMarker() {
        return "CI OK";
    }
}
