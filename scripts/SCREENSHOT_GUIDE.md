# Screenshot Automation Guide

I've created several options for automating screenshots:

## Option 1: Simple Manual Script (Easiest - Recommended)

Use `take_screenshots_simple.sh` - this is the simplest approach:

```bash
./scripts/take_screenshots_simple.sh
```

**How it works:**
1. Make sure Simulator is running with your app open
2. Run the script
3. It will prompt you to press Enter
4. Tap the app to show a different affirmation
5. Run the script again for the next screenshot

**Pros:** Simple, reliable, you control which affirmations to capture
**Cons:** Requires manual tapping between screenshots

## Option 2: Full Automation Script

Use `take_screenshots.sh` - attempts to fully automate:

```bash
./scripts/take_screenshots.sh
```

**How it works:**
1. Boots the simulator
2. Builds and installs the app
3. Launches the app
4. Automatically taps to cycle through affirmations
5. Takes screenshots at each step

**Pros:** Fully automated
**Cons:** May need adjustment for tap coordinates, requires building

**Note:** You may need to adjust the tap coordinates (`CENTER_X` and `CENTER_Y`) in the script based on your device size.

## Option 3: Using Xcode UI Testing (Most Reliable)

Create a UI test that can automate tapping and screenshot taking. This is the most reliable for automation.

## Option 4: Manual with Keyboard Shortcut

1. Open app in Simulator
2. Press `⌘ + S` to take screenshot (saves to Desktop)
3. Tap app to show next affirmation
4. Repeat

Then organize screenshots later.

## Recommended Workflow

1. **Start with Option 1 (Simple Script):**
   ```bash
   ./scripts/take_screenshots_simple.sh
   ```

2. Open Simulator with your app running
3. For each screenshot:
   - Tap the app to show the affirmation you want
   - Run the script (or press ⌘+S)
   - Wait for confirmation

4. **Organize screenshots:**
   - Screenshots will be in the `screenshots/` folder
   - Name them appropriately (they'll have timestamps)

5. **Resize if needed:**
   - App Store requires specific sizes
   - iPhone 6.7": 1290 x 2796 pixels
   - iPhone 6.5": 1242 x 2688 pixels
   - iPhone 5.5": 1242 x 2208 pixels

## Quick Command Reference

```bash
# Take screenshot of current simulator state
xcrun simctl io booted screenshot screenshot.png

# List available simulators
xcrun simctl list devices available

# Boot a specific simulator
xcrun simctl boot "iPhone 15 Pro Max"

# Open Simulator app
open -a Simulator
```
