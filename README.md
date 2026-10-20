# Flutter Awesome Animations Kit

Effortlessly animate any widget or list item by picking an animation type — no boilerplate, no complexity. 15 animation types, fully customizable. 🚀✨

<p>
  <a href="https://pub.dev/packages/flutter_awesome_animations_kit"><img src="https://img.shields.io/pub/v/flutter_awesome_animations_kit.svg" alt="pub version"/></a>
  <a href="https://pub.dev/packages/flutter_awesome_animations_kit/score"><img src="https://img.shields.io/pub/points/flutter_awesome_animations_kit" alt="pub points"/></a>
  <a href="https://pub.dev/packages/flutter_awesome_animations_kit/score"><img src="https://img.shields.io/pub/likes/flutter_awesome_animations_kit" alt="pub likes"/></a>
  <a href="https://pub.dev/packages/flutter_awesome_animations_kit/score"><img src="https://img.shields.io/pub/popularity/flutter_awesome_animations_kit" alt="pub popularity"/></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"/></a>
  <a href="https://github.com/Zaveri21/flutter_awesome_animations_kit/issues"><img src="https://img.shields.io/github/issues-raw/Zaveri21/flutter_awesome_animations_kit?style=flat" alt="GitHub issues"/></a>
  <img src="https://img.shields.io/github/last-commit/Zaveri21/flutter_awesome_animations_kit" alt="last commit"/>
</p>

---

## Preview

<table>
  <tr>
    <td><img src="https://github.com/Zaveri21/flutter_awesome_animations_kit/raw/main/gifs/animated_view1.gif" alt="Entry Animations Part 1" width="220"></td>
    <td><img src="https://github.com/Zaveri21/flutter_awesome_animations_kit/raw/main/gifs/animated_view2.gif" alt="Entry Animations Part 2" width="220"></td>
  </tr>
  <tr>
    <td align="center"><b>Entry Animations (1/2)</b><br/><sub>fadeIn · fadeInUp · scale · slideRTL · slideLTR · slideUp</sub></td>
    <td align="center"><b>Entry Animations (2/2)</b><br/><sub>slideDown · flip · bounce · scaleLTR · scaleCenterZoomOut · rotate</sub></td>
  </tr>
  <tr>
    <td><img src="https://github.com/Zaveri21/flutter_awesome_animations_kit/raw/main/gifs/animated_text.gif" alt="Animated Text" width="220"></td>
    <td><img src="https://github.com/Zaveri21/flutter_awesome_animations_kit/raw/main/gifs/animated_view_new.gif" alt="Attention Seekers" width="220"></td>
  </tr>
  <tr>
    <td align="center"><b>Animated Text</b><br/><sub>countUp · countDown · typing</sub></td>
    <td align="center"><b>Attention Seekers</b><br/><sub>pulse · shake</sub></td>
  </tr>
</table>

---

## Features

### FlutterAnimatedView
- 15 built-in animation types: `fadeIn`, `fadeInUp`, `scale`, `slideRTL`, `slideLTR`, `slideUp`, `slideDown`, `flip`, `bounce`, `scaleLTR`, `scaleCenterZoomOut`, `rotate`, `pulse`, `shake`, `none`
- Staggered ListView animations via the `index` parameter
- Fully customizable `duration`, `curve`, `repeatMode`, and `delayBetweenAnimation`

### FlutterAnimatedText
- 4 text animation types: `countUp`, `countDown`, `typing`, `none`
- Configurable `precision` for decimal counters
- Fully customizable `duration`, `curve`, `style`, and `repeatMode`

---

## Installation

```console
flutter pub add flutter_awesome_animations_kit
```

```dart
import 'package:flutter_awesome_animations_kit/flutter_awesome_animations_kit.dart';
```

> **Requires** Flutter ≥ 3.0.0 · Dart ≥ 2.17.0

---

## Quick Start

```dart
// Animate any widget
FlutterAnimatedView(
  animationType: AnimationType.fadeIn,
  child: const Text('Hello!'),
)

// Staggered ListView
ListView.builder(
  itemCount: 20,
  itemBuilder: (context, index) {
    return FlutterAnimatedView(
      index: index,
      animationType: AnimationType.slideRTL,
      child: ListTile(title: Text('Item $index')),
    );
  },
)

// Animated counter
FlutterAnimatedText(
  startValue: 0,
  endValue: 100,
  animationType: TextAnimationType.countUp,
)
```

---

## FlutterAnimatedView

### Animation Types

