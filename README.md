# Claude Code Coach

A Claude Code plugin that helps people get better at working with Claude **while** they build something. It is for anyone who directs an AI agent without reading the code it writes. It was built for UCLA MBA team course projects, and it works the same way for a project at work or a personal one.

| What | How it's used |
|---|---|
| **Project kickoff** | `/coach:kickoff`: asks what the project is for (course, work, or personal), interviews you, recommends an approach that fits your skills, and writes `CLAUDE.md`, a one-page `SPEC.md` (features with "done when" checks), `PLAN.md`, `.gitignore`, and a first git commit. Ends with three ready-to-use first prompts. |
| **Second opinion** | `/coach:check`: a fresh reviewer checks what was built against `SPEC.md` and reports, in plain language, what works, what to fix, and the few things you should look at yourself. |
| **Pasted-key guard** | Always on. A message that contains an API key or private key is stopped before it reaches Claude, with instructions for using `.env` instead. |
| **In-the-moment coaching** | Always on. When there's a real teaching moment (a vague prompt, a huge request with no plan, accepting changes without testing, no commits), Claude adds one short **Coach tip** to the end of its reply. |
| **Feedback on demand** | `/coach:review`: candid feedback on how you've worked with Claude in this session, with your own prompts rewritten. |
| **Technique playbook** | Loads automatically when someone asks "how do I get Claude to…?" Fourteen techniques, from beginner to advanced. |

The coaching is controlled from the project's `CLAUDE.md`, which `/coach:kickoff` writes:

```markdown
## Coaching
- Context: course       # or "work", or "personal"
- Experience level: mixed
- Learning goals: understand the code well enough to present it
- Coach tips: on        # or "light", or "off"
```

`Context` changes what the coach assumes:

| Context | What the coach assumes | Last milestone in the plan |
|---|---|---|
| `course` | A student project, usually a team's, that will be presented and graded. May use a partner company's confidential data. | Presentation-ready |
| `work` | Colleagues will rely on it. The employer's data and AI-tool rules apply. | Ready to hand over |
| `personal` | No team, deadline, or audience unless you say so. | Ready to use or share |

A `## Coaching` section with no `Context` line is treated as `course`, so projects set up before version 0.3.0 behave as they did.

## Repository layout

```
.claude-plugin/marketplace.json     ← makes this repo installable as a marketplace
plugins/coach/
  .claude-plugin/plugin.json
  hooks/hooks.json                  ← SessionStart hook that loads the coaching brief; UserPromptSubmit hook for the key guard
  hooks/coaching-context.md         ← the always-on coaching instructions (edit to tune tone and frequency)
  hooks/secret-guard.sh             ← stops messages that contain an API key (edit PATTERNS to add key formats)
  skills/kickoff/                   ← /coach:kickoff, plus CLAUDE.md, SPEC.md and PLAN.md templates and project-type guide
  skills/check/                     ← /coach:check
  skills/review/                    ← /coach:review
  skills/techniques/                ← technique playbook (loads automatically)
starter/.claude/settings.json       ← drop into a course starter repo to auto-offer the plugin
```

## Publishing updates (instructor)

This repo is the marketplace: whatever is on `main` is what students install. To ship a change, bump `version` in `plugins/coach/.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`, then commit and push.

## Installing it

**Option A: from a terminal (one time, works in the desktop app afterwards)**

```bash
claude plugin marketplace add todd450/build-coach
```

```bash
claude plugin install coach@build-coach
```

Then start a new session in the Claude desktop app's Code tab.

**Option B: a course starter repo (no terminal needed)**

Put `starter/.claude/settings.json` into a GitHub template repository for the course. When a team opens their copy of it in Claude Code and trusts the folder, Claude Code offers to install the coach marketplace and plugin.

**First session:** open the project folder, then type `/coach:kickoff`.

### Moving from the old name

This marketplace was called `ucla-mba-claude-coach` until November 2026. If you installed it under that name, switch once:

```bash
claude plugin uninstall coach@ucla-mba-claude-coach
```

```bash
claude plugin marketplace remove ucla-mba-claude-coach
```

Then follow Option A above. A project that carries the old `starter/.claude/settings.json` needs that file replaced with the current one. Nothing in your project's own files (CLAUDE.md, SPEC.md, PLAN.md) changes.

## Testing locally before you publish

From this folder:

```bash
claude plugin validate plugins/coach
```

```bash
claude --plugin-dir ./plugins/coach
```

### Trying it on your own projects (desktop app)

`--plugin-dir` only works from the terminal. To use the coach in the desktop app's Code tab while you refine it, install it from this folder into the projects you want, one time each:

```bash
claude plugin marketplace add /path/to/build-coach
```

```bash
cd ~/code/some-project && claude plugin install coach@build-coach --scope local
```

`--scope local` writes to that project's `.claude/settings.local.json`, which git ignores, so nothing lands in the project's history.

Claude Code installs a copy of the plugin, and `claude plugin update` won't refresh it while the version number is unchanged. After editing, run this from this folder to reinstall the current files (uncommitted edits included) in every project that has the coach:

```bash
scripts/dev-refresh.sh
```

Then start a new session in those projects.

## Tuning

- **Tip frequency and tone:** edit `plugins/coach/hooks/coaching-context.md`. It's injected into every session, so keep it short.
- **Recommended stacks per project type:** edit `plugins/coach/skills/kickoff/references/project-types.md`. For example, add your course's required tools or approved hosting.
- **Key formats the guard stops:** edit `PATTERNS` in `plugins/coach/hooks/secret-guard.sh`. It needs `bash`, so on Windows it runs only where Git Bash or WSL is installed.
- **Course-specific rules** (approved connectors, data policies, AI-use disclosure): add them to `coaching-context.md` and to the kickoff `CLAUDE.md` template.
- After a change, bump `version` in both `plugin.json` and `marketplace.json`. Students then run `claude plugin update coach@build-coach`.
