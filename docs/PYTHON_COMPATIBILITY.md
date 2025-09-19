# Python Version Compatibility Guide

## Supported Python Versions

This project supports Python 3.8 and above. The requirements.txt has been updated to use flexible version ranges that automatically select compatible package versions for your Python installation.

## Version Compatibility Matrix

| Python Version | PyTorch Version | NumPy Version | Status |
|---------------|-----------------|---------------|---------|
| 3.8           | 2.0.0+          | 1.21.0 - 1.24.4 | ✅ Fully Supported |
| 3.9           | 2.0.0+          | 1.21.0 - 1.26.4 | ✅ Fully Supported |
| 3.10          | 2.0.0+          | 1.21.0 - 1.26.4 | ✅ Fully Supported |
| 3.11          | 2.1.0+          | 1.23.0 - 1.26.4 | ✅ Fully Supported |
| 3.12          | 2.2.0+          | 1.26.0 - 1.26.4 | ✅ Fully Supported |
| 3.13          | 2.5.0+          | 1.26.0+         | ✅ Fully Supported |

## Installation with Different Python Versions

### Using the Setup Script

#### Auto-detect Python (works for 3.8-3.12):
```bash
./setup_venv.sh
```

#### Specify Python path (works for any version 3.8+):
```bash
# Linux/Mac
./setup_venv.sh /usr/bin/python3.10
./setup_venv.sh python3.13

# Windows
./setup_venv.sh C:/Python313/python.exe
./setup_venv.sh python
```

### Manual Installation

If the setup script doesn't work for your configuration:

```bash
# 1. Create virtual environment with your Python version
python3.13 -m venv venv  # or your specific Python version

# 2. Activate virtual environment
# Windows Git Bash:
source venv/Scripts/activate
# Linux/Mac:
source venv/bin/activate

# 3. Upgrade pip
pip install --upgrade pip

# 4. Install dependencies
pip install -r requirements.txt
```

## PyTorch Installation Notes

For different Python versions, PyTorch may need special installation:

### CPU-only installation (smaller, faster to install):
```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
```

### With CUDA support (for GPU acceleration):
```bash
# CUDA 12.1
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# CUDA 11.8
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

## Troubleshooting

### "No compatible Python version found"
- Install Python 3.10 (recommended) from [python.org](https://www.python.org/downloads/)
- Or use the custom path argument: `./setup_venv.sh /path/to/python`

### PyTorch installation fails
- Check available versions: `pip index versions torch`
- Use CPU-only version if you don't need GPU support
- Ensure pip is updated: `pip install --upgrade pip`

### Windows Store Python issues
- The script now handles Windows Store Python aliases correctly
- If issues persist, install Python from python.org instead of Windows Store
- Disable app execution aliases in Windows Settings > Apps > Advanced app settings

### Package version conflicts
- The requirements.txt uses flexible version ranges to avoid conflicts
- If you encounter issues, try creating a fresh virtual environment
- Report specific conflicts as issues for further assistance

## Why Version Ranges?

The updated requirements.txt uses version ranges (>=) instead of exact versions (==) to:
1. Support multiple Python versions (3.8-3.13+)
2. Allow pip to resolve compatible versions automatically
3. Prevent installation failures due to version conflicts
4. Enable security updates within compatible ranges

## Key Constraints

- **NumPy < 2.0.0**: NumPy 2.0 has breaking API changes
- **Kaleido < 0.3.0**: Major version changes may break image export
- **PyTorch >= 2.0.0**: Automatically selects version for your Python

## Recommended Setup

For the best experience, we recommend:
- Python 3.10 or 3.11 (most stable, best package compatibility)
- CPU-only PyTorch (unless you specifically need GPU support)
- Fresh virtual environment for clean installation