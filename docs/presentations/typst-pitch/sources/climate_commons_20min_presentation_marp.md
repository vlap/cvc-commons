---
marp: true
theme: default
paginate: true
size: 16:9
---

# Climate Commons

## A living knowledge system for scientific workflows

**Prototype proposal for BSC climate computing**

> The goal is not another documentation repository.  
> The goal is to make shared scientific workflows **findable, reusable and trustworthy**.

<!--
~1.5 min
Open with the problem, not the technology.
-->

---

# 1. The problem is institutional memory

Scientific workflows are rarely just scripts.

They include:

- model-specific assumptions
- HPC environment knowledge
- input/output conventions
- diagnostics
- operational workarounds
- scientific rationale
- undocumented dependencies

That knowledge is often split across:

**Git repositories · home directories · notebooks · wikis · scripts · people**

When infrastructure changes, the knowledge decays.

> **The expensive failure is not losing a file.  
> It is losing the context needed to use the file correctly.**

<!--
~2 min
Emphasize that the unit of knowledge is a workflow + context, not a script.
-->

---

# 2. Why previous documentation systems decay

The failure mode is familiar:

```text
Useful workflow
      ↓
central repository
      ↓
initial documentation
      ↓
people use their own tools
      ↓
models / HPC / dependencies change
      ↓
documentation gets stale
      ↓
scientists stop trusting it
      ↓
knowledge returns to individuals
```

The problem is therefore not:

> "We need better documentation."

It is:

> **How do we make knowledge maintenance part of normal scientific work?**

<!--
~2 min
This is the key motivation. Avoid blaming previous efforts; the process itself creates maintenance debt.
-->

---

# 3. Climate Commons: the operating idea

## Capture → Discover → Verify → Maintain

### Capture
Turn existing scripts and workflows into reusable institutional knowledge.

### Discover
Let a scientist find an existing solution before recreating it.

### Verify
Make uncertainty and validation status visible.

### Maintain
Detect when workflows, documentation or assumptions become stale.

**Git is the durable memory.**

The agent is only a mechanism for reducing the effort required to maintain it.

<!--
~1.5 min
This is the conceptual heart of the proposal.
-->

---

# 4. What belongs in the repository?

Not just code.

```text
                 Climate Commons
                       |
       +---------------+---------------+
       |               |               |
     Code          Workflow          Evidence
                   metadata
       |               |               |
       +---------------+---------------+
                       |
                Human-readable docs
                       |
                 Decisions / rationale
                       |
                    Tests / CI
                       |
                  Review history
```

A reusable workflow should tell us:

- what it does
- when to use it
- what it needs
- what it produces
- what environment it assumes
- how it was checked
- what is still unknown
- who owns the scientific meaning

<!--
~2 min
Make clear that "why" is first-class, not just "how".
-->

---

# 5. The architecture is GitHub-native

```text
                      GitHub repository
                             |
          +------------------+------------------+
          |                  |                  |
          v                  v                  v
     Workflow/code         CI/tests        Documentation
          |                  |                  |
          +------------------+------------------+
                             |
                           gh-aw
                             |
                          Gemini
                             |
                    reasoning / analysis
                             |
                       safe outputs
                             |
                       draft PR / issue
                             |
                       human review
                             |
                            main
```

### Design principle

**Deterministic Actions do deterministic work.**

**Agentic workflows do reasoning-heavy work.**

GitHub Agentic Workflows (`gh-aw`) runs agents through GitHub Actions and provides controls for permissions, tools, sandboxing and safe outputs. citeturn711682search6turn711682search0

<!--
~2 min
This is the major architectural change from the earlier concept: no custom Climate Commons CLI.
-->

---

# 6. AI is not the source of truth

The agent should create:

```text
Facts
  ↓
Inferences
  ↓
Unknowns
  ↓
Proposed documentation
  ↓
Human review
  ↓
Institutional knowledge
```

Example:

**Observed**

> `perturb.py` adds `0.1` to temperature.

**Not established**

> `0.1` is scientifically justified.

**Required**

> Scientific rationale must be confirmed by a human.

The system must be allowed to say:

> **"We do not know."**

<!--
~2 min
This is the trust argument. The agent is an assistant to institutional memory, not an authority.
-->

---

# 7. Trust has multiple dimensions

A workflow can be:

| Dimension | State |
|---|---|
| Documentation | Reviewed |
| Software checks | Passed |
| Scientific validation | Required |
| Reproducibility | Partial |
| HPC environment | Unknown |
| Maintenance | Current |

Do **not** collapse all of this into one:

```yaml
status: verified
```

Instead, distinguish:

**Observed → mechanically checked → human reviewed → scientifically validated**

A passing Python test must never imply scientific validity.

<!--
~1.5 min
This slide prevents the "green badge = scientifically correct" failure mode.
-->

---

# 8. What an ingestion interaction looks like

A scientist submits a GitHub issue:

```text
"Please ingest workflows/prediction-data/foo
for reuse by the group."
```

Then:

```text
Issue
  ↓
gh-aw + Gemini
  ↓
inspect repository
  ↓
extract evidence
  ↓
identify unknowns
  ↓
generate metadata + docs + candidate tests
  ↓
run deterministic checks
  ↓
draft pull request
  ↓
human review
```

