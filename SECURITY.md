# Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in Climate Commons or associated automation, please do **not** open a public issue.

Instead, please send a private security report to the repository maintainers via GitHub Security Advisories or by emailing the project maintainer (`@vlap`).

---

## Public Repository Threat Model

Because Climate Commons is a public repository that executes automation on contribution events:

1. **Untrusted Code Execution:**
   - Workflows submitted via external Pull Requests must never execute on persistent self-hosted BSC runners or any environment with access to BSC internal networks, credentials, or HPC clusters.
   - All deterministic CI checks run on ephemeral, isolated GitHub-hosted runners.
2. **Secrets & Credentials:**
   - Never commit API keys, SSH keys, passwords, or cluster access tokens to the repository.
   - GitHub Actions secrets (`GEMINI_API_KEY`, etc.) are never exposed to pull requests from forks.
3. **Agentic Execution Safeguards:**
   - AI agents run with read-only repository permissions and communicate mutations strictly through constrained safe outputs (draft pull requests or issue comments).
   - Agent prompts are sandboxed to treat all repository files, issues, and commit messages as untrusted data to mitigate prompt injection.
4. **Autonomous Merges Prohibited:**
   - No automated pipeline or agent possesses permissions to merge code into `main` or bypass review rules.
