# claude-login-share

Share your Claude Code login to another Mac. No browser needed.

You have Claude Code on your work Mac. You want it on your personal Mac too. Normally you'd need to log in via browser on the second machine. This skips that.

## Usage

**On the Mac that's logged in:**

```bash
npx claude-login-share
```

A transfer command gets copied to your clipboard. Send it to the other machine (AirDrop, iMessage, Slack, whatever).

**On the target Mac:**

Paste the command in Terminal. Done. Run `claude` and you're in.

## What it does

1. Extracts Claude Code OAuth credentials from macOS Keychain
2. Strips MCP tokens, local data, and session info (only shares auth)
3. Base64 encodes to avoid shell quoting issues
4. Copies a self-contained transfer command to clipboard
5. The command uses a leading space to skip shell history

## What it doesn't do

- No settings, projects, or CLAUDE.md files are transferred
- No MCP server configs are shared
- No session history is transferred
- Nothing is sent to any server. It's clipboard to clipboard.

## Install

```bash
# One-time use (recommended)
npx claude-login-share

# Or install globally
npm i -g claude-login-share

# Or via Homebrew
brew install yuvrajangadsingh/tap/claude-login-share

# Or curl (no Node required)
curl -sL https://raw.githubusercontent.com/yuvrajangadsingh/claude-login-share/main/share-login.sh | bash
```

## Requirements

- macOS on both machines
- Claude Code installed on both
- Logged into Claude Code on the source machine

Works with Pro, Max, Teams, and Enterprise subscriptions.

## Security

- Credentials never leave your clipboard. No network calls.
- MCP tokens are stripped before sharing. Only OAuth auth is transferred.
- The transfer command includes a leading space so it doesn't appear in shell history on most shells.
- The credential is base64 encoded in transit but is NOT encrypted. Don't post it publicly.

## How it works (technical)

```
macOS Keychain ("Claude Code-credentials")
  → security find-generic-password -s "Claude Code-credentials" -w
  → plutil extracts claudeAiOauth (strips MCP tokens)
  → base64 encode
  → pbcopy (clipboard)
  → recipient pastes: security add-generic-password -s "Claude Code-credentials" ...
```

Uses `plutil` (ships with every Mac since 10.2) for JSON parsing. No Python, no jq, no external dependencies.

## License

MIT
