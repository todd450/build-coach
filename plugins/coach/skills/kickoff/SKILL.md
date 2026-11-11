---
name: kickoff
description: Set up a new project for working with Claude Code, whether it's a team course project, something for work, or a personal build. Interviews the user, recommends an approach that fits their skills, and writes CLAUDE.md, SPEC.md, PLAN.md, .gitignore, and a first git checkpoint.
disable-model-invocation: true
argument-hint: "[one-sentence project idea]"
allowed-tools: Read
---

# Project kickoff

You are helping someone start a project so that every later Claude Code session goes well. They may be a student team on a course project, a professional building something for work, or a person building for themself. Teach as you go: before each step, say in one sentence what you're doing and why it matters. Keep the tone of a friendly, sharp project lead, not a tutorial.

They may have passed a project idea: `$ARGUMENTS`

## Step 1: Look before you ask
Check the current folder quietly before asking anything:
- Is it empty, or does it already hold files or code? If it's not empty, summarize what's there in two lines.
- Is it already a git repository (`git status`)?
- Does a CLAUDE.md already exist? If so, you'll **update** it: add or refresh the `## Coaching` section and fill gaps. Never overwrite what's already written there.
- Is it inside the user's home folder, Desktop, or Downloads root, rather than a dedicated project folder? If so, suggest making a project folder first.

## Step 2: Interview (two short rounds, not ten questions)
Use the AskUserQuestion tool if it's available; otherwise ask in one short numbered message. Skip anything `$ARGUMENTS` or the folder already answered.

Round 1:
1. **What it's for**: a course project, something for work, or a personal project? This sets the **context** (`course`, `work`, or `personal`) that the rest of the kickoff follows.
2. **The idea**: in a sentence or two, what problem does it solve, and for whom?
3. **The deliverable**: a web app or prototype, a data analysis, an automation or workflow, a business deliverable (model, market sizing, research report), or not sure yet?
4. **Comfort with code**: never coded, some (Excel formulas, a little Python or SQL), or comfortable.

Round 2, fitted to the context. Ask only what you still need:
- **course**: the final due date and any course checkpoints; team members and roles (who's PM, who builds, who does research or the deck); confidential data from a partner company; tools the course requires.
- **work**: when it's needed; who will use it or rely on it; who else is working on it, if anyone; company data it touches, and any employer rules on AI tools, approved services, or where data may go.
- **personal**: a target date if they have one (none is fine); whether anyone else will use it.
- **Any context**: budget for paid APIs or hosting, and a learning goal, e.g., "understand the code well enough to explain it to someone else."

Don't ask a solo builder about team roles, and don't invent a deadline for someone who has none.

## Step 3: Recommend an approach
Read `${CLAUDE_SKILL_DIR}/references/project-types.md` and recommend **one** approach matched to the deliverable and the least experienced builder (the user themself if they're working alone). Explain the trade-off in business terms (time to a first working version, cost, how hard it is to change later, how easy it is to show to others) in four to six lines. Offer one alternative. Let them choose.

## Step 4: Propose the setup, then write it
Show a short list of the files and folders you'll create, and get a yes. Then create:
- **CLAUDE.md**, from `${CLAUDE_SKILL_DIR}/templates/CLAUDE.md`. Fill in everything you learned. Leave a clear `TODO` where something is unknown instead of guessing. Set the Coaching section from their answers: the context from round 1, the experience level of the least experienced builder, their learning goals, and `Coach tips: on` unless they asked otherwise. For a solo builder, replace the Team table with one line saying who is building it.
- **SPEC.md**, from `${CLAUDE_SKILL_DIR}/templates/SPEC.md`. Write it before the plan: who it's for, the problem, 3–6 features each with "done when" checks a non-coder can run, and what's not being done. Draft it from the interview, then show the feature list and ask them to correct it before you go on. Explain in one sentence that the spec is the brief Claude builds from, the same way a PRD briefs an engineering team.
- **PLAN.md**, from `${CLAUDE_SKILL_DIR}/templates/PLAN.md`. Lay out 4–6 milestones, each with a checklist and a "how we'll know it works" line. Each milestone delivers named features from SPEC.md, and its "how we'll know it works" line points to their checks. With a deadline, work backwards from it and date each milestone. With no deadline, order the milestones and leave the dates out. The last milestone depends on the context:
  - course: **Presentation-ready** (a demo script, known limitations, and talking points on how it was built with Claude).
  - work: **Ready to hand over** (how to run it, known limitations, who owns it, and what it must never be used for).
  - personal: **Ready to use or share** (how to run it and known limitations).
- **.gitignore**, suited to the stack. Always include `.env`, `.DS_Store`, and any folder that holds confidential data.
- **.env.example** if the project will use API keys. Explain in one sentence why real keys go in `.env` and never in chat or in git.
- The starter folder layout for the chosen project type. Keep it empty: no app code yet.
- A short **README.md**: project name, one-paragraph pitch, how to run it (TODO for now).

## Step 5: First checkpoint
If it isn't a git repo yet, run `git init`, then commit everything with the message `Project kickoff: plan and Claude Code setup`. Explain in two sentences that a commit is a saved checkpoint they can always return to, and that committing after each working step is a habit worth building.

Do **not** create a GitHub repo or push without asking. Do offer it in terms that fit: for a team, "Want to put this on GitHub so your teammates can work on it too? I can walk you through it." For a solo builder, offer it as a backup. For a work project, tell them to check where their employer wants code kept before pushing anywhere.

## Step 6: Hand off with three great first prompts
Finish with:
1. A two-line summary of what's set up.
2. **"Your first three prompts"**: three specific, copy-pasteable prompts for milestone 1 of *their* project. Each should model a good brief (goal, context, constraints, what done looks like). Make the first one a planning prompt, for example "Read SPEC.md and PLAN.md and propose how to build milestone 1. Don't write code yet."
3. One line: "Run `/coach:check` when a milestone works, for a second opinion on what was built, and `/coach:review` any time for feedback on how you're working with Claude."

Keep the final message under about 250 words.
