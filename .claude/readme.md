# Setting up Claude Code for autonomous development


## Step 1 - Claude Code settings

Filepath: `.claude/settings.local.json`

Configure these settings as you like.
IMPORTANT NOTES:
- We are running sub-instances of Claude Code with flag `--dangerously-skip-permissions` so permissions hardly matter here either way. It will only affect the main instance of Claude Code.
- Opus for planning and Sonnet for subagents. Change this if you don't have MAX plan.
- Permissiong/deny-list isn't working asof today (bug). **This renders the entire deny-list useless**. Safetynet for this is the PreToolUse-hook configured to run `security_hook.sh`. I still do **NOT** garuantee your agents won't mess things up and delete your entire system. **YOU HAVE BEEN WARNED**

This is how I have them set up.
```json
{
  "model": "claude-opus-4-1-20250805",
  "env": {
    "BASH_DEFAULT_TIMEOUT_MS": "7200000",
    "BASH_MAX_TIMEOUT_MS": "7200000",
    "MCP_TIMEOUT": "60000",
    "MCP_TOOL_TIMEOUT": "120000",
    "ANTHROPIC_MODEL": "claude-opus-4-1-20250805",
    "CLAUDE_CODE_SUBAGENT_MODEL": "claude-sonnet-4-20250514",
    "CLAUDE_CODE_DISABLE_TERMINAL_TITLE": "1",
    "CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR": "1",
    "DISABLE_TELEMETRY": "1",
    "DISABLE_ERROR_REPORTING": "1", 
    "DISABLE_COST_WARNINGS": "1"
  },
  "permissions": {
    "allow": [
      "Bash(python:*)",
      "WebSearch",
      "WebFetch",
      "Bash(claude:*)",
      "Bash(mkdir:*)"
    ],
    "deny": [
      "Bash(rm -rf:*)"
    ],
    "ask": []
  },
  "hooks": {

    "PreToolUse": [
      {
        "matcher": "Read|Write|MultiEdit|Edit|NotebookEdit|NotebookRead|Task",
        "hooks": [
          {
            "type": "command",
            "command": "bash 'ABSOLUTE\\PATH\\TO\\PROJECT\\.claude\\scripts\\log_agent_activity.sh'"
          }
        ]
      },
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash 'ABSOLUTE\\PATH\\TO\\PROJECT\\.claude\\scripts\\.claude\\scripts\\security_hook.sh'"
          }
        ]
      }
    ]
  }
}
```

---

## Step 2 - Preparing the scripts

Filepath: `.claude/scripts/`

There are two scripts that are used in hooks:
- log_agent_activity.sh
    This script logs meaningful tool-calls by agents. Useful for agent hand-off.
- security_hook.sh
    This script prevents Claude from running destructive Bash-commands.
    Meant to replace the deny-list.
    **NO GARUANTEES**

Before these hooks can even be used you need to make them executeable by running:
```bash
chmod +x "ABSOLUTE/PATH/TO/PROJECT\.claude\log_agent_activity.sh" && chmod +x "ABSOLUTE/PATH/TO/PROJECT\.claude\security_hook.sh"
```

---

## Step 3 - Understanding how it works

## The process

The 'framework' is currently under development so this part will likely change in the future.

The entire process of starting autonomous development is to run a custom command in a fresh Claude Code instance.
```bash
claude  # Starts Claude Code
/start  # The custom command
```

Claude code will then work according to the instructions defined in `.claude/commands/start.md`.
TLDR this means:
- Changing a global variable (current_epic) to enable epic-specific logging by agents
- Running new Claude Code instances in dangerous-mode to complete epics
- Await task completion (max wait time defined in settings)
- Move on to next epic
- Summarize entire process according to logfiles


## The logging system

Tool-calls trigger Claude Code hooks that run script to log an agents action.
Naming convention for logfiles are the current EPIC_NAME (dynamically changed by the main agent/product manager)


## Custom commands

Markdown files in `.claude/commands/` that enables user or agent to simply run a file and reference a bunch of instructions.
Used by the user to start the process and by agents when giving epic-instructions to team-leads (separate claude code instances).


# Step 4 - Try it out

I want to emphasize that you should `import this` and learn that **We are all responsible adults**!
I take no responsibility for you screwing up. What you're dabbling with is potentially dangerous stuff.
**Proceed with caution and on your own risk!**

## Start the process

1. Open up Claude Code
2. Type /start
3. Wait
4. Enjoy the overcomplicated hello-world script