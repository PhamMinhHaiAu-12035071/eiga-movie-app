---
sidebar_position: 3
title: Environment Setup
description: Setting up the development environment for KSK App
---

# Environment Setup

This guide will help you set up the development environment for the KSK App project.

## Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Git
- FVM (Flutter Version Manager)

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/ksk/ksk_app.git
cd ksk_app
```

### 2. Install FVM (if not already installed)

FVM is used to manage Flutter SDK versions across projects.

```bash
dart pub global activate fvm
```

### 3. Use the Correct Flutter Version

```bash
fvm install
fvm use
```

### 4. Install Dependencies

```bash
fvm flutter pub get
```

### 5. Generate Code

The project uses code generation for various tasks:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Environment Configuration

The project uses three different environments:

- ✅ **development** (default)
- 🛠️ **staging**
- 🚀 **production**

### Environment Files

Environment variables are stored in `.env` files:

```
lib/assets/env/
├── .env.dev     # Development environment variables
├── .env.stg     # Staging environment variables
└── .env.prod    # Production environment variables
```

Create these files with the appropriate configuration values.

### Running in Different Environments

```bash
# Development
fvm flutter run --flavor development --target lib/main_development.dart

# Staging
fvm flutter run --flavor staging --target lib/main_staging.dart

# Production
fvm flutter run --flavor production --target lib/main_production.dart
```

## Environment Variables Setup

The project uses `envied` for secure environment variable handling.

1. Create the environment files in `lib/assets/env/`:

```
# .env.dev example
API_URL=https://api.dev.example.com
APP_NAME=KSK App Dev
```

2. Generate environment code:

```bash
fvm flutter pub run build_runner build
```

## IDE Setup

### VS Code

Recommended extensions:
- Dart
- Flutter
- Flutter Intl
- Pubspec Assist
- Error Lens

### Android Studio / IntelliJ IDEA

Recommended plugins:
- Dart
- Flutter
- Flutter Intl
- Rainbow Brackets
- String Manipulation 