# App Store Connect Build Status Guide

## Where to Check Build Status

### 1. App Store Connect Web Interface

**Path:** Your App → TestFlight tab → iOS Builds

1. Log into [App Store Connect](https://appstoreconnect.apple.com)
2. Click on your app
3. Go to the **"TestFlight"** tab (left sidebar)
4. Look at the **"iOS Builds"** section

**What you'll see:**
- **Processing** - Build is being processed (10-30 minutes)
- **Ready to Submit** - Build is ready, can be selected for submission
- **Expired** - Build is too old (90 days)
- **Missing Compliance** - Needs export compliance info

### 2. App Store Tab (For Submission)

**Path:** Your App → App Store tab → Version Information

1. Go to **"App Store"** tab (left sidebar)
2. Click on your version (e.g., "1.0")
3. Scroll to **"Build"** section
4. Click the **"+"** button to select a build

**If no builds appear:**
- Build is still processing (wait 10-30 minutes)
- Build hasn't been uploaded yet
- Build failed validation

## Build Processing Timeline

### Typical Timeline:
1. **Upload** (5-15 minutes)
   - Xcode shows "Upload successful"
   - Build appears in TestFlight with "Processing" status

2. **Processing** (10-30 minutes)
   - Apple processes the build
   - Validates code signing, symbols, etc.
   - Status shows "Processing"

3. **Ready** (30-60 minutes total)
   - Status changes to "Ready to Submit"
   - Build appears in App Store tab for selection

### If It Takes Longer:
- **1-2 hours** - Normal during busy periods
- **2-4 hours** - Still normal, but less common
- **4+ hours** - May indicate an issue

## Checking Upload Status

### Method 1: Xcode Organizer
1. Open Xcode
2. Window → Organizer (⌘+Shift+9)
3. Select your archive
4. Look for upload status:
   - ✅ "Uploaded" - Successfully uploaded
   - ⏳ "Uploading" - Still in progress
   - ❌ "Failed" - Upload failed

### Method 2: App Store Connect Activity
1. Go to App Store Connect
2. Click your name (top right) → **"Activity"**
3. Look for recent uploads
4. Shows upload status and any errors

### Method 3: Email Notifications
- Apple sends emails when:
  - Build processing starts
  - Build processing completes
  - Build processing fails

**Note:** Make sure email notifications are enabled in App Store Connect settings.

## Troubleshooting Empty Build List

### If TestFlight shows no builds:

1. **Check Upload Status:**
   - Did Xcode show "Upload successful"?
   - Check Xcode Organizer for upload status

2. **Wait Longer:**
   - First build can take 30-60 minutes
   - Refresh the page (builds don't auto-refresh)

3. **Check for Errors:**
   - Go to Activity tab
   - Look for error messages
   - Check email for notifications

4. **Verify Bundle ID:**
   - Make sure bundle ID matches: `com.tggreene.hype`
   - App Store Connect app must use same bundle ID

5. **Check Build Number:**
   - Each upload needs a unique build number
   - Increment `CURRENT_PROJECT_VERSION` in project.pbxproj

### Common Issues:

**"No builds available"**
- Build is still processing (wait)
- Build failed validation (check Activity)
- Wrong bundle ID

**"Build expired"**
- Builds expire after 90 days
- Upload a new build

**"Missing Compliance"**
- Answer export compliance questions
- Usually: "Does your app use encryption?" → "No"

## What to Do While Waiting

1. **Complete App Store Listing:**
   - Fill in description, keywords, etc.
   - Upload screenshots
   - Complete age rating

2. **Prepare Privacy Policy:**
   - Make sure it's hosted and accessible
   - Test the URL

3. **Check Email:**
   - Apple sends notifications
   - Check spam folder

## Quick Checklist

- [ ] Upload completed in Xcode (shows "Upload successful")
- [ ] Wait 10-30 minutes for processing
- [ ] Check TestFlight tab → iOS Builds
- [ ] Look for "Processing" or "Ready to Submit" status
- [ ] If still empty after 1 hour, check Activity tab for errors
- [ ] Once ready, go to App Store tab to select build

## Next Steps After Build Appears

1. **Select Build:**
   - App Store tab → Version → Build section
   - Click "+" → Select your build

2. **Complete Submission:**
   - Fill in "What's New" (release notes)
   - Answer export compliance
   - Submit for review

## Still Having Issues?

If build doesn't appear after 2+ hours:
1. Check Activity tab for errors
2. Verify upload succeeded in Xcode Organizer
3. Try uploading again (increment build number first)
4. Check Apple Developer forums for known issues
