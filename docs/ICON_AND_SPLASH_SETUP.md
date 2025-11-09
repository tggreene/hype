# App Icon & Splash Screen Setup Guide

## Tools for Creating Icons

### Online Tools (Easiest)
1. **AppIcon.co** (https://appicon.co)
   - Upload one 1024x1024 image
   - Generates all required sizes automatically
   - Free, no account needed
   - Downloads as a ready-to-use asset catalog

2. **IconKitchen** (https://icon.kitchen)
   - Google's tool for generating app icons
   - Free, supports multiple platforms
   - Can add adaptive icons with layers

3. **MakeAppIcon** (https://makeappicon.com)
   - Similar to AppIcon.co
   - Free, generates all sizes

### Design Tools
- **Figma** (free) - Create your icon, export at 1024x1024
- **Canva** (free) - Templates available, export at 1024x1024
- **Sketch** (paid) - Professional design tool
- **Photoshop/GIMP** - Full control

### Command Line Tools
- **ImageMagick** - Resize images programmatically
- **sips** (built into macOS) - Simple image processing

## Quick Start: Using AppIcon.co

1. **Create your icon** (1024x1024 PNG, no transparency for iOS)
2. **Go to** https://appicon.co
3. **Upload** your 1024x1024 image
4. **Select iOS** platform
5. **Download** the generated asset catalog
6. **In Xcode:**
   - Right-click `AppIcon.appiconset` in Assets.xcassets
   - Select "Show in Finder"
   - Replace the Contents.json and all image files with the downloaded ones

## Manual Setup in Xcode

### App Icon Sizes Needed:
- 20x20 (@2x, @3x) - Notification icons
- 29x29 (@2x, @3x) - Settings icons
- 40x40 (@2x, @3x) - Spotlight icons
- 60x60 (@2x, @3x) - App icon
- 76x76 (@2x) - iPad
- 83.5x83.5 (@2x) - iPad Pro
- 1024x1024 - App Store

### Steps:
1. Create a 1024x1024 PNG image (your master icon)
2. In Xcode, open `Assets.xcassets` → `AppIcon`
3. Drag your 1024x1024 image to the "App Store" slot
4. Xcode can auto-generate other sizes, or use online tools

## Splash Screen (Launch Screen)

For iOS 13+, you can create a launch screen using SwiftUI. The project is already configured with `UILaunchScreen_Generation = YES`.

### Option 1: Simple Launch Screen (Recommended)

Create a new SwiftUI view for the launch screen:

```swift
// LaunchScreenView.swift
import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            // Background color matching your app
            Color(red: 0.2, green: 0.2, blue: 0.3) // Example

            // Your app name or logo
            VStack {
                Text("Hype")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
}
```

Then update `HypeApp.swift` to show it initially:

```swift
@main
struct HypeApp: App {
    @State private var showLaunchScreen = true

    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showLaunchScreen = false
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
```

### Option 2: Asset Catalog Launch Image

1. In `Assets.xcassets`, create a new Image Set called "LaunchImage"
2. Add your launch screen image (full screen size)
3. Configure in Info.plist (but SwiftUI apps usually use the view approach)

### Option 3: Storyboard (Traditional)

Less common for SwiftUI, but you can create a LaunchScreen.storyboard if needed.

## Design Tips

### App Icon:
- Keep it simple and recognizable at small sizes
- Avoid text (it becomes unreadable)
- Use bold, contrasting colors
- Test at 60x60 to see how it looks on home screen
- No transparency (iOS will add rounded corners automatically)

### Splash Screen:
- Should match your app's first screen
- Keep it simple - just logo or app name
- Use your brand colors
- Don't make it too busy

## Quick Script to Generate Sizes

If you have a 1024x1024 icon, you can use this script:

```bash
# Save as scripts/generate_icon_sizes.sh
#!/bin/bash
INPUT="icon-1024.png"
OUTPUT_DIR="icon_output"

mkdir -p "$OUTPUT_DIR"

# Generate all required sizes
sizes=(20 29 40 60 76 1024)
for size in "${sizes[@]}"; do
    sips -z $((size*2)) $((size*2)) "$INPUT" --out "$OUTPUT_DIR/icon-${size}@2x.png"
    sips -z $((size*3)) $((size*3)) "$INPUT" --out "$OUTPUT_DIR/icon-${size}@3x.png"
done

# App Store size
sips -z 1024 1024 "$INPUT" --out "$OUTPUT_DIR/icon-1024.png"
```

## Recommended Workflow

1. **Design** your icon at 1024x1024 in Figma/Canva/Photoshop
2. **Export** as PNG
3. **Use AppIcon.co** to generate all sizes
4. **Replace** the AppIcon.appiconset contents in Xcode
5. **Create** a simple LaunchScreenView matching your app theme
6. **Test** on device to see how it looks
