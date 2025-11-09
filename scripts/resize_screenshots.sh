#!/bin/bash

# Script to resize screenshots to App Store Connect requirements
# Required dimensions: 1242 × 2688px, 2688 × 1242px, 1284 × 2778px or 2778 × 1284px

set -e

INPUT_DIR="screenshots"
OUTPUT_DIR="screenshots/app_store"

# App Store required dimensions (width x height)
declare -a DIMENSIONS=(
    "1242x2688"   # iPhone 6.5" portrait
    "2688x1242"   # iPhone 6.5" landscape
    "1284x2778"   # iPhone 6.7" portrait
    "2778x1284"   # iPhone 6.7" landscape
)

echo "📐 App Store Screenshot Resizer"
echo ""

# Check if sips is available
if ! command -v sips &> /dev/null; then
    echo "❌ Error: sips command not found (should be available on macOS)"
    exit 1
fi

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "❌ Error: Screenshots directory not found: $INPUT_DIR"
    echo "   Please run the screenshot script first or create the directory"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Count input files
INPUT_FILES=($(find "$INPUT_DIR" -maxdepth 1 -name "*.png" -not -path "*/app_store/*" | sort))
if [ ${#INPUT_FILES[@]} -eq 0 ]; then
    echo "❌ No PNG files found in $INPUT_DIR"
    exit 1
fi

echo "Found ${#INPUT_FILES[@]} screenshot(s) to process"
echo ""

# Process each screenshot
for input_file in "${INPUT_FILES[@]}"; do
    filename=$(basename "$input_file" .png)
    echo "Processing: $filename"

    # Create resized versions for each required dimension
    for dim in "${DIMENSIONS[@]}"; do
        IFS='x' read -r width height <<< "$dim"
        output_file="$OUTPUT_DIR/${filename}_${width}x${height}.png"

        echo "  → Resizing to ${width}x${height}..."
        sips -z "$height" "$width" "$input_file" --out "$output_file" > /dev/null
    done

    echo "  ✓ Done"
    echo ""
done

echo "✅ All screenshots resized!"
echo ""
echo "📁 Resized screenshots saved in: $OUTPUT_DIR"
echo ""
echo "📋 App Store Upload:"
echo "   Use the files from $OUTPUT_DIR when uploading to App Store Connect"
echo ""
echo "💡 Tip: You typically only need portrait OR landscape, not both."
echo "   For iPhone apps, portrait (1242x2688 or 1284x2778) is most common."
