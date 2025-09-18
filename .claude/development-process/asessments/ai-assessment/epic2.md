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
Assume you were the team-leader for 2_attention-mechanism, explain in great detail:
- How you would complete this task
- What subagents you would create for this epic
- How you would delegate work
- The prompts you would provide to each subagent

I want much details so that I can debug the instruction.
Do **not** give directions on how I should edit the instruction.
**Only** give descriptions on how you would complete the task as a team-lead.
```

This was the answer I got:
As team-lead for Epic 2: Attention Implementation, here's exactly how I would approach this task:
Initial Analysis and Planning
First, I would carefully read the .epic1_complete.json file to understand:

The exact notebook structure (20 cells total)
Implementation cell positions: 6, 9, 12, 15
Variable naming conventions: query, key, value, attention_scores, attention_weights, attended_values
Visualization function names that my implementations must work with
The established PROMPT_EXAMPLE = "The cat sat on the mat" with 6 tokens

I would identify that this epic requires specialized expertise in:

PyTorch tensor operations and transformer mathematics
Educational content development with clear pedagogical progression
Jupyter notebook structure and cell management
Integration testing to ensure outputs match expected shapes

Subagent Creation Strategy
Since no existing subagents would have the specific combination of transformer mathematics, educational scaffolding, and notebook integration skills needed, I would use the meta-agent to create specialized agents.
Meta-Agent Prompt 1: Transformer Implementation Specialist
Create a subagent specialized in implementing transformer attention mechanisms with educational scaffolding. This agent needs to:

1. Implement the 4 core attention steps (Linear Projections, Scaled Dot-Product, Softmax, Value Aggregation) in specific Jupyter notebook cells
2. Use PyTorch with exact tensor shapes and educational comments
3. Create pedagogically sound implementations that build understanding progressively
4. Ensure all implementations work with "The cat sat on the mat" as the consistent example
5. Add proper mathematical explanations and dimension comments for downstream integration

The agent should focus on correctness, educational clarity, and exact adherence to pre-defined cell positions and variable naming conventions.
Meta-Agent Prompt 2: Educational Content Developer
Create a subagent specialized in creating educational content and theory explanations for transformer attention mechanisms. This agent needs to:

1. Write clear markdown explanations with LaTeX formulas for each attention step
2. Create hint cells that guide implementation without giving away solutions
3. Structure content for 30-minute lesson progression
4. Ensure theory explanations match the specific 64-dimension, 6-token implementation
5. Add educational context about why each step matters in the attention mechanism

The agent should focus on pedagogical clarity, progressive difficulty, and connecting theory to practice.
Delegation Strategy
Phase 1: Foundation Setup (Transformer Implementation Specialist)
Prompt to Transformer Implementation Specialist:
You are tasked with implementing the 4 core attention mechanism cells in both lesson.ipynb and complete_lesson.ipynb. 

CRITICAL REQUIREMENTS:
- Read `.epic1_complete.json` first to get exact cell positions and variable names
- Implement ONLY cells 6, 9, 12, 15 - do not modify any other cells
- Use exactly these variable names: query, key, value, attention_scores, attention_weights, attended_values
- Use PROMPT_EXAMPLE = "The cat sat on the mat" (6 tokens) consistently
- Embedding dimension is exactly 64 throughout
- Output shapes must be: [6,64], [6,64], [6,64], [1,6,6], [1,6,6], [1,6,64]

IMPLEMENTATION CELLS:
Cell 6: Linear Projections - Create Q, K, V matrices using torch.nn.Linear layers
Cell 9: Scaled Dot-Product Attention - Implement attention_scores = (Q @ K.T) / sqrt(64)
Cell 12: Softmax & Attention Weights - Convert scores to normalized probabilities
Cell 15: Value Aggregation - Compute attended_values as weighted sum

TECHNICAL DETAILS:
- Use proper PyTorch initialization for Linear layers
- Include dimension assertions after each operation
- Add the comment "# Note: Educational implementation uses 64-dim, production models like distilgpt2 use 768-dim" in cell 15
- Ensure attention_weights sum to 1.0 across last dimension
- Handle batch dimension correctly (input has batch=1)

Complete the reference implementation in complete_lesson.ipynb first, then create the lesson.ipynb version with helpful TODO comments and hints.
Phase 2: Educational Content (Educational Content Developer)
Prompt to Educational Content Developer:
You are tasked with creating the educational content and theory explanations that precede each implementation cell.

REQUIREMENTS:
- Add comprehensive markdown cells BEFORE each implementation cell (positions 5, 8, 11, 14)
- Include LaTeX formulas for each mathematical operation
- Explain WHY each step is necessary in the attention mechanism
- Connect to the specific example "The cat sat on the mat" with 6 tokens
- Ensure 30-minute lesson pacing

CONTENT FOR EACH SECTION:
Before Cell 6: Explain linear projections, why we need Q/K/V, dimension preservation
Before Cell 9: Scaled dot-product attention, similarity computation, scaling factor importance
Before Cell 12: Softmax normalization, probability interpretation, row-wise summation
Before Cell 15: Value aggregation, weighted averaging, final output meaning

EDUCATIONAL PROGRESSION:
- Start with intuitive explanations before mathematical formals
- Use the specific 6-token example to make concepts concrete
- Build complexity gradually from projections → scores → weights → output
- Include brief hints about implementation approaches without giving solutions

Coordinate with the implementation specialist to ensure theory matches code exactly.
Phase 3: Integration and Testing (Transformer Implementation Specialist)
Prompt to Transformer Implementation Specialist:
Now that the core implementations are complete, ensure full integration:

INTEGRATION REQUIREMENTS:
- Test all 4 implementations produce correct tensor shapes
- Verify attention_weights sum to 1.0 (±0.01 tolerance)
- Ensure consistent use of "The cat sat on the mat" throughout
- Test that visualization cells can access all required variables
- Validate src/model_utils.py, src/evaluation.py, src/visualizations.py import correctly

TESTING CHECKLIST:
- Run complete_lesson.ipynb end-to-end without errors
- Verify all intermediate tensors have correct shapes and reasonable values
- Test that lesson.ipynb runs through all non-implementation cells
- Confirm variable names match Epic 1's specification exactly
- Validate dimension comment added for Epic 5

ERROR HANDLING:
- Add helpful error messages for common tensor shape mismatches
- Include assertions that catch dimension errors early
- Provide debugging output for tensor shapes at each step

Create comprehensive test cells that validate each implementation step and provide clear feedback on correctness.
Quality Control and Validation
Throughout the process, I would verify:

After Phase 1: Check that all 4 cells produce working PyTorch code with correct output shapes
After Phase 2: Ensure educational content flows logically and builds understanding progressively
After Phase 3: Run complete integration test to verify Epic 2 outputs work with Epic 1's infrastructure

Key Coordination Points
I would ensure both subagents understand:

The exact cell numbering system from Epic 1 (cells 6, 9, 12, 15 only)
The importance of consistent variable naming for Epic 3's visualizations
The need for the dimension comment in cell 15 for Epic 5's integration
That this is automated development - no student interaction exists

Final Deliverable Validation
Before marking Epic 2 complete, I would verify:

All 4 implementation cells execute without errors
Output shapes match exactly: [6,64], [6,64], [6,64], [1,6,6], [1,6,6], [1,6,64]
"The cat sat on the mat" used consistently everywhere
Educational progression is clear and pedagogically sound
Integration points with other epics are preserved
.epic2_complete.json file is created with all required fields

This delegation strategy ensures each subagent focuses on their expertise while maintaining the critical integration points that subsequent epics depend on.