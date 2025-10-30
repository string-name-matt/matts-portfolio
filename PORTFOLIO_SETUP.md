# Portfolio Web App - Setup & Customization Guide

## 🎨 Your New Impressive Portfolio

Congratulations! You now have a modern, professional web app portfolio built with Flutter and Firebase. This portfolio features:

- ✨ **Stunning Hero Section** with animated intro and gradient backgrounds
- 📊 **Animated Skills Showcase** with progress bars and categories
- 🚀 **Featured Projects Gallery** with detailed project cards and filtering
- 💼 **Professional About Section** with stats and highlights
- 🔐 **Resume Access Control** via Firebase authentication
- 🎯 **Modern Dark Theme** with smooth animations and transitions
- 📱 **Fully Responsive** design for mobile, tablet, and desktop

## 🔧 Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run the App

For web (recommended for portfolio):
```bash
flutter run -d chrome
```

For other platforms:
```bash
flutter run
```

## 📝 TODOs - Customize Your Portfolio

### ⚠️ REQUIRED - Update Personal Information

Open `lib/shared/constants.dart` and update:

```dart
// Personal Information (Line 4-8)
static const String name = 'Your Full Name';              // ✏️ UPDATE
static const String email = 'your.email@example.com';     // ✏️ UPDATE
static const String phone = '+1 (555) 123-4567';          // ✏️ UPDATE

// Social Links (Line 24-27)
static const String githubUrl = 'https://github.com/yourusername';     // ✏️ UPDATE
static const String linkedinUrl = 'https://linkedin.com/in/you';       // ✏️ UPDATE
static const String twitterUrl = 'https://twitter.com/you';            // ✏️ OPTIONAL
```

### 🎨 Add Your Assets

#### Profile Photo
1. Add your professional photo to: `assets/images/profile.png`
2. Uncomment the profile image code in `lib/features/home/widgets/hero_section.dart` (lines 56-63)

#### Project Screenshots
1. Create folder: `assets/images/projects/`
2. Add project images:
   - `healthpass_hero.png` - Hero image for HealthPass
   - `healthpass_thumb.png` - Thumbnail for HealthPass
   - `courthouse_hero.png` - Hero image for Courthouse Connect
   - `courthouse_thumb.png` - Thumbnail for Courthouse Connect
3. Update `pubspec.yaml` assets section (lines 50-51):
   ```yaml
   assets:
     - assets/images/profile.png
     - assets/images/projects/
   ```
4. Uncomment image code in project cards:
   - `lib/features/home/widgets/featured_projects_section.dart` (lines 107-117)
   - `lib/features/projects/project_screen.dart` (lines 237-248)

### 📋 Add More Projects

Edit `lib/shared/constants.dart`, line 72:

```dart
static const List<ProjectItem> projects = [
  // Your existing projects...

  // Add new project:
  ProjectItem(
    id: 'my-new-project',
    title: 'Your Project Name',
    shortDescription: 'Brief one-line description',
    fullDescription: 'Detailed description of your project...',
    technologies: ['Flutter', 'Firebase', 'etc'],
    features: [
      'Feature 1',
      'Feature 2',
      'Feature 3',
    ],
    imageUrl: 'assets/images/projects/your_project.png',
    thumbnailUrl: 'assets/images/projects/your_project_thumb.png',
    demoUrl: 'https://demo.yourproject.com',        // Add when ready
    githubUrl: 'https://github.com/you/project',    // Optional
    category: 'Full-Stack',  // Choose: Full-Stack, Enterprise, Mobile, Web, AI/ML
    featured: true,          // Show on home page?
    status: 'Live in Production',  // or 'In Development'
  ),
];
```

### 🔧 Customize Skills

Edit `lib/shared/constants.dart`, line 31:

```dart
static const Map<String, List<SkillItem>> skills = {
  'Your Category': [
    SkillItem(name: 'Skill Name', level: 0.90, icon: '📱'),
    // level is 0.0 to 1.0 (e.g., 0.90 = 90%)
  ],
};
```

