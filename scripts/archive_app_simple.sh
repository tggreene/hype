#!/bin/bash

# Simplified archive script - uses Xcode's default archive location
# This is more reliable and matches what Xcode does manually

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}📦 Hype App Archive (Simple)${NC}"
echo ""

# Configuration
PROJECT_FILE="Hype.xcodeproj"
SCHEME="Hype"

# Change to project directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_DIR"

echo -e "${BLUE}Cleaning...${NC}"
xcodebuild clean -project "$PROJECT_FILE" -scheme "$SCHEME" -configuration Release

echo ""
echo -e "${BLUE}Archiving...${NC}"
echo "This may take a few minutes..."
echo ""

# Archive to Xcode's default location (same as Product → Archive)
xcodebuild archive \
    -project "$PROJECT_FILE" \
    -scheme "$SCHEME" \
    -configuration Release \
    -destination "generic/platform=iOS" \
    CODE_SIGN_STYLE=Automatic \
    DEVELOPMENT_TEAM=HZLVXYG234

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Archive created successfully!${NC}"
    echo ""
    echo "Archive saved to Xcode's default location:"
    echo "  ~/Library/Developer/Xcode/Archives/"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Open Xcode"
    echo "2. Window → Organizer (⌘+Shift+9)"
    echo "3. Your archive should appear there"
    echo "4. Click 'Distribute App' → 'App Store Connect' → 'Upload'"
else
    echo ""
    echo "❌ Archive failed. Check the error messages above."
    exit 1
fi
