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
