---
EPIC_NAME: 2_attention-implementation
---

# Epic 2: Attention Implementation

## Prerequisites
Read `.epic1_complete.json` to get notebook structure, variable names, and cell positions from Epic 1.

## Epic Definition
Implement the core pedagogical content for transformer attention mechanisms within the lesson notebook infrastructure created by Epic 1. Fill in the 4 implementation sections with working attention mechanism code and create a standalone reference implementation module.

## Suggested Subagents
This epic will likely require 2-3 specialized agents:
- **PyTorch Implementation Specialist**: Expert in transformer attention mechanisms and PyTorch tensor operations
- **Educational Content Writer**: Specialist in creating clear explanations and educational materials

## Natural Delegation Points
- Attention mechanism implementation → PyTorch Implementation Specialist
- Theory explanations and educational content → Educational Content Writer
- Reference module creation → PyTorch Implementation Specialist

## Core Requirements

### 1. Implement 4 Core Sections
Complete these implementations in both notebooks:
1. **Linear Projections**: Create Q, K, V matrices
2. **Scaled Dot-Product Attention**: Calculate attention scores
3. **Softmax & Attention Weights**: Normalize to probabilities
4. **Value Aggregation**: Compute weighted sum

### 2. Consistent Example
Use throughout all implementations:
- `PROMPT_EXAMPLE = "The cat sat on the mat"`
- 6 tokens with embeddings dimension 64
- Batch dimension where appropriate [1, 6, X]

### 3. Create Reference Module
Create `src/reference_attention.py` with standalone implementation that Epic 5 can import directly (avoiding notebook parsing complexity).

### 4. Educational Content
For each section provide:
- Clear theory explanation with formulas
- Implementation that works correctly
- Comments explaining each step
- Expected output shapes

### 5. Expected Output Shapes
Ensure correct tensor dimensions:
- Q, K, V: [6, 64]
- attention_scores: [1, 6, 6]
- attention_weights: [1, 6, 6] (sum to 1.0)
- attended_values: [1, 6, 64]

## Scope
**Single-head attention only** - no multi-head, no positional encoding, no transformer blocks.

## Handoff Requirements
Provide to subsequent epics:
- Complete working implementations in `complete_lesson.ipynb`
- Standalone `src/reference_attention.py` module
- Consistent variable names and shapes
- Educational content integrated

## Success Criteria
- All 4 implementations working correctly
- Reference module importable and functional
- Attention weights sum to 1.0
- Educational explanations clear and accurate
- Completion marker `.epic2_complete.json` created

## Important Notes
- This is automated development - use reference implementation directly
- Focus on educational clarity and correctness
- Ensure consistency with Epic 1's structure