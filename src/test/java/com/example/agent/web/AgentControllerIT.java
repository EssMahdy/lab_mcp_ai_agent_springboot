package com.example.agent.web;

import com.example.agent.agent.BacklogAgent;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.reactive.server.WebTestClient;

import java.util.Map;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class AgentControllerIT {

    @Autowired
    WebTestClient web;

    @MockBean
    BacklogAgent backlogAgent;

    @Test
    void should_call_endpoint() {
        when(backlogAgent.handle(anyString())).thenReturn("ok");

        web.post().uri("/api/agent/run")
                .bodyValue(Map.of("prompt", "Create a task to add OpenTelemetry"))
                .exchange()
                .expectStatus().isOk();
    }
}
