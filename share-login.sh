#!/bin/bash
# Share your Claude Code login to another Mac. No browser needed.
#
# Usage (just paste this in Terminal):
#   curl -sL https://raw.githubusercontent.com/yuvrajangadsingh/claude-code-hacks/main/share-login.sh | bash
#
# What happens:
#   1. Extracts your Claude Code credentials from Keychain
#   2. Strips out everything except login info (no MCP tokens, no local data)
#   3. Copies a single command to your clipboard
#   4. Send that command to whoever needs it
#   5. They paste it in their Terminal, Claude Code starts logged in

# grab credentials from keychain
RAW=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)

if [ -z "$RAW" ]; then
  echo ""
  echo "  Could not find Claude Code credentials."
  echo "  Make sure Claude Code is installed and you're logged in."
  echo "  Run 'claude' first, then try again."
  echo ""
  exit 1
fi

# strip mcp tokens, keep only auth (python3 ships with xcode cli tools on every mac)
AUTH=$(echo "$RAW" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(json.dumps({'claudeAiOauth': d['claudeAiOauth']}))
except:
    print(sys.stdin.read())
" 2>/dev/null)

# fallback to raw if python3 failed (still works, just includes empty mcp tokens)
[ -z "$AUTH" ] && AUTH="$RAW"

# build the command and copy to clipboard
CMD="security delete-generic-password -s \"Claude Code-credentials\" 2>/dev/null; security add-generic-password -s \"Claude Code-credentials\" -a \"\$(whoami)\" -w '$AUTH' && echo 'Done. Run: claude'"

echo "$CMD" | pbcopy 2>/dev/null

echo ""
echo "  Copied to clipboard."
echo "  Send it to whoever needs to login."
echo "  They paste it in Terminal and run 'claude'."
echo ""
