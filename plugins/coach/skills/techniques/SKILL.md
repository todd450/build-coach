---
name: techniques
description: Playbook of Claude Code techniques for MBA students, from beginner to advanced (briefing, planning, verifying, git checkpoints, CLAUDE.md, context management, debugging, safety, teamwork, custom skills). Use when the student asks how to get Claude to do something, what the best way to work is, or wants to level up.
---

# Claude Code techniques playbook

When the student asks how to do something, pick the **one or two** techniques below that fit their question and their level (see CLAUDE.md `## Coaching`). Explain briefly, then show an example prompt drawn from **their** project, not the generic one here. Offer to apply the technique right now.

Levels: 🟢 start here · 🟡 once comfortable · 🔵 advanced

---

### 🟢 1. Write a brief, not a wish
A good request has a **goal**, **context**, **constraints**, and **what done looks like**. It's the same skill as delegating to a new analyst.
- Weak: "make the dashboard better"
- Strong: "Our investors care most about monthly retention. Add a retention chart to the top of the dashboard, using `data/users.csv`. Keep the current color scheme. Done means it runs and the chart matches the numbers in our deck."

### 🟢 2. Plan before you build
For anything bigger than a small change, get a plan first and review it the way you'd review a project proposal.
- Desktop app: switch the mode selector next to the prompt box to **Plan mode**, or just say "Make a plan first. Don't write code yet."
- Also try: "Interview me with questions until you understand what I want, then propose a plan."

### 🟢 3. Small steps, verified
Build one piece at a time, and have Claude **prove** each piece works before moving on.
- "Run it and show me the output." "Open it in the preview and take a screenshot." "Write a quick test for this."
- In the desktop app, open the diff view to see exactly what changed.

### 🟢 4. Git checkpoints
A commit is a save point. Commit every time something works.
- "Commit this with a clear message." / "Show me what changed since the last commit." / "Undo everything since the last commit."
- Experiment on a branch: "Create a branch called `try-new-layout` and try the redesign there."

### 🟢 5. Ask it to explain
You'll have to present and defend this work.
- "Explain how this works as if I'm presenting it to my study group."
- "What are the trade-offs of the approach you chose? What would you do differently with more time?"
- "Walk me through this codebase. What's in each folder?"

### 🟡 6. CLAUDE.md as team memory
CLAUDE.md loads into every session for every teammate. Put context there instead of repeating it: what you're building, conventions, how to run it, and decisions.
- "Add to CLAUDE.md that we use metric units and that all charts use our brand colors."
- Keep it short, current, and committed to git so the whole team shares it.

### 🟡 7. Point at things precisely
- Type `@` and a filename to reference a file instead of pasting it in.
- Paste a screenshot of a bug or a design you like. Claude can read images.
- Give an example: "Format the output like `outputs/example.csv`."

### 🟡 8. Debug like a consultant
- Give the **exact** error message, what you did, and what you expected.
- After two failed fixes, step back: "Stop fixing. What are the possible root causes? How could we test each one?"
- Still stuck? Start a fresh session with a short summary of what you've tried.

### 🟡 9. Manage context
Long sessions get sluggish and confused.
- One session per task. Start a new session when you switch topics.
- Before switching: "Summarize what we did and what's left, so I can start a new session." Then paste the summary into the new session.
- `/compact` condenses a long conversation. `/clear` starts over.

### 🟡 10. Safety and confidentiality
- Read permission prompts before approving them. If you don't understand a command, ask "what does this do?" first.
- API keys and passwords go in `.env`, which is listed in `.gitignore`. Never paste them into chat.
- Confidential partner data stays in a gitignored folder and should never be uploaded to outside services. Check your course or NDA rules.

### 🔵 11. Teamwork with git and GitHub
- Each teammate works on a branch and opens a pull request. Ask Claude: "Review this pull request like a senior engineer."
- Split work by area (frontend, data, research) so teammates don't edit the same files.
- Run several Claude sessions in parallel, each on a different task in its own worktree.

### 🔵 12. Automate your own workflow
- Repeating the same multi-step request? Turn it into a **custom skill**: "Create a skill that regenerates our charts and exports them for the deck."
- Use **subagents** for side research: "Use a subagent to research three competitors' pricing pages and summarize them."
- **Connectors (MCP)** let Claude reach tools like Google Drive or Notion. Ask your instructor which ones are approved.
