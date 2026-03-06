---

## Technical Highlights

| Topic | Implementation |
|---|---|
| State Management | `setState` — local state, no external packages |
| Navigation | `Navigator.push` + `MaterialPageRoute` + Named Routes |
| Data Passing | Route Arguments via `ModalRoute.of(context).settings.arguments` |
| Data Modeling | `fromJson` / `toJson` methods simulating an API response |
| UI Components | `SliverAppBar`, `SliverGrid`, `Dismissible`, `CustomScrollView` |
| Animations | `AnimationController` with `CurvedAnimation` on splash screen |

---

## Getting Started

**Requirements:** Flutter 3.41.4, Dart 3.11.1
```bash
# Clone the repo
git clone https://github.com/Hattapoglu-Ebru/velour.git
cd velour

# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Or run on a connected device / emulator
flutter run
```

---

## Live Demo

🌐 [velourmakeup.netlify.app](https://velourmakeup.netlify.app)

---

## Dependencies

No third-party packages were used beyond the Flutter SDK defaults. Everything — layout, navigation, animations, state — is built with `material.dart`.
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
```

---

## Screens

| Screen | Description |
|---|---|
| Splash | Animated logo with scale + fade transition |
| Home | Product grid with search bar and category chips |
| Detail | Full product info, quantity selector, add to cart |
| Cart | Item management with swipe-to-delete and checkout |
| Wishlist | Saved products with quick add-to-cart option |

---

