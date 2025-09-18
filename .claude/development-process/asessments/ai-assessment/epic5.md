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
Assume you were the team-leader for 5_mini-transfoemer-integration, explain in great detail:
- How you would complete this task
- What subagents you would create for this epic
- How you would delegate work
- The prompts you would provide to each subagent

I want much details so that I can debug the instruction.
Do **not** give directions on how I should edit the instruction.
**Only** give descriptions on how you would complete the task as a team-lead.
```

This was the answer I got:
As the team-leader for Epic 5: Mini-Transformer Integration, here's exactly how I would complete this task:
Initial Analysis and Planning
First, I would analyze the epic requirements by reading all prerequisite completion files:

.epic1_complete.json to understand notebook structure and cell positions
.epic2_complete.json to verify the 64-dim implementation with dimension note exists
.epic3_complete.json to confirm visualization functions are available
.epic4_complete.json to ensure evaluation system is working

The epic requires completing 7 functions in src/model_utils.py, adding 5 new cells to both notebooks, and creating a model comparison visualization. This is complex enough to require multiple specialized subagents.
Subagents I Would Create
Since this involves both transformer model integration and notebook modification, I would need to create specialized subagents through the meta-agent:
1. First Meta-Agent Call - Transformer Integration Specialist
Prompt to meta-agent:
"I need a subagent specialized in transformer model integration and PyTorch model surgery. This agent should handle loading pre-trained transformers, extracting attention layers, replacing model components, and managing model caching. The agent should be expert in the transformers library, model architecture manipulation, and dimension adaptation between different embedding sizes. Use this agent for implementing the core model_utils.py functions that involve direct model manipulation."
2. Second Meta-Agent Call - Notebook Code Extraction Specialist
Prompt to meta-agent:
"I need a subagent specialized in parsing Jupyter notebooks and extracting executable code from specific cells. This agent should handle JSON notebook parsing, code cell identification by position, combining code fragments into callable functions, and handling notebook cell extraction edge cases. The agent should be expert in notebook file structure and Python AST manipulation. Use this for extracting the reference attention implementation from complete_lesson.ipynb."
3. Third Meta-Agent Call - Educational Notebook Integration Specialist
Prompt to meta-agent:
"I need a subagent specialized in educational Jupyter notebook enhancement and integration sections. This agent should add new educational content to existing notebooks, create placeholder cells for incomplete implementations, maintain consistent cell numbering, and ensure both student and reference versions work correctly. Use this for adding the new Section 10 (cells 21-25) to both lesson.ipynb and complete_lesson.ipynb."
Delegation Strategy and Detailed Prompts
Phase 1: Core Model Functions Implementation
Delegate to transformer-integration-specialist:
"You need to implement all 7 functions in src/model_utils.py. The file exists but contains only empty stubs from Epic 1. Here are the critical requirements:
Context: This is fully automated development - use the reference implementation from complete_lesson.ipynb directly. The reference implementation uses 64-dim embeddings while distilgpt2 uses 768-dim, so you need dimension adapters.
Functions to implement:

load_mini_transformer() - Load distilgpt2 model and tokenizer, cache in cache/models/ directory
extract_attention_layer() - Extract specific attention layer from transformer
create_dimension_adapter() - Handle 64↔768 dimension conversion with linear projections
run_inference_comparison() - Compare original vs modified model outputs
extract_attention_weights() - Get attention weights from model forward pass
replace_attention_mechanism() - Replace model attention with reference implementation
get_reference_attention_from_notebook() - This will be implemented by the notebook extraction specialist

Critical constraints:

distilgpt2 model must be cached in cache/models/ directory
Handle offline scenarios gracefully after first download
All functions must have proper error handling and type hints
Dimension adapters critical for 64-dim to 768-dim conversion
Must complete in under 90 seconds total execution time
Create cache/models/ directory if it doesn't exist

Expected outputs:

load_mini_transformer returns (model, tokenizer) tuple
extract_attention_weights returns tensor [batch, heads, seq_len, seq_len]
run_inference_comparison returns dict with 'original_output', 'modified_output', 'original_attention', 'modified_attention' keys
All functions fully implemented, no TODO or pass statements

Test your implementation by loading distilgpt2 and verifying it has 6 transformer layers. The model should cache properly and work offline after first download."
Phase 2: Reference Implementation Extraction
Delegate to notebook-code-extraction-specialist:
"You need to implement the get_reference_attention_from_notebook() function in src/model_utils.py by extracting working code from complete_lesson.ipynb.
Context: Epic 2 implemented attention in exactly 4 cells at positions 6, 9, 12, 15 in complete_lesson.ipynb. Epic 1 defined the cell structure as:

Cell 6: Linear Projections (Q, K, V) - outputs query, key, value tensors [6, 64]
Cell 9: Scaled Dot-Product Attention - outputs attention_scores [1, 6, 6]
Cell 12: Softmax & Attention Weights - outputs attention_weights [1, 6, 6]
Cell 15: Value Aggregation - outputs attended_values [1, 6, 64]

Your task:
Parse complete_lesson.ipynb JSON structure, extract code from cells 6, 9, 12, 15, and combine into a single callable function that accepts (embeddings, tokens) and returns attended_values.
Critical requirements:

Use Epic 1's cell mapping: code cells are at positions [2, 4, 6, 7, 9, 10, 12, 13, 15, 16, 18, 19]
Implementation cells map to: {6: index 2, 9: index 4, 12: index 6, 15: index 8} in code_cells array
Extract source code, handle both list and string formats
Combine the 4 cell implementations into one cohesive attention function
Function should work with 64-dim embeddings and 6 tokens
Test with PROMPT_EXAMPLE = 'The cat sat on the mat' and tokens = ['The', 'cat', 'sat', 'on', 'the', 'mat']

Expected output:
Function returns callable that takes (embeddings, tokens) and produces the complete attention forward pass using the reference implementation from cells 6, 9, 12, 15."
Phase 3: Notebook Integration
Delegate to educational-notebook-integration-specialist:
"You need to add Section 10: Real Transformer Integration to both lesson.ipynb and complete_lesson.ipynb starting at cell 21.
Context: Both notebooks currently have 20 cells from previous epics. Do NOT modify existing cells 1-20. Add exactly 5 new cells (21-25) to both notebooks with different content.
For complete_lesson.ipynb (working version):
Add these exact cells:

Cell 21: Markdown title '## Section 10: Real Transformer Integration' with explanation
Cell 22: Load distilgpt2 using model_utils.load_mini_transformer()
Cell 23: Extract reference attention using model_utils.get_reference_attention_from_notebook()
Cell 24: Replace model attention using model_utils.replace_attention_mechanism()
Cell 25: Run comparison and visualize using model_utils.run_inference_comparison()

For lesson.ipynb (student version):
Add placeholder cells that show:
'Complete cells 6, 9, 12, 15 first to enable this integration'
Critical requirements:

Import model_utils functions correctly: from model_utils import load_mini_transformer
Use PROMPT_EXAMPLE variable that exists from cell 4
Include proper error handling for missing implementations
Cells must be properly formatted JSON notebook structure
Maintain consistent cell numbering and types
Test that new cells execute without errors in complete_lesson.ipynb

Expected output:
Both notebooks updated with new Section 10, complete_lesson.ipynb cells 21-25 work fully, lesson.ipynb shows helpful placeholders."
Phase 4: Visualization Enhancement
Delegate to transformer-integration-specialist:
"You need to add a model comparison visualization function to src/visualizations.py.
Function to add:
pythondef visualize_model_comparison(original_weights: torch.Tensor, 
                              modified_weights: torch.Tensor,
                              tokens: List[str]) -> None:
Requirements:

Create side-by-side heatmaps comparing original distilgpt2 attention vs reference implementation
Left subplot: Original model attention weights
Right subplot: Reference implementation attention weights
Use same colormap (Blues) and scale for both
Include tokens as axis labels
Highlight major differences between attention patterns
Title should indicate 'distilgpt2 vs Reference Implementation'
Follow same pattern as other visualization functions (plt.show() at end)

Expected output:
Function added to visualizations.py, callable from cell 25 in complete_lesson.ipynb, shows clear visual comparison between the two attention mechanisms."
Coordination and Integration
Phase 5: End-to-End Integration Testing
After all subagents complete their work, I would coordinate final integration:
Delegate to transformer-integration-specialist:
"Run complete integration test of the full pipeline:

Execute complete_lesson.ipynb cells 21-25
Verify model loads and caches in cache/models/
Confirm reference extraction works from cells 6, 9, 12, 15
Validate dimension adapters handle 64↔768 conversion
Ensure comparison runs in under 90 seconds
Test visualization shows meaningful differences

Create the .epic5_complete.json completion marker with all required fields from the epic specification."
Quality Assurance Strategy
Throughout the process, I would ensure each subagent:

Understands the automation context - This is fully automated development, no human interaction
Maintains Epic dependencies - Uses outputs from Epics 1-4 correctly
Follows exact specifications - Cell positions, function signatures, output formats
Handles the dimension mismatch - Critical 64-dim to 768-dim adaptation
Creates working demonstrations - Uses complete_lesson.ipynb reference implementation
Provides proper error handling - Graceful failures with helpful messages
Meets performance requirements - Under 90 second execution time

Validation Approach
I would verify completion by testing:

All 7 functions in model_utils.py are fully implemented
distilgpt2 loads and caches successfully
Reference attention extracts from notebook cells correctly
Both notebooks have new Section 10 with proper content
Complete pipeline executes without errors
Model comparison visualization displays properly
Integration works offline after initial setup
Epic completion JSON created with all required fields

This comprehensive delegation strategy ensures each specialist handles their domain expertise while maintaining integration across the complex transformer model integration requirements.