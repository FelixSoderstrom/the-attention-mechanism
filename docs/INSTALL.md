# Installation and Setup Guide

## Overview

This guide provides comprehensive instructions for setting up the Attention Mechanism Educational Project on your system. The project includes interactive Jupyter notebooks, PyTorch implementations, visualization tools, and LLM integration for educational purposes.

## System Requirements

### Minimum Requirements
- **Operating System**: Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+ recommended)
- **Python**: Version 3.8 or higher (Python 3.13.1 tested and recommended)
- **RAM**: 4GB minimum, 8GB recommended for transformer model loading
- **Storage**: 2GB free space (additional 1GB for cached models)
- **Internet**: Required for initial setup and LLM integration

### Recommended Specifications
- **Python**: 3.13.1 (latest tested version)
- **RAM**: 8GB+ for optimal performance with transformer models
- **Storage**: 5GB+ for comfortable development environment
- **GPU**: Optional - PyTorch will use CUDA if available

## Quick Start (Automated Setup)

The project includes an automated setup script that handles most installation steps:

### Windows (Git Bash/WSL)
```bash
bash setup_venv.sh
```

### Linux/macOS
```bash
bash setup_venv.sh
```

The setup script will:
1. Validate Python version (3.8+ required)
2. Create virtual environment in `./venv/`
3. Install all dependencies from `requirements.txt`
4. Create necessary directory structure
5. Validate installation

## Manual Installation Steps

If you prefer manual setup or the automated script encounters issues:

### 1. Python Installation Verification

Check your Python version:
```bash
python --version
# Should show Python 3.8+ (3.13.1 recommended)
```

If Python is not installed or version is too old:
- **Windows**: Download from [python.org](https://python.org)
- **macOS**: Use `brew install python` or download from python.org
- **Linux**: Use your package manager (e.g., `sudo apt install python3.13`)

### 2. Virtual Environment Setup

Create and activate virtual environment:

**Windows (Command Prompt/PowerShell):**
```cmd
python -m venv venv
venv\Scripts\activate
```

**Windows (Git Bash):**
```bash
python -m venv venv
source venv/Scripts/activate
```

**Linux/macOS:**
```bash
python -m venv venv
source venv/bin/activate
```

### 3. Dependency Installation

With virtual environment activated, install all dependencies:
```bash
pip install -r requirements.txt
```

**Key packages installed:**
- **Jupyter Environment**: `jupyter`, `jupyterlab`, `notebook`
- **Machine Learning**: `torch`, `transformers`, `numpy`
- **Visualization**: `matplotlib`, `seaborn`, `plotly`
- **LLM Integration**: `openai`, `requests`, `httpx`
- **Educational Tools**: `tqdm`, `rich`, `colorama`

### 4. Directory Structure Creation

The setup creates these directories (auto-created if missing):
```
project-root/
├── src/                    # Source modules
├── progress/               # Progress tracking
├── grade/                  # Evaluation outputs
├── cache/                  # Model and data cache
│   └── models/            # Transformer model cache
├── venv/                  # Virtual environment
└── .llm_cache/            # LLM response cache
```

### 5. Installation Validation

Verify your installation:

**Check Python packages:**
```python
python -c "import torch, numpy, matplotlib, jupyter; print('All packages imported successfully')"
```

**Check Jupyter:**
```bash
jupyter --version
```

**Test notebook launch:**
```bash
jupyter notebook
# Should open browser to http://localhost:8888
```

## Platform-Specific Instructions

### Windows Specific

**Using Git Bash (Recommended):**
Git Bash provides a Unix-like environment that works well with the project scripts.

1. Install Git for Windows (includes Git Bash)
2. Open Git Bash in project directory
3. Run setup script: `bash setup_venv.sh`

**Using Command Prompt/PowerShell:**
```cmd
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

**Common Windows Issues:**
- **Script execution blocked**: Run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` in PowerShell
- **Long path issues**: Enable long path support in Windows settings
- **antivirus interference**: Add project folder to antivirus exclusions

### macOS Specific

**Using Homebrew (Recommended):**
```bash
# Install Python if needed
brew install python@3.13

# Clone and setup project
cd project-directory
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**Common macOS Issues:**
- **Xcode Command Line Tools**: Install with `xcode-select --install`
- **M1/M2 Macs**: All dependencies are compatible with Apple Silicon
- **Permission issues**: Use `sudo` only for system-wide installations

### Linux Specific

**Ubuntu/Debian:**
```bash
# Install Python and pip
sudo apt update
sudo apt install python3.13 python3.13-venv python3-pip

# Setup project
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**CentOS/RHEL/Fedora:**
```bash
# Install Python
sudo dnf install python3.13 python3-pip python3-venv

# Setup project (same as Ubuntu)
```

## LLM Integration Setup

The project supports both Ollama and OpenAI for educational LLM features:

### Ollama Setup (Primary, Free)

1. **Install Ollama**: Download from [ollama.ai](https://ollama.ai)
2. **Start Ollama service**: 
   ```bash
   ollama serve
   ```
3. **Pull educational model**:
   ```bash
   ollama pull llama3.1:8b
   ```

### OpenAI Setup (Fallback)

1. **Get API key**: Sign up at [openai.com](https://openai.com)
2. **Set environment variable**:
   ```bash
   export OPENAI_API_KEY="your-api-key-here"
   ```
3. **Or create `.env` file**:
   ```
   OPENAI_API_KEY=your-api-key-here
   ```

The system automatically falls back to OpenAI if Ollama is unavailable.

## Verification and Testing

### 1. Basic Environment Test
```bash
source venv/Scripts/activate  # Windows Git Bash
# or source venv/bin/activate  # Linux/macOS

python -c "
import sys
print(f'Python version: {sys.version}')
import torch, numpy, matplotlib, jupyter
print('✓ All core packages available')
print('✓ Installation successful')
"
```

### 2. Jupyter Notebook Test
```bash
jupyter notebook
# Should open browser and show project files
```

### 3. Full System Test
Run the comprehensive test suite:
```bash
python test_epic3_integration.py
python test_epic4_integration.py  
python test_epic5_integration.py
```

All tests should pass, indicating a complete installation.

## Next Steps

After successful installation:

1. **Start with Documentation**: Read `README.md` for project overview
2. **Configure LLM**: Follow `CONFIGURATION.md` for LLM setup
3. **Launch Learning Environment**: Open `index.html` in browser
4. **Begin Lesson**: Start with `lesson.ipynb` for interactive learning

## Troubleshooting Quick Reference

**Installation fails:**
- Check Python version: `python --version`
- Check internet connection for package downloads
- Try `pip install --upgrade pip` before dependency installation

**Virtual environment issues:**
- Delete `venv/` folder and recreate
- Check Python virtual environment module: `python -m venv --help`

**Package conflicts:**
- Use fresh virtual environment
- Check `requirements.txt` for pinned versions

**Permission errors:**
- Don't use `sudo` with virtual environment
- Check file/directory permissions

For detailed troubleshooting, see `TROUBLESHOOTING.md`.

## Support

- **Technical Issues**: See `TROUBLESHOOTING.md`
- **Configuration**: See `CONFIGURATION.md`
- **Teaching Usage**: See `EDUCATOR_GUIDE.md`
- **System Requirements**: See `TECHNICAL_SPECS.md`