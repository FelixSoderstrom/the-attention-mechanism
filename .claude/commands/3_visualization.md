---
EPIC_NAME: 3_visualization
---

# Epic 3: Visualization

## Prerequisites
Read `.epic1_complete.json` and `.epic2_complete.json` to get function names, cell positions, and output shapes.

## Epic Definition
Implement visualization functions that bring the 4-cell attention implementation from Epic 2 to life through clear, educational visual feedback.

## Suggested Subagents
This epic will likely require 2 specialized agents:
- **Visualization Specialist**: Expert in matplotlib and educational data visualization
- **Notebook Integration Specialist**: Expert in Jupyter notebook integration and testing

## Natural Delegation Points
- Visualization function implementation → Visualization Specialist
- Notebook integration and testing → Notebook Integration Specialist

## Core Requirements

### 1. Implement 4 Visualization Functions
Complete these functions in `src/visualizations.py`:
- `visualize_qkv_projections(embeddings, query, key, value, tokens)`
- `visualize_attention_scores(attention_scores, tokens)`
- `visualize_attention_weights(attention_weights, tokens)`
- `visualize_attended_values(attended_values, attention_weights, tokens)`

### 2. Tensor Shape Handling
All tensors use batch dimension consistently:
- attention_scores: [1, 6, 6]
- attention_weights: [1, 6, 6]
- attended_values: [1, 6, 64]
- Handle batch dimension squeezing as needed

### 3. Display Requirements
Each function must:
- Create clear, educational visualizations
- Include proper labels and titles
- Show token labels ("The", "cat", "sat", "on", "the", "mat")
- Call `plt.show()` at the end
- Return None

### 4. Integration
Ensure visualizations:
- Work with Epic 2's outputs
- Display inline in notebooks
- Handle missing data gracefully

## Scope
Only implement the 4 required visualization functions.

## Handoff Requirements
Provide to subsequent epics:
- Working visualization functions
- Proper integration with notebooks
- Clear visual feedback for learning

## Success Criteria
- All 4 functions implemented and working
- Visualizations display correctly in notebooks
- Token labels visible
- Graceful error handling
- Completion marker `.epic3_complete.json` created

## Important Notes
- Let visualization specialist choose appropriate plot types and colors
- Focus on educational clarity
- Ensure consistency with tensor shapes from Epic 2