// lib/screens/templates/widgets/quick_tech_image_view.dart
import 'package:flutter/foundation.dart';

import 'package:e_prescription/const/web_image.dart';

import '../../../const/const.dart';

Widget customImageView(String imagePath) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Stack(
      children: [
        // Image viewer
        Center(
          child: kIsWeb
              ? _WebZoomableImage(imageUrl: imagePath)
              : InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 5.0,
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.broken_image_rounded,
                              color: Colors.white38, size: 64),
                          SizedBox(height: 12),
                          Text('Image unavailable',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
        ),

        // Top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.close, color: Colors.white, size: 20)),
                  const Spacer(),
                  const Text(
                    'Template Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Web-specific zoomable image using InteractiveViewer + WebImage
class _WebZoomableImage extends StatefulWidget {
  final String imageUrl;
  const _WebZoomableImage({required this.imageUrl});

  @override
  State<_WebZoomableImage> createState() => _WebZoomableImageState();
}

class _WebZoomableImageState extends State<_WebZoomableImage> {
  final TransformationController _transformController =
      TransformationController();
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Simulate load
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isLoaded = true);
    });
  }

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isLoaded ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      child: InteractiveViewer(
        transformationController: _transformController,
        minScale: 0.5,
        maxScale: 6.0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.85,
          child: WebImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
