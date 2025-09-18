---
EPIC_NAME: 5_mini-transformer
---

# Epic 5: Mini-Transformer Integration

## Prerequisites
Read `.epic1_complete.json` through `.epic4_complete.json` to understand the system state.

## Epic Definition
Complete the model integration infrastructure by implementing core functions in `src/model_utils.py` and demonstrating how the reference attention implementation compares to a real production transformer.

## Suggested Subagents
This epic will likely require 2-3 specialized agents:
- **Transformer Integration Specialist**: Expert in transformers library and model manipulation
- **Model Comparison Specialist**: Expert in comparing and visualizing model differences

## Natural Delegation Points
- Model loading and caching → Transformer Integration Specialist
- Attention replacement and comparison → Model Comparison Specialist
- Notebook integration → Either agent

## Core Requirements

### 1. Simplify model_utils.py
Implement 3-4 core functions (not 7):
- `load_mini_transformer()` - Load and cache distilgpt2
- `compare_attention_implementations()` - Main comparison function
- `visualize_model_comparison()` - Show differences
- Optional: `adapt_dimensions()` if needed for 64↔768

### 2. Use Reference Module
Import from `src/reference_attention.py` created by Epic 2 (avoid notebook parsing).

### 3. Model Integration
- Load distilgpt2 or similar small model
- Cache in `cache/models/` directory
- Compare with reference implementation
- Handle dimension differences if needed

### 4. Add Demonstration Section
Add new section to notebooks showing:
- Model loading
- Attention comparison
- Visualization of differences
Let implementer determine optimal cell organization.

### 5. Keep It Simple
- This demonstrates the reference implementation
- No student interaction needed
- Focus on showing comparison clearly

## Scope
Demonstrate reference implementation compared to production model. Keep dimension handling simple.

## Handoff Requirements
Provide to Epic 6:
- Working model comparison
- Clear demonstration in notebooks
- Cached model for offline use

## Success Criteria
- Core functions implemented in model_utils.py
- Model loads and caches successfully
- Comparison demonstrates differences clearly
- Notebooks updated with demonstration
- Completion marker `.epic5_complete.json` created

## Important Notes
- Import reference implementation directly from module
- Let agents decide best approach for dimensions
- Focus on educational value of comparison