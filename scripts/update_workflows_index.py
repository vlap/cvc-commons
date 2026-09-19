#!/usr/bin/env python3
"""
Deterministic index generator for Climate Commons workflows.

Reads all workflow metadata.yaml files, validates them against
schemas/workflow.schema.json, and generates WORKFLOWS.md and docs/workflows.md.

Never mutates configuration files (.readthedocs.yaml, mkdocs.yml, etc.).
"""

import json
import os
import sys
import yaml
import jsonschema


def load_schema(schema_path="schemas/workflow.schema.json"):
    with open(schema_path, "r", encoding="utf-8") as f:
        return json.load(f)


def find_workflows(workflows_dir="workflows"):
    workflows = []
    for root, _, files in os.walk(workflows_dir):
        if "metadata.yaml" in files:
            yaml_path = os.path.join(root, "metadata.yaml")
            workflows.append(yaml_path)
    return sorted(workflows)


def generate_index():
    schema = load_schema()
    workflow_files = find_workflows()

    validated_workflows = []
    has_errors = False

    for wf_path in workflow_files:
        with open(wf_path, "r", encoding="utf-8") as f:
            try:
                data = yaml.safe_load(f)
            except yaml.YAMLError as exc:
                print(f"ERROR: Failed parsing YAML in {wf_path}: {exc}", file=sys.stderr)
                has_errors = True
                continue

        try:
            jsonschema.validate(instance=data, schema=schema)
            validated_workflows.append((wf_path, data))
        except jsonschema.ValidationError as err:
            print(f"ERROR: Schema validation failed for {wf_path}: {err.message}", file=sys.stderr)
            has_errors = True

    if has_errors:
        print("Encountered validation errors. Aborting index generation.", file=sys.stderr)
        sys.exit(1)

    # Sort deterministically by workflow name
    validated_workflows.sort(key=lambda item: item[1]["identity"]["name"])

    # Build Markdown table
    header = (
        "# Workflows Catalog\n\n"
        "This catalog is deterministically generated from `workflows/**/metadata.yaml`.\n\n"
        "| Workflow | Domain | Maintainer | Platform | Software Status | Scientific Status |\n"
        "|:---------|:-------|:-----------|:---------|:----------------|:------------------|\n"
    )

    rows = []
    for _, wf in validated_workflows:
        name = wf["identity"]["name"]
        domain = wf["ownership"].get("scientific_domain", "unspecified")
        maintainer = wf["ownership"].get("maintainer", "unspecified")
        systems = ", ".join(wf.get("environment", {}).get("systems", ["Unknown"]))
        soft_val = wf["lifecycle"]["software_validation"]
        sci_val = wf["lifecycle"]["scientific_validation"]

        soft_icon = "✅" if soft_val == "passed" else ("❌" if soft_val == "failed" else "⏳")
        sci_icon = "🔬" if sci_val == "validated" else ("📋" if sci_val == "reviewed" else "❓")

        link = f"[{name}](./docs/_workflows/{name}.md)"
        link_docs = f"[{name}](./_workflows/{name}.md)"
        status_str = f"{soft_icon} {soft_val} | {sci_icon} {sci_val}"

        rows.append({
            "root_row": f"| {link} | {domain} | {maintainer} | {systems} | {status_str} |\n",
            "docs_row": f"| {link_docs} | {domain} | {maintainer} | {systems} | {status_str} |\n",
        })

    # Generate root WORKFLOWS.md
    with open("WORKFLOWS.md", "w", encoding="utf-8") as f:
        f.write(header)
        for r in rows:
            f.write(r["root_row"])
        f.write(f"\n*Total registered workflows: {len(validated_workflows)}*\n")

    # Generate docs/workflows.md for MkDocs navigation
    os.makedirs("docs", exist_ok=True)
    with open("docs/workflows.md", "w", encoding="utf-8") as f:
        f.write(header)
        for r in rows:
            f.write(r["docs_row"])
        f.write(f"\n*Total registered workflows: {len(validated_workflows)}*\n")

    print(f"Successfully generated WORKFLOWS.md and docs/workflows.md for {len(validated_workflows)} workflow(s).")


if __name__ == "__main__":
    generate_index()
