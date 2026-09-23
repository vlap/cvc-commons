// SeaSlides Typst Slides — cvc-shared-tools Pitch Presentation
// Theme: BSC Blueprint (Clean Technical / Scientific Design)
// Touying: 0.7.4 compatible

#import "@preview/touying:0.7.4": *
#import "template.typ": *

#show: blueprint-theme.with(
  aspect-ratio: "16-9",
  footer: [CVC Shared Tools \u{2014} Barcelona Supercomputing Center],
  config-info(
    title: [CVC Shared Tools],
    subtitle: [Almost-Zero-Cost Maintenance & Free Documentation for Climate Workflows],
    author: [Prepared by an AI agent CVC],
    date: datetime.today(),
  ),
  config-common(breakable: false),
)

#set text(font: ("DejaVu Sans", "Arial"), size: 13.5pt)
#show raw: set text(font: "DejaVu Sans Mono", size: 8.5pt)
#set par(leading: 0.55em)
#set heading(numbering: none)

#title-slide()

#speaker-note[
  Welcome everyone. Today we are presenting a proposal for cvc-shared-tools: a curated repository for scientific workflows and preprocessing pipelines designed for almost-zero-cost maintenance and automated documentation.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 1: DO YOU USE THESE OR THIS?
// ══════════════════════════════════════════════════════════════════

== Do you use these or this?

#v(0.2em)

#grid(columns: (1.15fr, 45pt, 1.15fr), align: (center + horizon, center + horizon, center + horizon),
  {
    text(weight: "bold", size: 1.05em, fill: palette.blue)[Do you use these?]
    v(0.8em)
    grid(columns: (1fr, 1fr, 1fr), row-gutter: 14pt, column-gutter: 12pt, align: center + horizon,
      {
        image("assets/chatgpt.svg", width: 34pt)
        v(0.2em)
        text(size: 0.65em, fill: palette.gray)[OpenAI]
      },
      {
        image("assets/gemini.svg", width: 34pt)
        v(0.2em)
        text(size: 0.65em, fill: palette.gray)[Gemini]
      },
      {
        image("assets/claude.svg", width: 34pt)
        v(0.2em)
        text(size: 0.65em, fill: palette.gray)[Claude]
      },
      {
        image("assets/copilot.svg", width: 34pt)
        v(0.2em)
        text(size: 0.65em, fill: palette.gray)[Copilot]
      },
      {
        image("assets/meta.svg", width: 34pt)
        v(0.2em)
        text(size: 0.65em, fill: palette.gray)[Meta AI]
      },
      {
        image("assets/deepseek.svg", width: 34pt)
        v(0.2em)
        text(size: 0.65em, fill: palette.gray)[DeepSeek]
      }
    )
  },
  {
    text(size: 2em, weight: "black", fill: palette.gray.transparentize(50%))[VS]
  },
  {
    text(weight: "bold", size: 1.05em, fill: palette.blue)[Or do you use this?]
    v(0.8em)
    image("assets/gitlab.svg", width: 44pt)
    v(0.4em)
    spec-card([BSC Institutional Repository], [
      #align(center)[
        #text(size: 1.15em, weight: "bold", fill: palette.red)[cvc-shared-tools] \
        #v(0.2em)
        #text(size: 0.72em, fill: palette.gray)[gitlab.earth.bsc.es/cvc/cvc-shared-tools.git]
      ]
    ], rev: "v1.0")
  }
)

#v(0.4em)
#insight-box[
  *The Irony:* Many of us interact with AI tools daily. Yet our shared departmental code remains scattered across personal `/gpfs/scratch/` directories where it quickly decays.
]

#speaker-note[
  Open with this question: Do you use these tools on the left? Most of us use OpenAI, Gemini, Claude, Copilot, Meta, or DeepSeek. But how many of us know and actively use cvc-shared-tools on the right? Let's bridge this gap.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 2: THE HORIZON SCAN (DUEBEN ET AL., 2026)
// ══════════════════════════════════════════════════════════════════

== Climate Adaptation vs. AI Adaptation: Changing How We Work

