# STEP 12.8 Troubleshooting

- Connection refused: check `kubectl -n lab-agent get pods` and logs.
- 403 Forbidden: check PAT permissions (Issues Read/Write).
- No tool calls: strengthen prompt (`MUST use tools`).
- Wrong MCP path: verify endpoint and `mcp.path`.
