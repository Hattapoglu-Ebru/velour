# Velour – Beauty & Fragrance Catalog

A Flutter-based mobile catalog app for cosmetics and fragrances. Built as part of a mobile development internship project, focusing on real-world UI patterns, navigation, and data modeling.

---

## Overview

Velour is a product catalog app featuring 16 premium beauty products across six categories. Users can browse, search, filter by category, save favorites, and manage a shopping cart — all with smooth navigation and a clean gradient UI.

The project was an opportunity to put several Flutter concepts into practice at once: custom widgets, named routes with arguments, JSON-based data modeling, and state management without any external packages.

---

## Features

- **Product Grid** — 16 products displayed in a responsive 2-column grid with cover images, brand labels, star ratings, and New/Bestseller badges
- **Search** — real-time filtering by product name, brand, or tag
- **Category Filter** — horizontal chip bar to filter by Fragrance, Lips, Eyes, Skincare, Base, or Cheeks
- **Product Detail** — full description, tags, star rating, review count, quantity selector, and add to cart
- **Cart** — add/remove items, adjust quantities, swipe-to-delete with Dismissible, order total calculation, and a checkout confirmation dialog
- **Wishlist** — save and manage favorite products, add directly to cart from the wishlist
- **Splash Screen** — animated logo intro with scale and fade transitions
- **Gradient UI** — pink-to-purple gradient theme applied consistently across all screens

---

## Project Structure
```
lib/
├── main.dart                       # App entry point & named route definitions
├── theme/
│   └── app_theme.dart              # Colors, gradients, ThemeData
├── models/
│   ├── product.dart                # Product model with fromJson / toJson
│   └── cart_item.dart              # Cart item model
├── data/
│   └── product_data.dart           # Simulated JSON dataset (16 products)
├── screens/
│   ├── splash_screen.dart          # Animated splash screen
│   ├── home_screen.dart            # Main screen: grid, search, category filter
│   ├── product_detail_screen.dart  # Product detail with Route Arguments
│   ├── cart_screen.dart            # Cart management screen
│   └── favorites_screen.dart       # Wishlist screen
└── widgets/
    ├── product_card.dart           # Reusable product card widget
    ├── category_chip.dart          # Category filter chip
    └── gradient_app_bar.dart       # Custom gradient AppBar widget
```

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

**Requirements:** Flutter 3.x, Dart 3.x
```bash
# Clone the repo
git clone https://github.com/Hattapoglu-Ebru/velour.git
cd velour

# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Or run on a connected device
flutter run
```

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
