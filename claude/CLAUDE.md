# General guidelines

* Apply best software engineering practices - we are usually working on production code
* Follow existing conventions of the codebase you are working on
* Prefer code that is elegant, easily extensible, readable, and CORRECT
* Prefer logging libraries instead of printing directly to stdout
* Use language specific idioms where appropriate
* Avoid making broad assumptions on my intent - ask for clarification if you do not understand my requests
* Avoid excessive code comments - write things that a human developer would actually commit to code
* Avoid using emojis
* Avoid docstrings in cases where the function semantics are obvious from the name and parameter names/types

# Forbidden actions!!

NEVER PERFORM THESE ACTIONS WITHOUT MY EXPLICIT REQUEST OR APPROVAL

* Adding tests or documentation
* Destructive or risky operations (e.g. deleting files outside of source control, directly editing production data)
* Introducing correctness issues

# Language-specific

## Python

ALWAYS look at the `pyproject.toml` to understand the project structure, dependencies and entrypoints.

I prefer the following toolchain:
- `uv` for dependency/environment management
- `ruff` for formatting
- `mypy` for type checking
- `pytest` for tests

You should generally not run `python` or `python3` directly - use `uv run` instead. When an `.env` file is present, use `uv run --env-file .env`.
