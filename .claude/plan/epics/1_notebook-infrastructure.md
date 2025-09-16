# Epic 1: Notebook Infrastructure

## Epic Definition
Create the foundational project structure, environment setup, and core notebook scaffolding that enables subsequent epics to implement lesson content, visualizations, and evaluation systems.

## Tech Stack & Frameworks
- **Python 3.10** with virtual environment
- **Jupyter Notebook** for lesson delivery
- **PyTorch 2.0+** for tensor operations and CUDA support
- **Matplotlib & Plotly** for visualizations
- **Transformers library** for mini-model integration
- **Ollama** for LLM-based evaluation
- **JSON** for progress tracking

## Hard Requirements

### 1. Directory Structure
```
/
├── index.html              # Entry point with lesson overview
├── lesson.ipynb            # Student notebook (empty implementation cells)
├── complete_lesson.ipynb   # Reference notebook (full solutions)
├── README.md               # Existing project documentation
├── verify.py               # Verification script skeleton
├── src/                    
│   ├── __init__.py
│   ├── visualizations.py   # Empty module with docstrings
│   ├── evaluation.py       # Empty module with docstrings
│   └── model_utils.py      # Empty module with docstrings
├── progress/
│   └── lesson_progress.json # Progress tracking structure
├── requirements.txt        # Pinned dependencies
└── setup_venv.sh          # Environment setup script
```

### 2. Environment Setup
- `requirements.txt` with pinned versions of all dependencies
- `setup_venv.sh` script that creates venv, installs requirements, and validates Ollama availability
- Cross-platform compatibility (Windows/Linux/macOS)

### 3. Notebook Structure
- `lesson.ipynb`: 10 numbered sections matching README.md structure, with empty code cells marked `# TODO: Implement`
- `complete_lesson.ipynb`: Identical structure with placeholder solutions
- Both notebooks must be executable without errors in base state

### 4. Progress Tracking
- JSON schema supporting: student_id, section_scores (1-10), total_score, completion_time
- Initialize with empty/default values
- Must be writable by verify.py

### 5. Verification Foundation
- `verify.py` with function stubs for each notebook section
- Must be importable from notebook cells
- Return format: `{"score": int, "feedback": str, "passed": bool}`

## Implementation Notes
- Use relative imports within src/ modules
- All scripts must handle missing dependencies gracefully
- Progress JSON must survive notebook restarts
- Notebook cells should have consistent numbering for evaluation
- Empty implementation cells must contain helpful TODO comments

## Success Criteria
1. Virtual environment creates successfully on fresh system
2. Both notebooks open and run all non-TODO cells without errors
3. Progress tracking JSON initializes and persists
4. All src/ modules import successfully
5. verify.py functions callable from notebook context
6. Project structure matches specification exactly
7. No hardcoded paths or system-specific dependencies

## Validation
Team-lead must demonstrate:
- Clean installation on fresh environment
- Notebook execution through all scaffold cells
- Progress JSON creation and modification
- Successful import of all src/ modules
- verify.py function calls returning expected structure