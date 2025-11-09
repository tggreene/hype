# Audio File Generation Setup

This script automates downloading audio files from ElevenLabs for your affirmations.

## Prerequisites

1. **ElevenLabs API Key**: Get it from https://elevenlabs.io/app/settings/api-keys

## Setup Steps

1. **Set your API key as an environment variable**:
   ```bash
   export ELEVENLABS_API_KEY='your-api-key-here'
   ```

2. **Run the script**:
   ```bash
   cd /path/to/hype
   swift scripts/generate_audio.swift
   ```

   Or from anywhere:
   ```bash
   swift /path/to/hype/scripts/generate_audio.swift
   ```

   Or if you made it executable:
   ```bash
   ./scripts/generate_audio.swift
   ```

3. **Add files to Xcode**:
   - The script creates `Hype/Resources/` folder with all audio files
   - In Xcode, right-click the `Hype` folder
   - Select "Add Files to 'Hype'..."
   - Select the `Resources` folder
   - **Important**: Check "Create folder references" (blue folder icon)
   - Check your app target
   - Click "Add"

## Changing the Voice

The voice is set in `generate_audio.swift` in the `voices` dictionary. Currently using "Juniper". To change it:

1. Edit `generate_audio.swift`
2. Update the `voices` dictionary with your preferred voice ID
3. Change `voices["Juniper"]` to use your voice

To find voice IDs, go to https://elevenlabs.io/app/voices

## Notes

- The script includes a 0.5 second delay between requests to avoid rate limiting
- Files are saved with descriptive names like `YouAreCapableOfAmazingThings.mp3`
- Make sure you have sufficient ElevenLabs credits for all affirmations
