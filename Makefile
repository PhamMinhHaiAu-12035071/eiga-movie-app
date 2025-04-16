# Flutter Project Makefile
# Provides simplified commands for common Flutter operations
# Follows the structure in the Flutter Structure Rule

.PHONY: setup clean test analyze format build-dev build-prod run-dev deps help install-lcov coverage docs-start docs-build docs-serve docs-install gen find-todos

# Variables
FLUTTER = fvm flutter
DART = fvm dart
FLUTTER_TEST = $(FLUTTER) test
COVERAGE_FOLDER = coverage/
COVERAGE_REPORT = $(COVERAGE_FOLDER)lcov.info
LCOV = lcov
GENHTML = genhtml
OS := $(shell uname)
DOCS_DIR = docs

# Default target
help:
	@echo "KSK App Makefile (with FVM support)"
	@echo ""
	@echo "Available commands:"
	@echo "  make setup              - Setup development environment"
	@echo "  make clean              - Clean build artifacts"
	@echo "  make test               - Run all tests"
	@echo "  make analyze            - Run static code analysis"
	@echo "  make format             - Format code using dart format"
	@echo "  make build-dev          - Build app for development environment"
	@echo "  make build-prod         - Build app for production environment"
	@echo "  make run-dev            - Run app in development mode"
	@echo "  make deps               - Update dependencies"
	@echo "  make install-lcov       - Install lcov for coverage reports"
	@echo "  make coverage           - Generate code coverage and open reports"
	@echo "  make gen                - Generate all code (assets, env models, l10n, etc.)"
	@echo "  make find-todos         - Find TODOs in the code"
	@echo ""
	@echo "Documentation commands:"
	@echo "  make docs-install       - Install Docusaurus dependencies"
	@echo "  make docs-start         - Start Docusaurus development server"
	@echo "  make docs-build         - Build Docusaurus static site"
	@echo "  make docs-serve         - Serve built Docusaurus site locally"

# Install lcov based on the OS
install-lcov:
	@echo "Checking if lcov is installed..."
	@if ! command -v lcov >/dev/null 2>&1; then \
		echo "lcov not found. Installing..."; \
		if [ "$(OS)" = "Darwin" ]; then \
			echo "Installing lcov using Homebrew..."; \
			brew install lcov || { echo "Error: Failed to install lcov. Please install it manually."; exit 1; }; \
		elif [ "$(OS)" = "Linux" ]; then \
			echo "Installing lcov using apt-get..."; \
			sudo apt-get update && sudo apt-get install -y lcov || { echo "Error: Failed to install lcov. Please install it manually."; exit 1; }; \
		else \
			echo "Unsupported OS for automatic installation. Please install lcov manually."; \
			exit 1; \
		fi; \
		echo "lcov installed successfully."; \
	else \
		echo "lcov is already installed."; \
	fi

# Setup development environment
setup: install-lcov
	$(FLUTTER) pub get
	$(DART) run build_runner build --delete-conflicting-outputs
	$(DART) run flutter_native_splash:create --path=flutter_native_splash_dev.yaml

# Clean build artifacts
clean:
	$(FLUTTER) clean
	rm -rf $(COVERAGE_FOLDER)
	rm -rf build/

# Run all tests
test:
	$(FLUTTER_TEST)

# Generate coverage for all tests and open reports
coverage: install-lcov
	@mkdir -p $(COVERAGE_FOLDER)html
	$(FLUTTER_TEST) --coverage
	$(GENHTML) $(COVERAGE_REPORT) -o $(COVERAGE_FOLDER)html
	
	@echo "Coverage report generated at:"
	@echo "  - $(COVERAGE_FOLDER)html/index.html"
	@echo "Coverage summary:"
	$(LCOV) --summary $(COVERAGE_REPORT)
	
	@echo "Opening coverage report in browser..."
	@if [ "$(OS)" = "Darwin" ]; then \
		open $(COVERAGE_FOLDER)html/index.html; \
	elif [ "$(OS)" = "Linux" ]; then \
		xdg-open $(COVERAGE_FOLDER)html/index.html; \
	else \
		echo "Automatic browser opening not supported on this OS."; \
		echo "Please open the reports manually."; \
	fi

# Run static code analysis
analyze:
	$(FLUTTER) analyze

# Format code using dart format
format:
	$(DART) format lib/ test/

# Build app for different environments
build-dev:
	$(FLUTTER) build apk --flavor development --target lib/main_development.dart

build-prod:
	$(FLUTTER) build apk --flavor production --target lib/main_production.dart

# Run app in development mode
run-dev:
	$(FLUTTER) run --flavor development --target lib/main_development.dart

# Update dependencies
deps:
	$(FLUTTER) pub upgrade
	$(FLUTTER) pub outdated

# Generate all code (assets, env models, l10n, etc.)
gen:
	@echo "Generating all code (assets, env models, l10n, etc.)..."
	$(DART) pub run build_runner build --delete-conflicting-outputs

# Find TODOs in the code
find-todos:
	@grep -r "TODO" lib/ --include="*.dart" || echo "No TODOs found!" 

# Documentation commands
# Install Docusaurus dependencies
docs-install:
	@echo "Installing Docusaurus dependencies..."
	cd $(DOCS_DIR) && npm install

# Start Docusaurus development server
docs-start:
	@echo "Starting Docusaurus development server..."
	cd $(DOCS_DIR) && npm start

# Build Docusaurus static site
docs-build:
	@echo "Building Docusaurus static site..."
	cd $(DOCS_DIR) && npm run build

# Serve built Docusaurus site locally
docs-serve:
	@echo "Serving built Docusaurus site locally..."
	cd $(DOCS_DIR) && npm run serve 