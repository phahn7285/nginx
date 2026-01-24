=========================================================
AGENTS.md
=========================================================

This repository is governed by an external standards system.

All AI agents MUST follow the rules below.

## Entry Point

1. Always begin by reading:
   standards/standards/agents/orchestration.md

2. Orchestration determines:
   - Which standards apply
   - Which role-specific agent files must be generated or used
   - Which language, platform, and tooling standards are required

## Role-Based Operation

- Orchestration MUST generate or reference role-specific agent files, such as:
  - standards/standards/agents/agent-nginx-platform.md
  - standards/standards/agents/agent-nginx-devsecops.md
  - standards/standards/agents/agent-nginx-frontend.md
  - standards/standards/agents/agent-nginx-backend.md
  - standards/standards/agents/agent-nginx-ai.md
  - standards/standards/agents/agent-nginx-data.md

- Agents MUST NOT operate outside their assigned role scope.

## Standards Composition Rules

- agents/ standards have highest precedence.
- ai/, databases/, languages/, messaging/, and platforms/ standards apply conditionally.
- Conflicts are resolved only via orchestration rules.
- No assumptions are allowed where standards exist.

## Execution Requirements

- All changes MUST:
  - Follow applicable standards
  - Include required tests
  - Pass CI checks defined by standards
- Work is incomplete until verification is successful.

## Prohibited Behavior

- Do not invent standards.
- Do not skip required files.
- Do not duplicate rules.
- Do not bypass orchestration.

Failure to follow these rules constitutes a standards violation.
