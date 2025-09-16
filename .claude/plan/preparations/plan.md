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

## Context bundles

Uses Claude Code hooks to log agent tool-calling.
Useful for orchestrating agents such as `product-manager` and `team-lead`.

- Triggered by tools
    - Read
    - Write
- Outputs
    - Tool used
    - Path for file
    - Agent name
- One context bundle per epic
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

## *product-manager*

#### Purpose

Orchestrates the entire development process.
Delegates epics to team-lead agents.

#### Input

- EPIC_DEFINITIONS


#### Workflow

1. Pick one EPIC from EPIC_DEFINITIONS
2. Create `prime-[EPIC_NAME].md` using the `prime-writer` subagent
3. Instantiate a new `team-lead` using `claude && /prime-[EPIC_NAME]`
4. Merge epics using the `git-specialist` subagent.
5. OPTIONAL: Instantiate new `team-leads` if merge conflics needs code adjustments.
6. Repeat


#### Output

- Status reports to human

---

## *team-lead*

#### Purpose

Orchestrates multiple subagents to complete epics.
A separate Claude code instance. **NOT** a subagent.
Works on separate branch.

#### Input

(These are coming from `prime-[EPIC_NAME].md` - **NOT** arguments)
- EPIC_DEFINITION
- EPIC_NAME

#### Workflow

1. Adress EPIC_DEFINITION and determine if a new subagent is needed
    1. Define agent purpose and area of expertise
    2. Delegate agent creation to `meta-agent`
    3. Await all agents to be created
2. Branch repository with name: EPIC_NAME
3. Delegate implementation to subagents
4. Delegate testing and validation to subagents
    - Testing for and fixing bugs using `unit-tester` and `notebook-tester`
    - Validates all features of the epic was implemented uwing `epic-validator`
5. OPTIONAL: Complement epic with missing feature(s)
    - Repeat step 4 for testing and validation
5. Push changes to branch
6. Report back to product-manager


#### Output

- Status report
    - Success. Epic was completed.
    - Fail. `team-lead` needs more context to complete epic.

---

## *prime-writer*

#### Purpose

Writes `.claude/commands/prime-[EPIC_NAME].md` files for context priming `team-leads`


#### Input

- EPIC_DEFINITION
- EPIC_NAME


#### Workflow

1. Read and understand what the epic requires
2. Define clear `prime-[EPIC_NAME].md` file after template


#### Output

- Status report
    - Success. Prime-file created.
    - Failure. `prime-writer` got missing arguments or EPIC_DEFINITION too vauge.

---

## *meta-agent*

#### Purpose

Responsible for creating new agents **before** they are needed.
Optionally used by `team-lead` at the start of epic.


#### Input

- AGENT_DESCRIPTION
- AREA_OF_EXPERTISE


#### Workflow

1. Examine input variables
2. OPTIONAL: Find intersections where agents coordinate to determine clear boundaries for agents.
3. Create agent definition
4. Report back to `team-lead`


#### Output

- Status report
    - Success. Context was sufficient to create agent
    - Failure. `meta-agent` needs more context to create agent.


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
2. Go through context bundle for epic to gain understanding of what **ALL** subagents did.
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



