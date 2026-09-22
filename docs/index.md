# Climate Commons

**A curated knowledge repository and workflow catalog for climate modeling and high-performance computing at BSC.**

---

## Overview

Climate Commons maintains scientific workflows, preprocessing pipelines, and infrastructure patterns. It provides:

- **A Living Catalog:** Discover reusable workflows indexed by domain, HPC system, and maintenance status. See the [Workflow Catalog](workflows.md).
- **Multi-Dimensional Verification:** Workflows clearly differentiate between software execution success and human scientific validation.
- **Evidence-Based Knowledge:** Claims, parameters, and design decisions are explicitly backed by code references or scientific decision records.
- **Agentic Assistance with Human Authority:** AI agents help inspect code and generate proposals, while scientists retain authority over merges and scientific methodology.

---

## Catalog

Browse verified workflows in the [Workflow Catalog](workflows.md).

---

## Contributing

To contribute or ingest a new workflow:

1. Review existing entries in the [Workflow Catalog](workflows.md).
2. Open a GitHub Issue using the **Workflow Ingestion** template.
3. The institutional agent will inspect your code, draft metadata, and propose a reviewable Pull Request.
4. For detailed guidelines and local validation, refer to the repository `CONTRIBUTING.md`.

---

## Architecture & Principles

Climate Commons operates on the principle that the **Git repository is the single source of truth**:

- **Metadata:** `workflows/**/metadata.yaml` provides structured, machine-validated truth.
- **Scripts:** `workflows/**/scripts/` contains the actual execution logic.
- **Decisions:** `docs/decisions/` documents rationale for physical parameters and environment choices.
- **CI:** Deterministic checks (JSON schema, ShellCheck, MkDocs strict) guarantee software integrity.