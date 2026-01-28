# Spikings - Ancient Egypt Educational App

A production-ready iOS SwiftUI application featuring rich educational content about Ancient Egypt with game-style UI, custom components, and offline-first architecture.

## Overview

Spikings is an immersive educational app that brings Ancient Egypt to life through:
- **20 Detailed Articles**: Comprehensive content covering pyramids, pharaohs, hieroglyphics, mythology, and more
- **20 Interactive Quests**: Step-by-step learning experiences with 6 stages each
- **Custom UI**: Ancient Egypt themed design with premium aesthetics
- **Progress Tracking**: Monitor your learning journey with statistics and achievements
- **Offline-First**: All content available without internet connection

## Features

### Core Functionality
- ✅ Rich article reading experience with multiple sections
- ✅ Interactive quest system with step-by-step progression
- ✅ Search and filter content by tags and difficulty
- ✅ Favorites system for bookmarking content
- ✅ Journal to track completed articles and quests
- ✅ Statistics dashboard with achievements
- ✅ Thematic screens: Pharaoh Timeline and Pyramid Explorer

### Monetization
- ✅ Free theme included (Desert Sands)
- ✅ Premium themes available for purchase ($1.99 each)
  - Golden Pharaoh
  - Night Nile
- ✅ In-app purchase flow with restore functionality

### Technical Features
- ✅ MVVM architecture with single MainViewModelSK
- ✅ JSON-driven content (no hardcoded data)
- ✅ UserDefaults persistence for progress
- ✅ Custom UI components (no default SwiftUI styles)
- ✅ SF Symbols for icons
- ✅ SwiftUI only (iOS 16+)

## Project Structure

```
Spikings/
├── App/
│   └── SpikingsApp.swift
├── Core/
│   ├── Models/
│   ├── ViewModels/
│   ├── Store/
│   ├── Persistence/
│   └── Loaders/
├── UI/
│   ├── Components/
│   ├── TabBar/
│   ├── Headers/
│   └── Cards/
├── Screens/
│   ├── Splash/
│   ├── Onboarding/
│   ├── Home/
│   ├── Articles/
│   ├── Tasks/
│   ├── Details/
│   ├── Journal/
│   ├── Search/
│   ├── Favorites/
│   ├── Stats/
│   ├── Settings/
│   └── About/
└── Resources/
    ├── Assets.xcassets/
    └── Data/
        ├── articles_sk.json
        └── tasks_sk.json
```

## File Naming Convention

All Swift files end with `SK` suffix:
- Views: `HomeViewSK`, `ArticleCardSK`, etc.
- Models: `ArticleModelSK`, `TaskModelSK`, etc.
- ViewModels: `MainViewModelSK`

## Data Structure

### Articles (20 total)
Each article contains:
- Title, subtitle, cover image
- Multiple content sections
- Tags for categorization
- Estimated read time
- Premium flag

### Tasks (20 total)
Each task contains:
- Title, subtitle, cover image
- Difficulty level (easy/medium/hard)
- Exactly 6 steps
- Premium flag

## Setup Instructions

1. **Open in Xcode**
   - Open `Spikings.xcodeproj` in Xcode 14+
   - Set deployment target to iOS 16.0+

2. **Add Assets**
   - Review `ASSETS_DOCUMENTATION.txt` for required images
   - Add images to `Assets.xcassets` or use placeholder gradients

3. **Build and Run**
   - Select a simulator or device
   - Build and run the project

## Color Palette

The app uses an Ancient Egypt inspired color scheme:
- **Gold**: `#D4AF37` - Primary accent
- **Sand**: `#D4A574` - Desert tones
- **Deep Blue**: `#1B2845` - Night sky
- **Warm Orange**: `#E67E22` - Sunset
- **Dark Purple**: `#5C4B99` - Royal accents

## Themes

1. **Desert Sands** (Free)
   - Warm desert tones
   - Golden accents
   - Light background

2. **Golden Pharaoh** (Premium - $1.99)
   - Rich gold gradient
   - Royal atmosphere
   - Luxurious feel

3. **Night Nile** (Premium - $1.99)
   - Deep blue tones
   - Night sky aesthetic
   - Dark mode friendly

## Content Highlights

### Articles Include:
- Secrets of the Great Pyramid
- The Curse of the Pharaohs
- Hieroglyphics: The Sacred Script
- Cleopatra: Last Pharaoh of Egypt
- Mummification: Preserving the Dead
- The Valley of the Kings
- And 14 more...

### Quests Include:
- Build the Great Pyramid
- Decode Hieroglyphics
- Mummify a Pharaoh
- Navigate the Nile
- Construct a Temple
- Excavate a Tomb
- And 14 more...

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+
- SwiftUI

## Architecture

### MVVM Pattern
- **Single ViewModel**: `MainViewModelSK` manages all app state
- **Models**: Codable structs for data
- **Views**: SwiftUI views with no business logic

### Data Flow
1. JSON files loaded on app launch
2. Decoded into model objects
3. Published through MainViewModelSK
4. Views observe and react to changes

### Persistence
- UserDefaults for user progress
- Completed tasks and articles
- Favorites
- Theme selection
- Purchase status

## Notes

- All UI components are custom-built
- No external dependencies
- Offline-first design
- English language only
- No comments in code (clean, self-documenting)
- All views include #Preview blocks

## License

© 2026 Spikings. All rights reserved.
