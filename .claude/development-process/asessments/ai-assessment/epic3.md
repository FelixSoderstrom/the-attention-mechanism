I created a Claude project and attached these files.
- `.claude/commands/1_notebook-infrastructure.md`
- `.claude/commands/2_attention-mechanism.md`
- `.claude/commands/3_visualization.md`
- `.claude/commands/4_evaluation-grading.md`
- `.claude/commands/5_mini-transfoemer-integration.md`
- `.claude/commands/6_web-interface-documentation.md`
- `.claude/agents/meta-agent.md`
- `CLAUDE.md`
I then gave sonnet this prompt:
```
Assume you were the team-leader for 3_visualization, explain in great detail:
- How you would complete this task
- What subagents you would create for this epic
- How you would delegate work
- The prompts you would provide to each subagent

I want much details so that I can debug the instruction.
Do **not** give directions on how I should edit the instruction.
**Only** give descriptions on how you would complete the task as a team-lead.
```

This was the answer I got:
As team-lead for Epic 3: Visualization, I would approach this systematically by first understanding the dependencies, then creating specialized subagents, and finally delegating work with precise prompts.
Initial Analysis and Planning
First, I would read the completion files from previous epics to understand exactly what I'm working with:

Reading .epic1_complete.json to get:

Exact visualization function names: visualize_qkv_projections, visualize_attention_scores, visualize_attention_weights, visualize_attended_values
Cell positions where these functions are called: 7, 10, 13, 16
Notebook structure and variable naming conventions


Reading .epic2_complete.json to understand:

Output shapes: query/key/value [6, 64], attention_scores [1, 6, 6], attention_weights [1, 6, 6], attended_values [1, 6, 64]
Test phrase: "The cat sat on the mat" (6 tokens)
Variable names that will be passed to visualization functions


Understanding the integration points: The visualization cells are already in place from Epic 1, they just need the functions implemented in src/visualizations.py.

Subagent Creation Strategy
I would use the meta-agent to create two specialized subagents:
1. First Meta-Agent Call - Educational Visualization Specialist
Prompt to meta-agent:
Create a specialized subagent for implementing educational data visualization functions for machine learning concepts. This agent needs to create matplotlib-based visualizations that help students understand transformer attention mechanisms. The agent should be expert in creating clear, educational plots with proper annotations, colormaps, and formatting that make complex tensor operations visually intuitive. The agent will work specifically with PyTorch tensors and must handle shape transformations, batch dimension squeezing, and tensor-to-numpy conversions. Focus on educational clarity over aesthetic complexity.
2. Second Meta-Agent Call - Notebook Integration Specialist
Prompt to meta-agent:
Create a specialized subagent for Jupyter notebook integration and validation. This agent needs to ensure that visualization functions integrate seamlessly with existing notebook cells, handle matplotlib inline rendering, validate that imports work correctly, and test that visualization cells display properly. The agent should be expert in notebook cell execution flow, matplotlib configuration for Jupyter, and debugging import/display issues. Focus on ensuring the integration between Python modules and notebook cells works flawlessly.
Detailed Work Delegation
Phase 1: Core Visualization Implementation
Prompt to Educational Visualization Specialist:
You need to implement exactly 4 visualization functions in `src/visualizations.py`. These functions must integrate with an existing educational notebook about transformer attention mechanisms.

**CRITICAL REQUIREMENTS:**
- All functions go in `src/visualizations.py`
- Each function MUST end with `plt.show()` for notebook display
- Handle tensor device transfers with `.cpu()` calls
- Include shape assertions with clear error messages
- Use the exact function signatures provided below

