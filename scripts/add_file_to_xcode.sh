#!/bin/bash

# Script to add a file to the Xcode project
# Usage: ./scripts/add_file_to_xcode.sh path/to/file.swift

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-file>"
    echo "Example: $0 Hype/LaunchScreenView.swift"
    exit 1
fi

FILE_PATH="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_FILE="$PROJECT_ROOT/Hype.xcodeproj/project.pbxproj"

# Convert to absolute path
if [[ "$FILE_PATH" != /* ]]; then
    FILE_PATH="$PROJECT_ROOT/$FILE_PATH"
fi

if [ ! -f "$FILE_PATH" ]; then
    echo "❌ Error: File not found: $FILE_PATH"
    exit 1
fi

# Get relative path from project root
RELATIVE_PATH="${FILE_PATH#$PROJECT_ROOT/}"

echo "📝 Adding $RELATIVE_PATH to Xcode project..."
echo ""
echo "⚠️  Note: This script can't fully automate Xcode project file editing."
echo "   The project.pbxproj file is complex and error-prone to edit manually."
echo ""
echo "✅ Recommended: Use Xcode's built-in feature:"
echo "   1. In Xcode, right-click the 'Hype' folder"
echo "   2. Select 'Add Files to \"Hype\"...'"
echo "   3. Select: $RELATIVE_PATH"
echo "   4. Make sure your target is checked"
echo "   5. Click 'Add'"
echo ""
echo "💡 Alternative: Just create files in Xcode (File → New → File)"
echo "   This automatically adds them to the project."