| Type                 | Description                    |
|----------------------|--------------------------------|
| `none`               | No animation                              |
| `fadeIn`             | Fade in                                   |
| `fadeInUp`           | Fade in + slide up simultaneously         |
| `scale`              | Scale up from center                      |
| `slideRTL`           | Slide from right to left                  |
| `slideLTR`           | Slide from left to right                  |
| `slideUp`            | Slide up from bottom                      |
| `slideDown`          | Slide down from top                       |
| `flip`               | 3D flip                                   |
| `bounce`             | Bounce                                    |
| `scaleLTR`           | Scale from left edge                      |
| `scaleCenterZoomOut` | Zoom out from center                      |
| `rotate`             | Full 360° spin into place                 |
| `pulse`              | Scale pulse — great with `repeatMode`     |
| `shake`              | Horizontal shake — great with `repeatMode`|

### Parameters

| Parameter               | Type            | Default                       | Description                                             |
|-------------------------|-----------------|-------------------------------|---------------------------------------------------------|
| `child`                 | `Widget`        | required                      | The widget to animate                                   |
| `animationType`         | `AnimationType` | `AnimationType.slideRTL`      | Animation to apply                                      |
| `duration`              | `Duration`      | `Duration(milliseconds: 500)` | Animation duration                                      |
| `curve`                 | `Curve`         | `Curves.easeInOut`            | Easing curve                                            |
| `index`                 | `int?`          | `null`                        | Item index for staggered ListView animations            |
| `repeatMode`            | `bool`          | `false`                       | Repeat animation continuously                           |
| `delayBetweenAnimation` | `Duration`      | `Duration(milliseconds: 50)`  | Delay before animation starts (used without `index`)    |

### Example — ListView

```dart
ListView.builder(
  itemCount: 20,
  itemBuilder: (context, index) {
    return FlutterAnimatedView(
      index: index,
      animationType: AnimationType.slideRTL,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        child: ListTile(title: Text('Item $index')),
      ),
    );
  },
)
```

### Example — Standalone Widget

```dart
FlutterAnimatedView(
  animationType: AnimationType.scale,
  repeatMode: true,
  duration: const Duration(milliseconds: 800),
  child: const Icon(Icons.star, size: 48),
)
```

---

## FlutterAnimatedText

### Animation Types

| Type        | Description                                         |
|-------------|-----------------------------------------------------|
| `countUp`   | Counts from `startValue` up to `endValue`           |
| `countDown` | Counts from `endValue` down to `startValue`         |
| `typing`    | Reveals `normalText` character by character         |
| `none`      | Displays static text                                |

### Parameters

| Parameter       | Type                | Default                  | Description                                    |
|-----------------|---------------------|--------------------------|------------------------------------------------|
| `animationType` | `TextAnimationType` | `TextAnimationType.none` | Animation to apply                             |
| `startValue`    | `double?`           | `null`                   | Start value (`countUp` / `countDown`)          |
| `endValue`      | `double?`           | `null`                   | End value (`countUp` / `countDown`)            |
| `precision`     | `int`               | `0`                      | Decimal places for count animations            |
| `normalText`    | `String?`           | `null`                   | Text for `typing` / `none`                     |
| `duration`      | `Duration`          | `Duration(seconds: 1)`   | Animation duration                             |
| `curve`         | `Curve`             | `Curves.easeInOut`       | Easing curve                                   |
| `style`         | `TextStyle?`        | `null`                   | Text style                                     |
| `repeatMode`    | `bool`              | `false`                  | Repeat animation continuously                  |

### Example

```dart
Row(
  children: [
    // Count up 0 → 100
    FlutterAnimatedText(
      startValue: 0,
      endValue: 100,
      animationType: TextAnimationType.countUp,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),

    // Count down 100 → 0 with decimal
    FlutterAnimatedText(
      startValue: 0,
      endValue: 100,
      precision: 1,
      animationType: TextAnimationType.countDown,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),

    // Typing effect
    FlutterAnimatedText(
      normalText: 'Hello World...',
      animationType: TextAnimationType.typing,
      duration: const Duration(seconds: 2),
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  ],
)
```

---

## Additional Information

- **Issues & feature requests**: [GitHub issue tracker](https://github.com/Zaveri21/flutter_awesome_animations_kit/issues)
- **Contributions**: Pull requests are welcome on [GitHub](https://github.com/Zaveri21/flutter_awesome_animations_kit)
- **Platforms**: Android ✅ · iOS ✅ · Web ✅

---

<p align="center">
  <b>If this package saved you time, a coffee would be appreciated ☕</b><br/><br/>
  <a href="https://www.buymeacoffee.com/vishaljhaveri" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45">
  </a>
  <br/><br/>
  <a href="/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
  </a>
  &nbsp;
  <b>MIT © <a href="https://github.com/Zaveri21">Vishal Zaveri</a></b>
</p>
