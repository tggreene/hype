# Screenshot Resizing Guide

App Store Connect requires screenshots in specific dimensions. This guide helps you resize your screenshots to meet those requirements.

## Required Dimensions

App Store Connect accepts these exact dimensions:
- **1242 × 2688px** (iPhone 6.5" portrait - iPhone 11 Pro Max, XS Max)
- **2688 × 1242px** (iPhone 6.5" landscape)
- **1284 × 2778px** (iPhone 6.7" portrait - iPhone 14 Pro Max, 15 Pro Max)
- **2778 × 1284px** (iPhone 6.7" landscape)

## Quick Resize

Run the resize script:

```bash
./scripts/resize_screenshots.sh
```

This will:
1. Find all PNG files in the `screenshots/` folder
2. Create resized versions in `screenshots/app_store/`
3. Generate all 4 required dimensions for each screenshot

## Which Dimensions to Use?

**For iPhone apps (portrait):**
- Use **1284 × 2778px** (iPhone 6.7") - most modern iPhones
- OR **1242 × 2688px** (iPhone 6.5") - older/larger iPhones

**For iPhone apps (landscape):**
- Use **2778 × 1284px** (iPhone 6.7" landscape)
- OR **2688 × 1242px** (iPhone 6.5" landscape)

**Recommendation:** Start with **1284 × 2778px** (portrait) as it covers the most devices.

## Manual Resize (Alternative)

If you prefer to resize manually or use a different tool:

### Using macOS Preview:
1. Open screenshot in Preview
2. Tools → Adjust Size
3. Enter width: 1284, height: 2778
4. Uncheck "Scale proportionally" (or keep it checked if you want to maintain aspect ratio)
5. Save

### Using sips (command line):
```bash
# Resize to 1284x2778 (portrait)
sips -z 2778 1284 screenshot.png --out screenshot_resized.png

# Resize to 2778x1284 (landscape)
sips -z 1284 2778 screenshot.png --out screenshot_resized.png
```

## Important Notes

1. **Aspect Ratio:** Your original screenshots may not match these exact aspect ratios. The resize script will stretch/crop to fit. For best results:
   - Take screenshots on iPhone 15 Pro Max (which matches 1284x2778)
   - Or use the simulator at the correct device size

2. **Quality:** Resizing up (making images larger) may reduce quality. Resizing down is usually fine.

3. **Multiple Sizes:** You only need to provide ONE size per screenshot, not all four. Choose the one that matches your target devices.

## Workflow

1. **Take screenshots** using the screenshot scripts
2. **Resize them** using `./scripts/resize_screenshots.sh`
3. **Upload to App Store Connect** from the `screenshots/app_store/` folder
4. **Use the 1284x2778px versions** (or whichever size you prefer)

## Troubleshooting

**Q: Screenshots look stretched after resizing**
A: Your original aspect ratio doesn't match. Take new screenshots on iPhone 15 Pro Max simulator, or use a tool that crops instead of stretches.

**Q: Which dimension should I use?**
A: Use **1284 × 2778px** for portrait (most common). This covers iPhone 14 Pro Max, 15 Pro Max, and similar devices.

**Q: Do I need to provide all 4 dimensions?**
A: No, just one per screenshot. App Store Connect will accept any of the 4 listed dimensions.

