## General guidelines

* Apply best software engineering practices - we are usually working on production code
* Follow existing conventions of the codebase you are working on
* Prefer code that is elegant, easily extensible, readable, and CORRECT
* Prefer logging libraries instead of printing directly to stdout
* Use language specific idioms where appropriate
* Avoid making broad assumptions on my intent - ask for clarification if you do not understand my requests
* Avoid excessive code comments - write things that a human developer would actually commit to code
* Avoid using emojis
* Avoid docstrings in cases where the function semantics are obvious from the name and parameter names/types

## Tools

Always use `relace_search` for codebase exploration. Do not call it in parallel with other tools.

## Forbidden actions

NEVER PERFORM THESE ACTIONS WITHOUT MY EXPLICIT REQUEST OR APPROVAL

* Adding tests or documentation
* Destructive or risky operations (e.g. deleting files outside of source control, directly editing production data)
* Introducing correctness issues
* Hard-coding secrets in code files

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

Avoid directly editing `pyproject.toml` - use `uv` commands instead (e.g. `uv add` to add a dependency).

You should generally not run `python` or `python3` directly - use `uv run` instead. When an `.env` file is present, use `uv run --env-file .env`.

Avoid using `import` in functions - do it in the import block at the top of the file.

### Rust

Avoid directly editing `Cargo.toml` - use `cargo` commands instead (e.g. `cargo add` to add a dependency).

## Cloud

I prefer to use Modal and AWS for infra. We also use CloudFlare for DNS and a CloudFlare Workers API gateway.

Prefer to use IaC (infrastructure-as-code). Avoid destructive actions over CLI.

Common tools:
- `aws` cli
- `kubectl` for EKS clusters
- `terraform` (and sometimes AWS CDK)
- `modal` cli (usually should run via `uv run`)
