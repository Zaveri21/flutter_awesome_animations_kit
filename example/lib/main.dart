import 'package:flutter/material.dart';
import 'package:flutter_awesome_animations_kit/flutter_awesome_animations_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Awesome Animations Kit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Home — lists every animation category
// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, dynamic>> _sections = [
    {
      'label': 'Entry Animations (ListView)',
      'subtitle': 'Staggered list animations with index',
      'icon': Icons.view_list,
      'route': 'list',
    },
    {
      'label': 'Attention Seekers',
      'subtitle': 'pulse & shake with repeatMode',
      'icon': Icons.notifications_active,
      'route': 'attention',
    },
    {
      'label': 'Animated Text',
      'subtitle': 'countUp · countDown · typing',
      'icon': Icons.text_fields,
      'route': 'text',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Animations Kit'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          final section = _sections[index];
          return FlutterAnimatedView(
            animationType: AnimationType.fadeInUp,
            index: index,
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(section['icon'] as IconData,
                    color: Colors.deepPurple),
                title: Text(section['label'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(section['subtitle'] as String),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  final route = section['route'] as String;
                  Widget screen;
                  if (route == 'list') {
                    screen = const ListAnimationsScreen();
                  } else if (route == 'attention') {
                    screen = const AttentionSeekersScreen();
                  } else {
                    screen = const AnimatedTextScreen();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => screen),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Entry Animations — all types shown as staggered ListViews
// ─────────────────────────────────────────────────────────────────────────────

class ListAnimationsScreen extends StatelessWidget {
  const ListAnimationsScreen({super.key});

  static const List<String> _types = [
    'fadeIn',
    'fadeInUp',
    'scale',
    'slideRTL',
    'slideLTR',
    'slideUp',
    'slideDown',
    'flip',
    'bounce',
    'scaleLTR',
    'scaleCenterZoomOut',
    'rotate',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entry Animations'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _types.length,
        itemBuilder: (context, index) {
          return FlutterAnimatedView(
            animationType: AnimationType.slideRTL,
            index: index,
            child: Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(_types[index],
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.play_arrow, color: Colors.deepPurple),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ListViewScreen(animationName: _types[index]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ListView demo — shows selected animation on 20 items
// ─────────────────────────────────────────────────────────────────────────────

class ListViewScreen extends StatelessWidget {
  final String animationName;

  const ListViewScreen({super.key, required this.animationName});

  AnimationType _toType(String name) {
    switch (name) {
      case 'fadeIn':
        return AnimationType.fadeIn;
      case 'fadeInUp':
        return AnimationType.fadeInUp;
      case 'scale':
        return AnimationType.scale;
      case 'slideRTL':
        return AnimationType.slideRTL;
      case 'slideLTR':
        return AnimationType.slideLTR;
      case 'slideUp':
        return AnimationType.slideUp;
      case 'slideDown':
        return AnimationType.slideDown;
      case 'flip':
        return AnimationType.flip;
      case 'bounce':
        return AnimationType.bounce;
      case 'scaleLTR':
        return AnimationType.scaleLTR;
      case 'scaleCenterZoomOut':
        return AnimationType.scaleCenterZoomOut;
      case 'rotate':
        return AnimationType.rotate;
      default:
        return AnimationType.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = _toType(animationName);
    return Scaffold(
      appBar: AppBar(title: Text(animationName), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 20,
        itemBuilder: (context, index) {
          return FlutterAnimatedView(
            animationType: type,
            index: index,
            child: Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Text('${index + 1}',
                          style: const TextStyle(color: Colors.deepPurple)),
                    ),
                    const SizedBox(width: 12),
                    Text('Item ${index + 1}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Attention Seekers — pulse & shake with repeatMode: true
// ─────────────────────────────────────────────────────────────────────────────

class AttentionSeekersScreen extends StatelessWidget {
  const AttentionSeekersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attention Seekers'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('pulse — great for badges & buttons',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterAnimatedView(
                  animationType: AnimationType.pulse,
                  repeatMode: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('NEW',
                        style:
                            TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const FlutterAnimatedView(
                  animationType: AnimationType.pulse,
                  repeatMode: true,
                  duration: Duration(milliseconds: 800),
                  child: Icon(Icons.notifications,
                      size: 48, color: Colors.orange),
                ),
                const FlutterAnimatedView(
                  animationType: AnimationType.pulse,
                  repeatMode: true,
                  duration: Duration(milliseconds: 600),
                  child: Icon(Icons.favorite, size: 48, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text('shake — great for error states & alerts',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterAnimatedView(
                  animationType: AnimationType.shake,
                  repeatMode: true,
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Error!',
                        style:
                            TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const FlutterAnimatedView(
                  animationType: AnimationType.shake,
                  repeatMode: true,
                  duration: Duration(milliseconds: 800),
                  child: Icon(Icons.warning_amber_rounded,
                      size: 48, color: Colors.amber),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated Text — countUp, countDown, typing
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedTextScreen extends StatelessWidget {
  const AnimatedTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Text'), centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TextCard(
              label: 'countUp',
              child: FlutterAnimatedText(
                startValue: 0,
                endValue: 1000,
                animationType: TextAnimationType.countUp,
                duration: Duration(seconds: 2),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
            ),
            SizedBox(height: 16),
            _TextCard(
              label: 'countDown',
              child: FlutterAnimatedText(
                startValue: 0,
                endValue: 100,
                animationType: TextAnimationType.countDown,
                duration: Duration(seconds: 2),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            SizedBox(height: 16),
            _TextCard(
              label: 'countUp with precision (2 decimal places)',
              child: FlutterAnimatedText(
                startValue: 0,
                endValue: 99.99,
                precision: 2,
                animationType: TextAnimationType.countUp,
                duration: Duration(seconds: 2),
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(height: 16),
            _TextCard(
              label: 'typing',
              child: FlutterAnimatedText(
                normalText: 'Hello, Flutter World! 🚀',
                animationType: TextAnimationType.typing,
                duration: Duration(seconds: 3),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextCard extends StatelessWidget {
  final String label;
  final Widget child;

  const _TextCard({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
