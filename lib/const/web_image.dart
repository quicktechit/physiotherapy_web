import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'dart:html' as html;

class WebImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const WebImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  String _cssObjectFit(BoxFit fit) {
    switch (fit) {
      case BoxFit.fill:
        return 'fill';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.fitWidth:
        return 'cover'; // closest CSS equivalent
      case BoxFit.fitHeight:
        return 'cover'; // closest CSS equivalent
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewType = 'img-${imageUrl.hashCode}';

    try {
      ui.platformViewRegistry.registerViewFactory(
        viewType,
        (int viewId) {
          final img = html.ImageElement()
            ..src = imageUrl
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.objectFit = _cssObjectFit(fit)
            ..style.objectPosition = 'center center'
            ..style.display = 'block'
            ..style.border = 'none'
            ..style.margin = '0'
            ..style.padding = '0';

          return img;
        },
      );
    } catch (_) {
      // Ignore if already registered
    }

    return SizedBox.expand(
      child: HtmlElementView(
        viewType: viewType,
      ),
    );
  }
}