The scientist does **not** need to learn an AI framework.

GitHub is the interface.

<!--
~2 min
This makes the system tangible. The important point is that the institutional interaction is ordinary GitHub work.
-->

---

# 9. The user can choose any local AI agent

Climate Commons should **not** own a local AI runtime.

A scientist may use:

- `agy` / Antigravity
- Codex
- Claude Code
- VS Code Agent Mode
- another coding agent

The repository supplies the contract:

```text
AGENTS.md
CONTRIBUTING.md
workflow schema
security rules
validation commands
```

So:

```text
Institutional automation
        = GitHub + gh-aw + Gemini

Personal productivity
        = scientist's preferred agent
```

**The repository should not care which local agent produced a Git diff.**

<!--
~1.5 min
This keeps the project vendor-neutral and avoids building another tool that itself needs maintenance.
-->

---

# 10. Safety boundary

### Agents may

- inspect code and documentation
- generate metadata
- propose documentation
- detect drift
- propose low-risk fixes
- create draft PRs
- explain repository knowledge

### Agents may not autonomously

- merge to `main`
- launch production EC-Earth jobs
- submit arbitrary HPC jobs
- change scientific methodology
- modify production infrastructure
- access unrestricted secrets

The intended control loop is:

```text
Read → Reason → Propose → Check → Review → Merge
```

`gh-aw`'s safe-output model keeps agent runs read-only while a separate controlled job performs the requested GitHub write. citeturn711682search0turn711682search7

<!--
~2 min
Security is part of the architecture, not an appendix.
-->

---

# 11. What the prototype will actually test

## First vertical slice

**Workflow ingestion + reuse documentation**

Start with **~10 real workflows**.

For each:

1. submit an ingestion request
2. inspect/extract evidence
3. generate metadata
4. generate reusable documentation
5. add lightweight validation where safe
6. produce a draft PR
7. human review
8. try to reuse the workflow

### Success is not "the README looks good."

Success is:

> **Can another scientist use the workflow without asking its original author the basic questions?**

<!--
~2 min
This is the practical experiment. It keeps the project grounded.
-->

---

# 12. What comes after the first vertical slice?

### C — Maintenance

Use scheduled/event-driven agents to detect:

- documentation drift
- broken links
- stale dependencies
- orphaned workflows
- missing verification
- duplicate solutions

### D — Infrastructure migration

Later:

- identify workflows affected by HPC/software changes
- compare environment assumptions
- prepare migration PRs
- coordinate controlled validation

**Do not build C or D until ingestion demonstrates value.**

<!--
~1 min
Make the roadmap intentionally sequential, not a shopping list.
-->

---

# 13. Why this can stay low-maintenance

The system deliberately avoids becoming a platform to operate.

### No

- custom web application
- always-on agent service
- knowledge database
- vector database
- mandatory local CLI
- autonomous HPC service

### Yes

- GitHub
- GitHub Actions
- `gh-aw`
- Gemini
- repository metadata
- deterministic CI
- ReadTheDocs
- pull requests

Git remains the durable artifact.

Agent/model vendors remain replaceable.

<!--
~1.5 min
This directly addresses the original project's maintenance failure mode.
-->

---

# 14. The first implementation steps

## Phase 0 — make the repository trustworthy

- clean up existing privileged automation
- establish community/security files
- protect `main`
- pin Actions and dependencies
- make documentation builds reliable on ReadTheDocs

## Phase 1 — deterministic foundation

- workflow schema
- evidence model
- lifecycle/verification model
- generated workflow index
- CI checks

## Phase 2 — agentic prototype

- install `gh-aw`
- Gemini read-only repository health
- Gemini read-only workflow inspection
- ingestion → draft PR
- evaluate on 10 workflows

**No autonomous HPC execution.**

<!--
~2 min
This is the concrete implementation sequence.
-->

---

# 15. Decision criteria

After the pilot, ask:

### Does it save time?

Does ingestion reduce documentation/setup effort?

### Does it improve reuse?

Can someone outside the original author recover the workflow?

### Does it improve trust?

Can users see what is verified, unknown or stale?

### Does it reduce knowledge debt?

Are fewer workflows orphaned or undocumented?

### Does it remain maintainable?

Could we remove the AI engine tomorrow and still have a useful repository?

> **The project succeeds when the repository becomes more useful than the sum of the scripts inside it.**

<!--
~1.5 min
End on measurable institutional value rather than AI capability.
-->

---

# 16. References / current implementation basis

### Repository

`vlap/cvc-commons`

### GitHub Agentic Workflows

- https://github.github.com/gh-aw/
- https://github.github.com/gh-aw/introduction/overview/
- https://github.github.com/gh-aw/reference/safe-outputs/
- https://github.github.com/gh-aw/engines/gemini/
- https://github.github.com/gh-aw/gallery/docs-automation/

### Documentation

- https://docs.readthedocs.com/

### Community / software practice

- https://docs.github.com/en/communities/
- https://scorecard.dev/

<!--
~Optional source slide. The talk itself is ~20 minutes without spending time here.
-->
