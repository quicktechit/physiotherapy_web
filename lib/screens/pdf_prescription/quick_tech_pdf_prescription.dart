
import 'package:e_prescription/screens/pdf_prescription/custom_pdf_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class PdfViewScreen extends StatefulWidget {
  final Uint8List pdfBytes;
  const PdfViewScreen({required this.pdfBytes});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();


  int _currentPage = 1;
  int _totalPages = 0;
  String? _webPdfUrl;

  @override
  void initState() {
    super.initState();
    debugPrint('PdfViewScreen: ${widget.pdfBytes.length} bytes');
    debugPrint('First 4 bytes: ${widget.pdfBytes.take(4).toList()}');
    if (kIsWeb) {
      _webPdfUrl = createBlobUrl(widget.pdfBytes);
    }
  }

  @override
  void dispose() {
    if (kIsWeb && _webPdfUrl != null) revokeBlobUrl(_webPdfUrl!);
    _pdfViewerController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDay = themeController.isDay.value;
      final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;

      return Scaffold(
        backgroundColor: isDay ? const Color(0xFFF4F6FA) : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prescription', style: myStyle(16, Colors.white, FontWeight.bold)),
              if (!kIsWeb && _totalPages > 0)
                Text('Page $_currentPage of $_totalPages',
                    style: const TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
          
        ),
        body: widget.pdfBytes.isEmpty
            ? _emptyState()
            : kIsWeb
                ? _buildWebViewer()
                : _buildMobileViewer(mainColor),
      );
    });
  }

  Widget _buildWebViewer() {
    if (_webPdfUrl == null) return _emptyState(message: 'Could not prepare PDF.');
    return buildWebPdfView(_webPdfUrl!);
  }

  Widget _buildMobileViewer(Color mainColor) {
    return Column(
      children: [
        Expanded(
          child: SfPdfViewer.memory(
            widget.pdfBytes,
            controller: _pdfViewerController,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            pageLayoutMode: PdfPageLayoutMode.single,
            scrollDirection: PdfScrollDirection.vertical,
            onPageChanged: (d) { if (mounted) setState(() => _currentPage = d.newPageNumber); },
            onDocumentLoaded: (d) {
              if (mounted) setState(() { _totalPages = d.document.pages.count; _currentPage = 1; });
            },
            onDocumentLoadFailed: (d) {
              debugPrint('PDF load failed: ${d.error} — ${d.description}');
              Get.snackbar('Load Failed', d.description,
                  backgroundColor: Colors.red, colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ),
        _buildNavBar(mainColor),
      ],
    );
  }

  Widget _buildNavBar(Color mainColor) {
    return Container(
      decoration: BoxDecoration(
        color: themeController.isDay.value ? Colors.white : const Color(0xFF1E2230),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navBtn(Icons.first_page, 'First Page', mainColor, () => _pdfViewerController.firstPage()),
          _navBtn(Icons.navigate_before, 'Previous', mainColor, () => _pdfViewerController.previousPage()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(color: mainColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
            child: Text(_totalPages > 0 ? '$_currentPage / $_totalPages' : '— / —',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainColor)),
          ),
          _navBtn(Icons.navigate_next, 'Next', mainColor, () => _pdfViewerController.nextPage()),
          _navBtn(Icons.last_page, 'Last Page', mainColor, () => _pdfViewerController.lastPage()),
        ],
      ),
    );
  }

  Widget _navBtn(IconData icon, String tooltip, Color color, VoidCallback onPressed) =>
      Tooltip(message: tooltip, child: IconButton(icon: Icon(icon, color: color), onPressed: onPressed));

  Widget _emptyState({String message = 'No PDF data received'}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.picture_as_pdf_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(fontSize: 16, color: Colors.grey[500])),
          const SizedBox(height: 8),
          Text('Please go back and try again', style: TextStyle(fontSize: 13, color: Colors.grey[400])),
        ],
      ),
    );
  }
}
