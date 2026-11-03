---
name: review
description: Give the student candid, specific feedback on how they've been working with Claude Code in this session (briefing, planning, verifying, checkpointing, understanding), with rewritten prompts and one technique to try next.
disable-model-invocation: true
argument-hint: "[optional focus, e.g. 'debugging' or 'my prompts']"
allowed-tools: Read, Bash(git log:*), Bash(git status:*)
---

# Coaching review

Review how the student has been **working with Claude** in this conversation. You are reviewing their process, not their project. Optional focus from the student: `$ARGUMENTS`

## Gather evidence
1. Re-read the student's own messages in this conversation, and how each one played out: did it need clarifying or redoing, or did it go well the first time?
2. If this is a git repo, run `git log --oneline -15` and `git status` to see how often they checkpoint and whether there's a lot of uncommitted work.
3. Check whether CLAUDE.md exists and has a Coaching section. Calibrate to the experience level there.

If the student has sent fewer than three real requests in this session, say there isn't enough to review yet. Then give a 30-second self-check instead: the five questions below, phrased as yes/no questions.

## Assess five habits
1. **Briefing**: do requests give the goal, context, constraints, and what done looks like?
2. **Planning**: are big tasks planned before building and split into steps?
3. **Verifying**: do they have Claude run, test, or show results before moving on?
4. **Checkpointing**: do they commit working states, and start fresh sessions for new tasks?
5. **Understanding**: do they ask Claude to explain decisions they'll need to defend?

## Write the review (under about 300 words)
Use exactly this structure:

**What's working**: one or two specific things, each pointing to a moment in this session.

**Two upgrades**: the two changes with the biggest payoff. For each:
- What happened (quote or paraphrase their actual prompt).
- **Try instead:** a rewritten version of that prompt, ready to copy.
- Why it's better, in one sentence. Use a business analogy when it helps (delegating to an analyst, writing a project brief).

**Try next session**: one technique from the `techniques` skill that fits their level, with a one-line how-to for the Claude desktop app.

Be candid and encouraging, like a good manager in a 1:1. Don't grade, score, or pad. If they're doing well, say so and suggest a more advanced technique.
