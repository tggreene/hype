#!/bin/bash

# Script to generate all required iOS app icon sizes from a 1024x1024 source image
# Usage: ./scripts/generate_icon_sizes.sh path/to/icon-1024.png

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-1024x1024-icon.png>"
    echo "Example: $0 ~/Desktop/my-icon.png"
    exit 1
fi

INPUT="$1"
OUTPUT_DIR="icon_output"

if [ ! -f "$INPUT" ]; then
    echo "❌ Error: Input file not found: $INPUT"
    exit 1
fi

# Check if sips is available (built into macOS)
if ! command -v sips &> /dev/null; then
    echo "❌ Error: sips command not found (should be available on macOS)"
    exit 1
fi

echo "🎨 Generating iOS app icon sizes from: $INPUT"
echo ""

mkdir -p "$OUTPUT_DIR"

# iOS App Icon sizes needed
# Format: size@scale
declare -a sizes=(
    "20@2x"  # 40x40
    "20@3x"  # 60x60
    "29@2x"  # 58x58
    "29@3x"  # 87x87
    "40@2x"  # 80x80
    "40@3x"  # 120x120
    "60@2x"  # 120x120
    "60@3x"  # 180x180
    "76@2x"  # 152x152 (iPad)
    "83.5@2x" # 167x167 (iPad Pro)
    "1024@1x" # 1024x1024 (App Store)
)

for size_spec in "${sizes[@]}"; do
    # Parse size and scale
    IFS='@' read -r size scale <<< "$size_spec"

    # Calculate actual pixel dimensions
    # Handle decimal sizes (83.5) by using awk for math
    if [ "$scale" == "1x" ]; then
        pixels=$(echo "$size" | awk '{printf "%.0f", $1}')
    elif [ "$scale" == "2x" ]; then
        pixels=$(echo "$size" | awk '{printf "%.0f", $1 * 2}')
    elif [ "$scale" == "3x" ]; then
        pixels=$(echo "$size" | awk '{printf "%.0f", $1 * 3}')
    fi

    output_file="$OUTPUT_DIR/AppIcon-${size}@${scale}.png"

    echo "Generating: ${size}@${scale} (${pixels}x${pixels})"
    sips -z "$pixels" "$pixels" "$INPUT" --out "$output_file" > /dev/null
done

echo ""
echo "✅ All icon sizes generated in: $OUTPUT_DIR"
echo ""
echo "📝 Next steps:"
echo "1. In Xcode, open Assets.xcassets → AppIcon"
echo "2. Drag the generated images to their corresponding slots"
echo "3. Or replace the entire AppIcon.appiconset folder"
