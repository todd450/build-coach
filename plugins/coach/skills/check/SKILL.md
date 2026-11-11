---
name: check
description: Get an independent second opinion on what Claude just built, written for someone who doesn't read code. A fresh reviewer checks the work against SPEC.md and reports what works, what's risky, and the few things a person should look at themself. Use when the user asks whether the work is right, safe, or ready to demo, submit, ship, or share.
argument-hint: "[optional scope, e.g. 'milestone 2' or 'the pricing calculation']"
allowed-tools: Read, Grep, Glob, Bash(git status:*), Bash(git diff:*), Bash(git log:*)
---

# Second-opinion check

The user may not be able to review code line by line, and you wrote the code, so your own opinion of it is not independent. Get a fresh reviewer to look at the work, then translate what it finds into decisions they can make. Say that in one sentence before you start. Optional scope from the user: `$ARGUMENTS`

## Step 1: Decide what's being checked
- If the user named a scope, use it.
- Otherwise check the work since the last commit (`git status`, `git diff`). If there are no uncommitted changes, check the most recent milestone's commits (`git log --oneline -15`).
- If this isn't a git repo, check the files changed in this session.
- Read SPEC.md and PLAN.md if they exist, and pick out the "done when" checks that apply to this scope. If there is no spec, use what the user asked for in this session and say that a spec would make this check sharper.

If there is nothing to check yet, say so in one line and stop.

## Step 2: Hand it to a fresh reviewer
Start a subagent if you can. Give it the scope, the file paths or diff, how to run the project (from CLAUDE.md), and the applicable "done when" checks. Do **not** give it your own view of whether the work is good, and do not summarize what you intended: it should read the code cold. Ask it to:
1. Run the project or its tests if that's possible, and test each "done when" check. Report each as passes, fails, or couldn't test, with what it saw.
2. Look for problems in these areas, most serious first:
   - **Wrong answers:** calculations, totals, filters, units, dates, and anything that feeds a number other people will see or rely on.
   - **Data and secrets:** keys or passwords in code or in git, confidential data that would be committed or sent to an outside service.
   - **Things that break in front of other people:** crashes on empty or unexpected input, steps that only work on this machine, missing setup instructions.
   - **Beyond the spec:** features nobody asked for, or spec features quietly skipped or faked with placeholder data.
3. Say how it confirmed each problem. A problem it only suspects must be labelled as a suspicion.

If you have no way to start a subagent, do the review yourself, and tell the user plainly that this was a self-review and is less independent.

## Step 3: Verify, then report (under about 300 words)
Confirm each serious finding yourself before passing it on. Drop anything you can't reproduce or that turns out to be wrong, and don't pad the list. Then write, in plain language with no jargon left unexplained:

**Verdict:** one sentence. Ready, ready with fixes, or not ready, for the purpose the user has in mind (a demo, a submission, shipping it, handing it to someone else). The Context line in CLAUDE.md `## Coaching` tells you which is likely.

**Against the spec:** each applicable "done when" check with passes, fails, or not tested.

**Fix before you rely on it:** the confirmed problems, most serious first. For each: what goes wrong, in terms of what someone using or judging the work would see, and how big the fix is.

**Look at these yourself:** two to four things only a person can judge, each with exactly how to check it. For example: "Open outputs/summary.csv and compare the total with your source spreadsheet." Choose the places where a mistake would be most embarrassing or costly: numbers other people will rely on, anything involving confidential data, anything a user sees first.

**Not checked:** what the review could not cover and why.

Then offer to fix the problems, most serious first. Do not change any files until the user says yes.
