## Description

<!-- Describe the changes made by this PR. Include motivation and context. -->

## Type of Change

- [ ] New scientific workflow ingestion
- [ ] Workflow documentation update
- [ ] Schema / deterministic generator enhancement
- [ ] Infrastructure / CI update
- [ ] Bug fix

## Validation Checklist

- [ ] `python3 scripts/update_workflows_index.py` ran without errors
- [ ] `mkdocs build --strict` passed cleanly
- [ ] Shell scripts pass `shellcheck`
- [ ] Workflow metadata adheres to `schemas/workflow.schema.json`
- [ ] No hardcoded passwords, cluster secrets, or personal access tokens included
- [ ] Human scientific review completed (for any changes touching physical algorithms or constants)
