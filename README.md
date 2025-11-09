# Hype

A simple, beautiful iOS app that delivers positive affirmations to boost your confidence and motivation. Tap to cycle through empowering messages and listen to encouraging audio affirmations.

## Features

- Minimalist interface
- Inspiring affirmations
- Audio affirmations for a powerful experience
- Tap to discover new empowering messages
- Perfect for daily motivation and self-care

## Getting Started

### Requirements

- Xcode 15.2 or later
- iOS 17.0 or later
- macOS 14.0 or later

### Building

1. Clone the repository
2. Open `Hype.xcodeproj` in Xcode
3. Select your development team in Signing & Capabilities
4. Build and run (⌘R)

## Project Structure

```
Hype/
├── Hype/                    # Main app source code
│   ├── HypeApp.swift        # App entry point
│   ├── ContentView.swift    # Main view with affirmations
│   ├── LaunchScreenView.swift
│   └── Resources/           # Audio affirmation files
├── scripts/                 # Automation scripts
├── docs/                    # Documentation
└── screenshots/             # App Store screenshots
```

## Documentation

All documentation is available in the [`docs/`](docs/) directory:

### App Store Submission
- [App Store Listing Content](docs/APP_STORE_LISTING.md) - App description, keywords, and listing content
- [Submission Checklist](docs/SUBMISSION_CHECKLIST.md) - Step-by-step submission guide
- [Final Steps](docs/FINAL_STEPS.md) - Final submission steps
- [Build Status Guide](docs/BUILD_STATUS_GUIDE.md) - How to check build status
- [Review Notifications](docs/REVIEW_NOTIFICATIONS.md) - Email notification setup

### Setup & Configuration
- [Audio Setup](docs/AUDIO_SETUP.md) - How to add/update audio affirmations
- [Icon & Splash Setup](docs/ICON_AND_SPLASH_SETUP.md) - App icon and launch screen guide
- [Privacy Policy](docs/PRIVACY_POLICY.md) - Privacy policy template
- [GitHub Pages Setup](docs/GITHUB_PAGES_SETUP.md) - Hosting privacy policy

### Scripts

Automation scripts are available in the [`scripts/`](scripts/) directory:

- `archive_app.sh` - Archive the app for App Store submission
- `take_screenshots_simple.sh` - Take App Store screenshots
- `resize_screenshots.sh` - Resize screenshots to required dimensions

See individual script files for usage instructions.

## License

Copyright © 2025

## Contact

For questions or support, visit: https://github.com/tggreene/hype
