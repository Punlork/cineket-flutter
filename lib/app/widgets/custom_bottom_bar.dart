import 'package:flutter_floating_bottom_bar/src/bottom_bar_scroll_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef BackToTopIconBuilder = Widget Function(double width, double height);

class CustomBottomBar extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    ScrollController controller,
    VoidCallback showBottomBar,
    VoidCallback hideBottomBar,
  ) body;

  final Widget child;

  final BackToTopIconBuilder? icon;

  final double iconWidth;

  final double iconHeight;

  final Color barColor;

  final BoxDecoration? barDecoration;

  final BoxDecoration? iconDecoration;

  final double end;

  final double start;

  final double offset;

  final Duration duration;

  final Curve curve;

  final bool reverse;

  final double width;

  final BorderRadius borderRadius;

  final bool showIcon;

  final Alignment alignment;

  final Alignment barAlignment;

  final Function()? onBottomBarShown;

  final Function()? onBottomBarHidden;

  final bool scrollOpposite;

  final bool hideOnScroll;

  final StackFit fit;

  final Clip clip;

  const CustomBottomBar({
    required this.body,
    required this.child,
    this.icon,
    this.iconWidth = 30,
    this.iconHeight = 30,
    this.barColor = Colors.black,
    this.barDecoration,
    this.iconDecoration,
    this.end = 0,
    this.start = 2,
    this.offset = 10,
    this.duration = const Duration(milliseconds: 120),
    this.curve = Curves.linear,
    this.width = 300,
    this.borderRadius = BorderRadius.zero,
    this.showIcon = true,
    @Deprecated(
        'Use barAlignment instead, this will be removed in a future release')
    this.alignment = Alignment.bottomCenter,
    this.barAlignment = Alignment.bottomCenter,
    this.onBottomBarShown,
    this.onBottomBarHidden,
    this.reverse = false,
    this.scrollOpposite = false,
    this.hideOnScroll = true,
    this.fit = StackFit.loose,
    this.clip = Clip.hardEdge,
    Key? key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  ScrollController scrollBottomBarController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late bool isScrollingDown;
  late bool isOnTop;

  @override
  void initState() {
    isScrollingDown = widget.reverse;
    isOnTop = !widget.reverse;
    myScroll();
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, widget.start),
      end: Offset(0, widget.end),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _controller.forward();
  }

  void showBottomBar() {
    if (mounted) {
      setState(() {
        _controller.forward();
      });
    }
    if (widget.onBottomBarShown != null) widget.onBottomBarShown!();
  }

  void hideBottomBar() {
    if (mounted && widget.hideOnScroll) {
      setState(() {
        _controller.reverse();
      });
    }
    if (widget.onBottomBarHidden != null) widget.onBottomBarHidden!();
  }

  Future<void> myScroll() async {
    scrollBottomBarController.addListener(() {
      if (!widget.reverse) {
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (!isScrollingDown) {
            isScrollingDown = true;
            isOnTop = false;
            hideBottomBar();
          }
        }
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (isScrollingDown) {
            isScrollingDown = false;
            isOnTop = true;
            showBottomBar();
          }
        }
      } else {
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!isScrollingDown) {
            isScrollingDown = true;
            isOnTop = false;
            hideBottomBar();
          }
        }
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (isScrollingDown) {
            isScrollingDown = false;
            isOnTop = true;
            showBottomBar();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollBottomBarController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: widget.fit,
      alignment: widget.alignment,
      clipBehavior: widget.clip,
      children: [
        BottomBarScrollControllerProvider(
          scrollController: scrollBottomBarController,
          child: widget.body(
            context,
            scrollBottomBarController,
            showBottomBar,
            hideBottomBar,
          ),
        ),
        if (widget.showIcon)
          Align(
            alignment: widget.barAlignment,
            child: Padding(
              padding: EdgeInsets.all(widget.offset),
              child: AnimatedOpacity(
                duration: widget.duration,
                curve: widget.curve,
                opacity: isOnTop == true ? 0 : 1,
                child: AnimatedContainer(
                  duration: widget.duration,
                  curve: widget.curve,
                  width: isOnTop == true ? 0 : widget.iconWidth,
                  height: isOnTop == true ? 0 : widget.iconHeight,
                  decoration: widget.iconDecoration ??
                      BoxDecoration(
                        color: widget.barColor,
                        shape: BoxShape.circle,
                      ),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          scrollBottomBarController
                              .animateTo(
                            (!widget.scrollOpposite)
                                ? scrollBottomBarController
                                    .position.minScrollExtent
                                : scrollBottomBarController
                                    .position.maxScrollExtent,
                            duration: widget.duration,
                            curve: widget.curve,
                          )
                              .then((value) {
                            if (mounted) {
                              setState(() {
                                isOnTop = true;
                                isScrollingDown = false;
                              });
                            }
                            showBottomBar();
                          });
                        },
                        child: () {
                          if (widget.icon != null) {
                            return widget.icon!(
                                isOnTop == true ? 0 : widget.iconWidth / 2,
                                isOnTop == true ? 0 : widget.iconHeight / 2);
                          } else {
                            return Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                icon: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.white,
                                  size: isOnTop == true
                                      ? 0
                                      : widget.iconWidth / 2,
                                ),
                              ),
                            );
                          }
                        }(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        Align(
          alignment: widget.barAlignment,
          child: Padding(
            padding: EdgeInsets.all(widget.offset),
            child: SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: widget.width,
                decoration: widget.barDecoration ??
                    BoxDecoration(
                      color: widget.barColor,
                      borderRadius: widget.borderRadius,
                    ),
                child: Material(
                  color: widget.barColor,
                  child: widget.child,
                  borderRadius: widget.borderRadius,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
