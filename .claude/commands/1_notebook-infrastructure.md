---
EPIC_NAME: 1_notebook-infrastructure
---

# Epic 1: Notebook Infrastructure

## Epic Definition
Create the foundational project structure, environment setup, and core notebook scaffolding that enables subsequent epics to implement lesson content, visualizations, and evaluation systems.

## Suggested Subagents
This epic will likely require 2-3 specialized agents:
- **Environment Setup Specialist**: Expert in cross-platform Python environments, virtual environments, and dependency management
- **Notebook Architect**: Specialist in Jupyter notebook structure, cell organization, and educational scaffolding

## Natural Delegation Points
- Environment setup and scripts → Environment Setup Specialist
- Notebook creation and structure → Notebook Architect
- Module stubs and directory structure → Either agent as appropriate

## Core Requirements

### 1. Directory Structure
Create organized project layout with:
- Notebooks: `lesson.ipynb`, `complete_lesson.ipynb`
- Source modules: `src/` with visualization, evaluation, and model utility stubs
- Configuration: `requirements.txt`, `setup_venv.sh`, `.llm_config.json`
- Progress tracking: `progress/lesson_progress.json`
- Grading output: `grade/` directory structure

### 2. Environment Setup
- Virtual environment setup script that works cross-platform
- Dependencies installation with pinned versions
- Basic LLM configuration (Ollama primary, OpenAI fallback)
- Python detection and validation

### 3. Notebook Structure
Create notebooks supporting 4 core implementation sections:
1. **Linear Projections (Q, K, V)**
2. **Scaled Dot-Product Attention**
3. **Softmax & Attention Weights**
4. **Value Aggregation**

Each section needs:
- Theory explanation
- Implementation cell (TODO in lesson.ipynb)
- Visualization cell

Use consistent example: `PROMPT_EXAMPLE = "The cat sat on the mat"`

### 4. Required Visualization Functions
Create stubs in `src/visualizations.py`:
- `visualize_qkv_projections()`
- `visualize_attention_scores()`
- `visualize_attention_weights()`
- `visualize_attended_values()`

### 5. Progress Tracking
Initialize `progress/lesson_progress.json` with schema for tracking 4 implementation sections.

### 6. LLM Configuration
Create `.llm_config.json` for Ollama/OpenAI setup that Epic 4 will use.

## Handoff Requirements
Provide to subsequent epics:
- Clear notebook structure with implementation cell positions
- Visualization function signatures
- Progress tracking schema
- LLM configuration
- Ready-to-implement module stubs

## Success Criteria
- Environment setup script works and installs all dependencies
- Both notebooks created with proper structure for 4 sections
- All module stubs created and importable
- Progress tracking initialized
- LLM configuration file created
- Completion marker `.epic1_complete.json` created with all outputs documented

## Important Notes
- This is automated development - no human interaction during execution
- NO documentation files (Epic 6 handles all docs)
- Focus on creating structure, not implementing functionality