# STEP 0 / 0.1 - MCP wrapper local setup

## Prerequisites
- Java 21
- Node.js >= 20
- npm
- Docker

Check:
```bash
node -v
npm -v
docker version
```

## Required env vars
```bash
export ANTHROPIC_API_KEY=sk-ant-xxx
export GITHUB_TOKEN=github_pat_xxx
export GITHUB_OWNER="EssMahdy"
export GITHUB_REPO="lab_mcp_ai_agent_springboot"
export GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_TOKEN"
```

## Run the official GitHub MCP server (STDIO)
Run in terminal A:
```bash
docker run --rm -i \
  -e GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN" \
  ghcr.io/github/github-mcp-server
```

## Run MCP HTTP wrapper (Node)
Run in terminal B:
```bash
git clone https://github.com/pierre-filliolaud/lab_mcp_ai_agent_springboot.git /tmp/lab_mcp_wrapper_source
cd /tmp/lab_mcp_wrapper_source/mcp-github-http-wrapper
npm install
npm start
```
Expected:
```text
GitHub MCP HTTP Wrapper listening on http://localhost:3333/mcp
```

## Verify tools/list
Run in terminal C:
```bash
curl http://localhost:3333/mcp \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": "1",
    "method": "tools/list",
    "params": {}
  }'
```

You should see a tool list containing `create_issue`.