#grid(columns: (1.15fr, 1fr), column-gutter: 14pt, align: (horizon, horizon),
  {
    image("assets/dueben-paper-header.png", width: 85%)
    v(0.15em)
    align(center)[
      #text(size: 0.65em, fill: palette.gray)[
        Dueben (ECMWF), Bauer (MPI-M), Fuhrer (MeteoSwiss), Koldunov (AWI), Kristiansen (Met Norway) \
        *arXiv:2606.25076* (June 2026)
      ]
    ]
  },
  {
    concept-card([1. Paradigm Shift: Ways of Working], [
      - ML skill is proven; the next step is *reshaping working practices*.
      - Re-engineering how climate models and workflows are coded, verified, and maintained.
    ], zone: "SHIFT")
    v(0.3em)
    concept-card([2. Agentic Software Engineering], [
      - Shifting burden from individual postdocs to *clear contracts, automated tests, and agentic workflows*.
      - Requires robust data stewardship and trust frameworks.
    ], zone: "AGENT")
  }
)

#v(0.25em)
#insight-box[
  #align(center)[
    #text(weight: "bold", size: 1.05em, fill: palette.blue)[AI climate change: Adaptation or Mitigation]
  ]
]

#speaker-note[
  Walk through the paper: Peter Dueben from ECMWF, Peter Bauer from MPI-M, and European colleagues argue that the AI revolution is no longer just about forecast skill, but about changing 'how we work'. Specifically, agentic software engineering and standardized verification are needed to prevent maintenance collapse.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 3: SIMPLIFIED PROBLEM SLIDE
// ══════════════════════════════════════════════════════════════════

== Why Previous Documentation Systems Decay

#grid(columns: (1fr, 1fr), column-gutter: 16pt,
  concept-card([Where Scripts Live Today], [
    - *Personal scratch spaces:* Scripts live in `/gpfs/scratch/bsc32/...`, unshared and unversioned.
    - *Copy-paste variants:* Ten slightly different versions of the same interpolation script.
    - *Silent breakage:* Hardcoded paths and modules break quietly when HPC systems update.
  ], zone: "SCRATCH"),
  concept-card([Why Manual Docs Fail], [
    - *Wikis detach from code:* Documentation written in wikis rots within weeks.
    - *High maintenance friction:* Scientists don't have time to manually update documentation after parameter tweaks.
    - *Unknown health:* Nobody knows if an old script still runs until someone tries it.
  ], zone: "DOCS")
)

#v(0.4em)
#dimension-box([The Core Opportunity], [
  We rarely lose scientific workflows because the physics was wrong. We lose them because documentation was detached from code. We need documentation that rebuilds itself automatically in Git.
])

#speaker-note[
  Keep it simple: Scripts get lost in scratch folders. Documentation rots because it's detached from code. We need a system where documentation is tied to code and updates automatically.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 4: THE DURABLE ARTIFACT (GIT SINGLE SOURCE OF TRUTH)
// ══════════════════════════════════════════════════════════════════

== Climate Commons: The Durable Artifact

#grid(columns: (1.1fr, 1fr), column-gutter: 16pt,
  {
    concept-card([Everything in Git], [
      - `workflows/**/metadata.yaml`: Structured metadata validated by schema.
      - `workflows/**/scripts/`: Actual Bash, Python, or CDO scripts.
      - `docs/decisions/`: Scientific & infrastructure Decision Records (ADRs).
      - `WORKFLOWS.md`: Automatically generated workflow catalog.
      - `schemas/`: Machine-executable contracts.
    ], zone: "REPO")
    v(0.4em)
    schematic-card([Core Rule: No Hidden State], [
      If it is not in Git, it does not exist for the team or for assistants. Git provides complete transparency and version history.
    ])
  },
  {
    spec-card([metadata.yaml Contract], [
      ```yaml
      schema_version: "1.0"
      workflow:
        name: "en4-to-orca"
        tier: "production"
      environment:
        platform: "mn5"
        modules:
          - "netcdf/4.7"
          - "cdo"
          - "sosie"
      validation:
        documentation: "reviewed"
        software: "passed"
        scientific: "required"
      ```
    ], rev: "CONTRACT")
  }
)

