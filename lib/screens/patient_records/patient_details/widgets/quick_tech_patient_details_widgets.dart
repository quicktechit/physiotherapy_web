import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/pdf_prescription/quick_tech_pdf_prescription.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/services/template_services/quick_tech_template_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';


final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

Widget customDetilsTile(String title, String detail) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title ',
              style: myStyle(
                14,
                QuickTechAppColors.lightmaincolor,
                FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                detail,
                style: myStyle(
                  12,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                  FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customPrescriptionListItem(BuildContext context, int patientId, Map<String, dynamic> prescription) {
  final prescriptionId = prescription['id'] ?? 5;
  final date = prescription['date'] ?? 'Unknown Date';
  final templateId = QuickTechTemplateStorageService.getSelectedTemplateId();

  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
        ),
      ),
      tileColor: themeController.isDay.value
          ? QuickTechAppColors.bktxtfld
          : QuickTechAppColors.bkdarktxtfld,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ID:$prescriptionId",
            style: myStyle(
              15,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.bold,
            ),
          ),
          Text(
            "Date: $date",
            style: myStyle(
              15,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: patientController.isPdfLoading.value &&
              patientController.prescriptionPreviewPdfBytes.value != null
          ? CircularProgressIndicator()
          : null,
      onTap: () async {
        final token = QuickTechAuthStorageService.getToken();
        if (token == null) {
          Get.snackbar('Error', 'Authentication token not found');
          return;
        }

        if (templateId == null) {
          Get.snackbar('Wait!', 'No template selected. Please select a template first.',colorText: QuickTechAppColors.white,
            backgroundColor:QuickTechAppColors.lightmaincolor,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            icon: Icon(Icons.error_outline, color: Colors.white),
            duration: const Duration(seconds: 4),
          );
          return;
        }

        // Show loading dialog
        Get.dialog(
          Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        try {
          final String? errorMessage = await patientController.fetchPrescriptionPreviewPdf(prescriptionId, templateId, token);
          // Close loading dialog
          Get.back();
          if (patientController.prescriptionPreviewPdfBytes.value != null) {
            Get.to(
              () => PdfViewScreen(pdfBytes: patientController.prescriptionPreviewPdfBytes.value!),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 300),
            );
          } else if (errorMessage != null && errorMessage.isNotEmpty) {
            print('Error fetching PDF: $errorMessage');
            Get.snackbar(
              'Error',
              errorMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xFFff5252),
              colorText: Colors.white,
              margin: const EdgeInsets.all(16),
              borderRadius: 12,
              icon: Icon(Icons.error_outline, color: Colors.white),
              duration: const Duration(seconds: 4),
            );
          }
        } catch (e) {
          Get.back();
          Get.snackbar(
            'Error',
            'Failed to load PDF: ${e.toString()}',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    ),
  );
}
