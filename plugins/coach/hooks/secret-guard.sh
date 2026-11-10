#!/usr/bin/env bash
# UserPromptSubmit hook: stop a message that contains an API key or private key
# before it reaches Claude, and tell the student what to do instead.
#
# Exit 2 blocks the message; what we print to stderr is shown to the student.
# Any other outcome lets the message through, so a failure here never blocks work.
#
# To add a pattern, add a line to PATTERNS. Keep them specific (a known prefix
# plus a long random tail): a false alarm blocks a real message.

input=$(cat)

# The message arrives inside JSON, where a line break is the two characters \n.
# Turn those into spaces so a key at the start of a line still starts a word.
text=$(printf '%s' "$input" | sed -e 's/\\[nrt]/ /g')

PATTERNS=(
  'sk-ant-[A-Za-z0-9_-]{20,}'                # Anthropic
  'sk-proj-[A-Za-z0-9_-]{32,}'               # OpenAI project key
  'sk-[A-Za-z0-9]{32,}'                      # OpenAI and lookalikes
  '[sr]k_live_[A-Za-z0-9]{20,}'              # Stripe live key
  'AKIA[0-9A-Z]{16}'                         # AWS access key ID
  'AIza[0-9A-Za-z_-]{35}'                    # Google API key
  'gh[pousr]_[A-Za-z0-9]{36,}'               # GitHub token
  'github_pat_[A-Za-z0-9_]{40,}'             # GitHub fine-grained token
  'xox[baprs]-[A-Za-z0-9-]{20,}'             # Slack token
)

found=0
for p in "${PATTERNS[@]}"; do
  # The key must start a word, so "task-..." or "risk-..." never matches "sk-...".
  if printf '%s' "$text" | grep -Eq -e "(^|[^A-Za-z0-9_-])$p"; then
    found=1
    break
  fi
done

if [ "$found" -eq 0 ] && printf '%s' "$text" | grep -Eq -e '-----BEGIN [A-Z ]*PRIVATE KEY-----'; then
  found=1
fi

if [ "$found" -eq 1 ]; then
  cat >&2 <<'EOF'
Coach: your message looks like it contains an API key or private key, so it was not sent to Claude.

Keys don't belong in chat. Do this instead:
  1. Put the key in a file named .env in your project folder, on a line like  MY_SERVICE_API_KEY=...
  2. Make sure .env is listed in .gitignore, so it never reaches GitHub.
  3. Send your message again without the key. Say "the key is in .env as MY_SERVICE_API_KEY" and Claude will read it from there.

If this key has been pasted anywhere else (a chat, a doc, a commit), replace it with a new one from the service's dashboard.
EOF
  exit 2
fi

exit 0
