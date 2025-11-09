#!/bin/bash

# Script to automate taking screenshots of the Hype app
# This script will boot the simulator, run the app, and take screenshots

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📸 Hype App Screenshot Automation${NC}"
echo ""

# Configuration
SCREENSHOT_DIR="screenshots"
DEVICE_TYPE="iPhone 15 Pro Max"  # Change this to the device you want
SIMULATOR_UDID=""

# Create screenshots directory
mkdir -p "$SCREENSHOT_DIR"

# Function to get simulator UDID
get_simulator_udid() {
    xcrun simctl list devices available | grep "$DEVICE_TYPE" | head -1 | grep -oE '\([A-F0-9-]+\)' | tr -d '()'
}

# Function to boot simulator
boot_simulator() {
    echo -e "${BLUE}🚀 Booting simulator...${NC}"
    UDID=$(get_simulator_udid)
    if [ -z "$UDID" ]; then
        echo "❌ Could not find simulator: $DEVICE_TYPE"
        echo "Available devices:"
        xcrun simctl list devices available | grep iPhone
        exit 1
    fi

    SIMULATOR_UDID=$UDID
    xcrun simctl boot "$SIMULATOR_UDID" 2>/dev/null || true
    open -a Simulator
    sleep 3
    echo -e "${GREEN}✓ Simulator booted${NC}"
}

# Function to install and run app
install_app() {
    echo -e "${BLUE}📱 Building and installing app...${NC}"

    # Build the app
    xcodebuild -project Hype.xcodeproj \
               -scheme Hype \
               -destination "platform=iOS Simulator,id=$SIMULATOR_UDID" \
               -derivedDataPath build \
               clean build

    # Install the app
    APP_PATH="build/Build/Products/Debug-iphonesimulator/Hype.app"
    xcrun simctl install "$SIMULATOR_UDID" "$APP_PATH"

    # Launch the app
    xcrun simctl launch "$SIMULATOR_UDID" com.tggreene.hype
    sleep 5  # Wait for app to load
    echo -e "${GREEN}✓ App installed and launched${NC}"
}

# Function to take screenshot
take_screenshot() {
    local name=$1
    local filename="$SCREENSHOT_DIR/$name.png"
    xcrun simctl io booted screenshot "$filename"
    echo -e "${GREEN}✓ Screenshot saved: $filename${NC}"
    sleep 1
}

# Function to tap on simulator (to cycle through affirmations)
tap_simulator() {
    local x=$1
    local y=$2
    xcrun simctl io booted tap "$x" "$y"
    sleep 2  # Wait for transition
}

# Main execution
echo -e "${BLUE}Starting screenshot automation...${NC}"
echo ""

# Boot simulator
boot_simulator

# Install and run app
install_app

echo ""
echo -e "${BLUE}📸 Taking screenshots...${NC}"
echo ""

# Take initial screenshot (first affirmation)
take_screenshot "01-initial"

# Tap to cycle through affirmations
# Center of screen tap (approximate - you may need to adjust)
CENTER_X=400
CENTER_Y=800

for i in {2..5}; do
    echo -e "${BLUE}Tapping to show affirmation $i...${NC}"
    tap_simulator $CENTER_X $CENTER_Y
    take_screenshot "0$i-affirmation"
done

echo ""
echo -e "${GREEN}✅ Screenshot automation complete!${NC}"
echo -e "${GREEN}Screenshots saved in: $SCREENSHOT_DIR/${NC}"
echo ""
echo "Next steps:"
echo "1. Review screenshots in the $SCREENSHOT_DIR folder"
echo "2. Use them when creating your App Store Connect listing"
echo "3. You may need to resize them for different device sizes"
