# Archiving and Uploading Guide

This guide covers how to archive your app and upload it to App Store Connect, both manually and automatically.

## Manual Process (Xcode GUI)

### Step 1: Archive
1. Open your project in Xcode
2. Select **Product → Destination → Any iOS Device** (not a simulator)
3. Select **Product → Archive**
4. Wait for the archive to complete (may take a few minutes)
5. The Organizer window will open automatically

### Step 2: Upload
1. In the Organizer window, select your archive
2. Click **"Distribute App"**
3. Choose **"App Store Connect"**
4. Click **"Next"**
5. Select **"Upload"** (not "Export")
6. Follow the prompts:
   - Select your team
   - Review app information
   - Click **"Upload"**
7. Wait for upload to complete (10-30 minutes)

## Automated Process (Command Line)

### Option 1: Archive Only

```bash
./scripts/archive_app.sh
```

This will:
- Clean the build
- Create an archive
- Save it to `build/archives/`

After running, open Xcode → Window → Organizer to see your archive and upload it manually.

### Option 2: Archive + Upload (Full Automation)

**Note:** The upload script requires authentication. You have two options:

#### A. Using Apple ID (Recommended for first time)

1. **Set up App-Specific Password:**
   - Go to https://appleid.apple.com
   - Sign in → App-Specific Passwords
   - Generate a new password
   - Save it securely

2. **Add to Keychain:**
   ```bash
   xcrun altool --store-password-in-keychain-item "Application Loader: your@email.com" \
     -u "your@email.com" -p "your-app-specific-password"
   ```

3. **Set environment variable:**
   ```bash
   export APPLE_ID="your@email.com"
   ```

4. **Run the scripts:**
   ```bash
   ./scripts/archive_app.sh
   ./scripts/upload_to_appstore.sh
   ```

#### B. Using API Key (More secure, requires setup)

1. **Create API Key in App Store Connect:**
   - Go to App Store Connect → Users and Access → Keys
   - Create a new key with "App Manager" or "Admin" role
   - Download the `.p8` key file

2. **Set environment variables:**
   ```bash
   export APP_API_KEY="your-api-key-id"
   export APP_API_ISSUER="your-issuer-uuid"
   ```

3. **Run the scripts:**
   ```bash
   ./scripts/archive_app.sh
   ./scripts/upload_to_appstore.sh
   ```

## Quick Workflow

### Recommended: Semi-Automated

1. **Archive automatically:**
   ```bash
   ./scripts/archive_app.sh
   ```

2. **Upload manually in Xcode:**
   - Window → Organizer
   - Select archive → Distribute App → App Store Connect → Upload

This gives you control over the upload process while automating the archive.

## Troubleshooting

### "No signing certificate found"
- Open Xcode
- Go to Preferences → Accounts
- Add your Apple ID if not already added
- Select your team in the project settings

### "Archive failed"
- Make sure you selected "Any iOS Device" (not a simulator)
- Check that code signing is configured correctly
- Try cleaning: Product → Clean Build Folder (⌘+Shift+K)

### "Upload failed - authentication"
- Use the manual upload process in Xcode Organizer
- Or set up API key authentication (see Option B above)

### Archive not appearing in Organizer
- Make sure you're looking at the correct Xcode window
- Try: Window → Organizer (⌘+Shift+9)
- The archive should appear automatically after creation

## File Locations

- **Archives:** `build/archives/`
- **Exports:** `build/export/`
- **Xcode Archives:** `~/Library/Developer/Xcode/Archives/` (default Xcode location)

## Tips

1. **Increment Build Number:** Before archiving, increment `CURRENT_PROJECT_VERSION` in project.pbxproj
2. **Test First:** Always test on a physical device before archiving
3. **Check Signing:** Verify code signing is set to "Automatically manage signing"
4. **Wait for Processing:** After upload, it takes 10-30 minutes for the build to appear in App Store Connect

