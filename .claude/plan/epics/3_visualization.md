# Epic 3: Visualization

## Epic Definition
Implement comprehensive attention visualization functions that transform abstract tensor operations into intuitive visual understanding. This epic creates the visual bridge between student implementations and conceptual comprehension, enabling immediate feedback on attention patterns and preparing comparison infrastructure for subsequent epic integration.

## Tech Stack & Frameworks
- **Matplotlib 3.5+** for static plots and heatmaps
- **Plotly 5.0+** for interactive attention flow diagrams  
- **PyTorch 2.0+** tensor integration from Epic 2 outputs
- **NumPy** for numerical visualization preprocessing
- **Python 3.10** maintaining infrastructure consistency
- **Jupyter Notebook** inline rendering with %matplotlib inline
- **Seaborn** for enhanced heatmap aesthetics and educational color schemes

## Hard Requirements

### 1. Core Visualization Functions
Four essential functions in src/visualizations.py with exact signatures:
```python
plot_attention_heatmap(attention_weights: torch.Tensor, tokens: List[str], title: str = "Attention Weights") -> None
plot_attention_flow(attention_weights: torch.Tensor, tokens: List[str], threshold: float = 0.1) -> None  
plot_calculation_steps(query: torch.Tensor, key: torch.Tensor, attention_scores: torch.Tensor, attention_weights: torch.Tensor, tokens: List[str]) -> None
plot_qkv_projections(embeddings: torch.Tensor, query: torch.Tensor, key: torch.Tensor, value: torch.Tensor, tokens: List[str]) -> None
```

### 2. PROMPT_EXAMPLE Integration
- All visualizations must handle exactly 6 tokens: ["The", "cat", "sat", "on", "the", "mat"]
- Attention weights input shape: [1, 6, 6] or [6, 6] with automatic reshaping
- Token labels positioned clearly on axes without overlap
- Consistent color mapping across all visualizations for token relationships

### 3. Educational Design Standards
- **Heatmap**: Blue-white-red gradient with 0.0 (blue) to 1.0 (red) attention strength
- **Flow diagram**: Directed arrows with thickness proportional to attention weight
- **Step-by-step**: 2x2 subplot layout showing Q@K.T → scaling → softmax progression
- **Projections**: Side-by-side embeddings vs Q/K/V transformations with dimension annotations

### 4. Notebook Integration Points
- Automatic inline rendering without explicit plt.show() calls
- Integration with variable names: attention_weights, query, key, value
- Called immediately after each implementation cell for instant feedback
- Error handling for malformed tensors with educational error messages
- Maximum 5-second render time per visualization on standard hardware

### 5. Comparison Infrastructure
Additional function for Epic 5 mini-transformer integration:
```python
plot_attention_comparison(student_weights: torch.Tensor, reference_weights: torch.Tensor, tokens: List[str], labels: List[str] = ["Student", "Reference"]) -> None
```
- Side-by-side heatmaps with difference visualization
- Quantitative similarity metrics displayed
- Supports validation and performance comparison

## Implementation Notes
- Input validation must handle common errors: wrong shapes, NaN values, non-normalized weights
- All functions should gracefully degrade with informative warnings rather than crashes
- Use figsize=(10, 6) for heatmaps and (12, 8) for multi-panel displays
- Include colorbar legends with clear attention strength indicators
- Token labels should be readable at default notebook zoom levels
- Preserve tensor device (CPU/GPU) without unnecessary transfers
- Function docstrings must include exact input tensor shape requirements

## Success Criteria
1. All four core functions render correctly with previous epic tensor outputs
2. Attention heatmap clearly shows "cat-sat" and "mat" token relationships for PROMPT_EXAMPLE
3. Flow diagram filters noise (threshold=0.1) while preserving meaningful connections
4. Step-by-step visualization demonstrates softmax normalization effect visually
5. Q/K/V projections show dimensional transformation from 64-dim embeddings
6. Error handling provides helpful feedback for common implementation mistakes
7. Visualization outputs integrate seamlessly with next epic evaluation functions
8. Comparison function foundation supports next epic mini-transformer validation
9. All plots maintain educational clarity and professional appearance
10. Render performance stays under 5 seconds per visualization

## Validation
Team-lead must demonstrate:
- Complete visualization suite with previous epic reference implementation outputs
- Clear attention patterns showing semantic relationships in "The cat sat on the mat"
- Graceful handling of malformed tensor inputs with helpful error messages
- Visual confirmation that attention weights sum to 1.0 across sequence dimension
- Comparison function producing meaningful side-by-side analysis
- Integration testing with previous epics notebook infrastructure and implementations
- Performance validation under next epic evaluation scenarios