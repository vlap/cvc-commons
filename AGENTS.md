# Agents

## Intake Agent
- **Trigger**: Push to `/workflows/*/scripts/*`.
- **Action**:
  1. Parse `metadata.yaml` and scripts to extract metadata.
  2. Generate `docs/_workflows/<name>.md` using Jinja2 template.
  3. Open a draft PR with the generated docs.
- **Engine**: Gemini API (via `gh.aw`).
- **Safety**: Level 1 (docs-only; no code execution).
- **Rate Limit**: Max 3 open PRs/day.

## Librarian Agent
- **Trigger**: Weekly schedule or PR merge to `main`.
- **Action**:
  1. Regenerate `WORKFLOWS.md` from all `metadata.yaml`.
  2. Validate internal links in docs (`mkdocs serve --strict`).
  3. Suggest doc improvements via Gemini API (Level 2 review).
- **Engine**: Gemini API.
- **Safety**: Level 1 (auto-generated changes are PR-only).

## Validation Agent
- **Trigger**: PR opened or weekly schedule.
- **Action**:
  1. Run `lint.sh` (ShellCheck) on scripts.
  2. Compare `metadata.yaml` dependencies against `infrastructure/mn5.yaml`.
  3. Add PR comment with warnings (e.g., "netcdf/4.7 is deprecated").
- **Engine**: Static analysis + Gemini API.
- **Safety**: Level 1.