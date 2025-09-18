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
Assume you were the team-leader for 4_evaluation-grading, explain in great detail:
- How you would complete this task
- What subagents you would create for this epic
- How you would delegate work
- The prompts you would provide to each subagent

I want much details so that I can debug the instruction.
Do **not** give directions on how I should edit the instruction.
**Only** give descriptions on how you would complete the task as a team-lead.
```

This was the answer I got:
As the team-lead for Epic 4 (Evaluation & Grading), I would approach this complex task through systematic delegation to specialized subagents. Let me detail my complete strategy:
Initial Assessment and Planning
First, I would read all prerequisite completion files (.epic1_complete.json, .epic2_complete.json, .epic3_complete.json) to understand the exact infrastructure I'm working with. This includes understanding the cell positions (6, 9, 12, 15), the progress schema structure, the LLM configuration setup, and the exact output shapes from Epic 2.
The task involves multiple specialized domains: LLM integration, tensor validation, notebook parsing, file I/O, and educational feedback generation. This clearly requires multiple specialized agents.
Subagent Creation Strategy
I would use the meta-agent to create these specialized subagents:
1. LLM Integration Specialist
Meta-agent prompt:
"Create a subagent specialized in integrating Large Language Models (both Ollama and OpenAI) for educational evaluation tasks. This agent needs to handle API communication, prompt engineering for code evaluation, fallback mechanisms when LLMs are unavailable, and generating educational feedback. The agent should be expert in both Ollama HTTP API and OpenAI API patterns, with robust error handling for network failures, rate limiting, and model unavailability."
2. Notebook Parser Agent
Meta-agent prompt:
"Create a subagent specialized in parsing and extracting code from Jupyter notebooks. This agent must handle JSON notebook format, extract code cells by position (not ID), handle malformed notebooks gracefully, and work with the specific cell mapping from Epic 1 where implementation cells are at positions 6, 9, 12, 15. The agent needs expertise in notebook cell structure and robust error handling for corrupted files."
3. Tensor Validation Specialist
Meta-agent prompt:
"Create a subagent specialized in PyTorch tensor validation for educational purposes. This agent must validate tensor shapes, check numerical properties (like attention weights summing to 1.0), compare student outputs against reference implementations, and provide clear educational feedback about tensor operations. The agent needs deep understanding of transformer attention mechanics and common student mistakes."
4. Educational Feedback Generator
Meta-agent prompt:
"Create a subagent specialized in generating human-readable educational feedback for coding assignments. This agent takes technical validation results and LLM assessments to create structured, encouraging feedback files that help students understand their mistakes and improve their implementations. The agent should be expert in pedagogical communication and constructive criticism."
5. Progress Tracking System Agent
Meta-agent prompt:
"Create a subagent specialized in managing educational progress tracking systems. This agent must work with the exact JSON schema from Epic 1, handle attempt numbering, timestamp management, score calculation, and file persistence. The agent needs expertise in educational record-keeping and data integrity."
Detailed Delegation Strategy
Phase 1: Infrastructure Setup
I would delegate to the Progress Tracking System Agent:
Prompt: "You need to complete the dependencies update in requirements.txt by adding 'requests>=2.31.0' and 'openai>=1.0.0'. Then examine the existing progress/lesson_progress.json file to understand the exact schema structure that Epic 1 created. Your task is to create the foundation for attempt tracking by implementing functions that can determine the next attempt number by scanning the grade/ directory, and create the basic directory structure for new attempts. Focus on the file system operations and JSON schema compliance."
Phase 2: LLM Provider Setup
I would delegate to the LLM Integration Specialist:
Prompt: "Your primary task is to implement the LLM provider configuration system. Read the .llm_config.json file that Epic 1 created and implement the get_llm_provider() function that can instantiate either OllamaProvider, OpenAIProvider, or RuleBasedProvider based on the configuration. For Ollama, implement HTTP API communication to http://localhost:11434/api/generate with proper error handling. For OpenAI, use the openai package with API key from environment variables. Create a RuleBasedProvider as fallback that performs shape checking and basic code analysis when LLMs are unavailable. Each provider must implement the same interface for code evaluation."
Phase 3: Core Evaluation Logic
I would delegate to the Tensor Validation Specialist:
Prompt: "Implement the core tensor validation functions in src/evaluation.py. Your focus is the validate_tensor_output() function that compares student tensors against reference tensors. Handle the specific shapes from Epic 2: query/key/value [6,64], attention_scores [1,6,6], attention_weights [1,6,6], attended_values [1,6,64]. For attention_weights, implement the critical validation that they sum to 1.0 ± 0.01 across the last dimension. Include tolerance-based comparison for numerical values and clear error messages when shapes don't match. Also implement the EVALUATION_CONFIG structure with the exact cell mapping from Epic 1."
Phase 4: Notebook Integration
I would delegate to the Notebook Parser Agent:
Prompt: "Implement the extract_cell_code() function that can reliably extract code from notebook cells by position. You must handle the Epic 1 cell mapping: code cells at positions 6, 9, 12, 15 correspond to actual code cell indices 2, 4, 6, 8 in the notebook JSON structure. Handle malformed notebooks, empty cells, and cells containing only 'TODO' or 'pass' statements. Implement robust error handling for corrupted JSON, missing cells, and extraction failures. The function must work with both lesson.ipynb and complete_lesson.ipynb."
Phase 5: Main Evaluation Pipeline
I would delegate to the Tensor Validation Specialist again:
Prompt: "Now implement the main grade_notebook() function that orchestrates the entire evaluation process. This function must: 1) Extract code from all 4 implementation cells using the notebook parser, 2) Execute both student and reference code in isolated environments, 3) Capture the standardized output variables (query, key, value, attention_scores, attention_weights, attended_values), 4) Use your tensor validation functions to compare outputs, 5) Interface with the LLM provider for qualitative code assessment, 6) Combine all results into a comprehensive evaluation report. Handle execution errors gracefully and assign 0 points to TODO/empty implementations."
Phase 6: Feedback Generation
I would delegate to the Educational Feedback Generator:
Prompt: "Implement the generate_feedback_files() function that creates human-readable feedback in the grade/attempt_X/ directory structure. For each of the 4 cells (6, 9, 12, 15), create individual .txt files following the exact format specified in the requirements: score display, status (PASS/FAIL), variable checks with checkmarks, implementation quality assessment, suggestions for improvement, and LLM evaluation quotes. Also create the receipt.json with score summary. The feedback must be encouraging and educational, helping students understand both what they did right and how to improve."
Phase 7: Integration and Testing
I would delegate to the Progress Tracking System Agent:
Prompt: "Complete the verify.py integration by implementing the LessonVerifier class. This class must provide the main entry point that calls grade_notebook(), determines the attempt number, generates feedback files, and updates the progress JSON with the exact schema from Epic 1. Implement the _update_progress() method that writes section scores to the specific keys: cell_6_linear_projections, cell_9_scaled_dot_product, cell_12_softmax_weights, cell_15_value_aggregation. Ensure the verification can be called from notebook cells and provides clear return values."
Quality Assurance and Validation
Final Integration Testing
I would delegate to the LLM Integration Specialist:
Prompt: "Perform end-to-end integration testing of the complete evaluation system. Test with empty implementations (should score 0), test with the reference implementation from complete_lesson.ipynb (should score 100), and test partial implementations. Verify that both Ollama and OpenAI providers work correctly, and that the rule-based fallback provides reasonable evaluation when LLMs are unavailable. Confirm that the entire evaluation process completes within 30 seconds and produces properly formatted output files."
Critical Success Validation
Before marking the epic complete, I would verify:

All subagents have successfully implemented their assigned functions
The system correctly identifies and scores empty implementations as 0
Reference implementations score 100 points with positive feedback
All output files follow the exact format specifications
Progress JSON updates use Epic 1's exact schema
Both LLM providers function correctly with proper fallbacks
The complete evaluation pipeline executes within performance requirements

Coordination Strategy
Throughout this process, I would maintain constant communication between agents to ensure compatibility:

The Notebook Parser Agent's output format must work seamlessly with the Tensor Validation Specialist's input expectations
The LLM Integration Specialist's evaluation format must integrate properly with the Educational Feedback Generator's template system
The Progress Tracking System Agent must coordinate with all other agents to collect the right data for JSON updates

This systematic approach ensures that each agent focuses on their area of expertise while maintaining the complex integrations required for a functional evaluation system that builds properly on the infrastructure from previous epics.