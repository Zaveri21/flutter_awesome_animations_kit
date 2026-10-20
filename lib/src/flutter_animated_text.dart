import 'package:flutter/widgets.dart';

enum TextAnimationType { countUp, countDown, typing, none }

class FlutterAnimatedText extends StatefulWidget {
  /// Only required for countUp and countDown.
  final double? startValue;

  /// Only required for countUp and countDown.
  final double? endValue;

  /// Decimal places shown for countUp/countDown. Default: 0.
  final int precision;

  final TextAnimationType animationType;

  /// Default: Duration(seconds: 1).
  final Duration duration;

  final Curve curve;

  final TextStyle? style;

  /// Only required for typing and none animations.
  final String? normalText;

  /// Default: false.
  final bool repeatMode;

  const FlutterAnimatedText({
    super.key,
    this.startValue,
    this.endValue,
    this.animationType = TextAnimationType.none,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.style,
    this.normalText,
    this.precision = 0,
    this.repeatMode = false,
  });

  @override
  FlutterAnimatedTextState createState() => FlutterAnimatedTextState();
}

class FlutterAnimatedTextState extends State<FlutterAnimatedText>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;

  // CurvedAnimation stored as field so it can be properly disposed,
  // preventing status-listener leaks on _controller.
  CurvedAnimation? _curvedAnimation;

  Animation<double>? _countAnimation;
  Animation<double>? _typingAnimation;
  late Widget _animatedWidget;
  bool _wantKeepAlive = false;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _wantKeepAlive = !widget.repeatMode;
    _initializeAnimations();
    _startAnimation();
  }

  @override
  void dispose() {
    _curvedAnimation?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    // Reset so animation always plays from the beginning.
    _controller.reset();

    // Dispose old CurvedAnimation to remove its status listener from _controller.
    _curvedAnimation?.dispose();
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    final curved = _curvedAnimation!;

    _countAnimation = null;
    _typingAnimation = null;

    switch (widget.animationType) {
      case TextAnimationType.countUp:
        if (widget.startValue != null && widget.endValue != null) {
          _countAnimation = Tween<double>(
            begin: widget.startValue!,
            end: widget.endValue!,
          ).animate(curved);
          _animatedWidget = AnimatedBuilder(
            animation: _countAnimation!,
            builder: (context, child) => Text(
              _countAnimation!.value.toStringAsFixed(widget.precision),
              style: widget.style,
            ),
          );
        } else {
          _animatedWidget = Text('', style: widget.style);
        }
        break;

      case TextAnimationType.countDown:
        if (widget.startValue != null && widget.endValue != null) {
          _countAnimation = Tween<double>(
            begin: widget.endValue!,
            end: widget.startValue!,
          ).animate(curved);
          _animatedWidget = AnimatedBuilder(
            animation: _countAnimation!,
            builder: (context, child) => Text(
              _countAnimation!.value.toStringAsFixed(widget.precision),
              style: widget.style,
            ),
          );
        } else {
          _animatedWidget = Text('', style: widget.style);
        }
        break;

      case TextAnimationType.typing:
        final int textLength = widget.normalText?.length ?? 0;
        _typingAnimation = Tween<double>(
          begin: 0.0,
          end: textLength.toDouble(),
        ).animate(curved);
        _animatedWidget = AnimatedBuilder(
          animation: _typingAnimation!,
          builder: (context, child) {
            final int length = _typingAnimation!.value.toInt().clamp(
              0,
              textLength,
            );
            return Text(
              (widget.normalText ?? '').substring(0, length),
              style: widget.style,
            );
          },
        );
        break;

      case TextAnimationType.none:
        _animatedWidget = Text(widget.normalText ?? '', style: widget.style);
        break;
    }
  }

  void _startAnimation() {
    if (widget.repeatMode) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant FlutterAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    // Reinitialize whenever anything that affects the animation changes.
    final needsReinit =
        widget.animationType != oldWidget.animationType ||
        widget.repeatMode != oldWidget.repeatMode ||
        widget.curve != oldWidget.curve ||
        widget.startValue != oldWidget.startValue ||
        widget.endValue != oldWidget.endValue ||
        widget.normalText != oldWidget.normalText ||
        widget.precision != oldWidget.precision;

    if (needsReinit) {
      _wantKeepAlive = !widget.repeatMode;
      _initializeAnimations();
      _startAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _animatedWidget;
  }
}
