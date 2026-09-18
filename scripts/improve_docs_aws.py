import boto3
import json

client = boto3.client('bedrock-runtime', region_name='us-east-1')
with open('docs/_workflows/download_en4.md', 'r') as f:
    docs = f.read()

response = client.invoke_model(
    modelId='mistral.mistral-large-3-675b-instruct',
    body=json.dumps({'prompt': f'Improve these docs:\n\n{docs}', 'max_tokens': 1000})
)
suggestions = json.loads(response['body'].read())['outputs'][0]['text']

with open('docs_improvements.txt', 'w') as f:
    f.write(suggestions)