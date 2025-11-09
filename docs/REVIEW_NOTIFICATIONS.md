# App Store Review Notifications

## Automatic Email Notifications

Apple **automatically sends email notifications** when your app's review status changes. You don't need to set anything up - it happens automatically.

### What You'll Get Emailed About:

1. **"Your app has been submitted for review"**
   - Sent immediately after you click "Submit for Review"

2. **"Your app is in review"**
   - Sent when Apple starts reviewing your app
   - Usually happens within 24-48 hours of submission

3. **"Your app has been approved"** ✅
   - Sent when your app passes review
   - Your app is ready to go live!

4. **"Your app needs additional information"** ⚠️
   - Sent if Apple needs clarification or has questions
   - Usually includes what needs to be fixed

5. **"Your app has been rejected"** ❌
   - Sent if your app doesn't meet guidelines
   - Includes reasons and what to fix

## Ensure Notifications Are Enabled

### Check Your Email Settings:

1. **Log into App Store Connect:**
   - https://appstoreconnect.apple.com

2. **Go to Settings:**
   - Click your name (top right)
   - Select **"Preferences"**

3. **Check Email Notifications:**
   - Under "Email Notifications"
   - Make sure **"App Status"** is checked
   - This should be enabled by default

4. **Verify Email Address:**
   - Make sure your email address is correct
   - Check spam/junk folder if you're not receiving emails

## Email Address Used

Apple sends notifications to:
- The email address associated with your Apple Developer account
- The email of the account you used to log into App Store Connect

## What to Expect

### Typical Timeline:

1. **Submitted** → Email: "Your app has been submitted for review"
2. **In Review** (24-48 hours) → Email: "Your app is in review"
3. **Approved** → Email: "Your app has been approved" 🎉

### Email Format:

Subject lines typically look like:
- `Your app "Hype - Get Motivated" has been submitted for review`
- `Your app "Hype - Get Motivated" is in review`
- `Your app "Hype - Get Motivated" has been approved`

## Check Status Manually

Even with email notifications, you can check status anytime:

1. **App Store Connect:**
   - Go to your app
   - Look at the top of the page for status badge
   - Statuses: "Waiting for Review", "In Review", "Ready for Sale", etc.

2. **TestFlight Tab:**
   - Shows build processing status
   - Shows if build is ready

3. **App Store Tab:**
   - Shows submission status
   - Shows if app is approved and ready

## Troubleshooting

### Not Receiving Emails?

1. **Check Spam/Junk Folder:**
   - Apple emails sometimes end up here
   - Add `noreply@email.apple.com` to contacts

2. **Verify Email in App Store Connect:**
   - Settings → Preferences
   - Check email address is correct

3. **Check Apple Developer Account:**
   - Make sure email is verified
   - https://developer.apple.com/account

4. **Check Email Filters:**
   - Some email providers filter Apple emails
   - Check your email provider's spam settings

### Alternative: Push Notifications

Unfortunately, Apple doesn't offer:
- ❌ Push notifications to your phone
- ❌ SMS notifications
- ❌ Slack/Discord webhooks

You can only get:
- ✅ Email notifications (automatic)
- ✅ Check App Store Connect manually

## Pro Tips

1. **Add to Contacts:**
   - Add `noreply@email.apple.com` to your email contacts
   - This helps prevent emails going to spam

2. **Check Regularly:**
   - Even with emails, check App Store Connect daily
   - Sometimes emails can be delayed

3. **Set Up Email Filters:**
   - Create a filter for "App Store Connect" emails
   - This helps you find them quickly

4. **Monitor Activity Tab:**
   - App Store Connect → Your name → Activity
   - Shows all recent changes and status updates

## After Approval

Once you get the "approved" email:

1. **Your app status changes to:**
   - "Ready for Sale" (if you set it to auto-release)
   - "Pending Developer Release" (if you chose manual release)

2. **If "Pending Developer Release":**
   - Go to App Store Connect
   - Click "Release This Version"
   - Your app goes live immediately!

3. **Your app appears on App Store:**
   - Usually within 24 hours of approval
   - Searchable by name
   - Available for download

## Summary

✅ **You WILL get email notifications automatically**
- No setup required
- Sent to your Apple Developer account email
- Covers all status changes

📧 **Check your email** (and spam folder) for:
- Submission confirmation
- Review started
- Approval/rejection
- Any issues that need attention

🎉 **You're all set!** Just wait for the emails and check App Store Connect if needed.
