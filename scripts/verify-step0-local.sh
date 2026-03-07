#!/usr/bin/env bash
set -euo pipefail

echo "[1/4] Tool versions"
node -v
npm -v
docker version --format '{{.Server.Version}}'

echo "[2/4] Required env vars"
: "${GITHUB_PERSONAL_ACCESS_TOKEN:?Missing GITHUB_PERSONAL_ACCESS_TOKEN}"

echo "[3/4] Checking MCP wrapper endpoint"
RESPONSE=$(curl -sS http://localhost:3333/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":"1","method":"tools/list","params":{}}')

echo "$RESPONSE" | rg -q 'create_issue' || {
  echo "ERROR: create_issue not found in tools/list"
  echo "$RESPONSE"
  exit 1
}

echo "[4/4] OK - create_issue is available"
