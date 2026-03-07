#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${NAMESPACE:-lab-agent}"
SERVICE_NAME="${SERVICE_NAME:-ai-agent}"

kubectl get ns "$NAMESPACE" >/dev/null

echo "[1/5] Pods"
kubectl -n "$NAMESPACE" get pods

echo "[2/5] Services"
kubectl -n "$NAMESPACE" get svc

echo "[3/5] Wait ai-agent ready"
kubectl -n "$NAMESPACE" wait --for=condition=Available deployment/ai-agent --timeout=180s

echo "[4/5] Port-forward + health"
kubectl -n "$NAMESPACE" port-forward "svc/$SERVICE_NAME" 18080:8080 >/tmp/ai-agent-pf.log 2>&1 &
PF_PID=$!
trap 'kill $PF_PID >/dev/null 2>&1 || true' EXIT
sleep 4
curl -fsS http://127.0.0.1:18080/actuator/health

echo "[5/5] Optional agent call"
cat <<MSG
Run manually with valid keys and running MCP wrapper service:
curl -s http://127.0.0.1:18080/api/agent/run \\
  -H "Content-Type: application/json" \\
  -d '{"prompt":"Create a GitHub task to add OpenTelemetry with OTLP exporter."}'
MSG
