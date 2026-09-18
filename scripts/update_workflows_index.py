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

# Update mkdocs.yml (if it exists)
if os.path.exists('docs/mkdocs.yml'):
    with open('docs/mkdocs.yml', 'r') as f:
        mkdocs_config = yaml.safe_load(f)

    if mkdocs_config is None:
        mkdocs_config = {'nav': []}

    if 'nav' not in mkdocs_config:
        mkdocs_config['nav'] = []

    # Find or create the "Workflows" section
    workflows_section = None
    for item in mkdocs_config['nav']:
        if isinstance(item, dict) and 'Workflows' in item:
            workflows_section = item['Workflows']
            break

    if workflows_section is None:
        workflows_section = []
        mkdocs_config['nav'].append({'Workflows': workflows_section})

    # Update the workflows list
    workflows_section.clear()
    for wf in sorted(workflows, key=lambda x: x['name']):
        workflows_section.append({wf['name']: f"_workflows/{wf['name']}.md"})

    with open('docs/mkdocs.yml', 'w') as f:
        yaml.dump(mkdocs_config, f)