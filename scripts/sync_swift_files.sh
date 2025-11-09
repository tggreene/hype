#!/bin/bash

# Script to automatically sync Swift files in Hype/ directory to Xcode project
# Adds any Swift files that aren't already in the project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
HYPE_DIR="$PROJECT_ROOT/Hype"
PROJECT_FILE="$PROJECT_ROOT/Hype.xcodeproj/project.pbxproj"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "❌ Error: Xcode project file not found: $PROJECT_FILE"
    exit 1
fi

if [ ! -d "$HYPE_DIR" ]; then
    echo "❌ Error: Hype directory not found: $HYPE_DIR"
    exit 1
fi

echo "🔍 Scanning for Swift files in Hype/ directory..."
echo ""

# Find all Swift files in Hype directory (excluding subdirectories like Preview Content, Resources)
SWIFT_FILES=$(find "$HYPE_DIR" -maxdepth 1 -name "*.swift" -type f | sort)

if [ -z "$SWIFT_FILES" ]; then
    echo "✅ No Swift files found in Hype/ directory"
    exit 0
fi

# Check which files are already in the project
FILES_TO_ADD=()
for file in $SWIFT_FILES; do
    filename=$(basename "$file")
    # Check if file is already referenced in project.pbxproj
    if ! grep -q "$filename" "$PROJECT_FILE"; then
        FILES_TO_ADD+=("$file")
        echo "📄 Found new file: $filename"
    fi
done

if [ ${#FILES_TO_ADD[@]} -eq 0 ]; then
    echo "✅ All Swift files are already in the Xcode project"
    exit 0
fi

echo ""
echo "📝 Found ${#FILES_TO_ADD[@]} file(s) to add to Xcode project:"
for file in "${FILES_TO_ADD[@]}"; do
    echo "   - $(basename "$file")"
done
echo ""

# Ask for confirmation
read -p "Add these files to the Xcode project? [y/N] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled"
    exit 0
fi

echo ""
echo "⚠️  Note: Automatically editing project.pbxproj is complex and error-prone."
echo "   This script will provide you with instructions to add them manually,"
echo "   or you can use Xcode's 'Add Files' feature."
echo ""
echo "📋 To add these files in Xcode:"
echo "   1. Open Xcode"
echo "   2. Right-click the 'Hype' folder in Project Navigator"
echo "   3. Select 'Add Files to \"Hype\"...'"
echo "   4. Select the following files:"
for file in "${FILES_TO_ADD[@]}"; do
    rel_path="${file#$PROJECT_ROOT/}"
    echo "      - $rel_path"
done
echo "   5. Make sure 'Copy items if needed' is UNCHECKED"
echo "   6. Make sure your app target is CHECKED"
echo "   7. Click 'Add'"
echo ""
echo "💡 Tip: You can select multiple files at once by Cmd+clicking them"
echo ""

# Use the Python script if available
PYTHON_SCRIPT="$SCRIPT_DIR/sync_swift_files.py"
if [ -f "$PYTHON_SCRIPT" ] && command -v python3 &> /dev/null; then
    echo "🤖 Using Python script to auto-add files..."
    echo ""
    python3 "$PYTHON_SCRIPT"
else
    echo "💡 To auto-add files, ensure Python 3 is installed and sync_swift_files.py exists"
    echo "   Or use the manual Xcode steps above"
fi
