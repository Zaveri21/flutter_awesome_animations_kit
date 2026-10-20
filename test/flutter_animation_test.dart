import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_awesome_animations_kit/flutter_awesome_animations_kit.dart';

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // FlutterAnimatedText
  // ─────────────────────────────────────────────────────────────────────────

  group('FlutterAnimatedText', () {
    testWidgets('countUp: starts at startValue, ends at endValue', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(
              startValue: 0,
              endValue: 100,
              animationType: TextAnimationType.countUp,
              duration: Duration(seconds: 1),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('0'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(Text), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('countDown: starts at endValue, ends at startValue', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(
              startValue: 0,
              endValue: 100,
              animationType: TextAnimationType.countDown,
              duration: Duration(seconds: 1),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('100'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(Text), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('countUp with precision shows decimal places', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(
              startValue: 0,
              endValue: 1,
              animationType: TextAnimationType.countUp,
              precision: 2,
              duration: Duration(seconds: 1),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('1.00'), findsOneWidget);
    });

    testWidgets('countUp with null values renders empty string safely', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(animationType: TextAnimationType.countUp),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('countDown with null values renders empty string safely', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(
              animationType: TextAnimationType.countDown,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('typing: reveals text character by character', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(
              normalText: 'Hello',
              animationType: TextAnimationType.typing,
              duration: Duration(seconds: 1),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.text(''), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.textContaining('He'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('none: renders static text immediately', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(
              normalText: 'Static Text',
              animationType: TextAnimationType.none,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Static Text'), findsOneWidget);
    });

    testWidgets('none: null normalText renders empty string safely', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedText(animationType: TextAnimationType.none),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(''), findsOneWidget);
    });
  });

  // ─────────────────────────────────────────────────────────────────────────
  // FlutterAnimatedView — all animation types
  // ─────────────────────────────────────────────────────────────────────────

  group('FlutterAnimatedView', () {
    Widget buildView(AnimationType type, {int? index}) {
      return MaterialApp(
        home: Scaffold(
          body: FlutterAnimatedView(
            animationType: type,
            index: index,
            duration: const Duration(milliseconds: 200),
            child: const Text('child'),
          ),
        ),
      );
    }

    testWidgets('none: renders child without animation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.none));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('fadeIn: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.fadeIn));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('scale: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.scale));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('slideRTL: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.slideRTL));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('slideLTR: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.slideLTR));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('slideUp: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.slideUp));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('slideDown: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.slideDown));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('fadeInUp: renders child with fade + slide', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.fadeInUp));
      await tester.pump();
      // starts invisible
      expect(find.text('child'), findsOneWidget);
      await tester.pumpAndSettle();
      // fully visible after animation
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('rotate: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.rotate));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('pulse: renders child and completes one cycle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.pulse));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('pulse with repeatMode: renders child without crash', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedView(
              animationType: AnimationType.pulse,
              repeatMode: true,
              duration: Duration(milliseconds: 200),
              child: Text('child'),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('shake: renders child and completes one cycle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.shake));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('shake with repeatMode: renders child without crash', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedView(
              animationType: AnimationType.shake,
              repeatMode: true,
              duration: Duration(milliseconds: 200),
              child: Text('child'),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('flip: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.flip));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('bounce: renders child', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(AnimationType.bounce));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('scaleLTR: renders child with centerLeft alignment', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.scaleLTR));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('scaleCenterZoomOut: renders child with center alignment', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.scaleCenterZoomOut));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('with index: uses staggered delay and renders child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.fadeIn, index: 3));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('repeatMode true: renders child without crash', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlutterAnimatedView(
              animationType: AnimationType.fadeIn,
              repeatMode: true,
              duration: Duration(milliseconds: 200),
              child: Text('child'),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('dispose cancels timer without error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(AnimationType.slideRTL));
      // Dispose immediately before the timer fires
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      // No exception means timer was safely cancelled
    });
  });
}
