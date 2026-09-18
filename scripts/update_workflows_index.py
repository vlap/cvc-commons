import os
import yaml

# Build WORKFLOWS.md
workflows = []
for root, _, files in os.walk('workflows'):
    if 'metadata.yaml' in files:
        with open(os.path.join(root, 'metadata.yaml'), 'r') as f:
            workflow = yaml.safe_load(f)
        workflows.append(workflow)

with open('WORKFLOWS.md', 'w') as f:
    f.write("# Workflows Status\n\n")
    f.write("| Workflow | Owner | Status | Last Verified |\n")
    f.write("|----------|-------|--------|---------------|\n")
    for wf in sorted(workflows, key=lambda x: x['name']):
        status = wf.get('status', '⚪ Experimental')
        last_verified = wf.get('last_verified', 'Never')
        f.write(
            f"| [{wf['name']}](./_workflows/{wf['name']}.md) | "
            f"{wf['owner']} | {status} | {last_verified} |\n"
        )

    mkdocs_config = yaml.safe_load(f)

mkdocs_config['nav'][1]['Workflows'] = [
    {'name': wf['name'], 'file': f"_workflows/{wf['name']}.md"}
    for wf in sorted(workflows, key=lambda x: x['name'])
]

    yaml.dump(mkdocs_config, f)