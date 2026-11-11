---
name: techniques
description: Playbook of Claude Code techniques for people who direct an AI agent without reading code, from beginner to advanced (briefing, specs, planning, second-opinion review, verifying, git checkpoints, CLAUDE.md, context management, choosing a model, debugging, safety, teamwork, custom skills). Use when the user asks how to get Claude to do something, what the best way to work is, or wants to level up.
---

# Claude Code techniques playbook

When the user asks how to do something, pick the **one or two** techniques below that fit their question, their level, and their context (see CLAUDE.md `## Coaching`). Skip team techniques for someone working alone. Explain briefly, then show an example prompt drawn from **their** project, not the generic one here. Offer to apply the technique right now.

Levels: 🟢 start here · 🟡 once comfortable · 🔵 advanced

---

### 🟢 1. Write a brief, not a wish
A good request has a **goal**, **context**, **constraints**, and **what done looks like**. It's the same skill as delegating to a new analyst.
- Weak: "make the dashboard better"
- Strong: "Our investors care most about monthly retention. Add a retention chart to the top of the dashboard, using `data/users.csv`. Keep the current color scheme. Done means it runs and the chart matches the numbers in our deck."

### 🟢 2. Agree on "done" before you start
A one-page spec says who it's for, what it does, and how you'll check each feature without reading code. It's a PRD, and Claude builds from it.
- "Read SPEC.md and tell me what's ambiguous or missing before we build anything."
- Changing your mind is fine. Change the spec first: "Update SPEC.md: we're dropping login and adding CSV export. Then tell me what that changes in PLAN.md."
- No spec yet? "Interview me, then write SPEC.md: the user, the problem, 3 to 6 features with 'done when' checks, and what we're not doing."

### 🟢 3. Plan before you build
For anything bigger than a small change, get a plan first and review it the way you'd review a project proposal.
- Desktop app: switch the mode selector next to the prompt box to **Plan mode**, or just say "Make a plan first. Don't write code yet."
- Also try: "Interview me with questions until you understand what I want, then propose a plan."

### 🟢 4. Small steps, verified
Build one piece at a time, and have Claude **prove** each piece works before moving on.
- "Run it and show me the output." "Open it in the preview and take a screenshot." "Write a quick test for this."
- In the desktop app, open the diff view to see exactly what changed.

### 🟢 5. Git checkpoints
A commit is a save point. Commit every time something works.
- "Commit this with a clear message." / "Show me what changed since the last commit." / "Undo everything since the last commit."
- Experiment on a branch: "Create a branch called `try-new-layout` and try the redesign there."

### 🟢 6. Ask it to explain
Sooner or later you'll have to explain this work to someone: a class, a manager, or whoever takes it over.
- "Explain how this works as if I'm presenting it to people who weren't here."
- "What are the trade-offs of the approach you chose? What would you do differently with more time?"
- "Walk me through this codebase. What's in each folder?"

### 🟡 7. Get a second opinion
The Claude that wrote the code tends to think the code is fine. A fresh reviewer that hasn't seen the conversation catches more, the same way a second analyst checks a model.
- Run `/coach:check` when a milestone works, and before you demo, submit, ship, or share it. It checks the work against SPEC.md and tells you the few things to look at yourself.
- By hand: "Use a subagent to review the changes since the last commit. Don't tell it what you intended. Have it report anything that could give a wrong number."

### 🟡 8. CLAUDE.md as project memory
CLAUDE.md loads into every session, yours and every teammate's. Put context there instead of repeating it: what you're building, conventions, how to run it, and decisions.
- "Add to CLAUDE.md that we use metric units and that all charts use our brand colors."
- Keep it short, current, and committed to git, so every session and every teammate shares it.

### 🟡 9. Point at things precisely
- Type `@` and a filename to reference a file instead of pasting it in.
- Paste a screenshot of a bug or a design you like. Claude can read images.
- Give an example: "Format the output like `outputs/example.csv`."

### 🟡 10. Debug like a consultant
- Give the **exact** error message, what you did, and what you expected.
- After two failed fixes, step back: "Stop fixing. What are the possible root causes? How could we test each one?"
- Still stuck? Start a fresh session with a short summary of what you've tried.
- A bigger model is the last thing to try, not the first (see technique 12).

### 🟡 11. Manage context
Long sessions get sluggish and confused.
- One session per task. Start a new session when you switch topics.
- Before switching: "Summarize what we did and what's left, so I can start a new session." Then paste the summary into the new session.
- `/compact` condenses a long conversation. `/clear` starts over.
- Changing models? Do it at one of these breaks, after `/compact` or in a new session. The first message on a new model re-reads the whole conversation at full price, and the new model may not see the old one's reasoning.

### 🟡 12. Match the model to the job
Claude comes in several sizes. Bigger models handle harder work and cost more per message, like staffing a task with an analyst or a partner. The default model is the right place to start.
- **Step down** to a smaller model for simple, clearly defined work: a small fix, a feature the spec already describes, sorting or tagging a lot of items.
- **Step up** to the largest model for the hardest work: restructuring a whole project, a complex financial model, deep research or analysis, or a long task you'll leave running.
- **When the result isn't good enough, try these in order:**
  1. Give Claude a way to check its own work: "Run it and compare the total with `data/source.csv`." This is usually cheaper and faster than anything else.
  2. Raise the effort setting one level, which lets the same model think longer and check more. It can't supply skill the model doesn't have.
  3. Then move up one model.
- Change models in the app's model menu, or with `/model` in a terminal. Not sure the bigger model is worth it? Run the same task on two models and compare the results and what `/usage` reports.
- Names change with each release. As of November 2026, smallest to largest: Haiku, Sonnet, Opus (the default), Fable.

### 🟡 13. Safety and confidentiality
- Read permission prompts before approving them. If you don't understand a command, ask "what does this do?" first.
- API keys and passwords go in `.env`, which is listed in `.gitignore`. Never paste them into chat.
- Confidential data (a partner company's, your employer's, your customers') stays in a gitignored folder and should never be uploaded to outside services. Check your course, employer, or NDA rules.

### 🔵 14. Teamwork with git and GitHub
- Each teammate works on a branch and opens a pull request. Ask Claude: "Review this pull request like a senior engineer."
- Split work by area (frontend, data, research) so teammates don't edit the same files.
- Run several Claude sessions in parallel, each on a different task in its own worktree.

### 🔵 15. Automate your own workflow
- Repeating the same multi-step request? Turn it into a **custom skill**: "Create a skill that regenerates our charts and exports them for the deck."
- Use **subagents** for side research: "Use a subagent to research three competitors' pricing pages and summarize them."
- Helpers that only search, read, or summarize can run on a smaller model, because their mistakes are easy to spot: "Use a subagent on the smallest model to read the logs and list each error." Keep edits and judgment calls on the main model.
- **Connectors (MCP)** let Claude reach tools like Google Drive or Notion. In a course or at work, check which ones are approved before connecting one.
