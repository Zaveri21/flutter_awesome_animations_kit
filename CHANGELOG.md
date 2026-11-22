## 0.0.6

- **Flutter 3.50.1 support:** Verified on Flutter 3.50.1 / Dart 3.14.0. Minimum SDK raised to Flutter ≥ 3.50.1 / Dart ≥ 3.14.0 (keeps the TLS certificate security fix from 0.0.5, GHSA-frr6-h895-5pxp).
- **Fix:** Replaced deprecated `package:flutter/material.dart` import in the library with `package:flutter/widgets.dart` — resolves the pub.dev static analysis deprecation warning. The package no longer depends on Material.
- Example app and tests migrated to `package:material_ui`.
- Example Android project updated to Gradle 9.5.0, Android Gradle Plugin 9.3.1 and Kotlin 2.4.20 (required by Flutter 3.50).
- Bumped `flutter_lints` to 6.0.0.
- Updated package description to list all animation types.
- Added pub.dev `topics` and `screenshots` for better discoverability.
- Reduced published package size from 25 MB to 2 MB (build outputs excluded via `.pubignore`).
- No API changes.

## 0.0.5

- **Security:** Bumped minimum SDK to Dart ≥ 3.13.7 / Flutter ≥ 3.47.8 to address a Dart HTTPS certificate validation vulnerability. No API changes.

## 0.0.4
* Fixed `scaleLTR` and `scaleCenterZoomOut` animations not rendering with correct alignment.
* Fixed crash when `startValue`/`endValue` are null for countUp/countDown animations.
* Fixed `Timer` leak in `FlutterAnimatedView` — timer is now cancelled on dispose.
* Fixed `repeatMode` in `FlutterAnimatedView` now actually repeats the animation.
* Fixed `wantKeepAlive` logic in `FlutterAnimatedText` (was inverted).
* Fixed typing animation `substring` out-of-bounds with clamping.
* Removed `late` modifier from nullable `Animation` fields.
* Removed dead `isAnimationOn` code and commented-out blocks.
* Removed deprecated `library` directive from main export file.
* Updated Dart SDK constraint to `>=3.0.0 <4.0.0`.
* Updated Flutter SDK constraint to `>=3.10.0`.

## 0.0.3
* Readme file update.
* 📝 Minor documentation updated.


## 0.0.2
* Readme file update.
* 📝 Minor documentation updated.

## 0.0.1
* 🛠️ Flutter animated view widget integration.
* 🛠️ Flutter animated text widget integration.
* 📝 documentation updated.
