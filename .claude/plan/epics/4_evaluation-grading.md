# Epic 4: Evaluation & Grading

## Epic Definition
Implement automated evaluation system using LLM-based assessment to grade student attention mechanism implementations against reference solutions. This epic creates the intelligent grading infrastructure that validates correctness while maintaining tolerance for alternative valid approaches, enabling autonomous lesson completion scoring.

## Tech Stack & Frameworks
- **Ollama** for primary local LLM inference and code evaluation
- **OpenAI API** as fallback when local LLM unavailable or insufficient
- **Python 3.10** maintaining consistency with project infrastructure
- **JSON** for progress tracking integration with infrastructure epic
- **PyTorch 2.0+** for tensor comparison and validation from attention implementation epic
- **AST module** for Python code analysis and structure validation
- **Requests/HTTP** for LLM API communication (Ollama/OpenAI)
- **Logging** for evaluation audit trails and debugging

## Hard Requirements

### 1. LLM Evaluation Functions
Core evaluation functions in src/evaluation.py with exact signatures:
```python
evaluate_implementation(student_code: str, reference_code: str, test_case: Dict, section_name: str) -> Dict[str, Any]
evaluate_attention_head(student_weights: torch.Tensor, reference_weights: torch.Tensor, tokens: List[str]) -> Dict[str, Any]
batch_evaluate_notebook(notebook_path: str, reference_path: str) -> Dict[str, Any]
update_progress_json(student_id: str, section_scores: Dict[str, int], progress_path: str) -> bool
```

### 2. Attention Implementation Assessment
Evaluate four specific implementation cells from attention epic:
- **Linear Projections**: Q/K/V matrix initialization and forward pass correctness
- **Scaled Dot-Product**: Mathematical accuracy of attention score computation
- **Softmax Weights**: Normalization correctness and numerical stability handling
- **Value Aggregation**: Weighted sum computation and output tensor validation

### 3. Evaluation Criteria & Scoring
Each section scored 0-1 points based on:
- **Functional Correctness** (60%): Output tensors match expected shapes and value ranges
- **Implementation Quality** (25%): Code follows transformer architecture patterns
- **Educational Understanding** (15%): Comments and variable naming demonstrate comprehension
- **Tolerance Level**: ±0.01 for floating-point tensor comparisons, alternative valid algorithms accepted

### 4. Progress Integration
Interface with infrastructure epic's progress tracking:
- Read existing progress/lesson_progress.json structure
- Update section_scores dictionary with evaluation results
- Maintain completion timestamps and total_score calculation
- Support multiple evaluation runs without data loss
- Atomic file operations preventing corruption during concurrent access

### 5. LLM Integration Requirements
**Primary: Ollama Integration**
- Local Ollama instance running llama3.1:8b or equivalent model
- Default base_url: http://localhost:11434/v1/chat/completions
- Evaluation prompts engineered for code assessment consistency
- Retry logic for API failures with exponential backoff

**Fallback: OpenAI Integration**
- OpenAI API as secondary option when Ollama unavailable or insufficient hardware
- User configuration choice with API key prompt if selected
- Identical base_url parameter substitution for seamless switching
- Model: gpt-4-turbo-preview

**Shared Requirements**
- Response parsing extracting structured evaluation data
- Identical prompt templates and evaluation criteria across both providers
- Final fallback to rule-based evaluation if both LLM options fail

## Implementation Notes
- Evaluation must handle common errors gracefully: syntax errors, wrong tensor shapes, missing imports
- LLM prompts should include reference implementation context and specific evaluation criteria
- Tensor comparison functions must account for different but equivalent implementations
- Evaluation results cached to prevent redundant LLM calls during development
- Integration with verify.py functions from infrastructure epic maintaining backward compatibility
- Evaluation audit logs for debugging and fairness validation
- Support for partial credit on implementations showing partial understanding
- LLM provider selection through configuration file or environment variable
- OpenAI API key collection only when user explicitly chooses OpenAI fallback
- Base URL switching mechanism transparent to evaluation logic

## Success Criteria
1. All four attention implementation sections evaluate correctly against reference solutions
2. LLM evaluation produces consistent scores across multiple runs with same input
3. Progress JSON updates successfully maintain data integrity across evaluation cycles
4. Tensor comparison handles floating-point precision and equivalent algorithmic approaches
5. Evaluation system integrates seamlessly with verify.py infrastructure from previous epic
6. Primary Ollama integration provides meaningful feedback for incorrect implementations
7. Evaluation completes within 60 seconds for full notebook assessment
8. Fallback mechanisms ensure grading availability without LLM dependency
9. Scoring system accurately identifies partial understanding and common misconceptions
10. Progress tracking enables lesson resumption and incremental completion

## Validation
Team-lead must demonstrate:
- Complete evaluation pipeline processing reference implementation notebook with perfect scores
- Incorrect implementations receiving appropriate partial credit and feedback
- Progress JSON integrity after multiple evaluation cycles and interruptions
- LLM evaluation consistency producing stable scores for identical implementations
- Integration testing with visualization functions from previous epic for evaluation feedback
- Primary Ollama evaluation system functioning with local LLM
- OpenAI fallback system activating seamlessly when Ollama unavailable
- API key prompt mechanism functioning only when OpenAI explicitly selected
- Performance validation completing full notebook evaluation within time constraints
- Error handling for malformed code and tensor outputs