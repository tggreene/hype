#!/bin/bash

# Simple screenshot script - takes screenshots of whatever is on the simulator
# Use this for quick, controlled screenshot capture

set -e

SCREENSHOT_DIR="screenshots"
mkdir -p "$SCREENSHOT_DIR"

echo "📸 Hype App Screenshot Tool"
echo ""
echo "Make sure:"
echo "1. Simulator is running"
echo "2. Hype app is open"
echo ""

COUNTER=1
while true; do
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Screenshot #$COUNTER"
    echo ""
    echo "Current setup:"
    echo "  • Tap the app to show the affirmation you want"
    echo "  • Press Enter to take screenshot"
    echo "  • Type 'done' and press Enter to finish"
    echo ""

    read -p "Ready? (Enter to capture, 'done' to finish): " input

    if [ "$input" = "done" ]; then
        echo ""
        echo "✅ Finished! Screenshots saved in: $SCREENSHOT_DIR"
        echo "Total screenshots: $((COUNTER - 1))"
        break
    fi

    # Take screenshot with numbered filename
    FILENAME=$(printf "$SCREENSHOT_DIR/screenshot_%02d.png" $COUNTER)
    xcrun simctl io booted screenshot "$FILENAME"

    echo "✅ Screenshot #$COUNTER saved: $FILENAME"
    echo ""

    COUNTER=$((COUNTER + 1))
done
