import 'package:flutter/material.dart';

class CustomScrollingText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double speed; // pixels per second

  const CustomScrollingText({
    super.key,
    required this.text,
    this.style,
    this.speed = 50.0,
  });

  @override
  State<CustomScrollingText> createState() => _CustomScrollingTextState();
}

class _CustomScrollingTextState extends State<CustomScrollingText> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _controller;

  double _textWidth = 0;
  bool _scrollingStarted = false;

  final _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(vsync: this, duration: const Duration(hours: 1))..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.hasClients && _textWidth > 0) {
      final offset = _controller.value * _textWidth;
      _scrollController.jumpTo(offset % _textWidth);
    }
  }

  void _startScrolling() {
    if (!_scrollingStarted && _textWidth > 0) {
      _scrollingStarted = true;
      _controller.repeat(period: Duration(milliseconds: (_textWidth / widget.speed * 1000).toInt()));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
      if (textBox != null) {
        setState(() {
          _textWidth = textBox.size.width;
        });
        _startScrolling();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.style?.fontSize ?? 20,
      child: ListView.builder(
        key: const PageStorageKey('custom_scroll_text'),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Row(
            children: [
              Text(widget.text, key: index == 0 ? _textKey : null, style: widget.style),
              const SizedBox(width: 40),
            ],
          );
        },
        itemCount: 1000, // enough to create an endless loop effect
      ),
    );
  }
}
