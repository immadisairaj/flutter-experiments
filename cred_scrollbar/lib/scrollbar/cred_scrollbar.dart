import 'package:cred_scrollbar/scrollbar/src/four_star_scroll.dart';
import 'package:cred_scrollbar/scrollbar/src/movebar.dart';
import 'package:flutter/material.dart';

class CredScrollbar extends StatefulWidget {
  const CredScrollbar({
    super.key,
    required this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  State<CredScrollbar> createState() => _CredScrollbarState();
}

class _CredScrollbarState extends State<CredScrollbar> {
  double scrollPercent = 0.0;

  void scrollListen() {
    final maxScroll = widget.scrollController!.position.maxScrollExtent;
    final currentScroll = widget.scrollController!.position.pixels;
    final percent = currentScroll / maxScroll * 100;
    setState(() {
      scrollPercent = (percent).clamp(0.0, 100.0);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController!.addListener(scrollListen);
  }

  @override
  void dispose() {
    widget.scrollController!.removeListener(scrollListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;

        return Stack(
          children: [
            Movebar(
              width: maxWidth,
              height: maxHeight,
              scrollPercent: scrollPercent,
            ),
            Movebar(
              width: 4 * maxWidth / 6,
              maxWidth: maxWidth,
              height: maxHeight,
              scrollPercent: scrollPercent,
            ),
            Movebar(
              width: 3 * maxWidth / 6,
              maxWidth: maxWidth,
              height: maxHeight,
              scrollPercent: scrollPercent,
            ),
            Movebar(
              width: maxWidth / 3,
              maxWidth: maxWidth,
              height: maxHeight,
              scrollPercent: scrollPercent,
            ),
            FourStarScroll(
              height: maxHeight,
              width: maxWidth / 3,
              maxWidth: maxWidth,
              scrollPercent: scrollPercent,
            )
          ],
        );
      }),
    );
  }
}
