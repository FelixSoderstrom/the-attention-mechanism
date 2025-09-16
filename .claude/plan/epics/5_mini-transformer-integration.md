# Epic 5: Mini-Transformer Integration

## Epic Definition
Integrate student attention implementations with a small pre-trained transformer model, enabling real-world inference comparison between student-built attention mechanisms and production transformer attention. This epic serves as the capstone demonstration where theoretical implementations meet practical transformer architecture, validating student understanding through functional model integration.

## Tech Stack & Frameworks
- **Transformers library 4.21+** for pre-trained model loading and architecture access
- **PyTorch 2.0+** for model modification and tensor operations from previous epics
- **Python 3.10** maintaining project consistency
- **distilgpt2** as the 82M parameter reference model (small enough for educational use)
- **Tokenizers** for consistent PROMPT_EXAMPLE processing with model vocabulary
- **Model surgery utilities** for attention mechanism replacement

## Hard Requirements

### 1. Model Integration Functions
Core integration functions in src/model_utils.py with exact signatures:
```python
load_mini_transformer() -> Tuple[AutoModel, AutoTokenizer]
extract_attention_layer(model: AutoModel, layer_idx: int = 0) -> nn.Module
replace_attention_mechanism(model: AutoModel, student_attention: callable, layer_idx: int = 0) -> AutoModel
run_inference_comparison(model: AutoModel, student_model: AutoModel, prompt: str) -> Dict[str, torch.Tensor]
extract_attention_weights(model: AutoModel, input_ids: torch.Tensor, layer_idx: int = 0) -> torch.Tensor
```

### 2. Student Attention Integration
Bridge student implementations from attention epic with transformer architecture:
- **Attention Head Wrapper**: Adapt student Q/K/V projections to accept transformer hidden states
- **Shape Compatibility**: Handle dimension mismatches between 64-dim student implementation and model's 768-dim hidden states
- **Layer Integration**: Replace first attention layer in distilgpt2 while preserving remaining architecture
- **Gradient Flow**: Maintain backpropagation capability for educational gradient analysis

### 3. Inference Demonstration
Run comparative inference using established PROMPT_EXAMPLE:
- **Tokenization**: Convert "The cat sat on the mat" using model's native tokenizer
- **Attention Extraction**: Capture attention weights from both original and student-modified models
- **Output Generation**: Generate next-token predictions showing attention influence on model behavior
- **Performance Metrics**: Compare inference speed, attention pattern coherence, and output quality

### 4. Comparison Analysis
Quantitative and qualitative attention pattern comparison:
- **Attention Similarity**: Cosine similarity and Earth Mover's Distance between attention matrices
- **Semantic Coherence**: Validate that student attention captures meaningful token relationships
- **Visualization Integration**: Use comparison plotting functions from visualization epic
- **Pattern Analysis**: Identify where student implementation differs from production attention

### 5. Educational Integration Points
Connect with all previous epics for comprehensive learning experience:
- **Progress Tracking**: Update lesson completion status via infrastructure epic's JSON system
- **Evaluation Integration**: Feed comparison results into evaluation epic's LLM assessment
- **Visualization Pipeline**: Generate side-by-side attention heatmaps using established visualization functions
- **Error Handling**: Graceful degradation when student implementation incompatible with model architecture

## Implementation Notes
- Model download and caching handled automatically by transformers library
- Attention mechanism replacement must preserve model's forward pass signature
- Handle tokenization differences gracefully - student implementation uses 6 tokens, model may tokenize differently
- Dimension adaptation layers required between 64-dim student embeddings and 768-dim model hidden states
- Memory management critical - clear GPU cache between model versions
- Support both CPU and CUDA execution with automatic device detection
- Integration testing against reference attention implementation before student testing
- Attention weight extraction must handle different attention head configurations

## Success Criteria
1. distilgpt2 model loads successfully and runs baseline inference with PROMPT_EXAMPLE
2. Student attention mechanism integrates without breaking model architecture
3. Comparative inference produces meaningful attention weight comparisons
4. Attention similarity metrics provide educational feedback on implementation quality
5. Visualization integration generates clear side-by-side attention pattern comparisons
6. Performance remains acceptable - full comparison completes within 90 seconds on standard hardware
7. Integration gracefully handles common implementation errors
8. Output demonstrates clear attention influence on model predictions
9. Results integrate with evaluation epic for comprehensive assessment
10. Educational value clear - connection demonstrated between implementations and production transformers

## Validation
Team-lead must demonstrate:
- Successful model loading and baseline inference with expected attention patterns
- Reference implementation integration producing equivalent attention patterns
- Modified implementations showing measurable attention differences
- Comparison metrics accurately reflecting attention pattern similarities and differences
- Integration with visualization epic producing meaningful side-by-side comparisons
- Performance validation completing full comparison pipeline within time constraints
- Error handling for incompatible implementations with helpful educational feedback
- Connection to evaluation epic providing integrated assessment functionality
- Memory management preventing GPU/CPU resource exhaustion during comparison runs