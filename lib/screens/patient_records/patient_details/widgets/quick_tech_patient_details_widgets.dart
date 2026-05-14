// quick_tech_patient_details_widgets.dart
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/pdf_prescription/quick_tech_pdf_prescription.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/services/template_services/quick_tech_template_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../responsive.dart';

final QuickTechPatientController patientController =
    locator.get<QuickTechPatientController>();
final QuickTechThemeController themeController =
    locator.get<QuickTechThemeController>();

Widget customDetilsTile(String title, String detail) {
  return Obx(() {
    final isDark = !themeController.isDay.value;
    final mainColor = isDark
        ? QuickTechAppColors.darkmaincolor
        : QuickTechAppColors.lightmaincolor;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title ',
              style: TextStyle(
                  color: mainColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700)),
          Expanded(
            child: Text(detail,
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  });
}

Widget customPrescriptionListItem(
    BuildContext context, int patientId, Map<String, dynamic> prescription) {
  final prescriptionId = prescription['id'] ?? 5;
  final date = prescription['date'] ?? 'Unknown';
  final templateId = QuickTechTemplateStorageService.getSelectedTemplateId();
  final isDesktop = Responsive.isDesktop(context);

  return Obx(() {
    final isDark = !themeController.isDay.value;
    final mainColor = isDark
        ? QuickTechAppColors.darkmaincolor
        : QuickTechAppColors.lightmaincolor;

    return _PrescriptionCard(
      prescriptionId: prescriptionId,
      date: date,
      templateId: templateId,
      isDark: isDark,
      mainColor: mainColor,
      isDesktop: isDesktop,
    );
  });
}

class _PrescriptionCard extends StatefulWidget {
  final dynamic prescriptionId;
  final String date;
  final dynamic templateId;
  final bool isDark;
  final Color mainColor;
  final bool isDesktop;

  const _PrescriptionCard({
    required this.prescriptionId,
    required this.date,
    required this.templateId,
    required this.isDark,
    required this.mainColor,
    required this.isDesktop,
  });

  @override
  State<_PrescriptionCard> createState() => _PrescriptionCardState();
}

class _PrescriptionCardState extends State<_PrescriptionCard> {
  bool _hovered = false;

  Future<void> _openPrescription() async {
    final token = QuickTechAuthStorageService.getToken();
    if (token == null) {
      Get.snackbar('Error', 'Authentication token not found');
      return;
    }
    if (widget.templateId == null) {
      Get.snackbar(
        'Template Required',
        'Please select a template first.',
        backgroundColor: widget.mainColor,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        duration: const Duration(seconds: 4),
      );
      return;
    }

    Get.dialog(
      Center(
          child: CircularProgressIndicator(
              color: widget.mainColor, strokeWidth: 2.5)),
      barrierDismissible: false,
    );

    try {
      final error = await patientController.fetchPrescriptionPreviewPdf(
          widget.prescriptionId, widget.templateId, token);
          
      Get.back();
      if (patientController.prescriptionPreviewPdfBytes.value != null) {
        Get.off(
          () => PdfViewScreen(
              pdfBytes: patientController.prescriptionPreviewPdfBytes.value!),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 300),
        );
      } else if (error != null && error.isNotEmpty) {
        Get.snackbar('Error', error,
            backgroundColor: const Color(0xFFEF4444), colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to load PDF: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _openPrescription,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          padding: EdgeInsets.all(widget.isDesktop ? 20.w : 16.w),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: _hovered
                  ? widget.mainColor.withValues(alpha: 0.5)
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.07)
                      : const Color(0xFFE2E8F0)),
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.1 : 0.04),
                blurRadius: _hovered ? 18 : 6,
                offset: Offset(0, _hovered ? 6 : 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: widget.mainColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.description_rounded,
                    color: widget.mainColor,
                    size: widget.isDesktop ? 18.sp : 16.sp),
              ),
              SizedBox(width: 14.w),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prescription #${widget.prescriptionId}',
                      style: TextStyle(
                        color: widget.isDark
                            ? Colors.white
                            : const Color(0xFF0F172A),
                        fontSize: widget.isDesktop ? 14.sp : 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded,
                            color: widget.isDark
                                ? Colors.white38
                                : Colors.black26,
                            size: widget.isDesktop ? 11.sp : 10.sp),
                        SizedBox(width: 4.w),
                        Text(
                          widget.date,
                          style: TextStyle(
                            color: widget.isDark
                                ? Colors.white.withValues(alpha: 0.45)
                                : const Color(0xFF94A3B8),
                            fontSize: widget.isDesktop ? 11.sp : 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // CTA
              Obx(() => patientController.isPdfLoading.value
                  ? SizedBox(
                      width: 18.w,
                      height: 18.h,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: widget.mainColor),
                    )
                  : AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: _hovered
                            ? widget.mainColor
                            : widget.mainColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            color: _hovered
                                ? Colors.white
                                : widget.mainColor,
                            size: widget.isDesktop ? 13.sp : 12.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'View',
                            style: TextStyle(
                              color: _hovered
                                  ? Colors.white
                                  : widget.mainColor,
                              fontSize: widget.isDesktop ? 11.sp : 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}