/// Converts plain text to HTML format with paragraph tags
/// Example: "Line 1\nLine 2" → "<p>Line 1</p><p>Line 2</p>"
String convertToHtmlParagraphs(String text) {
  final lines = text
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();
  
  if (lines.isEmpty) return '';
  
  return lines.map((line) => '<p>$line</p>').join('');
}

/// Strips HTML tags for UI display
/// Example: "<p>snacks</p><p>snnsjs</p>" → "snacks\nsnnsjs"
String stripHtmlTags(String htmlText) {
  if (htmlText.isEmpty) return '';
  
  // Remove <p>, </p>, <br>, <br/>, etc.
  String result = htmlText
      .replaceAll(RegExp(r'<p>', caseSensitive: false), '')
      .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]*>', caseSensitive: false), '');
  
  // Clean up multiple newlines and trim
  result = result.replaceAll(RegExp(r'\n\n+'), '\n').trim();
  
  return result;
}