**Function 1: visualize_qkv_projections**
```python
def visualize_qkv_projections(embeddings: torch.Tensor, query: torch.Tensor, 
                             key: torch.Tensor, value: torch.Tensor, 
                             tokens: List[str]) -> None:

Create 2x2 subplot layout
Top-left: embeddings heatmap (shape [6, 64], first 20 dims only)
Top-right: query heatmap (shape [6, 64], first 20 dims)
Bottom-left: key heatmap (shape [6, 64], first 20 dims)
Bottom-right: value heatmap (shape [6, 64], first 20 dims)
Use different colormaps: viridis, Reds, Blues, Greens
Show shape annotations on each subplot
Token labels on y-axis for all subplots
Figure size: (12, 10)

Function 2: visualize_attention_scores
pythondef visualize_attention_scores(attention_scores: torch.Tensor, tokens: List[str]) -> None:

Single heatmap of raw attention scores (shape [1, 6, 6] - squeeze batch dim)
Use diverging colormap RdBu_r centered at 0
Include actual score values as text annotations in cells
Title must mention scaling factor: "Raw Attention Scores (scaled by 1/√64)"
Token labels on both axes
Figure size: (8, 6)

Function 3: visualize_attention_weights
pythondef visualize_attention_weights(attention_weights: torch.Tensor, tokens: List[str]) -> None:

Heatmap with values 0.0 to 1.0 (shape [1, 6, 6] - squeeze batch dim)
Use sequential colormap Blues
Text annotations showing probabilities (2 decimal places)
Row sums displayed on the right side (should all be 1.0)
Title: "Attention Weights (Normalized Probabilities)"
Token labels on both axes
Figure size: (10, 6)

Function 4: visualize_attended_values
pythondef visualize_attended_values(attended_values: torch.Tensor, attention_weights: torch.Tensor,
                             tokens: List[str]) -> None:

Two subplots side by side
Left: attention weights heatmap (reuse from function 3)
Right: first 10 dimensions of attended_values (shape [1, 6, 64] - squeeze and slice)
Add visual connection showing aggregation flow
Highlight strongest attention connections (>0.15)
Figure size: (14, 6)

TECHNICAL REQUIREMENTS:

All tensors may need .detach().cpu() before numpy conversion
Handle batch dimensions correctly (squeeze [1, 6, 6] to [6, 6])
Include proper error handling for shape mismatches
Add assertions at function start: assert isinstance(tokens, list) and len(tokens) == 6
Import statements: import matplotlib.pyplot as plt, import torch, import numpy as np

TESTING DATA for validation:
pythontokens = ["The", "cat", "sat", "on", "the", "mat"]
embeddings = torch.randn(6, 64)
query = torch.randn(6, 64)
key = torch.randn(6, 64)
value = torch.randn(6, 64)
attention_scores = torch.randn(1, 6, 6)
attention_weights = torch.softmax(torch.randn(1, 6, 6), dim=-1)
attended_values = torch.randn(1, 6, 64)
Create the complete src/visualizations.py file with all 4 functions implemented.

### Phase 2: Integration and Testing

**Prompt to Notebook Integration Specialist:**
You need to ensure the visualization functions integrate perfectly with the existing notebook structure. The notebooks already have visualization cells at positions 7, 10, 13, and 16 that call these functions.
CRITICAL TASKS:

Verify Cell 2 Configuration:

Ensure cell 2 in both lesson.ipynb and complete_lesson.ipynb contains %matplotlib inline
This is essential for plots to display in the notebook


Test Import Chain:

Verify that the visualization cells can successfully import from src.visualizations
Check that the import statements in cells 7, 10, 13, 16 work correctly
Test with both relative and absolute import paths if needed


Validate Function Calls:

Confirm that cells 7, 10, 13, 16 call the visualization functions with correct variable names
Verify the variable names match Epic 2's outputs:

Cell 7 uses: embeddings, query, key, value, tokens
Cell 10 uses: attention_scores, tokens
Cell 13 uses: attention_weights, tokens
Cell 16 uses: attended_values, attention_weights, tokens




Test Error Handling:

Create test scenario where implementation variables are None or missing
Verify the try/except blocks in visualization cells show helpful messages
Ensure graceful failure when students haven't completed implementations


End-to-End Validation:

Run cells 1-4 to set up the environment and test data
Manually create test variables:



python   import torch
   tokens = ["The", "cat", "sat", "on", "the", "mat"]
   embeddings = torch.randn(6, 64)
   query = torch.randn(6, 64)
   key = torch.randn(6, 64)
   value = torch.randn(6, 64)
   attention_scores = torch.randn(1, 6, 6)
   attention_weights = torch.softmax(torch.randn(1, 6, 6), dim=-1)
   attended_values = torch.randn(1, 6, 64)

Execute visualization cells 7, 10, 13, 16 and confirm all plots render
Document any import errors or display issues


Cross-Platform Testing:

Test on the current system to ensure matplotlib backend works
Verify plots display inline rather than in separate windows
Check that figure sizing works correctly



EXPECTED OUTPUTS:

Confirmation that all 4 visualization cells execute without errors
Screenshots or descriptions of the rendered plots
Any fixes needed for import paths or matplotlib configuration
Verification that error messages appear when variables are missing

Report back with complete integration status and any issues discovered.

## Coordination and Quality Assurance

After receiving outputs from both subagents, I would:

1. **Review Integration**: Ensure the Educational Visualization Specialist's functions work with the Notebook Integration Specialist's testing results

2. **Final Validation Checkpoint**: Personally verify (through the subagents) that:
   - All 4 functions exist in `src/visualizations.py`
   - Each function includes `plt.show()`
   - Function signatures match Epic 1's requirements exactly
   - Shape handling works with Epic 2's tensor dimensions
   - Token labels are clearly visible on all plots
   - Error handling provides helpful messages

3. **Create Completion Marker**: Once validation passes, I would have a subagent create the `.epic3_complete.json` file with all required fields from the epic specification.

## Key Delegation Principles

Throughout this process, I would maintain clear separation of concerns:
- **Educational Visualization Specialist**: Focus purely on creating effective visualizations that teach attention mechanisms
- **Notebook Integration Specialist**: Focus purely on making sure the functions work seamlessly within the Jupyter environment
- **No overlap**: Each agent has distinct, non-overlapping responsibilities
- **Clear success criteria**: Each prompt includes specific, testable requirements
- **Dependency management**: Integration specialist works after visualization specialist completes their work

This approach ensures that Epic 3 delivers exactly what Epic 1 specified (function names and positions), works with Epic 2's outputs (tensor shapes and variable names), and provides the foundation Epic 4 needs for evaluation.