import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class QuicktechAssessmentPdfView extends StatelessWidget {
  final int assessmentId;
  const QuicktechAssessmentPdfView({Key? key, required this.assessmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();
    final String? token = QuickTechAuthStorageService.getToken();
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    return Scaffold(
      appBar: AppBar(backgroundColor: themeController.isDay.value?QuickTechAppColors.lightmaincolor:QuickTechAppColors.darkmaincolor,
      foregroundColor: QuickTechAppColors.white,
        title: const Text('Assessment PDF'),
        actions: [
          Obx(() {
            final pdfBytes = patientController.assessmentPdfBytes.value;
            if (pdfBytes == null) return SizedBox.shrink();
            return Row(
              children: [
                IconButton(
                  icon: Icon(Icons.download),
                  tooltip: 'Download',
                  onPressed: () async {
                    final fileName = 'assessment_${assessmentId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
                    try {
                      String filePath = '';
                      // Request storage permission for Android
                      if (Platform.isAndroid) {
                        var status = await Permission.storage.status;
                        if (!status.isGranted) {
                          status = await Permission.storage.request();
                          if (!status.isGranted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Storage permission denied.')),
                            );
                            return;
                          }
                        }
                        // Save to /storage/emulated/0/Download
                        filePath = '/storage/emulated/0/Download/$fileName';
                      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
                        final downloadsDir = await getDownloadsDirectory();
                        if (downloadsDir == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not find Downloads folder.')),
                          );
                          return;
                        }
                        filePath = '${downloadsDir.path}/$fileName';
                      } else {
                        // For iOS, fallback to app documents directory
                        final dir = await getApplicationDocumentsDirectory();
                        filePath = '${dir.path}/$fileName';
                      }
                      final file = File(filePath);
                      await file.writeAsBytes(pdfBytes);
                      print('Downloaded to $filePath');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloaded to $filePath')),
                      );
                    } catch (e) {
                      print('Download failed: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Download failed: $e')),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.print),
                  tooltip: 'Print',
                  onPressed: () async {
                    try {
                      await Printing.layoutPdf(
                        onLayout: (format) async => pdfBytes,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Print failed: $e')),
                      );
                    }
                  },
                ),
              ],
            );
          }),
        ],
      ),
      body: FutureBuilder<String?>(
        future: patientController.fetchAssessmentPdf(assessmentId, token ?? ''),
        builder: (context, snapshot) {
          if (patientController.isAssessmentPdfLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (patientController.assessmentPdfError.isNotEmpty) {
            return Center(
              child: Text(
                'Error: ${patientController.assessmentPdfError.value}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (patientController.assessmentPdfBytes.value != null) {
            return SfPdfViewer.memory(patientController.assessmentPdfBytes.value!);
          } else {
            return const Center(child: Text('No PDF data available.'));
          }
        },
      ),
    );
  }
}
