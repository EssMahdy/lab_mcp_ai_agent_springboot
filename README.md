# lab_mcp_ai_agent_springboot

Spring Boot AI agent that creates GitHub issues through MCP.

## Stack
- Java 21
- Spring Boot 3.5.11
- Gradle
- LangChain4j 1.10.0 + Anthropic
- Docker
- GitHub Actions
- Minikube

## Quick start
1. Create local env file:
```bash
cp .env.example .env
```
2. Fill `.env` with real values.
3. Export vars:
```bash
set -a
source .env
set +a
```
4. Run:
```bash
./gradlew bootRun
```

## Main endpoint
```bash
curl -s http://localhost:8080/api/agent/run \
  -H "Content-Type: application/json" \
  -d '{"prompt":"Create a task to add OpenTelemetry and export traces via OTLP."}'
```

## Tests
```bash
./gradlew --no-daemon clean test
```

## Useful docs
- docs/STEP0-MCP-WRAPPER.md
- k8s/README-step12.md
