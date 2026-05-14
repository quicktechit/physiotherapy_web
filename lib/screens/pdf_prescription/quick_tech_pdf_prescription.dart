
import 'dart:io';

import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatefulWidget {
  final Uint8List pdfBytes;
  
  PdfViewScreen({required this.pdfBytes});

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isLoading = true;
  bool _isDownloading = false;
  bool _isPrinting = false;
  int _currentPage = 0;
  int _totalPages = 0;

final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _downloadPdf() async {
    try {
      setState(() => _isDownloading = true);
      
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        Get.snackbar(
          'Permission Denied',
          'Storage permission is required to download the PDF.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        setState(() => _isDownloading = false);
        return;
      }

      // Get downloads directory
      final dir = await getDownloadsDirectory();
      if (dir == null) {
        Get.snackbar('Error', 'Could not access Downloads folder');
        setState(() => _isDownloading = false);
        return;
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${dir.path}/prescription_$timestamp.pdf';
      final file = File(filePath);
      await file.writeAsBytes(widget.pdfBytes);

      setState(() => _isDownloading = false);
      Get.snackbar(
        'Success',
        'PDF downloaded to Downloads folder',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      setState(() => _isDownloading = false);
      Get.snackbar('Error', 'Failed to download: ${e.toString()}');
    }
  }

  Future<void> _printPdf() async {
    try {
      setState(() => _isPrinting = true);
      await Printing.layoutPdf(
        onLayout: (format) async => widget.pdfBytes,
      );
      setState(() => _isPrinting = false);
    } catch (e) {
      setState(() => _isPrinting = false);
      Get.snackbar('Error', 'Failed to print: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = !themeController.isDay.value;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Prescription', style: myStyle(16, Colors.white, FontWeight.bold)),
                if (_totalPages > 0)
                  Text(
                    'Page $_currentPage of $_totalPages',
                    style: myStyle(12, Colors.white70, FontWeight.normal),
                  ),
              ],
            ),
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.lightmaincolor
            : QuickTechAppColors.darkmaincolor,
        foregroundColor: Colors.white,
        actions: [
          // Zoom In
          Tooltip(
            message: 'Zoom In',
            child: IconButton(
              icon: Icon(Icons.zoom_in, color: Colors.white),
              onPressed: () {
                _pdfViewerController.zoomLevel = (_pdfViewerController.zoomLevel) + 0.5;
              },
            ),
          ),
          // Zoom Out
          Tooltip(
            message: 'Zoom Out',
            child: IconButton(
              icon: Icon(Icons.zoom_out, color: Colors.white),
              onPressed: () {
                if ((_pdfViewerController.zoomLevel) > 1.0) {
                  _pdfViewerController.zoomLevel = (_pdfViewerController.zoomLevel) - 0.5;
                }
              },
            ),
          ),
          // Download
          Tooltip(
            message: 'Download PDF',
            child: IconButton(
              icon: _isDownloading
                  ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)))
                  : Icon(Icons.download, color: Colors.white),
              onPressed: _isDownloading ? null : _downloadPdf,
            ),
          ),
          // Print
          Tooltip(
            message: 'Print PDF',
            child: IconButton(
              icon: _isPrinting
                  ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)))
                  : Icon(Icons.print, color: Colors.white),
              onPressed: _isPrinting ? null : _printPdf,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaincolor
                            : QuickTechAppColors.darkmaincolor,
                      ),
                    ),
                  )
                : SfPdfViewer.memory(
                    widget.pdfBytes,
                    controller: _pdfViewerController,
                    canShowScrollHead: true,
                    canShowScrollStatus: true,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    scrollDirection: PdfScrollDirection.vertical,
                    onPageChanged: (PdfPageChangedDetails details) {
                      setState(() {
                        _currentPage = details.newPageNumber;
                      });
                    },
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      setState(() {
                        _totalPages = details.document.pages.count;
                        _currentPage = 1;
                      });
                      print('PDF loaded: ${details.document.pages.count} pages');
                    },
                  ),
          ),
          // Bottom Navigation Bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? QuickTechAppColors.bkdarktxtfld : QuickTechAppColors.bktxtfld,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Page
                Tooltip(
                  message: 'First Page',
                  child: IconButton(
                    icon: Icon(Icons.first_page,
                        color: themeController.isDay.value
                            ? QuickTechAppColors.lightmaincolor
                            : QuickTechAppColors.darkmaincolor),
                    onPressed: () => _pdfViewerController.firstPage(),
                  ),
                ),
                // Previous Page
                Tooltip(
                  message: 'Previous Page',
                  child: IconButton(
                    icon: Icon(Icons.navigate_before,
                        color: themeController.isDay.value
                            ? QuickTechAppColors.lightmaincolor
                            : QuickTechAppColors.darkmaincolor),
                    onPressed: () => _pdfViewerController.previousPage(),
                  ),
                ),
                // Page Count
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1)
                        : QuickTechAppColors.darkmaincolor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _totalPages > 0 ? '$_currentPage / $_totalPages' : '-',
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                      FontWeight.bold,
                    ),
                  ),
                ),
                // Next Page
                Tooltip(
                  message: 'Next Page',
                  child: IconButton(
                    icon: Icon(Icons.navigate_next,
                        color: themeController.isDay.value
                            ? QuickTechAppColors.lightmaincolor
                            : QuickTechAppColors.darkmaincolor),
                    onPressed: () => _pdfViewerController.nextPage(),
                  ),
                ),
                // Last Page
                Tooltip(
                  message: 'Last Page',
                  child: IconButton(
                    icon: Icon(Icons.last_page,
                        color: themeController.isDay.value
                            ? QuickTechAppColors.lightmaincolor
                            : QuickTechAppColors.darkmaincolor),
                    onPressed: () => _pdfViewerController.lastPage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }
}