### 🎨 Customize Colors & Theme

Edit `lib/shared/theme.dart`:

```dart
// Change primary colors (Line 8-11)
static const Color primaryBlue = Color(0xFF2563EB);    // Main brand color
static const Color accentPurple = Color(0xFF7C3AED);   // Accent color
```

### 📧 Enable Contact Features

#### Email Links
The contact section already shows your email from constants. To enable "mailto:" links:
1. The email is already displayed when clicking "Contact Me" button
2. Optional: Implement URL launcher for mailto: links in `lib/features/home/widgets/contact_section.dart`

#### Social Links
Update URLs in `constants.dart` and uncomment the launch URL code in `contact_section.dart` (lines 68-70, 80-82)

## 🚀 Deploy Your Portfolio

### Deploy to Firebase Hosting

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Build for web:
   ```bash
   flutter build web --release
   ```

4. Deploy:
   ```bash
   firebase init hosting  # First time only
   firebase deploy
   ```

### Deploy to GitHub Pages

1. Build:
   ```bash
   flutter build web --release --base-href "/your-repo-name/"
   ```

2. Copy `build/web` to `docs/` or use GitHub Actions

## 📂 Project Structure

```
lib/
├── features/
│   ├── home/
│   │   ├── home_screen.dart           # Main home page
│   │   └── widgets/
│   │       ├── hero_section.dart      # Animated hero with gradient
│   │       ├── skills_section.dart    # Skills with progress bars
│   │       ├── about_section.dart     # About me with stats
│   │       ├── featured_projects_section.dart  # Project cards
│   │       └── contact_section.dart   # CTA and social links
│   ├── projects/
│   │   └── project_screen.dart        # Full projects gallery
│   └── resume/
│       └── resume_screen.dart         # Protected resume viewer
├── shared/
│   ├── theme.dart                     # ✏️ Customize colors here
│   ├── constants.dart                 # ✏️ Update all content here
│   └── widgets/
│       └── app_scaffold.dart          # Navigation bar
└── app.dart                           # App configuration
```

## 🎯 Key Features Implemented

### Home Page Sections
1. **Hero Section** - Eye-catching intro with your photo, name, and CTA buttons
2. **About Section** - Your story with impressive stats (2000+ users, etc.)
3. **Skills Section** - Animated skill bars grouped by category
4. **Featured Projects** - Your best work with hover effects
5. **Contact Section** - CTA card with social links

### Projects Page
- Filterable project gallery by category
- Detailed project cards with tech stack
- Modal dialogs with full project details
- Hover animations and smooth transitions

### Resume Page
- Firebase authentication required
- Access request form for visitors
- Markdown resume rendering

## 🎨 Design Features

- **Modern Dark Theme** - Professional look with blue/purple gradients
- **Smooth Animations** - Fade-ins, slides, hover effects
- **Responsive Design** - Perfect on mobile, tablet, desktop
- **Professional Typography** - Google Fonts (Inter)
- **Accessibility** - Semantic HTML, proper contrast ratios

## 🔒 Firebase Setup

Your Firebase is already configured for web. To add mobile support:

1. Add Android/iOS Firebase config files
2. Update `lib/firebase_options.dart`
3. See [Firebase Flutter docs](https://firebase.google.com/docs/flutter/setup)

## 📞 Support

If you need help customizing your portfolio, refer to:
- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- TODOs marked throughout the code with `// TODO:`

## ✅ Checklist Before Going Live

- [ ] Update all personal info in `constants.dart`
- [ ] Add profile photo
- [ ] Add project screenshots
- [ ] Update social media links
- [ ] Test all navigation links
- [ ] Test on mobile, tablet, desktop
- [ ] Set up Firebase Hosting or GitHub Pages
- [ ] Add your custom domain (optional)
- [ ] Enable Google Analytics (optional)

## 🎉 You're All Set!

Your portfolio is ready to impress employers and clients. Good luck! 🚀
