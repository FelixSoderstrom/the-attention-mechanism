# ONE-SHOT PLAN

Plan on how to complete the entire project in one interaction.
Requires significant preparations. Goal is to run `claude && /prime-product-manager` and one-shot the entire project.
This will trigger Claude Code to become `product-manager` and delegate epic-sized tasks to `team-lead` agents.
`team-lead` agents are responsible for completing epics using `subagents`.
Epics are implemented on their own branches and later merged to not cause conflics during development.



---
# PREREQUISITES

## Context priming

A way to prepare an agent with the correct context.
`product-manager` runs `claude && /prime-[agent-name]` to start a new Claude Code instance for a `team-lead`.
New agent now has all neccesary context on how to be a `team-lead` and can start implementing their epic.

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
{"tool": "read", "path": "README.md", "agent": "ipynb-manager"}
{"tool": "write", "path": "notebook.ipynb", "agent": "ipynb-manager"}
{"tool": "read", "path": "notebook.ipynb", "agent": "llm-manager"}
{"tool": "read", "path": "src/llm//utils.py", "agent": "llm-manager"}
```



---
# AGENTS

These are the basic agents we need in order to get started.
Several more agents will have to be created during development as new features are added. This is done by the `team-lead` describing and delegating the agent-creation to `meta-agent`.

---

## *unit-tester*

#### Purpose

Tests individual components to validate functionality.
Mocks data needed to test component.


#### Input

- FILE_TO_TEST


#### Workflow

1. Read FILE_TO_TEST and understand what needs to be tested
2. Read surrounding files to understand context
3. Write new test-file
4. Import FILE_TO_TEST into test-file
5. Mock any data needed
6. Execute test
7. OPTIONAL: Fix bugs
8. Report back to `team-lead`


#### Output

-Status report
    - Success. Test successful.
    - Failure. Bugfix requires specialized subagent.

---

## *notebook-tester*

#### Purpose

Validates that the notebook is working properly.
Runs cells in sequential order and fixes small bugs.


#### Workflow

1. Configure correct environment for notebook
2. Run all cells in order
3. OPTIONAL: Fix bugs inside or outside the notebook
4. Report back to `team-lead`


#### Output

- Status report
    - Success. All cells run with expected output.
    - Failure. Bugfix requires specialized subagent.

---

## *epic-validator*

#### Purpose

Validates that all features were included in the epic.
Notifies `team-lead` if epic does not qualify as complete.


#### Input

- EPIC_DEFINITION


#### Workflow

1. Identify all features of the epic
2. Go through  agent-logs for epic to gain understanding of what **ALL** subagents did.
3. Report back to `team-lead`


#### Output

- Status report
    - Success message. All features implemented.
    - Fialure message. Features missing.

---
## *researcher*

#### Purpose

Searches the web to give `team-leads` knowledge on advanced topics or documentation.


#### Input

- TOPIC
- QUESTION


#### Workflow

1. Understand the question and what the `team-lead` is asking for
2. Research TOPIC using web-search-tool
3. Consicely answer the QUESTION.


#### Output
- Answer. 
    - Success. Detailed and consice information that answers the QUESTION.
    - Failure. Could not fetch information. `team-lead` should phrase the question differently or provide more context.

---

# EPIC_DEFINITIONS

## Description

A collection of markdown documents, each describing an epic. Written by the human and AI assistants **before** development starts.
`product-manager` is given this list and picks one epic at a time, delegating tis implementation to `team-leads`.


## For each epic

We include:
- Finished epic definition **SET IN STONE**
- Tech stacks, packages and frameworks that should be used
- Distinct and **HARD** requirements of epic completion
- Indicative description on implementation



