#!/bin/sh
# Run this once after cloning to enable shared git hooks
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
echo "Git hooks configured. Pre-commit checks are now active."
