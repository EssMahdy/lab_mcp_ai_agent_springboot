#!/usr/bin/env bash
set -euo pipefail

OWNER_REPO="${OWNER_REPO:-EssMahdy/lab_mcp_ai_agent_springboot}"
TOKEN="${GITHUB_TOKEN:?Missing GITHUB_TOKEN}"

api() {
  curl -sS -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" "$@"
}

create_label() {
  local name="$1" color="$2"
  api -X POST "https://api.github.com/repos/$OWNER_REPO/labels" \
    -d "$(jq -nc --arg n "$name" --arg c "$color" '{name:$n,color:$c}')" >/dev/null || true
}

echo "Creating labels..."
create_label feature 1D76DB
create_label bug D73A4A
create_label test 0E8A16
create_label docker 5319E7
create_label ci-cd FBCA04

echo "Creating feature issue..."
TITLE='[FEATURE] AI Agent – LangChain4j + MCP + Claude'
BODY='## Goal
Build an AI agent using LangChain4j 1.10.0 that:
- reasons with Claude (Anthropic)
- calls tools via MCP
- creates GitHub issues automatically

## Scope
- Spring Boot
- LangChain4j 1.10.0
- MCP (HTTP / JSON-RPC)
- Docker
- CI/CD

## Tasks
All implementation steps are tracked as child issues.'

api -X POST "https://api.github.com/repos/$OWNER_REPO/issues" \
  -d "$(jq -nc --arg t "$TITLE" --arg b "$BODY" '{title:$t,body:$b,labels:["feature"]}')" \
  | jq -r '.html_url // .message'
