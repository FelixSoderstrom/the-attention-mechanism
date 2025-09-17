#!/usr/bin/env bash

# Hardcoded project paths with forward slashes for git-bash
PROJECT_DIR="/c/Users/felix/Desktop/Code/Skola/AI2/vg-assignment/the-attention-mechanism"
LOGS_DIR="${PROJECT_DIR}/.claude/logs"

# Make sure logs directory exists
mkdir -p "$LOGS_DIR"

# Read hook input and epic name
HOOK_INPUT=$(cat)  # Read directly from stdin instead of a file
EPIC_NAME=$(cat "${PROJECT_DIR}/.claude/current_epic.txt" 2>/dev/null || echo "default")

# Capture everything to a debug file for analysis (temporary)
echo "=== HOOK DEBUG $(date) ===" >> "${LOGS_DIR}/debug.log"
echo "Epic: $EPIC_NAME" >> "${LOGS_DIR}/debug.log"
echo "Raw input: '$HOOK_INPUT'" >> "${LOGS_DIR}/debug.log"
echo "Input length: ${#HOOK_INPUT}" >> "${LOGS_DIR}/debug.log"
echo "===================" >> "${LOGS_DIR}/debug.log"

# Extract metadata
TOOL_NAME=$(echo "$HOOK_INPUT" | jq -r '.tool_name // "unknown"')
TOOL_INPUT=$(echo "$HOOK_INPUT" | jq '.tool_input // {}')

# Get path or description
if [[ "$TOOL_NAME" == "Task" ]]; then
    PATH_INFO=$(echo "$TOOL_INPUT" | jq -r '.description // "unknown"')
else
    PATH_INFO=$(echo "$TOOL_INPUT" | jq -r '.file_path // .path // .notebook_path // "unknown"')
fi

# Create log entry as simple JSON string
TOOL_LOWER=$(echo "$TOOL_NAME" | tr '[:upper:]' '[:lower:]')
if [[ "$TOOL_NAME" == "Task" ]]; then
    # Special format for Task tools - focus on agent instantiation
    SUBAGENT=$(echo "$TOOL_INPUT" | jq -r '.subagent_type // "unknown"')
    INSTRUCTION=$(echo "$TOOL_INPUT" | jq -r '.description // "unknown"')
    LOG_ENTRY="{\"tool\": \"task\", \"agent-instantiated\": \"$SUBAGENT\", \"instruction\": \"$INSTRUCTION\"}"
else
    # Standard format for other tools
    LOG_ENTRY="{\"tool\": \"$TOOL_LOWER\", \"path\": \"$PATH_INFO\"}"
fi

# Write to epic-specific logfile
echo "$LOG_ENTRY" >> "${LOGS_DIR}/${EPIC_NAME}.json"

# Debug output
echo "Logged to ${EPIC_NAME}.json" >&2