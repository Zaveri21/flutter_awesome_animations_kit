import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

enum AnimationType {
  none,
  fadeIn,
  scale,
  slideRTL,
  slideLTR,
  slideUp,
  slideDown,
  flip,
  bounce,
  scaleLTR,
  scaleCenterZoomOut,
  fadeInUp,
  rotate,
  pulse,
  shake,
}

class FlutterAnimatedView extends StatefulWidget {
  final Widget child;

  final AnimationType animationType;

  /// Default: Duration(milliseconds: 500).
  final Duration duration;

  /// Default: Curves.easeInOut.
  final Curve curve;

  final int? index;

  /// Default: false.
  final bool repeatMode;

  /// Delay before animation starts when used without [index].
  /// Default: Duration(milliseconds: 50).
  final Duration delayBetweenAnimation;

  const FlutterAnimatedView({
    super.key,
    required this.child,
    this.index,
    this.animationType = AnimationType.slideRTL,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.repeatMode = false,
    this.delayBetweenAnimation = const Duration(milliseconds: 50),
  });

  @override
  FlutterAnimatedViewState createState() => FlutterAnimatedViewState();
}

class FlutterAnimatedViewState extends State<FlutterAnimatedView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;

  // CurvedAnimation stored as field so it can be properly disposed,
  // preventing status-listener leaks on _controller.
  CurvedAnimation? _curvedAnimation;

  Animation<double>? _fadeAnimation;
  Animation<double>? _scaleAnimation;
  Animation<Offset>? _slideAnimation;
  Animation<Offset>? _slideVerticalAnimation;
  Animation<double>? _flipAnimation;
  Animation<double>? _bounceAnimation;
  Animation<double>? _rotateAnimation;
  Animation<double>? _pulseAnimation;
  Animation<double>? _shakeAnimation;

  Timer? _delayTimer;
  bool _wantKeepAlive = false;
  late AnimationType _animationType;

  @override
  bool get wantKeepAlive => _wantKeepAlive;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _wantKeepAlive = !widget.repeatMode;
    _animationType = widget.animationType;
    _initAnimations();
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _curvedAnimation?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlutterAnimatedView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    final needsReinit =
        widget.animationType != oldWidget.animationType ||
        widget.curve != oldWidget.curve;

    if (needsReinit) {
      _animationType = widget.animationType;
      _wantKeepAlive = !widget.repeatMode;
      _initAnimations();
    } else if (widget.repeatMode != oldWidget.repeatMode) {
      // Animation type/curve unchanged — just restart with new repeat mode.
      _wantKeepAlive = !widget.repeatMode;
      _controller.reset();
      _delayTimer?.cancel();
      _delayTimer = Timer(widget.delayBetweenAnimation, () {
        if (!mounted) return;
        if (widget.repeatMode) {
          _controller.repeat();
        } else {
          _controller.forward();
        }
      });
    }
  }

  void _initAnimations() {
    // Reset controller so the animation always plays from the beginning,
    // even if this is called mid-animation from didUpdateWidget.
    _controller.reset();

    // Dispose old CurvedAnimation to remove its status listener from _controller.
    _curvedAnimation?.dispose();
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    final curved = _curvedAnimation!;

    _fadeAnimation = null;
    _scaleAnimation = null;
    _slideAnimation = null;
    _slideVerticalAnimation = null;
    _flipAnimation = null;
    _bounceAnimation = null;
    _rotateAnimation = null;
    _pulseAnimation = null;
    _shakeAnimation = null;

    switch (_animationType) {
      case AnimationType.none:
        break;

      case AnimationType.fadeIn:
        _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curved);
        break;

      case AnimationType.fadeInUp:
        _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curved);
        _slideVerticalAnimation = Tween<Offset>(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
        ).animate(curved);
        break;

      case AnimationType.scale:
        _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(curved);
        break;

      case AnimationType.scaleLTR:
        _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
        break;

      case AnimationType.scaleCenterZoomOut:
        _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
        break;

      case AnimationType.slideRTL:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curved);
        break;

      case AnimationType.slideLTR:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(curved);
        break;

      case AnimationType.slideUp:
        _slideVerticalAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(curved);
        break;

      case AnimationType.slideDown:
        _slideVerticalAnimation = Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(curved);
        break;

      case AnimationType.flip:
        _flipAnimation = Tween<double>(begin: 0, end: 1).animate(curved);
        break;

      case AnimationType.bounce:
        _bounceAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
        break;

      case AnimationType.rotate:
        _rotateAnimation = Tween<double>(
          begin: -2 * math.pi,
          end: 0,
        ).animate(curved);
        break;

      case AnimationType.pulse:
        _pulseAnimation = TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.15),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.15, end: 1.0),
            weight: 1,
          ),
        ]).animate(curved);
        break;

      case AnimationType.shake:
        // Uses _controller directly (no curve) for linear back-and-forth motion.
        _shakeAnimation = TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: -10),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: -10, end: 10),
            weight: 2,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 10, end: -10),
            weight: 2,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: -10, end: 10),
            weight: 2,
          ),
          TweenSequenceItem(tween: Tween<double>(begin: 10, end: 0), weight: 1),
        ]).animate(_controller);
        break;
    }

    final delay = widget.index != null
        ? Duration(milliseconds: 100 * ((widget.index ?? 0) % 12))
        : widget.delayBetweenAnimation;

    _delayTimer?.cancel();
    _delayTimer = Timer(delay, () {
      if (!mounted) return;
      if (widget.repeatMode) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget animatedWidget = widget.child;

    // fadeInUp sets both _fadeAnimation and _slideVerticalAnimation —
    // must be checked before the individual field checks below.
    if (_animationType == AnimationType.fadeInUp &&
        _fadeAnimation != null &&
        _slideVerticalAnimation != null) {
      animatedWidget = FadeTransition(
        opacity: _fadeAnimation!,
        child: SlideTransition(
          position: _slideVerticalAnimation!,
          child: widget.child,
        ),
      );
    } else if (_fadeAnimation != null) {
      animatedWidget = FadeTransition(
        opacity: _fadeAnimation!,
        child: widget.child,
      );
    } else if (_scaleAnimation != null &&
        _animationType == AnimationType.scale) {
      animatedWidget = ScaleTransition(
        scale: _scaleAnimation!,
        child: widget.child,
      );
    } else if (_scaleAnimation != null &&
        _animationType == AnimationType.scaleLTR) {
      animatedWidget = AnimatedBuilder(
        animation: _scaleAnimation!,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation!.value,
          alignment: Alignment.centerLeft,
          child: widget.child,
        ),
      );
    } else if (_scaleAnimation != null &&
        _animationType == AnimationType.scaleCenterZoomOut) {
      animatedWidget = AnimatedBuilder(
        animation: _scaleAnimation!,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation!.value,
          alignment: Alignment.center,
          child: widget.child,
        ),
      );
    } else if (_slideAnimation != null) {
      animatedWidget = SlideTransition(
        position: _slideAnimation!,
        child: widget.child,
      );
    } else if (_slideVerticalAnimation != null) {
      animatedWidget = SlideTransition(
        position: _slideVerticalAnimation!,
        child: widget.child,
      );
    } else if (_bounceAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _bounceAnimation!,
        builder: (context, child) {
          final double scale = (1.5 - (_bounceAnimation!.value * 0.5)).clamp(
            1.0,
            1.5,
          );
          return Transform.scale(scale: scale, child: widget.child);
        },
      );
    } else if (_flipAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _flipAnimation!,
        builder: (context, child) => Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_flipAnimation!.value * -math.pi),
          alignment: FractionalOffset.center,
          child: widget.child,
        ),
      );
    } else if (_rotateAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _rotateAnimation!,
        builder: (context, child) => Transform.rotate(
          angle: _rotateAnimation!.value,
          child: widget.child,
        ),
      );
    } else if (_pulseAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _pulseAnimation!,
        builder: (context, child) =>
            Transform.scale(scale: _pulseAnimation!.value, child: widget.child),
      );
    } else if (_shakeAnimation != null) {
      animatedWidget = AnimatedBuilder(
        animation: _shakeAnimation!,
        builder: (context, child) => Transform.translate(
          offset: Offset(_shakeAnimation!.value, 0),
          child: widget.child,
        ),
      );
    }

    return animatedWidget;
  }
}
