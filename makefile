# Define variables
VENV_DIR = venv
PYTHON = $(VENV_DIR)/bin/python
PIP = $(VENV_DIR)/bin/pip
REQUIREMENTS = requirement.txt

# Create a virtual environment
venv:
	python3 -m venv $(VENV_DIR)

# Install dependencies
install: venv
	$(PIP) install -r $(REQUIREMENTS)

# Freeze dependencies
freeze: venv
	$(PIP) freeze > $(REQUIREMENTS)

# Run the application in development mode
dev:
	$(PYTHON) app.py

# Run the application in production mode
prod: venv
	$(VENV_DIR)/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app

# Clean the virtual environment
clean:
	rm -rf $(VENV_DIR)

# Help message
help:
	@echo "Makefile commands:"
	@echo "  venv    - Create a virtual environment"
	@echo "  install - Install dependencies"
	@echo "  freeze  - Freeze dependencies to requirements.txt"
	@echo "  run     - Run the application in development mode"
	@echo "  dev     - Run the application in development mode"
	@echo "  prod    - Run the application in production mode"
	@echo "  clean   - Remove the virtual environment"
	@echo "  help    - Show this help message"

.PHONY: venv install freeze dev prod clean help