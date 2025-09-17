---
EPIC_NAME: 1_notebook-infrastructure
---


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

### 2. Intelligent Environment Setup
- `requirements.txt` with pinned versions of all dependencies
- `setup_venv.sh` script with hardware detection and adaptive configuration:
  - **Hardware Assessment**: Detect VRAM (≥8GB), RAM (≥8GB), CPU cores (≥4), and available disk space (≥4GB)
  - **Ollama Auto-Installation**: If hardware sufficient, automatically download and install Ollama
  - **Model Auto-Download**: Pull llama3.1:8b model if Ollama installation succeeds
  - **Fallback Configuration**: If hardware insufficient, prompt for OpenAI API key and configure fallback
  - **Validation Suite**: Test all installed components and report configuration status
- Cross-platform compatibility with platform-specific error recovery (Windows/Linux/macOS)

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
- **Comprehensive Error Handling**: All scripts detect failures, provide specific error messages, and offer automated fixes where possible
- **Graceful Degradation**: Missing dependencies trigger alternative installation methods or clear manual instructions
- **State Recovery**: Progress JSON survives notebook restarts, and setup script resumes from interruption points
- **Validation Feedback**: Each setup step reports success/failure with actionable next steps
- Notebook cells maintain consistent numbering with error boundaries preventing cascade failures
- Empty implementation cells contain helpful TODO comments with common pitfall warnings

## Success Criteria
1. Hardware detection accurately assesses system capabilities and selects appropriate LLM provider
2. Virtual environment creates successfully on fresh system with automatic error recovery
3. Ollama installation and model download complete automatically on sufficient hardware
4. OpenAI API key collection and validation succeed on insufficient hardware
5. Both notebooks open and run all non-TODO cells without errors, with helpful failure messages
6. Progress tracking JSON initializes and persists through interruptions
7. All src/ modules import successfully with dependency conflict resolution
8. verify.py functions callable from notebook context with error boundary protection
9. Project structure matches specification exactly with platform-specific adaptations
10. Setup script provides clear status reporting and recovery instructions for all failure modes

## Validation
Team-lead must demonstrate:
- Clean installation on fresh environment across all three platforms
- Hardware detection correctly identifying system capabilities and configuring appropriate LLM provider
- Successful Ollama installation and model download on sufficient hardware
- Graceful API key collection and OpenAI configuration on insufficient hardware
- Notebook execution through all scaffold cells with error recovery demonstrations
- Progress JSON persistence through simulated interruptions and restarts
- Error handling scenarios with automatic and manual recovery paths
- Setup script resumption from various failure points