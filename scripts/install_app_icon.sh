#!/bin/bash

# Script to install app icons from icon.kitchen zip file
# Usage: ./scripts/install_app_icon.sh path/to/icon-kitchen.zip

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-icon-kitchen-zip>"
    echo "Example: $0 ~/Downloads/ios-icon.zip"
    exit 1
fi

ZIP_FILE="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMP_DIR=$(mktemp -d)
APPICON_DIR="$PROJECT_ROOT/Hype/Assets.xcassets/AppIcon.appiconset"

if [ ! -f "$ZIP_FILE" ]; then
    echo "❌ Error: Zip file not found: $ZIP_FILE"
    exit 1
fi

echo "📦 Extracting icon files..."
cd "$TEMP_DIR"
unzip -q "$ZIP_FILE" || {
    echo "❌ Error: Failed to extract zip file"
    exit 1
}

# Check if it's a directory of PNGs or an AppIcon.appiconset structure
ICON_SOURCE=""
IS_PNG_DIR=false

if [ -d "ios/Assets.xcassets/AppIcon.appiconset" ]; then
    ICON_SOURCE="ios/Assets.xcassets/AppIcon.appiconset"
elif [ -d "Assets.xcassets/AppIcon.appiconset" ]; then
    ICON_SOURCE="Assets.xcassets/AppIcon.appiconset"
elif [ -d "ios/AppIcon.appiconset" ]; then
    ICON_SOURCE="ios/AppIcon.appiconset"
elif [ -d "AppIcon.appiconset" ]; then
    ICON_SOURCE="AppIcon.appiconset"
else
    # Check if root or ios directory contains PNG files (icon.kitchen might just give PNGs)
    PNG_COUNT=$(find . -maxdepth 1 -name "*.png" | wc -l | tr -d ' ')
    IOS_PNG_COUNT=0
    if [ -d "ios" ]; then
        IOS_PNG_COUNT=$(find ios -maxdepth 1 -name "*.png" | wc -l | tr -d ' ')
    fi

    if [ "$IOS_PNG_COUNT" -gt 0 ]; then
        IS_PNG_DIR=true
        ICON_SOURCE="ios"
        echo "📁 Found directory of PNG files in ios/"
    elif [ "$PNG_COUNT" -gt 0 ]; then
        IS_PNG_DIR=true
        ICON_SOURCE="."
        echo "📁 Found directory of PNG files"
    else
        echo "⚠️  Warning: Could not find AppIcon.appiconset folder or PNG files in zip"
        echo "Contents of zip:"
        ls -la
        echo ""
        echo "Please manually extract and copy files to:"
        echo "$APPICON_DIR"
        exit 1
    fi
fi

if [ "$IS_PNG_DIR" = false ] && [ ! -d "$ICON_SOURCE" ]; then
    echo "❌ Error: AppIcon.appiconset not found in expected location"
    exit 1
fi

echo "✅ Found icon files"
echo ""

# Backup existing AppIcon
if [ -d "$APPICON_DIR" ] && [ "$(ls -A $APPICON_DIR 2>/dev/null)" ]; then
    BACKUP_DIR="${APPICON_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "💾 Backing up existing AppIcon to: $BACKUP_DIR"
    cp -r "$APPICON_DIR" "$BACKUP_DIR"
fi

# Remove old contents
echo "📥 Installing new app icons..."
rm -rf "$APPICON_DIR"/*

if [ "$IS_PNG_DIR" = true ]; then
    # Handle directory of PNGs
    echo "📋 Copying PNG files..."
    cp "$ICON_SOURCE"/*.png "$APPICON_DIR"/ 2>/dev/null || true

    # Check if Contents.json exists in the extracted files (might be in a subdirectory)
    CONTENTS_JSON=""
    if [ -f "Contents.json" ]; then
        CONTENTS_JSON="Contents.json"
    elif [ -f "ios/Contents.json" ]; then
        CONTENTS_JSON="ios/Contents.json"
    elif [ -f "AppIcon.appiconset/Contents.json" ]; then
        CONTENTS_JSON="AppIcon.appiconset/Contents.json"
    elif [ -f "ios/AppIcon.appiconset/Contents.json" ]; then
        CONTENTS_JSON="ios/AppIcon.appiconset/Contents.json"
    elif [ -f "Assets.xcassets/AppIcon.appiconset/Contents.json" ]; then
        CONTENTS_JSON="Assets.xcassets/AppIcon.appiconset/Contents.json"
    elif [ -f "ios/Assets.xcassets/AppIcon.appiconset/Contents.json" ]; then
        CONTENTS_JSON="ios/Assets.xcassets/AppIcon.appiconset/Contents.json"
    fi

    if [ -n "$CONTENTS_JSON" ] && [ -f "$CONTENTS_JSON" ]; then
        echo "📄 Copying Contents.json from zip..."
        cp "$CONTENTS_JSON" "$APPICON_DIR/Contents.json"
    else
        # Create a basic Contents.json - Xcode will auto-detect and fill in the rest
        echo "📄 Creating basic Contents.json..."
        cat > "$APPICON_DIR/Contents.json" << 'EOF'
{
  "images" : [
    {
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF
    fi
    echo ""
    echo "⚠️  Note: PNG files copied. You'll need to assign them in Xcode:"
    echo "   1. Open Assets.xcassets → AppIcon in Xcode"
    echo "   2. Drag each PNG to its corresponding size slot"
    echo "   3. Xcode will auto-detect the correct sizes"
else
    # Standard AppIcon.appiconset structure - copy everything including Contents.json
    echo "📋 Copying AppIcon.appiconset contents (including Contents.json)..."
    cp -r "$ICON_SOURCE"/* "$APPICON_DIR"/

    # Verify Contents.json was copied
    if [ ! -f "$APPICON_DIR/Contents.json" ]; then
        echo "⚠️  Warning: Contents.json not found in source, creating basic one..."
        cat > "$APPICON_DIR/Contents.json" << 'EOF'
{
  "images" : [
    {
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF
    else
        echo "✅ Contents.json copied successfully"
    fi
fi

echo ""
echo "✅ App icons installed successfully!"
echo "📁 Location: $APPICON_DIR"
echo ""
echo "💡 Next steps:"
echo "1. Open Xcode"
echo "2. Check Assets.xcassets → AppIcon to verify all sizes are filled"
echo "3. Build and run to see your new icon"

# Cleanup
rm -rf "$TEMP_DIR"
