import 'dart:typed_data';
import 'package:flutter/widgets.dart';

/// Creates a blob: URL from PDF bytes — not supported on mobile.
String createBlobUrl(Uint8List bytes) {
  return '';
}

/// Releases the blob URL from memory — no-op on mobile.
void revokeBlobUrl(String url) {
  // No-op on mobile platforms
}

/// Stub implementation for PDF view — not supported on mobile.
/// On mobile, use platform-specific PDF viewers instead.
Widget WebPdfView(String blobUrl) {
  return const Center(
    child: Text('PDF view not supported on this platform'),
  );
}
