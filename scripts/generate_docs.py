#!/usr/bin/env python3
"""
Generate Markdown documentation for individual workflows from metadata.yaml.
"""

import os
import yaml
from jinja2 import Environment, FileSystemLoader

# Load template
template_dir = os.path.join(os.path.dirname(__file__), '..', '.github', 'templates')
env = Environment(loader=FileSystemLoader(template_dir))
template = env.get_template('workflow.md.j2')

# Generate docs for each workflow
generated_count = 0
for root, _, files in os.walk('workflows'):
    if 'metadata.yaml' in files:
        yaml_path = os.path.join(root, 'metadata.yaml')
        with open(yaml_path, 'r', encoding='utf-8') as f:
            metadata = yaml.safe_load(f)

        name = metadata['identity']['name']
        script_path = os.path.join(root, 'scripts', f"{name}.sh")
        if os.path.exists(script_path):
            with open(script_path, 'r', encoding='utf-8') as f:
                metadata['script_content'] = f.read()

        output_path = os.path.join('docs', '_workflows', f"{name}.md")
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(template.render(**metadata))
        generated_count += 1
        print(f"Generated docs for {name} -> {output_path}")
print(f"Completed documentation generation for {generated_count} workflow(s).")