#speaker-note[
  Introduce the repository structure. The Git repository is the sole durable artifact. We do not build an external web database. Every workflow includes a metadata.yaml file that defines its platform, modules, inputs, and validation status according to a strict JSON Schema.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 5: THE PROBLEM IS INSTITUTIONAL MEMORY
// ══════════════════════════════════════════════════════════════════

== The Problem is Institutional Memory

#align(center)[
#text(size: 9.5pt)[
```text
                       CVC WORKFLOWS
                             │
                 ┌───────────┴────────────┐
                 │                        │
             BSC-ES GitHub             AI Agents
                 │                        │
        ┌────────┼────────┐       ┌───────┼────────┐
        │        │        │       │       │        │
      Code      Docs     Tests   Intake  Review  Repair
        │        │        │       │       │        │
        └────────┴────────┴───────┴───────┴────────┘
                             │
                       Pull Requests ──► [Scientists Review]
                             │                 │
                             ▼                 ▼
                      Documentation        [LATER: Ephemeral
                       Auto-Rebuilt        BSC HPC Runner]
```
]
]

#v(0.1em)
#insight-box[
  *How We Preserve Memory:* By connecting shared code and AI intake through standard Pull Requests, scientists stay in control while documentation rebuilds automatically on merge.
]

#speaker-note[
  Explain how this solves institutional memory: Workflows are held centrally on GitHub. AI agents help with intake and testing, but scientists remain the sole gatekeepers. Documentation rebuilds automatically on merge.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 6: EXPLAIN LIKE I'M FIVE
// ══════════════════════════════════════════════════════════════════

== Explain Like I'm Five: Agentic Workflows

#grid(columns: (1fr, 1fr), column-gutter: 16pt,
  concept-card([A "Smart Intern" in the Cloud], [
    - *Beyond rigid scripts:* Traditional CI only runs fixed commands. Agentic workflows (`gh-aw`) give an AI a goal, tools, and repo context.
    - *Can read and reason:* It reads messy user scripts, checks schema rules, spots deprecated HPC modules, and drafts docs.
    - *Triggered automatically:* Runs on schedule, on issue creation, or on new PRs via standard GitHub Actions.
  ], zone: "HOW IT WORKS"),
  concept-card([Strict Safety & Zero Cost], [
    - *Can only suggest, never merge:* All agent output is restricted to Draft PRs or Issue comments for scientists to review.
    - *Zero HPC credentials:* No SSH access, no keys, zero execution on MareNostrum 5 or cluster nodes.
    - *Free maintenance:* Runs entirely on GitHub free runner tiers and API allocations (Gemini / Claude).
  ], zone: "SAFETY")
)

#v(0.4em)
#insight-box[
  *In short:* Think of `gh-aw` as an eager research assistant who reads through messy scripts, fills out the paperwork, and leaves a tidy draft on your desk for approval.
]

#speaker-note[
  If someone asks what an agentic workflow actually is: It's like having a tireless intern in an isolated sandbox. Traditional CI is just a dumb script that breaks on a typo. An agentic workflow uses an LLM to read files, understand the context, check our schema rules, and draft pull requests. It has zero credentials to HPC, cannot merge without your approval, and costs zero euros.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 7: AUTOMATED DOCUMENTATION (REDUCED)
// ══════════════════════════════════════════════════════════════════

== Automated Documentation: Git as the Living Catalog

#grid(columns: (1.1fr, 0.9fr), column-gutter: 16pt,
  concept-card([Deterministic Catalog Generator], [
    - *Zero manual editing:* A lightweight Python script (`update_workflows_index.py`) scans all workflow metadata.
    - *Instantaneous & reliable:* Validates against JSON Schema and rebuilds `WORKFLOWS.md` in *under 1 second*.
    - *Zero server cost:* Published automatically via GitHub Pages / ReadTheDocs on every merge to `main`.
    - *Always in sync:* When a scientist updates `metadata.yaml`, the public documentation updates immediately.
  ], zone: "INDEXER"),
  concept-card([What Scientists & Engineers Get], [
    - *Instant Discovery:* Search workflows by tool (`CDO`, `NEMO`, `SOSIE`, `xarray`).
    - *HPC Compatibility:* Filter immediately by platform (`mn5`, workstation).
    - *Trust Transparency:* Clear badges for documentation, software checks, and scientific review.
  ], zone: "BENEFIT")
)

