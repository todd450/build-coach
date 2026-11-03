---
name: kickoff
description: Set up a new MBA team course project for working with Claude Code. Interviews the team, recommends an approach that fits their skills, and writes CLAUDE.md, PLAN.md, .gitignore, and a first git checkpoint.
disable-model-invocation: true
argument-hint: "[one-sentence project idea]"
allowed-tools: Read
---

# Project kickoff

You are helping an MBA team start their course project so that every later Claude Code session goes well. Teach as you go: before each step, say in one sentence what you're doing and why it matters. Keep the tone of a friendly, sharp project lead, not a tutorial.

The student may have passed a project idea: `$ARGUMENTS`

## Step 1: Look before you ask
Check the current folder quietly before asking anything:
- Is it empty, or does it already hold files or code? If it's not empty, summarize what's there in two lines.
- Is it already a git repository (`git status`)?
- Does a CLAUDE.md already exist? If so, you'll **update** it: add or refresh the `## Coaching` section and fill gaps. Never overwrite what the team wrote.
- Is it inside the user's home folder, Desktop, or Downloads root, rather than a dedicated project folder? If so, suggest making a project folder first.

## Step 2: Interview the team (one or two rounds, not ten questions)
Use the AskUserQuestion tool if it's available; otherwise ask in one short numbered message. Skip anything `$ARGUMENTS` or the folder already answered.

Round 1:
1. **The idea**: in a sentence or two, what problem does it solve, and for whom?
2. **The deliverable**: a web app or prototype, a data analysis, an automation or workflow, a business deliverable (model, market sizing, research report), or not sure yet?
3. **Comfort with code**: never coded, some (Excel formulas, a little Python or SQL), or comfortable.
4. **Deadline**: final due date, plus any course checkpoints.

Round 2, only if needed:
- Team members and roles (who's PM, who builds, who does research or the deck).
- Constraints: data sources, confidential data from a partner company, budget for paid APIs or hosting, tools the course requires.
- Learning goal: e.g., "understand the code well enough to explain it in our final presentation."

## Step 3: Recommend an approach
Read `${CLAUDE_SKILL_DIR}/references/project-types.md` and recommend **one** approach matched to the deliverable and the team's least experienced builder. Explain the trade-off in business terms (time to first demo, cost, how hard it is to change later, how easy it is to present) in four to six lines. Offer one alternative. Let them choose.

## Step 4: Propose the setup, then write it
Show a short list of the files and folders you'll create, and get a yes. Then create:
- **CLAUDE.md**, from `${CLAUDE_SKILL_DIR}/templates/CLAUDE.md`. Fill in everything you learned. Leave a clear `TODO` where something is unknown instead of guessing. Set the Coaching section from their answers: experience level is the team's least experienced builder, learning goals are theirs, and `Coach tips: on` unless they asked otherwise.
- **PLAN.md**, from `${CLAUDE_SKILL_DIR}/templates/PLAN.md`. Work backwards from the deadline into 4–6 milestones, each with a checklist and a "how we'll know it works" line.
- **.gitignore**, suited to the stack. Always include `.env`, `.DS_Store`, and data folders that hold confidential partner data.
- **.env.example** if the project will use API keys. Explain in one sentence why real keys go in `.env` and never in chat or in git.
- The starter folder layout for the chosen project type. Keep it empty: no app code yet.
- A short **README.md**: project name, one-paragraph pitch, how to run it (TODO for now).

## Step 5: First checkpoint
If it isn't a git repo yet, run `git init`, then commit everything with the message `Project kickoff: plan and Claude Code setup`. Explain in two sentences that a commit is a saved checkpoint they can always return to, and that committing after each working step is a habit worth building.

Do **not** create a GitHub repo or push without asking. Do offer: "Want to put this on GitHub so your teammates can work on it too? I can walk you through it."

## Step 6: Hand off with three great first prompts
Finish with:
1. A two-line summary of what's set up.
2. **"Your first three prompts"**: three specific, copy-pasteable prompts for milestone 1 of *their* project. Each should model a good brief (goal, context, constraints, what done looks like). Make the first one a planning prompt, for example "Read PLAN.md and propose how to build milestone 1. Don't write code yet."
3. One line: "Run `/coach:review` any time for feedback on how you're working with Claude."

Keep the final message under about 250 words.
