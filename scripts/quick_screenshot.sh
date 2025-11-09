#!/bin/bash

# Ultra-simple one-liner screenshot script
# Just takes a screenshot with timestamp

SCREENSHOT_DIR="screenshots"
mkdir -p "$SCREENSHOT_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"

xcrun simctl io booted screenshot "$FILENAME"
echo "✅ Screenshot saved: $FILENAME"

