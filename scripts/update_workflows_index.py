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

# Update ReadTheDocs config (.readthedocs.yaml) if it exists
if os.path.exists('.readthedocs.yaml'):
    with open('.readthedocs.yaml', 'r') as f:
        rtd_config = yaml.safe_load(f)

    if rtd_config is None:
        rtd_config = {'version': 2}

    # Ensure 'build.files' exists and update workflow docs
    if 'build' not in rtd_config:
        rtd_config['build'] = {}
    if 'files' not in rtd_config['build']:
        rtd_config['build']['files'] = []

    for wf in sorted(workflows, key=lambda x: x['name']):
        docs_path = f'docs/_workflows/{wf["name"]}.md'
        if docs_path not in rtd_config['build']['files']:
            rtd_config['build']['files'].append(docs_path)

    with open('.readthedocs.yaml', 'w') as f:
        yaml.dump(rtd_config, f)