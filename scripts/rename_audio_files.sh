#!/usr/bin/env bash

# Script to rename existing audio files to match the new naming convention
# Converts PascalCase names to the exact affirmation text

set -e

# Get script directory and go up one level to project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RESOURCES_DIR="$PROJECT_ROOT/Hype/Resources"

if [ ! -d "$RESOURCES_DIR" ]; then
    echo "❌ Error: Resources directory not found: $RESOURCES_DIR"
    exit 1
fi

# Mapping from old PascalCase names to new affirmation text names
# This matches the affirmations array in ContentView.swift
declare -A RENAME_MAP=(
    ["YouAreCapableOfAmazingThings.mp3"]="You are capable of amazing things.mp3"
    ["YourPotentialIsLimitless.mp3"]="Your potential is limitless.mp3"
    ["YouAreWorthyOfLoveAndHappiness.mp3"]="You are worthy of love and happiness.mp3"
    ["EveryDayIsAFreshStart.mp3"]="Every day is a fresh start.mp3"
    ["YouHaveTheStrengthToOvercomeAnyChallenge.mp3"]="You have the strength to overcome any challenge.mp3"
    ["YouAreEnoughJustAsYouAre.mp3"]="You are enough, just as you are.mp3"
    ["YourDreamsAreValidAndAchievable.mp3"]="Your dreams are valid and achievable.mp3"
    ["YouRadiatePositivityAndConfidence.mp3"]="You radiate positivity and confidence.mp3"
    ["YouAreCreatingTheLifeYouDeserve.mp3"]="You are creating the life you deserve.mp3"
    ["BelieveInYourselfAndYourAbilities.mp3"]="Believe in yourself and your abilities.mp3"
    # Additional files that might exist
    ["YouAreAMajesticBeast.mp3"]="You are a majestic beast.mp3"
    # Handle any affirmation0.mp3, affirmation1.mp3 style names if they exist
    ["affirmation0.mp3"]="You are capable of amazing things.mp3"
    ["affirmation1.mp3"]="Your potential is limitless.mp3"
    ["affirmation2.mp3"]="You are worthy of love and happiness.mp3"
    ["affirmation3.mp3"]="Every day is a fresh start.mp3"
    ["affirmation4.mp3"]="You have the strength to overcome any challenge.mp3"
    ["affirmation5.mp3"]="You are enough, just as you are.mp3"
    ["affirmation6.mp3"]="Your dreams are valid and achievable.mp3"
    ["affirmation7.mp3"]="You radiate positivity and confidence.mp3"
    ["affirmation8.mp3"]="You are creating the life you deserve.mp3"
    ["affirmation9.mp3"]="Believe in yourself and your abilities.mp3"
)

echo "🔄 Renaming audio files to match new naming convention..."
echo ""

cd "$PROJECT_ROOT"

# Count files to rename
rename_count=0
for old_name in "${!RENAME_MAP[@]}"; do
    old_path="$RESOURCES_DIR/$old_name"
    if [ -f "$old_path" ]; then
        rename_count=$((rename_count + 1))
    fi
done

if [ $rename_count -eq 0 ]; then
    echo "✅ No files found to rename. They may already be renamed or don't exist."
    exit 0
fi

echo "Found $rename_count file(s) to rename:"
for old_name in "${!RENAME_MAP[@]}"; do
    old_path="$RESOURCES_DIR/$old_name"
    if [ -f "$old_path" ]; then
        new_name="${RENAME_MAP[$old_name]}"
        echo "  $old_name -> $new_name"
    fi
done
echo ""

# Ask for confirmation
read -p "Rename these files? [y/N] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Cancelled"
    exit 0
fi

# Perform renames
renamed=0
for old_name in "${!RENAME_MAP[@]}"; do
    old_path="$RESOURCES_DIR/$old_name"
    new_name="${RENAME_MAP[$old_name]}"
    new_path="$RESOURCES_DIR/$new_name"

    if [ -f "$old_path" ]; then
        if [ -f "$new_path" ]; then
            echo "⚠️  Skipping $old_name (target already exists: $new_name)"
        else
            mv "$old_path" "$new_path"
            echo "✓ Renamed: $old_name -> $new_name"
            renamed=$((renamed + 1))
        fi
    fi
done

echo ""
echo "✅ Done! Renamed $renamed file(s)."
