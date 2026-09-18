import os

site_name = "Climate Commons PoC"
site_description = "Living documentation for BSC climate workflows"
copyright = "BSC Climate Variability and Change Group"

theme:
    name: material
    features:
        - navigation.tabs
        - toc.integrate

markdown_extensions = [
    "toc",
    "tables",
    "fenced_code",
]

nav = [
    {"Home": "index.md"},
    {"Workflows": []},  # Auto-populated by Librarian Agent
]