#v(0.4em)
#insight-box[
  *The Win:* Scientists never maintain separate wiki pages. Documentation stays permanently linked to code and rebuilds itself automatically on every merge.
]

#speaker-note[
  Here is how we get free documentation that never rots: The single source of truth is the metadata.yaml inside each workflow folder. A fast, deterministic Python script scans these files and generates WORKFLOWS.md and the web docs in under one second. Scientists never copy-paste into external wikis; updating Git updates the documentation.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 8: MULTI-TIER VERIFICATION & SAFETY (REDUCED)
// ══════════════════════════════════════════════════════════════════

== Multi-Tier Verification & Scientific Safety

#grid(columns: (1fr, 1fr), column-gutter: 16pt,
  spec-card([Three Distinct Trust Tiers], [
    - *1. Software Health (Deterministic):*
      ShellCheck warnings = 0, Python syntax passes, schema valid.
    - *2. Documentation Completeness:*
      Clear inputs/outputs, platform requirements, and contact authors.
    - *3. Scientific Truth (Human-Reviewed):*
      Grid interpolation, constants, and physics confirmed by domain scientists.
  ], rev: "TRUST"),
  spec-card([Strict Safety Boundaries (Class C)], [
    - *Zero HPC Execution:* Agents never hold SSH keys, credentials, or submit SLURM jobs to MareNostrum 5.
    - *Never Alter Physics:* AI cannot autonomously alter numerical schemes, grid definitions, or physical constants.
    - *Sole Gatekeeper:* All agent actions are gated behind human review via standard Pull Requests.
  ], rev: "SAFETY")
)

#v(0.4em)
#insight-box[
  *Core Rule:* We never trust a single green CI check to declare science valid. Software health, documentation, and scientific verification are kept strictly decoupled.
]

#speaker-note[
  Scientific safety is non-negotiable. We divide truth into three decoupled tiers: mechanical software checks, documentation completeness, and domain scientific review. A green CI badge only proves syntax, not physics. Furthermore, AI agents have zero access to MareNostrum 5, zero SSH keys, and cannot touch physical algorithms.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 9: LOW-MAINTENANCE PHILOSOPHY (REDUCED)
// ══════════════════════════════════════════════════════════════════

== Low-Maintenance Philosophy: Start Small, Stay Simple

#grid(columns: (1fr, 1fr), column-gutter: 16pt,
  concept-card([Pragmatic Engineering (YAGNI & DRY)], [
    - *No heavy web portal:* Git is the durable storage and single source of truth.
    - *No custom CLI runtime:* Standard `git`, bash, and python. No bespoke daemons to install or maintain.
    - *Tool Neutrality:* Developers can use any assistant locally (Antigravity, Claude Code, Copilot) or GitHub cloud agents.
  ], zone: "DESIGN"),
  concept-card([Seeding the Commons: The First 10], [
    - *Focus on high-reuse workflows:* Onboard 10 essential preprocessing pipelines (ocean regridding, atmospheric masking, CDO chains).
    - *Clean reference standards:* Each workflow provides tested scripts, `metadata.yaml`, and sample inputs.
    - *Measured by reuse:* The goal is not lines of code, but developer hours saved and scripts rescued from decay.
  ], zone: "ROADMAP")
)

#v(0.4em)
#insight-box[
  *Design Motto:* Keep it flat, keep it in Git, and start small. If a workflow isn't saving real developer time on MN5, it doesn't belong in the repo.
]

#speaker-note[
  Our engineering philosophy is ruthless simplicity: YAGNI. We do not build an over-engineered web portal or a custom CLI that breaks after two years. We use plain Git and flat files. We propose seeding the repository with 10 high-value, frequently copied workflows so the entire department immediately benefits.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 10: IN PRACTICE: THIS REPOSITORY (CVC-COMMONS)
// ══════════════════════════════════════════════════════════════════

