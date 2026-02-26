# Step 12 (Minikube)

```bash
minikube start --driver=docker --cpus=2 --memory=4000
kubectl create ns lab-agent

eval $(minikube -p minikube docker-env)
docker build -t ai-agent:dev .

git clone https://github.com/github/github-mcp-server.git
cd github-mcp-server
docker build -t github-mcp-server:dev .
cd ..

kubectl -n lab-agent create secret generic agent-secrets \
  --from-literal=ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
  --from-literal=GITHUB_TOKEN="$GITHUB_TOKEN"

kubectl apply -f k8s/github-mcp.yaml
kubectl apply -f k8s/agent.yaml
kubectl -n lab-agent get pods,svc
```

Note:
- The official `github-mcp-server` image runs in STDIO mode.
- In Kubernetes it exits quickly without a client session.
- For stable in-cluster HTTP usage, deploy an MCP HTTP wrapper.
