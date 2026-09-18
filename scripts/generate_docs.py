import os
import yaml
from jinja2 import Environment, FileSystemLoader

# Load template
env = Environment(loader=FileSystemLoader('.github/templates'))
template = env.get_template('workflow.md.j2')

# Generate docs for each workflow
for root, _, files in os.walk('workflows'):
    if 'metadata.yaml' in files:
        yaml_path = os.path.join(root, 'metadata.yaml')
        with open(yaml_path, 'r') as f:
            metadata = yaml.safe_load(f)
        script_path = os.path.join(root, 'scripts', f"{metadata['name']}.sh")
        if os.path.exists(script_path):
            with open(script_path, 'r') as f:
                metadata['script_content'] = f.read()
        output_path = os.path.join('docs', '_workflows', f"{metadata['name']}.md")
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w') as f:
            f.write(template.render(**metadata))