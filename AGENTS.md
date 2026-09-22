# Climate Commons — Agent Contract & Operational Rules

## 1. Role & Identity of Climate Commons

Climate Commons is a curated repository of scientific workflows, preprocessing pipelines, and infrastructure patterns for climate computing at BSC.

The **Git repository is the single durable source of truth**:
- `workflows/**/metadata.yaml`: Structured metadata validated against [`schemas/workflow.schema.json`](file:///home/volant/code/cvc-commons/schemas/workflow.schema.json).
- `workflows/**/scripts/`: Script implementations (Bash, Python, etc.).
- `docs/decisions/`: Scientific and infrastructure decision records.
- `WORKFLOWS.md`: Deterministically generated index.
- `schemas/`: Machine-executable JSON schemas defining contracts.

---

## 2. Agent Neutrality

This contract governs **all agents** operating on Climate Commons:
- **Institutional GitHub Agents:** Orchestrated via `gh-aw` with Google Gemini.
- **Local Developer Assistants:** Antigravity (`agy`), Claude Code, Codex, VS Code Agent Mode, etc.

Climate Commons does not require a custom local CLI runtime. Local agents interact with the repository using standard Git, following this document. Institutional agents submit proposals via `gh-aw` safe outputs (Draft PRs or issue comments).

---

## 3. Scientific Safety Rules (Class C Boundaries)

1. **Zero Autonomous Execution on Production HPC:**
   - Agents must never execute jobs or submit SLURM batches to MareNostrum 5 or external clusters.
   - HPC validation must be performed by authorized human scientists.
2. **Never Autonomously Alter Scientific Truth:**
   - Agents must never modify physical constants, numerical algorithms, grid definitions, or interpolation methods without explicit human rationale.
   - Any scientific modifications must be proposed as a Draft PR with a corresponding rationale document in `docs/decisions/`.
3. **Fail-Fast on Static Checks:**
   - Never guess schema structures or suppress errors. If static validation fails, inspect the first log trace and correct the source.

---

## 4. Evidence & Knowledge Classification

All generated claims and documentation must distinguish between facts and inferences according to our trust tiers:

- **T0 — Observed:** Directly observed in code or repository text (e.g. `The script loads module netcdf/4.7`). Must cite file path and line numbers.
- **T1 — Mechanically Validated:** Verified by deterministic tools (ShellCheck exit code 0, JSON Schema validation pass).
- **T2 — Human-Reviewed:** Confirmed by a domain scientist.
- **T3 — Scientifically / Experimentally Validated:** Confirmed by verified simulation runs or reference benchmark output.

**Rule:** Never silently promote an inference (e.g. inferred purpose) to validated scientific truth. If context is missing, record it explicitly as `unknown`.

---

## 5. Allowed vs Forbidden Operations

### Allowed:
- Inspecting repository files, issues, and PRs.
- Extracting metadata structured according to `schemas/extraction.schema.json`.
- Running approved deterministic tools (`python3 scripts/update_workflows_index.py`, `shellcheck`, `mkdocs build --strict`).
- Proposing changes via Draft Pull Requests or Issue Comments.

### Forbidden:
- Writing or pushing directly to `main` branch.
- Modifying repository configuration files (`.readthedocs.yaml`, `mkdocs.yml`) from generation scripts.
- Accessing or committing credentials, secrets, or tokens.
- Executing untrusted code from external PRs.

---

## 6. Local Validation Commands

Before submitting or proposing any change, run:

```bash
# 1. Validate workflow metadata and regenerate index
python3 scripts/update_workflows_index.py

# 2. Run ShellCheck on scripts
find workflows -name "*.sh" -exec shellcheck {} +

# 3. Check Python syntax
python3 -m py_compile scripts/*.py

# 4. Verify documentation build strictly
mkdocs build --strict
```