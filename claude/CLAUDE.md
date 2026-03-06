## General guidelines

* Write software that follows these principles:
  * Composition over inheritance
  * Locality of behavior
  * Make invalid states unrepresentable
* Prefer logging libraries instead of printing directly to stdout

## Tools

Always use `relace_search` for codebase exploration. Do not call it in parallel with other tools.

## Languages

Frequently used:
* Python
* TypeScript
* Rust

### Python

ALWAYS look at the `pyproject.toml` to understand the project structure, dependencies and entrypoints.

I prefer the following toolchain:
- `uv` for dependency/environment management
- `ruff` for formatting
- `mypy` for type checking
- `pytest` for tests

When in a uv project:
- Avoid directly editing `pyproject.toml` - use `uv` commands instead (e.g. `uv add` to add a dependency)
- Use `uv run` instead of directly calling `python` or other binaries. When an `.env` file is present, use `uv run --env-file .env`.

General guidelines:
- Avoid using `import` in functions; do it in the import block at the top of the file.
- Avoid overly ambiguous or permissive logic (do not allow multiple data types as inputs unless there is direct justification)
- Use accurate and precise type annotations to the best of your ability.

### Rust

Avoid directly editing `Cargo.toml` - use `cargo` commands instead (e.g. `cargo add` to add a dependency).

## Shell

- Shell: `zsh`
- Terminal: WezTerm
- Set `GIT_EDITOR=true` on git commands that may open an editor (e.g. `git rebase --continue`, `git commit` without `-m`) to prevent blocking on interactive input

## Cloud

Platforms:
- AWS: Preferred for production infrastructure
- GCP: Preferred for ML training and storage
- CloudFlare: DNS for relace.ai, relace.run; reverse proxy for our model APIs
- Modal: Preferred for production inference workloads, quick prototyping. Also contains some production relace-agent APIs
- Grafana Cloud: Monitoring, logging, alerting

Prefer to use IaC (infrastructure-as-code). Avoid destructive actions over CLI. Do not knowingly introduce drift from IaC-managed resources (e.g. Terraform).

Always be mindful of the current kube context (`kubectx`) and SSO/auth profile (e.g. `AWS_PROFILE`) when running infrastructure CLI commands to avoid operating on the wrong cluster or account.

Common tools:
- `aws` cli
- `gcloud` cli
- `kubectl` and `kubectx` for Kubernetes
- `terraform` (and sometimes AWS CDK)
- `modal` cli (usually should run via `uv run`)

### Modal

Prefer the module syntax for Modal CLI commands:
- `modal run -m package.module::function`
- `modal serve -m package.module::function`
- `modal deploy -m package.module::function`

### Kubernetes

- **Production**: AWS EKS
- **ML training**: GCP GKE (also use GCS for storage)
- Use `kubectx` for context switching between clusters
- Use `kubectl` for cluster operations

## Development Workflow

* Prefer working on a feature branch with stacked diffs approach in git. Always keep a clean, linear git log.
* Do not include details on intermediate state (i.e. edits that were reverted) in PR or commit messages
* Do not go way overboard on detail for commit messages and PRs. Keep comments focused and practical.
* Use `gh` to create and manage PRs
* Use Linear MCP to read and update issues. Always reference a Linear issue (e.g. `Part of REL-123`) in PR messages when relevant.

### Git rebasing

* For interactive rebase, use a three-step workflow:
  1. `todo=$(mktemp) && GIT_SEQUENCE_EDITOR="cp \$1 $todo && cat $todo && false" git rebase -i <base>` — saves the todo to a tempfile, prints it, and aborts.
  2. Use the Edit tool to modify `$todo` (change pick to edit/fixup/drop, reorder lines, etc).
  3. `GIT_SEQUENCE_EDITOR="cp $todo" git rebase -i <base>` — replays with the edited todo.
* To amend a non-HEAD commit: use `edit` in the todo, make changes, `git commit --amend --no-edit`, `git rebase --continue`.
* Never chain rebase commands in a single Bash call — run each step separately to inspect intermediate state.
* After every rebase, verify with both `git log --oneline` and `git diff <base>..HEAD --stat`.
