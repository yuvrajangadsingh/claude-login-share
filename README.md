# claude-code-hacks

Useful scripts and tricks for Claude Code CLI.

## share-login.sh

Share your Claude Code login to another Mac without opening a browser.

### Quick start

Paste this in Terminal on the Mac that's logged in:

```bash
curl -sL https://raw.githubusercontent.com/yuvrajangadsingh/claude-code-hacks/main/share-login.sh | bash
```

That's it. A command gets copied to your clipboard. Send it to whoever needs it. They paste it in their Terminal.

### What it does

- Extracts OAuth credentials from macOS Keychain
- Strips out MCP tokens and local data (only shares auth)
- Copies a transfer command to your clipboard
- The transfer command auto-detects the target machine's username
- No settings, sessions, projects, or CLAUDE.md files are touched on either machine

### Requirements

- macOS on both machines
- Claude Code installed on both machines
- Logged into Claude Code on the source machine

Works with Pro, Max, Teams, and Enterprise subscriptions.
