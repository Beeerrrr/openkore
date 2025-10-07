#!/bin/bash
# AI-AGENT-CORE Bootstrap v1.0.0
# One-command initialization for any project

set -e  # Exit on error

echo "🚀 AI-AGENT-CORE Bootstrap Starting..."
echo "========================================"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📍 AI-AGENT-CORE location: $SCRIPT_DIR"
echo ""

# Detect project information
echo "🔍 Auto-detecting project information..."
echo ""

# Project name (from git or directory)
if git rev-parse --show-toplevel >/dev/null 2>&1; then
    PROJECT_DIR=$(git rev-parse --show-toplevel)
    PROJECT_NAME=$(basename "$PROJECT_DIR")
    REPO_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
    if [ -z "$REPO_URL" ]; then
        REPO_URL="https://github.com/user/$PROJECT_NAME"
    fi
else
    PROJECT_DIR=$(dirname "$SCRIPT_DIR")
    PROJECT_NAME=$(basename "$PROJECT_DIR")
    REPO_URL="https://github.com/user/$PROJECT_NAME"
fi

# Detect tech stack
TECH_STACK="Generic"
if [ -f "$PROJECT_DIR/"*.pa.yaml ] 2>/dev/null || [ -f "$PROJECT_DIR/"*.msapp ] 2>/dev/null; then
    TECH_STACK="Power Platform"
elif [ -f "$PROJECT_DIR/package.json" ]; then
    if grep -q '"react"' "$PROJECT_DIR/package.json" 2>/dev/null; then
        TECH_STACK="React + Node.js"
    else
        TECH_STACK="Node.js"
    fi
elif [ -f "$PROJECT_DIR/manage.py" ] && [ -f "$PROJECT_DIR/requirements.txt" ]; then
    TECH_STACK="Python + Django"
fi

# Detect timezone
TIMEZONE=$(date +%Z 2>/dev/null || echo "GMT+0")

# Get current timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || echo "2025-01-01T00:00:00Z")

echo "✅ Detected configuration:"
echo "   Project: $PROJECT_NAME"
echo "   Tech Stack: $TECH_STACK"
echo "   Repository: $REPO_URL"
echo "   Timezone: $TIMEZONE"
echo ""

# Confirm with user
read -p "🚀 Proceed with this configuration? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Bootstrap cancelled by user."
    exit 0
fi

echo ""
echo "🔧 Initializing AI-AGENT-CORE..."
echo "================================="
echo ""

# Check if .ai-config.json already exists
if [ -f "$SCRIPT_DIR/.ai-config.json" ]; then
    echo "⚠️  Warning: .ai-config.json already exists!"
    read -p "Overwrite existing configuration? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Keeping existing configuration. Bootstrap stopped."
        exit 0
    fi
fi

# Populate .ai-config.json from template
echo "1️⃣  Creating .ai-config.json..."
if [ -f "$SCRIPT_DIR/.templates/config.template.json" ]; then
    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s|{{REPOSITORY_URL}}|$REPO_URL|g" \
        -e "s/{{TECH_STACK}}/$TECH_STACK/g" \
        -e "s/{{TIMEZONE}}/$TIMEZONE/g" \
        -e "s/{{TIMESTAMP}}/$TIMESTAMP/g" \
        "$SCRIPT_DIR/.templates/config.template.json" > "$SCRIPT_DIR/.ai-config.json"
    echo "   ✅ .ai-config.json created"
else
    echo "   ⚠️  Template not found, using default structure"
    cat > "$SCRIPT_DIR/.ai-config.json" <<EOF
{
  "project": {
    "name": "$PROJECT_NAME",
    "tech_stack": "$TECH_STACK",
    "repository": "$REPO_URL",
    "timezone": "$TIMEZONE",
    "initialized": "$TIMESTAMP"
  },
  "ai_system": {
    "version": "1.0.0",
    "cache_enabled": true,
    "mapping_enabled": true,
    "auto_cache_load": true,
    "anti_hallucination": true
  },
  "statistics": {
    "total_solutions": 0,
    "prevented_mistakes": 0,
    "components_mapped": 0,
    "token_savings_estimate": "0%"
  }
}
EOF
    echo "   ✅ .ai-config.json created (default)"
fi

# Verify cache/ structure
echo "2️⃣  Verifying cache/ structure..."
if [ ! -f "$SCRIPT_DIR/cache/solutions.json" ] || [ ! -f "$SCRIPT_DIR/cache/mistakes.json" ] || [ ! -f "$SCRIPT_DIR/cache/patterns.json" ]; then
    echo "   ⚠️  Cache files missing or incomplete"
    echo "   This is normal for first-time setup"
else
    echo "   ✅ cache/ structure verified"
fi

# Verify mapping/ structure
echo "3️⃣  Verifying mapping/ structure..."
if [ ! -f "$SCRIPT_DIR/mapping/components.json" ] || [ ! -f "$SCRIPT_DIR/mapping/variables.json" ] || [ ! -f "$SCRIPT_DIR/mapping/dependencies.json" ]; then
    echo "   ⚠️  Mapping files missing or incomplete"
    echo "   This is normal for first-time setup"
else
    echo "   ✅ mapping/ structure verified"
fi

# Verify extensions/ structure
echo "4️⃣  Verifying extensions/ structure..."
mkdir -p "$SCRIPT_DIR/extensions/quick-reference"
mkdir -p "$SCRIPT_DIR/extensions/tech-specific"
mkdir -p "$SCRIPT_DIR/extensions/archives"
echo "   ✅ extensions/ folders created"

echo ""
echo "🎉 AI-AGENT-CORE Bootstrap Complete!"
echo "====================================="
echo ""
echo "✅ Your AI assistant is ready with:"
echo "   • Intelligent caching (40-70% token savings)"
echo "   • Component mapping (prevents hallucination)"
echo "   • Mistake tracking (prevents repeats)"
echo "   • Auto-cache-load (no manual mentions needed)"
echo ""
echo "📚 Next Steps:"
echo ""
echo "1. Start a new AI conversation"
echo "2. Mention: @CallMeBabe.md"
echo "3. Ask AI to build initial codebase mapping:"
echo "   \"Build a mapping of my codebase for faster responses\""
echo "4. Start asking questions!"
echo ""
echo "📖 Documentation:"
echo "   • AI manual: CallMeBabe.md"
echo "   • Human guide: Me.md"
echo "   • Full docs: README.md"
echo ""
echo "🔍 Check your configuration:"
echo "   cat .ai-config.json"
echo ""
echo "💡 Tip: AI will automatically check cache before every response."
echo "   You'll see token savings after asking similar questions!"
echo ""
echo "🚀 Ready to use! Happy coding!"
