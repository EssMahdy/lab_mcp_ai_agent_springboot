# lab_mcp_ai_agent_springboot

## Local setup (safe)
1. Copy env template:
```bash
cp .env.example .env
```
2. Fill real values in `.env` (do not commit it).
3. Export env vars:
```bash
set -a
source .env
set +a
```
4. Run app:
```bash
./gradlew bootRun
```

## Test
```bash
./gradlew test
```

## STEP guides
- `docs/STEP0-MCP-WRAPPER.md`

## Notes
- Real API keys stay in local `.env` only.
- `.env` is ignored by git.
