# ONE-SHOT FRAMEWORK

## Framework description

Plan on how to complete the entire project in one interaction.
Requires significant preparations. Goal is to run `/start` in Claude Code and one-shot the entire project.
This will trigger Claude Code to become `product-manager` and delegate epic-sized tasks to `team-lead` agents.
`team-lead` agents are responsible for completing epics using `subagents`.
Epics are finished in series and each epic prepares for the next one and build on the previous one.


## Current state

**All of the prerequisites are implemented**.
HUMANS can run `/start` to use the framework.
Frameworks completes ~90% of the desired output.
Minor tweaks to prompts are needed for 100%.


---
# PREREQUISITES

## Custom commands

A way to prepare a team-lead with the correct context.
`product-manager` runs `/CUSTOM_COMMAND` in a new instance of Claude Code to create a `team-lead`.
New agent now has all neccesary context on how to be a `team-lead` and can start implementing their epic, delegating tasks to subagents within that session.

## Agent-logs

Uses Claude Code hooks to log agent tool-calling.
Useful for orchestrating agents such as `product-manager` and `team-lead`.

- Triggered by tools
    - Read
    - Write
- Outputs
    - Tool used
    - Path for file
    - Agent name
- One logfile per epic
- Provides insight to *how* the epic/feature was implemented.

Example:
```json
{"tool": "task", "agent-instantiated": "general-purpose", "instruction": "Analyze existing infrastructure"}
{"tool": "read", "path": "C:\Users\felix\Desktop\Code\Skola\AI2\vg-assignment\the-attention-mechanism\verify.py"}
```



---
# AGENTS

Here are the subagents available.
During development, each team-lead can create new subagents if needed through the use of meta-agent. These agents have been marked with *Created by team-lead*


## **unit-tester**

#### Purpose

Tests individual components to validate functionality.
Mocks data needed to test component.


## **notebook-tester**

#### Purpose

Validates that the notebook is working properly.
Runs cells in sequential order and fixes small bugs.


## **epic-validator**

#### Purpose

Validates that all features were included in the epic.
Notifies `team-lead` if epic does not qualify as complete.


## **researcher**

#### Purpose

Searches the web to give `team-leads` knowledge on advanced topics or documentation.


## **attention-visualization-implementer**
*Created by team-lead*

#### Purpose

Creates visualizations for the notebook. Specifically focused on Matplotlib, plotly and teh attention mechanism.


## **educational-documentation-specialist**
*Created by team-lead*

#### Purpose

Writes documentation. Used proactively.


## **educational-web-interface-specialist**
*Created by team-lead*

#### Purpose

Front-end agent for HTML, CSS and JavaScript. Optimizes interface for education.


## **llm-evaluation-implementer**
*Created by team-lead*

#### Purpose

Handles the evaluation system. Works with OpenAI API and Ollama.


## **python-jupyter-infrastructure**
*Created by team-lead*

#### Purpose

Used to create the infrastructure of the Notebooks.


## **transformer-attention-educator**
*Created by team-lead*

#### Purpose

Implements attention mechanism in the Notebook. 

---



# EPIC_DEFINITIONS

## Description

A collection of markdown documents, each describing an epic. Written **before** development starts.
`product-manager` is given a list of custom commands used to initiate each team-lead and epic.
Custom commands trigger team-leads to read the epic definition.


## For each epic

We include:
- Finished epic definition **SET IN STONE**
- Tech stacks, packages and frameworks that should be used
- Distinct and **HARD** requirements of epic completion
- Indicative description on implementation



