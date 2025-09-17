# Epic 2: Attention Implementation

## Epic Definition
Implement the core pedagogical content for transformer attention mechanisms within the lesson notebook infrastructure. This epic creates the primary learning experience where students implement scaled dot-product attention from scratch, building understanding through hands-on coding of Q/K/V projections, attention scoring, and value aggregation.

## Tech Stack & Frameworks
- **PyTorch 2.0+** for tensor operations and automatic differentiation
- **NumPy** for numerical computations and array operations
- **Python 3.10** following infrastructure epic conventions
- **Jupyter Notebook** cells building on established scaffold
- **Math/LaTeX** rendering for educational formulas
- **Pre-tokenized datasets** for consistent PROMPT_EXAMPLE usage

## Hard Requirements

### 1. Consistent Example Data
- Single PROMPT_EXAMPLE: "The cat sat on the mat" tokenized to exactly 6 tokens
- Embedding dimension: 64 (small enough for clear visualization, large enough for meaningful computation)
- All implementations must use identical input tensors for reproducible results
- Token-to-index mapping must be deterministic and documented

### 2. Student Implementation Cells
Four core implementation sections in lesson.ipynb:
- **Cell 4: Linear Projections** - Create learnable Q, K, V matrices (64x64 each)
- **Cell 5: Scaled Dot-Product Attention** - Implement attention_scores = (Q @ K.T) / sqrt(d_k)
- **Cell 6: Softmax & Attention Weights** - Convert scores to normalized probabilities
- **Cell 7: Value Aggregation** - Compute weighted sum of values using attention weights

### 3. Educational Scaffolding
- Each implementation cell preceded by theory explanation with LaTeX formulas
- Followed by collapsed hint cell with implementation guidance
- Test cell validating correctness using shape checks and basic functionality
- Immediate feedback showing attention pattern for PROMPT_EXAMPLE

### 4. Reference Implementation
Complete attention head in complete_lesson.ipynb with:
- Identical cell structure and numbering as student version
- Well-commented reference solutions
- Dimensionality assertions and error handling
- Performance considerations and best practices

### 5. Integration Points
- All implementations must integrate with src/visualizations.py functions
- Output format compatible with verify.py validation functions
- Attention weights tensor shape: [1, 6, 6] for single head over 6 tokens
- Consistent variable naming: query, key, value, attention_weights, attended_values

## Implementation Notes
- **Architecture Fidelity**: Use torch.nn.Linear layers for Q/K/V projections matching real transformer architecture with proper initialization
- **Educational Clarity**: Include scaling factor (1/sqrt(64)) as explicit step with mathematical justification and numerical stability discussion
- **Robust Numerical Handling**: Softmax implementation with overflow protection, underflow handling, and edge case management for educational understanding
- **Error Prevention**: Student cells include comprehensive input validation, common mistake detection, and guidance toward correct implementations
- **Integration Continuity**: All intermediate tensors preserved with consistent naming and shape documentation for seamless visualization epic integration
- **Developer Experience**: Detailed dimension comments, assert statements for shape validation, and helpful error messages guiding students toward correct solutions
- **Performance Considerations**: Efficient tensor operations with memory usage monitoring and automatic fallbacks for resource-constrained environments

## Success Criteria
1. All four implementation cells structured for clear educational progression
2. Attention weights sum to 1.0 across sequence dimension (validated automatically)
3. Output tensors match expected shapes and reasonable value ranges
4. Implementation produces consistent results across multiple runs
5. Code integrates seamlessly with visualization functions from infrastructure
6. Reference implementation serves as definitive correctness benchmark
7. Educational progression builds intuition before introducing complexity
8. All cells execute efficiently on standard hardware

## Validation
Team-lead must demonstrate:
- Reference implementation producing expected attention patterns for "cat sat mat"
- Integration with verify.py functions returning correct validation scores
- Error handling for common implementation mistakes
- Consistent output format enabling downstream epic integration