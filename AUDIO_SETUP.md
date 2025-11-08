# Audio File Generation Setup

This script automates downloading audio files from ElevenLabs for your affirmations.

## Prerequisites

1. **ElevenLabs API Key**: Get it from https://elevenlabs.io/app/settings/api-keys
2. **Voice ID**: Get it from ElevenLabs (or use a default like "21m00Tcm4TlvDq8ikWAM" for Rachel)

## Setup Steps

1. **Edit the script** (`generate_audio.swift`):
   - Replace `YOUR_API_KEY_HERE` with your ElevenLabs API key
   - Replace `YOUR_VOICE_ID_HERE` with your preferred voice ID

2. **Run the script**:
   ```bash
   cd /path/to/hype
   swift generate_audio.swift
   ```

   Or if you made it executable:
   ```bash
   ./generate_audio.swift
   ```

3. **Add files to Xcode**:
   - The script creates `Hype/Resources/` folder with all audio files
   - In Xcode, right-click the `Hype` folder
   - Select "Add Files to 'Hype'..."
   - Select the `Resources` folder
   - **Important**: Check "Create folder references" (blue folder icon)
   - Check your app target
   - Click "Add"

## Finding Your Voice ID

1. Go to https://elevenlabs.io/app/voices
2. Click on a voice you like
3. The Voice ID is in the URL or voice settings
4. Common voice IDs:
   - Rachel: `21m00Tcm4TlvDq8ikWAM`
   - Adam: `pNInz6obpgDQGcFmaJgB`
   - Antoni: `ErXwobaYiN019PkySvjV`

## Notes

- The script includes a 0.5 second delay between requests to avoid rate limiting
- Files are saved as `affirmation0.mp3`, `affirmation1.mp3`, etc.
- Make sure you have sufficient ElevenLabs credits for all affirmations
