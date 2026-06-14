import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class WebImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;

  const WebImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  @override
  State<WebImage> createState() => _WebImageState();
}

class _WebImageState extends State<WebImage> {
  late final String viewType;

  @override
  void initState() {
    super.initState();

    viewType = 'img-${widget.imageUrl.hashCode}';

    // register only ONCE
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) {
        final img = html.ImageElement()
          ..src = widget.imageUrl
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = _cssObjectFit(widget.fit)
          ..style.objectPosition = 'center'
          ..style.border = 'none'
          ..style.display = 'block';

        return img;
      },
    );
  }

  String _cssObjectFit(BoxFit fit) {
    switch (fit) {
      case BoxFit.fill:
        return 'fill';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.fitWidth:
        return 'cover';
      case BoxFit.fitHeight:
        return 'cover';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: HtmlElementView(
        viewType: viewType,
      ),
    );
  }
}
