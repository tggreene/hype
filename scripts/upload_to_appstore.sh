#!/bin/bash

# Script to upload archived app to App Store Connect
# This automates the "Distribute App" → "App Store Connect" → "Upload" process

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Upload to App Store Connect${NC}"
echo ""

# Configuration
PROJECT_NAME="Hype"
SCHEME="Hype"
PROJECT_FILE="Hype.xcodeproj"
ARCHIVE_PATH="build/archives"
EXPORT_PATH="build/export"

# Find the most recent archive
LATEST_ARCHIVE=$(ls -t "$ARCHIVE_PATH"/*.xcarchive 2>/dev/null | head -1)

if [ -z "$LATEST_ARCHIVE" ]; then
    echo -e "${RED}❌ No archive found in $ARCHIVE_PATH${NC}"
    echo ""
    echo "Please run archive first:"
    echo "  ./scripts/archive_app.sh"
    echo ""
    echo "Or create archive manually in Xcode:"
    echo "  Product → Archive"
    exit 1
fi

echo "Found archive: $(basename "$LATEST_ARCHIVE")"
echo ""

# Check if export options plist exists, create if not
EXPORT_OPTIONS_PLIST="$EXPORT_PATH/ExportOptions.plist"
if [ ! -f "$EXPORT_OPTIONS_PLIST" ]; then
    echo -e "${BLUE}Creating export options...${NC}"
    mkdir -p "$EXPORT_PATH"

    cat > "$EXPORT_OPTIONS_PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>compileBitcode</key>
    <false/>
    <key>destination</key>
    <string>upload</string>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>stripSwiftSymbols</key>
    <true/>
    <key>teamID</key>
    <string>HZLVXYG234</string>
</dict>
</plist>
EOF
    echo -e "${GREEN}✓ Export options created${NC}"
    echo ""
fi

echo -e "${BLUE}Step 1: Exporting archive for App Store...${NC}"
echo "This may take a few minutes..."
echo ""

xcodebuild -exportArchive \
    -archivePath "$LATEST_ARCHIVE" \
    -exportOptionsPlist "$EXPORT_OPTIONS_PLIST" \
    -exportPath "$EXPORT_PATH"

if [ $? -ne 0 ]; then
    echo ""
    echo -e "${RED}❌ Export failed. Check the error messages above.${NC}"
    echo ""
    echo "Common issues:"
    echo "  • Code signing errors - check your signing settings in Xcode"
    echo "  • Team ID mismatch - update teamID in ExportOptions.plist"
    echo "  • Missing certificates - ensure you're signed in to Xcode with your Apple ID"
    exit 1
fi

echo ""
echo -e "${BLUE}Step 2: Uploading to App Store Connect...${NC}"
echo "This may take 10-30 minutes..."
echo ""

# Find the .ipa file
IPA_FILE=$(find "$EXPORT_PATH" -name "*.ipa" | head -1)

if [ -z "$IPA_FILE" ]; then
    echo -e "${RED}❌ No .ipa file found after export${NC}"
    exit 1
fi

echo "Uploading: $(basename "$IPA_FILE")"
echo ""

xcrun altool --upload-app \
    --type ios \
    --file "$IPA_FILE" \
    --username "$APPLE_ID" \
    --password "@keychain:Application Loader: $APPLE_ID" \
    || xcrun altool --upload-app \
        --type ios \
        --file "$IPA_FILE" \
        --apiKey "$APP_API_KEY" \
        --apiIssuer "$APP_API_ISSUER"

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Upload successful!${NC}"
    echo ""
    echo "Your app is now being processed by App Store Connect."
    echo "It may take 10-30 minutes to appear in your app's build list."
    echo ""
    echo "Next steps:"
    echo "1. Go to App Store Connect"
    echo "2. Select your app"
    echo "3. Go to the App Store tab"
    echo "4. Wait for the build to appear"
    echo "5. Select the build and submit for review"
else
    echo ""
    echo -e "${YELLOW}⚠️  Upload may have failed or requires authentication${NC}"
    echo ""
    echo "Alternative: Upload manually in Xcode:"
    echo "1. Window → Organizer"
    echo "2. Select your archive"
    echo "3. Click 'Distribute App'"
    echo "4. Choose 'App Store Connect'"
    echo "5. Follow the prompts"
fi
