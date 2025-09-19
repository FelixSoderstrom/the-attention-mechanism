# LLM Configuration Guide

## Overview

The Attention Mechanism Educational Project integrates Large Language Models (LLMs) to provide intelligent code evaluation, educational feedback, and interactive explanations. This guide covers setup and configuration of both Ollama (primary, free) and OpenAI (fallback) providers.

## Configuration File Structure

The system uses `.llm_config.json` for all LLM settings:

```json
{
  "llm_providers": {
    "primary": { /* Ollama configuration */ },
    "fallback": { /* OpenAI configuration */ }
  },
  "educational_settings": { /* Learning preferences */ },
  "logging": { /* Interaction logging */ },
  "rate_limiting": { /* Usage controls */ },
  "cache": { /* Response caching */ },
  "prompts": { /* Educational prompts */ }
}
```

## Primary Provider: Ollama Setup

Ollama is the recommended primary provider as it's free and runs locally.

### 1. Install Ollama

**Windows:**
1. Download from [ollama.ai](https://ollama.ai/download/windows)
2. Run the installer
3. Ollama service starts automatically

**macOS:**
```bash
# Using Homebrew
brew install ollama

# Or download from ollama.ai
```

**Linux:**
```bash
# Install script
curl -fsSL https://ollama.ai/install.sh | sh

# Or manual installation
wget https://ollama.ai/download/ollama-linux-amd64
sudo mv ollama-linux-amd64 /usr/local/bin/ollama
sudo chmod +x /usr/local/bin/ollama
```

### 2. Start Ollama Service

**Automatic (Recommended):**
Ollama typically starts as a system service automatically.

**Manual:**
```bash
ollama serve
# Runs on http://localhost:11434
```

### 3. Download Educational Models

The project uses `llama3.1:8b` for educational explanations:

```bash
# Primary educational model
ollama pull llama3.1:8b

# Optional: Code-specific model
ollama pull codellama:7b
```

**Model Requirements:**
- **llama3.1:8b**: ~4.7GB - Primary educational model
- **codellama:7b**: ~3.8GB - Optional code explanation model

### 4. Verify Ollama Installation

Test Ollama is working:
```bash
# Check service
curl http://localhost:11434/api/tags

# Test model
ollama run llama3.1:8b "Explain attention mechanism briefly"
```

### 5. Ollama Configuration in .llm_config.json

```json
{
  "llm_providers": {
    "primary": {
      "provider": "ollama",
      "base_url": "http://localhost:11434",
      "models": {
        "default": "llama3.1:8b",
        "code_explanation": "codellama:7b",
        "educational": "llama3.1:8b"
      },
      "parameters": {
        "temperature": 0.7,
        "max_tokens": 2048,
        "top_p": 0.9,
        "stream": false
      },
      "timeout": 60,
      "retry_attempts": 3
    }
  }
}
```

## Fallback Provider: OpenAI Setup

OpenAI provides high-quality responses but requires an API key and usage costs.

### 1. Get OpenAI API Key

1. Sign up at [platform.openai.com](https://platform.openai.com)
2. Navigate to API Keys section
3. Create new API key
4. Copy the key (starts with `sk-...`)

### 2. Configure API Key

**Method 1: Environment Variable (Recommended)**
```bash
# Windows (Command Prompt)
set OPENAI_API_KEY=sk-your-api-key-here

# Windows (PowerShell)
$env:OPENAI_API_KEY="sk-your-api-key-here"

# Linux/macOS
export OPENAI_API_KEY="sk-your-api-key-here"
```

**Method 2: .env File**
Create `.env` file in project root:
```
OPENAI_API_KEY=sk-your-api-key-here
```

**Method 3: Direct Configuration**
Add to `.llm_config.json` (less secure):
```json
{
  "llm_providers": {
    "fallback": {
      "api_key": "sk-your-api-key-here"
    }
  }
}
```

### 3. OpenAI Configuration in .llm_config.json

```json
{
  "llm_providers": {
    "fallback": {
      "provider": "openai",
      "base_url": "https://api.openai.com/v1",
      "models": {
        "default": "gpt-3.5-turbo",
        "code_explanation": "gpt-3.5-turbo",
        "educational": "gpt-3.5-turbo"
      },
      "parameters": {
        "temperature": 0.7,
        "max_tokens": 2048,
        "top_p": 0.9,
        "stream": false
      },
      "timeout": 30,
      "retry_attempts": 2
    }
  }
}
```

### 4. Cost Management

**Recommended Settings for Educational Use:**
- **Model**: `gpt-3.5-turbo` (most cost-effective)
- **Max Tokens**: 2048 (balance quality vs cost)
- **Temperature**: 0.7 (educational explanations)

**Usage Estimates:**
- Typical evaluation: ~1000 tokens ($0.002)
- Full notebook evaluation: ~5000 tokens ($0.010)
- Educational session: ~10000 tokens ($0.020)

## Educational Settings

Configure learning preferences in `.llm_config.json`:

```json
{
  "educational_settings": {
    "explanation_style": "beginner_friendly",
    "include_code_comments": true,
    "step_by_step_breakdown": true,
    "provide_examples": true,
    "difficulty_level": "intermediate"
  }
}
```

**Available Options:**

| Setting | Options | Description |
|---------|---------|-------------|
| `explanation_style` | `beginner_friendly`, `detailed`, `concise` | Explanation verbosity |
| `include_code_comments` | `true`, `false` | Add inline code comments |
| `step_by_step_breakdown` | `true`, `false` | Break complex concepts |
| `provide_examples` | `true`, `false` | Include concrete examples |
| `difficulty_level` | `beginner`, `intermediate`, `advanced` | Target learning level |

## Logging Configuration

Control LLM interaction logging:

```json
{
  "logging": {
    "enabled": true,
    "log_level": "INFO",
    "log_file": "progress/llm_interactions.log",
    "include_prompts": false,
    "include_responses": true
  }
}
```

**Log Levels:**
- `DEBUG`: All interactions and debug info
- `INFO`: Standard operations and responses
- `WARNING`: Issues and fallback usage
- `ERROR`: Errors and failures only

**Privacy Settings:**
- `include_prompts`: Log prompts sent to LLM
- `include_responses`: Log LLM responses
- Set both to `false` for maximum privacy

## Rate Limiting and Caching

Control usage to prevent API overuse:

```json
{
  "rate_limiting": {
    "requests_per_minute": 30,
    "burst_limit": 5
  },
  "cache": {
    "enabled": true,
    "cache_dir": "progress/.llm_cache",
    "ttl_seconds": 3600
  }
}
```

**Rate Limiting:**
- Prevents excessive API calls
- Protects against costs (OpenAI) and overuse (Ollama)
- Burst limit allows quick successive calls

**Caching:**
- Stores responses for repeated requests
- Reduces API calls and improves response time
- TTL (time-to-live) controls cache freshness

## Testing LLM Configuration

### 1. Test Ollama Connection
```python
# In Python environment
from src.llm_integration import LLMEvaluator

evaluator = LLMEvaluator()
response = evaluator.evaluate_code(
    student_code="def attention(): pass",
    function_name="test",
    context="Testing connection"
)
print(response)
```

### 2. Test OpenAI Fallback
```bash
# Temporarily stop Ollama
# Windows: Stop "Ollama" service in Services
# Linux/macOS: pkill ollama

# Run test again - should use OpenAI
python test_llm_comprehensive.py
```

### 3. Comprehensive Test
```bash
# Run all LLM integration tests
python test_epic4_integration.py

# Check specific LLM functionality
python -c "
from src.evaluation import grade_notebook
results = grade_notebook('lesson.ipynb', attempt_number=1)
print('LLM evaluation working:', results['sections_evaluated'] > 0)
"
```

## Provider Switching and Failover

The system automatically handles provider switching:

1. **Primary (Ollama)**: Always tried first
2. **Fallback (OpenAI)**: Used if Ollama unavailable
3. **Error Handling**: Graceful degradation with informative messages

**Manual Provider Selection:**
```python
from src.llm_integration import LLMEvaluator

# Force specific provider
evaluator = LLMEvaluator(preferred_provider='openai')
```

## Advanced Configuration

### Custom Prompts

Modify educational prompts in `.llm_config.json`:

```json
{
  "prompts": {
    "attention_explanation": "You are an educational AI helping students understand attention mechanisms. Provide clear, step-by-step explanations with visual descriptions.",
    "code_review": "Review the following attention mechanism code and provide educational feedback focusing on understanding rather than optimization.",
    "concept_check": "Ask a thoughtful question to help the student verify their understanding."
  }
}
```

### Custom Models

Add support for other Ollama models:

```json
{
  "llm_providers": {
    "primary": {
      "models": {
        "default": "mistral:7b",
        "code_explanation": "codellama:13b",
        "educational": "llama3.1:8b"
      }
    }
  }
}
```

### Development Settings

For development and testing:

```json
{
  "educational_settings": {
    "explanation_style": "detailed",
    "difficulty_level": "advanced"
  },
  "logging": {
    "log_level": "DEBUG",
    "include_prompts": true
  },
  "cache": {
    "ttl_seconds": 60
  }
}
```

## Troubleshooting Configuration

### Ollama Issues

**Service not running:**
```bash
# Check service status
curl http://localhost:11434/api/tags

# Restart service (Windows)
# Stop and start "Ollama" service in Services

# Restart service (Linux/macOS)
ollama serve
```

**Model not found:**
```bash
# Check available models
ollama list

# Pull missing model
ollama pull llama3.1:8b
```

### OpenAI Issues

**API key errors:**
```bash
# Verify API key is set
echo $OPENAI_API_KEY

# Test API key
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY"
```

**Rate limit errors:**
- Reduce `requests_per_minute` in config
- Enable caching to reduce API calls
- Use `gpt-3.5-turbo` instead of `gpt-4`

### Configuration Validation

**Validate .llm_config.json:**
```python
import json
with open('.llm_config.json') as f:
    config = json.load(f)
print("Configuration valid")
```

**Reset to defaults:**
If configuration becomes corrupted, restore from the working default in the project.

## Best Practices

### Educational Use
- Use Ollama for cost-free evaluation
- Enable caching for repeated sessions
- Set appropriate difficulty levels for students
- Monitor logs for learning insights

### Production Use
- Configure rate limiting appropriately
- Use environment variables for API keys
- Enable logging for debugging
- Regular backup of configuration

### Privacy and Security
- Never commit API keys to version control
- Use environment variables or .env files
- Disable prompt logging for sensitive content
- Regularly rotate API keys

## Next Steps

After configuration:
1. **Test System**: Run integration tests to verify setup
2. **Launch Notebooks**: Start with `lesson.ipynb` for interactive learning
3. **Explore Features**: Try different LLM evaluation features
4. **Customize**: Adjust settings based on educational needs

For additional support, see `TROUBLESHOOTING.md` for common configuration issues.