# Step 12 (Minikube) - real E2E with MCP HTTP wrapper

The official `ghcr.io/github/github-mcp-server` image runs in STDIO mode.
It is not a stable HTTP MCP service by itself in Kubernetes.

Use a wrapper deployment and point `ai-agent` to it.

## 1) Start minikube and namespace
```bash
minikube start --driver=docker --cpus=4 --memory=8192
kubectl create ns lab-agent
```

## 2) Build images in minikube docker
```bash
eval $(minikube -p minikube docker-env)

# agent image (this repo)
docker build -t ai-agent:dev .

# wrapper image (from wrapper source repo)
git clone https://github.com/pierre-filliolaud/lab_mcp_ai_agent_springboot.git /tmp/lab_mcp_wrapper_source
cd /tmp/lab_mcp_wrapper_source/mcp-github-http-wrapper
docker build -t mcp-github-http-wrapper:dev .
cd -
```

## 3) Create secrets
```bash
kubectl -n lab-agent create secret generic agent-secrets \
  --from-literal=ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
  --from-literal=GITHUB_TOKEN="$GITHUB_TOKEN"
```

## 4) Deploy wrapper and agent
```bash
kubectl apply -f k8s/github-mcp-wrapper.yaml
kubectl apply -f k8s/ai-agent.yaml

kubectl -n lab-agent get pods
kubectl -n lab-agent get svc
```

## 5) Logs
```bash
kubectl -n lab-agent logs deploy/github-mcp-wrapper -f
kubectl -n lab-agent logs deploy/ai-agent -f
```

## 6) Test from local
```bash
kubectl -n lab-agent port-forward svc/ai-agent 8080:8080

curl http://localhost:8080/api/agent/run \
  -H "Content-Type: application/json" \
  -d '{"prompt":"Create a GitHub task to add OpenTelemetry with OTLP exporter."}'
```

Expected: the agent calls Claude, then MCP via wrapper, then creates a GitHub issue.

## Troubleshooting found during validation
- If `ai-agent` crashes with missing `GITHUB_OWNER`/`GITHUB_REPO`, set both env vars in `k8s/ai-agent.yaml`.
- If `github-mcp-wrapper` crashes with docker socket error, mount `/var/run/docker.sock` in the wrapper deployment.
- Delete old `github-mcp-server` resources if still present:
  `kubectl -n lab-agent delete deploy/github-mcp-server svc/github-mcp-server --ignore-not-found`.
