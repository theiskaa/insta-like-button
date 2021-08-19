library insta_like_button;

import 'dart:async';

import 'package:flutter/material.dart';

/// ### Instagram post style, customizable card widget made for flutter.
///
/// Default Usage: (provided just required parameters).
/// ```dart
/// InstaLikeButton(
///  image: AssetImage("example/overview/img.jpg"),
///  onChanged: () {},
/// );
///
/// ```
/// Other properties which helps to customize [InstaLikeButton].
/// - `duration`, `curve`.
/// - `icon`, `iconColor`, `iconSize`.
/// - `height`, `width`.
/// - `onImageError`, `imageColorFilter`, `imageBoxfit`, `imageAlignment`, `imageScale`.
/// ---
class InstaLikeButton extends StatefulWidget {
  /// This property takes a photo, and builds the entire button on that photo.
  ///
  /// **Usage:**
  ///
  /// add photo by [AssetImage] widget from local path.
  /// ```dart
  /// InstaLikeButton(
  ///  image: AssetImage("assets/photo.png"),
  /// ...
  /// )
  /// ```
  /// or add photo by [NetworkImage] widget, from network.
  /// ```dart
  /// InstaLikeButton(
  ///  image: NetworkImage("https://picsum.photos/200/300"),
  /// ...
  /// )
  /// ```
  final ImageProvider<Object>? image;

  /// The user has tapped the screen with a primary button at the same location
  /// twice in quick succession.
  ///
  /// that's means `icon` will be displayed onto [image] in center.
  /// and would call something you provide within `onChanged` function
  final VoidCallback onChanged;

  /// The icon which would be displayed onto image in center.
  /// as default icon is [Icons.favorite].
  /// If user wanna customize it, then should use it.
  final IconData icon;

  /// The icon's color. as default it equals `Colors.grey[200]`.
  /// If user wanna customize it, then should use it.
  final Color? iconColor;

  /// Height of [InstaLikeButton].
  final double? height;

  /// width of [InstaLikeButton].
  final double? width;

  /// Animation duration. As default it equals [Duration(milliseconds: 500)].
  /// If user wanna customize it, then should use it.
  final Duration? duration;

  /// Curve of like animation. As default it equals [Curves.easeInOut].
  /// If user wanna customize it, then should use it.
  final Curve curve;

  /// size of icon. As default it equals 120
  /// If user wanna customize it, then should use it.
  final double iconSize;

  /// An optional error callback for errors emitted when loading [image].
  final Function(Object, StackTrace?)? onImageError;

  /// A color filter to apply to the image before painting it.
  final ColorFilter? imageColorFilter;

  ///How the [image] should be inscribed into the box.
  final BoxFit? imageBoxfit;

  ///How to align the image within its bounds.
  /// The alignment aligns the given position in the image to the given position in the layout bounds.
  final AlignmentGeometry imageAlignment;

  /// Defines image pixels to be shown per logical pixels.
  ///
  /// By default the value of scale is 1.0.
  /// The scale for the image is calculated by multiplying [scale]
  /// with scale of the given [ImageProvider].
  final double imageScale;

  InstaLikeButton({
    required this.image,
    required this.onChanged,

    ///
    this.icon = Icons.favorite,
    this.iconColor = const Color(0xFFF5F5F5),
    this.height = 300,
    this.width,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.iconSize = 120,
    this.onImageError,
    this.imageColorFilter,
    this.imageBoxfit,
    this.imageAlignment = Alignment.center,
    this.imageScale = 1.0,
  });
  @override
  _InstaLikeButtonState createState() => _InstaLikeButtonState();
}

class _InstaLikeButtonState extends State<InstaLikeButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconSizeAnimation;

  // Curve to set animating style of [_iconSizeAnimation].
  late Animation _curve;

  bool _isTapped = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Initilaze animation controller.
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curve = CurvedAnimation(parent: _animationController, curve: widget.curve);

    _iconSizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        // First act is animating [widget.iconSize - 20] to [widget.iconSize].
        TweenSequenceItem(
          weight: widget.iconSize,
          tween: Tween<double>(
            begin: widget.iconSize - 20,
            end: widget.iconSize,
          ),
        ),

        // Second act is animating [widget.iconSize] to [widget.iconSize - 20].
        TweenSequenceItem(
          weight: widget.iconSize,
          tween: Tween<double>(
            begin: widget.iconSize,
            end: widget.iconSize - 20,
          ),
        ),
      ],

      // Animate with [_curve].
    ).animate(_curve as Animation<double>);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => GestureDetector(
        onDoubleTap: () => onAct(),
        onDoubleTapCancel: () => onActCancel(),
        child: buttonBody(context),
      ),
    );
  }

  // The body of button.
  Container buttonBody(BuildContext context) => Container(
        height: widget.height,
        width: (widget.width != null)
            ? widget.width
            : MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.image!,
            onError: widget.onImageError,
            colorFilter: widget.imageColorFilter,
            fit: widget.imageBoxfit,
            scale: widget.imageScale,
            alignment: widget.imageAlignment,
          ),
        ),
        child: Center(child: buildAnimatedIcon()),
      );

  // The animated icon.
  AnimatedOpacity buildAnimatedIcon() => AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _isTapped ? 1 : 0,
        child: Icon(widget.icon,
            size: _iconSizeAnimation.value, color: widget.iconColor),
      );

  // Custom act method which would be used into [onDoubleTap].
  void onAct() {
    // First change [_isTapped] to `true`.
    setState(() => _isTapped = true);

    // Wait 80 milisecond and forward [_animationController]
    Timer(
      const Duration(milliseconds: 80),
      () => _animationController.forward(),
    );

    // Then should call [widget.onTap] function.
    widget.onChanged();

    // Wait one sec.
    // and change [_isTapped] to `false`.
    // and reverse the [_animationController].
    Timer(const Duration(seconds: 1), () {
      setState(() => _isTapped = false);
      _animationController.reverse();
    });
  }

  void onActCancel() => Timer(
        const Duration(seconds: 1),
        () {
          setState(() => _isTapped = false);
          _animationController.reverse();
        },
      );
}
