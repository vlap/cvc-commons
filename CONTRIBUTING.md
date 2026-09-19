# Contributing to Climate Commons

Thank you for contributing your scientific workflows, documentation, or tooling to Climate Commons!

---

## Core Contribution Principles

1. **Pragmatic Scientist Philosophy:** Keep code flat, modular, and minimal. Avoid speculative wrappers or unnecessary abstractions.
2. **Deterministic Standards:** All code submissions must pass deterministic CI checks (ShellCheck, Python syntax, JSON schema validation, MkDocs strict build).
3. **Evidence-Based Documentation:** Clearly distinguish between:
   - **Observed facts** (directly extracted from code/scripts)
   - **Inferences** (assumptions or context deduced from comments or filenames)
   - **Validated facts** (tested or human-reviewed)
   - **Unknowns** (unresolved parameters or missing context)
4. **No Autonomous Merging:** All contributions—whether authored by humans or prepared by AI agents—require human scientific review before merging into `main`.

---

## How to Ingest a New Workflow

1. **Option A: GitHub Issue (Institutional Ingestion)**
   - Open an issue using the [Workflow Ingestion Template](file:///.github/ISSUE_TEMPLATE/workflow-ingestion.yml).
   - Provide the path to the scripts, intended purpose, environment constraints (e.g. MareNostrum 5 modules), inputs, and outputs.
   - The institutional agent will analyze the scripts, validate metadata against `schemas/workflow.schema.json`, and open a Draft Pull Request.

2. **Option B: Local / Manual PR**
   - Place your workflow in `workflows/<workflow-name>/`.
   - Include:
     - `scripts/`: Executable Bash/Python scripts.
     - `metadata.yaml`: Validated against `schemas/workflow.schema.json`.
     - `tests/`: Basic validation script (e.g., `tests/lint.sh`).
   - Run local validation:
     ```bash
     python3 scripts/update_workflows_index.py
     mkdocs build --strict
     ```
   - Open a Pull Request against `main`.

---

## Agent Usage & Policy

You are welcome to use local AI assistants (Antigravity `agy`, Claude Code, Codex, etc.) to help document or inspect workflows. However:
- All agents must respect [`AGENTS.md`](file:///home/volant/code/cvc-commons/AGENTS.md).
- Agents must never alter physical constants, numerical algorithms, or scientific behavior without explicit human rationale recorded in `docs/decisions/`.
- Never execute untrusted workflow code on production HPC systems.