== In Practice: How This Repo Works (cvc-commons)

#grid(columns: (1.1fr, 0.9fr), column-gutter: 16pt,
  {
    concept-card([Production Prototype: en4-to-orca], [
      - *Path:* `workflows/en4-to-orca/`
      - *Function:* SOSIE 3D interpolation of ocean temperature & salinity.
      - *Target Platform:* MareNostrum 5 (`netcdf/4.7`, `cdo`, `sosie`).
      - *Verified Clean:* 0 ShellCheck warnings, strict bash flags (`set -euo pipefail`), documented modules.
    ], zone: "WORKFLOW")
    v(0.4em)
    grid(columns: (1fr, 1fr), column-gutter: 10pt,
      stat-card([0], [ShellCheck Warnings]),
      stat-card([< 1s], [Catalog Build Time]),
    )
  },
  spec-card([Repository Machine Contracts], [
    - `schemas/workflow.schema.json`: Strict JSON schema validating workflow metadata.
    - `schemas/extraction.schema.json`: Schema for agent knowledge extraction.
    - `docs/decisions/`: Architecture & scientific Decision Records (ADRs).
    - `AGENTS.md`: Machine-readable contract defining trust tiers and safety boundaries for all agents.
  ], rev: "CONTRACTS")
)

#v(0.4em)
#insight-box[
  *Ready Today:* The repository contract, schemas, catalog generator, and reference workflow are already implemented and running in this repository.
]

#speaker-note[
  This is not vaporware: cvc-commons is an active working prototype today. In workflows/en4-to-orca/, we have a fully configured SOSIE workflow with zero ShellCheck warnings and complete metadata. The schemas in schemas/ enforce contracts deterministically, and AGENTS.md defines strict operational rules for both local and institutional agents.
]


// ══════════════════════════════════════════════════════════════════
// SLIDE 11: AGENTIC WORKFLOWS IN ACTION
// ══════════════════════════════════════════════════════════════════

== Agentic Workflows in Action: Issues & Pull Requests

#grid(columns: (1fr, 1fr), column-gutter: 16pt,
  spec-card([1. Health Audit (repo-health)], [
    - *Trigger:* Scheduled weekly (Monday) via GitHub Actions (`gh-aw`).
    - *Agent Action:* Runs Gemini/Claude in a sandbox, reads all workflows, checks schemas & module deprecations.
    - *Safe Output:* Opens a GitHub Issue with a health matrix and actionable checklist.
    - *Live Proof:* Issue \#10 was generated live by Claude Sonnet 4.6 in *65 seconds* at zero cost!
  ], rev: "AUDIT"),
  spec-card([2. Ingestion (inspect-workflow)], [
    - *Trigger:* Scientist opens an issue requesting workflow onboarding.
    - *Agent Action:* Parses script paths, extracts facts (T0), flags unknowns, and drafts `metadata.yaml`.
    - *Safe Output:* Posts a structured review comment on the issue.
    - *Draft PR:* Proposes a clean Draft Pull Request for scientist review — human merges to `main`.
  ], rev: "INGEST")
)

#v(0.4em)
#insight-box[
  *Safe Automation:* AI agents do the tedious reading, schema checking, and drafting via Issues and Draft PRs. Scientists retain 100% control over merging to main.
]

#speaker-note[
  Here is how agentic workflows actually operate in this repository: First, repo-health.md runs on schedule via gh-aw, audits the entire repo, and opens an Issue with a health report. We verified this live with Issue #10 generated by Claude Sonnet 4.6 in 65 seconds. Second, inspect-workflow.md assists scientists during onboarding: it reads their scripts, drafts candidate metadata, posts a comment, and opens a Draft PR for human review.
]

#focus-slide[
  The project succeeds when the repository becomes more useful than the sum of the scripts inside it.
]

#speaker-note[
  Leave the audience with this essential takeaway: The project succeeds when the repository becomes more useful than the sum of the scripts inside it.
]

#ending-slide[cvc-shared-tools]

#speaker-note[
  Thank the audience. Share repository link: gitlab.earth.bsc.es/cvc/cvc-shared-tools.git. Questions and discussion.
]

