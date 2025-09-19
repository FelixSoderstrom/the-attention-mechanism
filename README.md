# WARNING

Some of the custom commands found in this directory could potentially be **VERY DANGEROUS**.
If you are running Claude Code I **HIGHLY RECOMMEND** you read through the setup I have going on.
It includes running background sessions of Claude Code with flag `--dangerously-skip-permissions`.
The background task is completely headless and you have **NO** control over what Claude Code does.
Do **NOT** run any custom commands in this repository unless you have read and understood the configured Claude Code settings.

This repo serves as a way to demonstarte how I did it. Not for anyone to copy/paste.

# Project overview

This is my assignment for an interactive lesson in the AI/ML engineering course.
We got to pick our own subject of interactive lessons and I picked 'Transformers: The Attention Mechanism' where my plan was to let students of this lesson implement their own attention head that we later use to replace a layer in distilgpt2.

When asking about the difficulty of this assignment I got the reply:
"If it's one-shottable, it's definitely too easy and needs adjusting"

I'm perfectly aware that this was not meant to be interpreted as a challenge at all.

---

# One-shotting the assignment

I'm sure my attempt of this didn't actually make it *all the way*..
But I'm at the stage where I'm happy even if it didn't. Tests, validation and simulations have given me the impression I'm 99% of the way there - That's more than I thought was possible to be honest.
Achieving this required several attempts, many hours of fine-tuning prompts, rigorous testing and a $90 Claude Code subscription.
I have learned a tremendous amount about agentic development and realised Claude Code is my new favourite dev tool.
Even if working like this is highly ineffective and requires a tremendous setup (with current technology), I have gained powerful insights on how to achieve more in less time, how to work smart and to understand language models better.

---

# How I did it

```
This setup was heavily inspired by YouTuber [IndyDevDan](https://www.youtube.com/@indydevdan)
A lot of credit goes to him and his course on agentic workflows.
```
The process was executed with Claude Code. You can possibly replicate this using Aider or Cursor CLI but that would require some adjusting for the config.
The configuration utilizes several important components:
- Hooks
- Custom commands
- Agent-logging
- Preemtive subagent creation
- Background sessions


## Project dictionary

**Product-manager:** The main Claude Code session that I am talking to. This agent delegates Epics to Team-leads using background sessions of Claude Code.
**Team-lead:** A separate session of Claude Code running in the background tasked with completing an Epic. This agent delegates work to subagents.
**Meta-agent:** The only predetermined agent. Used preemtively to create new subagents.
**Epic:** A distinct feature in the project. These are handed to team-leads to complete. Epic definitions refer to the instructions given to each team-lead.
****


## Explaining the settings

Copy this JSON into `.claude/settings.local.json` to use my settings
Make sure to replace `PATH\\TO\\THIS\\REPO\\`

```json
{
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
    "allow": [],
    "deny": [],
    "ask": []
  },
  "model": "claude-opus-4-1-20250805",
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read|Write|MultiEdit|Edit|NotebookEdit|NotebookRead|Task",
        "hooks": [
          {
            "type": "command",
            "command": "bash 'PATH\\TO\\THIS\\REPO\\.claude\\scripts\\log_agent_activity.sh'"
          }
        ]
      },
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash 'PATH\\TO\\THIS\\REPO\\.claude\\scripts\\security_hook.sh'"
          }
        ]
      }
    ]
  }
}
```

### env

- Increases bash timeout. Crucial for running long background tasks.
- Increases MCP tool timeout. Might prove beneficial for background tasks.
- Sets Opus as main model for Claude Code. This really only affects the product-manager since we run team-leads with `--model sonnet` to save tokens. If you can spend more tokens, set team-lead model to Opus.
- Subagents set to Sonnet. Subagents are our main token-consumers. This saves a lot of tokens compared to Opus.
- Disables terminal title. Unnecessary content for running headless.
- Maintain project working directory as product-manager.
- Disables data collection.
- Disables error reporting.
- Disables cost warnings

Disabling these last three is equivalent of `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true`, so that might just be the cleaner option here. Even though the only one I'm interested in is cost warnings. Unsure if cost warnings actually halt headless sessions. But I didn't want to take any risk given the difficult nature of debugging this.


### Permissions

Didn't include this because it's highly dependent on paths for the most part.
Obviously allow everything.
There is currently a bug where deny-list is ignored. This was solved with a hook and script for bash tools.


### Hooks

*Read|Write|MultiEdit|Edit|NotebookEdit|NotebookRead|Task* - Tools
All log agent activity.
Example log:
```
Epic:      0_start
Time:      2025-09-19 08:58:43
Tool used: Edit
File:      .claude/current_epic.txt
```

*Bash* - Tool
Triggers security hook.
This prevents Claude from running dangerous bash commands.

---

## Custom commands

Native support in Claude Code.
Creating Markdown file: `.claude/commands/EXAMPLE.md` allows a user to run `/EXAMPLE` directly in the Claude Code interface. This is the same thing as referencing a file with '@' for our purpose.
Product-manager uses these commands to hand team-leads epic specific instructions.
Example usage:
```bash
cd PROJECT_PATH && echo "/EXAMPLE" | claude --model sonnet --output-format json --dangerously-skip-permissions
```
This starts a new session of Claude Code in dangerous mode with model set to sonnet and then starts the custom command /EXAMPLE.

---

## Agent logging

Logs agent activity when tools *Read|Write|MultiEdit|Edit|NotebookEdit|NotebookRead|Task* are used.
These tool calls run `.claude/scripts/log-agent-activity.sh`.
Currently set up to use filename defined in `.claude/current-epic.txt`.
Changing `epic-name.txt` was done by the product manager in between epics. This ensured separate logfiles for each epic.
The script also outputs verbose logs shared for all epics (not included in push because of size)

---

## Preemtive subagent creation

I actually tried leaving subagents created in attempt 1 for attempt 2 but the team-leads seemed to ignore these agents and created their own instead. Perhaps because of my suggestive instructions on how to use the meta-agent.
The use of meta-agent was crucial for this process to succeed. Without it we would not have had a centralized agent format. A crucial component for any agentic development, especially when each subagent's prompt is predetermined by a prompt itself.
Meta-agent, probably the biggest contributor to this entire workflow.
Thanks again to IndyDevDan!

---

## Background sessions

Done by having the product-manager run a new Claude Code session with `--dangerously-skip-permissions` to create a team-lead.
These sessions are as you might have already figured, completely headless. Which makes them **VERY** hard to debug.
Check the logs often to see if a background task hangs.
Run `tasklist | findstr node` to find node processes running.
These are not guaranteed to be Claude Code, but if Claude Code is running it's here.
Use `taskkill //f //pidw [ID]` to kill the processes.
This might mess up the current epic you were in, so be warned when you try to resume a team-lead mid-epic.