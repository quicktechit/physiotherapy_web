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
  @override
  Widget build(BuildContext context) {
    // On mobile platforms, use the standard Image widget
    return Image.network(
      widget.imageUrl,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image),
        );
      },
    );
  }
}
