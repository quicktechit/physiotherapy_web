// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui;
import 'package:flutter/widgets.dart';

/// Creates a blob: URL from PDF bytes — browser renders it natively.
String createBlobUrl(Uint8List bytes) {
  final blob = html.Blob([bytes], 'application/pdf');
  return html.Url.createObjectUrlFromBlob(blob);
}

/// Releases the blob URL from memory.
void revokeBlobUrl(String url) {
  html.Url.revokeObjectUrl(url);
}

/// Registers an <iframe> pointing at the blob URL and returns an HtmlElementView.
Widget WebPdfView(String blobUrl) {
  final viewId = 'pdf-iframe-${blobUrl.hashCode}';

  // Register only once per unique URL
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(viewId, (int id) {
    final iframe = html.IFrameElement()
      ..src = blobUrl
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%';
    return iframe;
  });

  return SizedBox.expand(
    child: HtmlElementView(viewType: viewId),
  );
}


