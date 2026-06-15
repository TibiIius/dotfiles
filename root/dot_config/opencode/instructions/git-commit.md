# Git Commit Rules

These rules apply to ALL git commits, whether triggered by `/commit`, user request, or autonomously.

## Staging

Always use `git add -A` to stage all changes before committing.

## Conventional Commits

Every commit message must follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
type(scope): description

[optional body]
```

### Allowed Types

- `feat` — a new feature
- `fix` — a bug fix
- `docs` — documentation only changes
- `style` — formatting, missing semicolons, etc; no code change
- `refactor` — code change that neither fixes a bug nor adds a feature
- `perf` — code change that improves performance
- `test` — adding missing tests or correcting existing tests
- `build` — changes that affect the build system or external dependencies
- `ci` — changes to CI configuration files and scripts
- `chore` — other changes that don't modify src or test files
- `revert` — reverts a previous commit

### Scope

The scope is optional but encouraged. Use it to indicate the module, file, or area affected (e.g., `feat(parser): add JSON support`).

## Commit Message Confirmation

Before running `git commit`, use the `question` tool to present a proposed commit title and body for the user to review and edit.

### Question Format

- Present the proposed **title** as an editable text field
- Present the proposed **body** as an editable text field
- Provide a default commit that the user can accept with minimal effort

### Skipping Confirmation

If the user explicitly says "don't ask", "no confirmation", "just commit", or similar, skip the `question` tool and commit directly with your best judgment.

## Co-Author Attribution

Every commit message MUST include a co-author footer in the body:

```
Co-authored-by: OpenCode using <model_name> <noreply@opencode.ai>
```

Where `<model_name>` is the human-readable name of the model currently in use (e.g., "Qwen 3.6 27B", "Gemma 4 26B A4B"). Determine this from the current session context.

### Example

```
feat(parser): add JSON support for nested objects

Support parsing nested JSON objects with arbitrary depth.
Adds recursive traversal logic and updates the tokenizer.

Co-authored-by: OpenCode using Qwen 3.6 27B <noreply@opencode.ai>
```

## Commit Execution

After confirmation (or when skipping confirmation), run:

```bash
git add -A && git commit -m "<title>" -m "<full body with co-author>"
```

Or use `git commit` with a heredoc/multiline message if the body is long.
