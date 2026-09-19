# Climate Commons (`cvc-commons`)

**A curated repository of scientific workflows, preprocessing pipelines, and infrastructure patterns for climate computing at BSC.**

Climate Commons serves as a single source of truth for research workflows—bridging the gap between individual scientist scripts and institutional knowledge.

---

## Key Principles

- **Repository is the Source of Truth:** Workflows, structured schemas, evidence, and decision records are tracked in Git.
- **Deterministic CI as Software Arbiter:** Exit codes, schema validation, ShellCheck, linting, and documentation builds determine software correctness.
- **Human Authority for Science:** AI agents assist with workflow analysis and propose reviewable draft PRs; human scientists own scientific decisions and validation.
- **Agent Neutrality:** Automated maintenance runs institutionally on GitHub (`gh-aw` + Gemini); local development agents (`agy`, Claude Code, Codex, VS Code) are fully supported via the agent contract in [`AGENTS.md`](file:///home/volant/code/cvc-commons/AGENTS.md).

---

## Repository Layout

```text
cvc-commons/
├── workflows/             # Ingested scientific workflows
│   └── <category>/
│       ├── metadata.yaml  # Structured workflow descriptor
│       ├── scripts/       # Implementation scripts (Bash, Python, etc.)
│       └── tests/         # Verification tests (lint, smoke tests)
├── schemas/               # Executable JSON schemas
│   ├── workflow.schema.json
│   └── extraction.schema.json
├── docs/                  # MkDocs documentation source
│   ├── index.md
│   ├── _workflows/        # Human-readable workflow docs
│   └── decisions/         # Scientific and architectural decision records
├── scripts/               # Deterministic repository utilities (e.g. index generator)
├── .github/               # Issue templates, CI, and agentic workflows
├── AGENTS.md              # Agent contract & operational boundaries
├── WORKFLOWS.md           # Deterministically generated workflow index
└── mkdocs.yml             # MkDocs configuration
```

---

## Contributing a Workflow

1. Check existing workflows in [`WORKFLOWS.md`](file:///home/volant/code/cvc-commons/WORKFLOWS.md).
2. Open an issue using the **Workflow Ingestion** issue template.
3. The institutional agent will inspect the workflow, gather facts and inferences, and submit a reviewable Draft Pull Request.
4. See [`CONTRIBUTING.md`](file:///home/volant/code/cvc-commons/CONTRIBUTING.md) for step-by-step instructions.

---

## Local Development & Validation

To validate workflows and build documentation locally:

```bash
# Install doc dependencies
pip install -r docs/requirements.txt jsonschema

# Validate workflow metadata against schema and regenerate index
python3 scripts/update_workflows_index.py

# Run documentation build with strict link checking
mkdocs build --strict
```

---

## Governance & License

- **Ownership:** Maintained by `@vlap` and BSC Climate Contributors. See [`.github/CODEOWNERS`](file:///home/volant/code/cvc-commons/.github/CODEOWNERS).
- **Security:** Read [`SECURITY.md`](file:///home/volant/code/cvc-commons/SECURITY.md) for threat model and reporting.
- **License:** [Apache-2.0](file:///home/volant/code/cvc-commons/LICENSE).
