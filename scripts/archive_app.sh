#!/bin/bash

# Script to automate archiving the Hype app for App Store submission
# This replaces the manual "Product → Archive" process in Xcode

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}📦 Hype App Archive Automation${NC}"
echo ""

# Configuration
PROJECT_NAME="Hype"
SCHEME="Hype"
PROJECT_FILE="Hype.xcodeproj"
ARCHIVE_PATH="build/archives"
EXPORT_PATH="build/export"
ARCHIVE_NAME="${PROJECT_NAME}_$(date +%Y%m%d_%H%M%S).xcarchive"

# Create directories
mkdir -p "$ARCHIVE_PATH"
mkdir -p "$EXPORT_PATH"

# Get the full archive path (use absolute path)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
FULL_ARCHIVE_PATH="$PROJECT_DIR/$ARCHIVE_PATH/$ARCHIVE_NAME"

# Change to project directory
cd "$PROJECT_DIR"

echo -e "${BLUE}Step 1: Cleaning build folder...${NC}"
xcodebuild clean \
    -project "$PROJECT_FILE" \
    -scheme "$SCHEME" \
    -configuration Release

echo ""
echo -e "${BLUE}Step 2: Building and archiving...${NC}"
echo "This may take a few minutes..."
echo ""

# Use a more specific destination
xcodebuild archive \
    -project "$PROJECT_FILE" \
    -scheme "$SCHEME" \
    -configuration Release \
    -destination "generic/platform=iOS" \
    -archivePath "$FULL_ARCHIVE_PATH" \
    -allowProvisioningUpdates \
    CODE_SIGN_STYLE=Automatic \
    DEVELOPMENT_TEAM=HZLVXYG234

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Archive created successfully!${NC}"
    echo ""
    echo "Archive location: $FULL_ARCHIVE_PATH"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Open Xcode"
    echo "2. Window → Organizer (or press ⌘+Shift+9)"
    echo "3. Your archive should appear there"
    echo "4. Click 'Distribute App' to upload to App Store Connect"
    echo ""
    echo "Or use the upload script: ./scripts/upload_to_appstore.sh"
else
    echo ""
    echo "❌ Archive failed. Check the error messages above."
    exit 1
fi

