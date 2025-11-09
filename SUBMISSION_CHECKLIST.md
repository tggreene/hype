# App Store Submission Checklist

## ✅ Completed
- [x] Apple Developer Program membership confirmed
- [x] Project version and build numbers verified (1.0 / 1)
- [x] Bundle ID configured (com.tggreene.hype)
- [x] Code signing configured (Team: HZLVXYG234)
- [x] App listing content prepared (see APP_STORE_LISTING.md)
- [x] Privacy policy template created (see PRIVACY_POLICY.md)

## 📋 To Do (Manual Steps)

### 1. Prepare Privacy Policy
- [ ] Update PRIVACY_POLICY.md with your contact information
- [ ] Host privacy policy on a publicly accessible URL
- [ ] Test the URL works before submitting

### 2. Create Screenshots
- [ ] Open app in iOS Simulator (Product → Destination → iPhone 15 Pro Max)
- [ ] Take 3-5 screenshots showing different affirmations
- [ ] Ensure text is clear and readable
- [ ] Save screenshots in a folder for easy access

**Screenshot Requirements:**
- Minimum: iPhone 6.7" (iPhone 14 Pro Max, 15 Pro Max)
- Recommended: Also create iPhone 6.5" and iPhone 5.5" sizes

### 3. Test on Physical Device
- [ ] Connect your iPhone/iPad
- [ ] Build and run the app
- [ ] Test audio playback works
- [ ] Test all affirmations cycle correctly
- [ ] Verify launch screen displays properly
- [ ] Test on both light and dark mode

### 4. Create App Record in App Store Connect
- [ ] Log into [App Store Connect](https://appstoreconnect.apple.com)
- [ ] Click "+" → New App
- [ ] Fill in:
  - Platform: iOS
  - Name: (choose available name - see APP_STORE_LISTING.md)
  - Primary Language: English
  - Bundle ID: com.tggreene.hype
  - SKU: hype-001 (or your preferred unique identifier)

### 5. Complete App Information
- [ ] Enter app description from APP_STORE_LISTING.md
- [ ] Enter subtitle
- [ ] Enter keywords
- [ ] Enter privacy policy URL
- [ ] Enter support URL
- [ ] Select category (Health & Fitness recommended)
- [ ] Complete age rating questionnaire
- [ ] Upload screenshots
- [ ] Save as draft

### 6. Archive and Upload Build
- [ ] In Xcode: Product → Destination → Any iOS Device
- [ ] Product → Archive
- [ ] Wait for archive to complete
- [ ] In Organizer: Click "Distribute App"
- [ ] Choose "App Store Connect"
- [ ] Select "Upload"
- [ ] Wait for validation and upload (10-30 minutes)

### 7. Submit for Review
- [ ] In App Store Connect, go to your app → App Store tab
- [ ] Wait for build to appear (may take time)
- [ ] Select the uploaded build
- [ ] Fill in "What's New in This Version" (see APP_STORE_LISTING.md)
- [ ] Answer export compliance questions (usually "No")
- [ ] Add review notes if needed (optional)
- [ ] Click "Submit for Review"

### 8. Monitor Submission
- [ ] Check App Store Connect regularly for status updates
- [ ] Respond to any review feedback if needed
- [ ] Once approved, app will be live on App Store!

## Notes

- Review typically takes 24-48 hours
- You can save the App Store Connect listing as a draft and come back to it
- You can upload the build before completing all listing information
- Build must be approved before you can submit for review
