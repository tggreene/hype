# GitHub Pages Setup for Privacy Policy

## Quick Setup Steps

### 1. Enable GitHub Pages

1. **Go to your GitHub repository:**
   - https://github.com/tggreene/hype

2. **Click Settings** (top right of repo page)

3. **Scroll down to "Pages"** (left sidebar)

4. **Under "Source":**
   - Select **"Deploy from a branch"**
   - Branch: **`main`** (or your default branch)
   - Folder: **`/ (root)`**
   - Click **"Save"**

5. **Wait 1-2 minutes** for GitHub to build your site

6. **Your site will be available at:**
   ```
   https://tggreene.github.io/hype/privacy-policy.html
   ```

### 2. Verify Your Files Are Committed

Make sure `privacy-policy.html` is committed and pushed:

```bash
# Check if file is tracked
git status

# If not committed, add and commit:
git add privacy-policy.html
git commit -m "Add privacy policy for App Store"
git push
```

### 3. Check Repository Visibility

**Important:** GitHub Pages works with:
- ✅ **Public repositories** (free, unlimited)
- ✅ **Private repositories** (requires GitHub Pro/Team/Enterprise)

If your repo is private and you don't have a paid plan, you have two options:

**Option A: Make repo public** (if you're okay with that)
- Settings → Danger Zone → Change repository visibility → Make public

**Option B: Use a different hosting service** (see alternatives below)

### 4. Test Your Privacy Policy URL

After enabling Pages, wait 1-2 minutes, then test:
```
https://tggreene.github.io/hype/privacy-policy.html
```

If it doesn't work immediately:
- Wait a few more minutes (first-time setup can take 5-10 minutes)
- Check the Pages settings show "Your site is live at..."
- Make sure the file is in the root directory (not in a subfolder)

## Troubleshooting

### "404 Not Found"
- **Wait longer** - First deployment can take 5-10 minutes
- **Check file location** - File must be in root or `docs/` folder
- **Verify branch** - Make sure you selected the correct branch
- **Check file name** - Must be exactly `privacy-policy.html`

### "Repository not found"
- Repository might be private (see visibility section above)
- Check you're using the correct username: `tggreene`

### "Site not found"
- GitHub Pages might not be enabled
- Go back to Settings → Pages and verify it's set up

### Pages Settings Not Showing
- Make sure you're the repository owner or have admin access
- Some organizations disable Pages - check with your org admin

## Alternative Hosting Options

If GitHub Pages doesn't work for you, here are quick alternatives:

### Option 1: Netlify Drop (Easiest)
1. Go to https://app.netlify.com/drop
2. Drag and drop `privacy-policy.html`
3. Get instant URL (e.g., `https://random-name-123.netlify.app/privacy-policy.html`)
4. Free, no account needed

### Option 2: Vercel
1. Go to https://vercel.com
2. Sign up with GitHub
3. Import your repository
4. Deploy automatically
5. Get URL like `https://hype.vercel.app/privacy-policy.html`

### Option 3: GitHub Gist (Simple but less ideal)
1. Go to https://gist.github.com
2. Create a new gist with `privacy-policy.html` content
3. Use the "raw" URL (but this shows raw HTML, not formatted)

### Option 4: Your Own Domain/Website
If you have any website, just upload the HTML file there.

## Recommended: GitHub Pages

GitHub Pages is the best option because:
- ✅ Free
- ✅ Reliable
- ✅ Easy to update (just push changes)
- ✅ Professional URL
- ✅ Works great with your existing repo

## Quick Checklist

- [ ] Repository is public OR you have GitHub Pro
- [ ] `privacy-policy.html` is committed and pushed
- [ ] GitHub Pages enabled in Settings → Pages
- [ ] Branch set to `main` (or your default)
- [ ] Folder set to `/ (root)`
- [ ] Wait 1-2 minutes for deployment
- [ ] Test URL: `https://tggreene.github.io/hype/privacy-policy.html`

## Next Steps After Setup

Once your privacy policy is accessible:

1. **Test the URL** in a browser (make sure it loads)
2. **Add to App Store Connect:**
   - Go to your app → App Store tab
   - Scroll to "Privacy Policy URL"
   - Paste your GitHub Pages URL
   - Save

3. **You're done!** ✅
