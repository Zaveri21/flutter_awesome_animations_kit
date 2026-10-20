import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('HomeScreen displays all section cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Awesome Animations Kit'), findsOneWidget);
    expect(find.text('Entry Animations (ListView)'), findsOneWidget);
    expect(find.text('Attention Seekers'), findsOneWidget);
    expect(find.text('Animated Text'), findsOneWidget);
  });

  testWidgets('Navigates to ListAnimationsScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entry Animations (ListView)'));
    await tester.pumpAndSettle();

    expect(find.text('Entry Animations'), findsOneWidget);
  });

  testWidgets('Navigates to AttentionSeekersScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Attention Seekers'));
    await tester.pumpAndSettle();

    expect(find.text('Attention Seekers'), findsOneWidget);
  });

  testWidgets('Navigates to AnimatedTextScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Animated Text'));
    await tester.pumpAndSettle();

    expect(find.text('Animated Text'), findsOneWidget);
  });
}
