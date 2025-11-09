# Fixing iPad Screenshot Requirement

## Option 1: Disable iPad Support (Recommended)

I've updated your project to **iPhone-only** support. This should remove the iPad screenshot requirement.

### What Changed:
- `TARGETED_DEVICE_FAMILY` changed from `"1,2"` (iPhone + iPad) to `1` (iPhone only)
- Removed iPad-specific orientation settings

### Next Steps:

1. **Increment Build Number:**
   - You'll need to upload a new build with this change
   - Update `CURRENT_PROJECT_VERSION` in project.pbxproj (change from 1 to 2)

2. **Create New Archive:**
   - Product → Archive in Xcode
   - Upload the new build to App Store Connect

3. **Wait for Processing:**
   - New build should process without iPad requirement
   - This may take 30-60 minutes

### Important Note:
If you've already uploaded a build with iPad support, you'll need to upload a new build with iPhone-only support. The old build will still require iPad screenshots.

## Option 2: Quick iPad Screenshot (Faster Alternative)

If you don't want to wait for a new build, you can quickly create an iPad screenshot:

### Quick Method:
1. **Open iPad Simulator:**
   - Xcode → Open Simulator
   - Device → iPad Pro (12.9-inch) (6th generation)

2. **Run Your App:**
   - Build and run on the iPad simulator
   - Your app will run in iPhone compatibility mode (smaller window)

3. **Take Screenshot:**
   - ⌘ + S in simulator
   - Or use: `xcrun simctl io booted screenshot ipad_screenshot.png`

4. **Resize if Needed:**
   - iPad Pro 12.9" requires: 2048 × 2732px (portrait) or 2732 × 2048px (landscape)
   - Use your resize script or manually resize

### Even Faster - Reuse iPhone Screenshot:
Since your app will run in iPhone compatibility mode on iPad, you can:
1. Take your existing iPhone screenshot
2. Resize it to iPad dimensions (2048 × 2732px)
3. Upload it

The screenshot will show your app in the smaller iPhone-sized window on iPad, which is fine for App Store requirements.

## Option 3: Disable in App Store Connect (If Available)

Some developers report that you can sometimes:
1. Go to App Store Connect → Your App → App Store tab
2. Look for device support settings
3. Uncheck iPad if the option is available

However, this option isn't always available, especially if your build already supports iPad.

## Recommendation

**If you haven't submitted yet:**
- Use **Option 1** (disable iPad support) - cleaner solution
- Upload new build with iPhone-only support
- No iPad screenshots needed

**If you need to submit quickly:**
- Use **Option 2** (quick iPad screenshot)
- Take one iPad screenshot (5 minutes)
- Submit immediately

## After Making Changes

If you chose Option 1 (disable iPad):
1. Increment build number (1 → 2)
2. Archive and upload new build
3. Wait for processing
4. iPad screenshot requirement should be gone

If you chose Option 2 (iPad screenshot):
1. Upload the iPad screenshot
2. Continue with submission
3. App will work on iPad in compatibility mode (which is fine)

## Build Number Update

To increment build number, update in `Hype.xcodeproj/project.pbxproj`:
- Change `CURRENT_PROJECT_VERSION = 1;` to `CURRENT_PROJECT_VERSION = 2;`
- Do this in both Debug and Release configurations
