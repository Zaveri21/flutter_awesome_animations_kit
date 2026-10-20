// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_awesome_animations_kit/flutter_awesome_animations_kit.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FlutterAnimatedView — wrap any widget to animate it on entry
// ─────────────────────────────────────────────────────────────────────────────

// Standalone widget
Widget standaloneExample() {
  return const FlutterAnimatedView(
    animationType: AnimationType.fadeIn,
    duration: Duration(milliseconds: 600),
    curve: Curves.easeInOut,
    child: Text('Hello!'),
  );
}

// ListView with staggered animation (index is required)
Widget listViewExample() {
  return ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) {
      return FlutterAnimatedView(
        index: index,
        animationType: AnimationType.slideRTL,
        child: ListTile(title: Text('Item $index')),
      );
    },
  );
}

// Continuous animation with repeatMode
Widget repeatExample() {
  return const FlutterAnimatedView(
    animationType: AnimationType.pulse,
    repeatMode: true,
    child: Icon(Icons.notifications, size: 32),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// FlutterAnimatedText — animate numeric counters or text
// ─────────────────────────────────────────────────────────────────────────────

// Count up from 0 to 100
const countUpExample = FlutterAnimatedText(
  startValue: 0,
  endValue: 100,
  animationType: TextAnimationType.countUp,
  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
);

// Count down from 100 to 0
const countDownExample = FlutterAnimatedText(
  startValue: 0,
  endValue: 100,
  animationType: TextAnimationType.countDown,
  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
);

// Count up with decimal precision
const precisionExample = FlutterAnimatedText(
  startValue: 0,
  endValue: 99.99,
  precision: 2,
  animationType: TextAnimationType.countUp,
  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
);

// Typing effect
const typingExample = FlutterAnimatedText(
  normalText: 'Hello, Flutter World!',
  animationType: TextAnimationType.typing,
  duration: Duration(seconds: 2),
  style: TextStyle(fontSize: 20),
);
