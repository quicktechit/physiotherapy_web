import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/prescription_controller/patient_info_controller/patient_info_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_electrotherapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_manual_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_miscellaneous_therapy_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_rx_controller.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_speech_language_therapy_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_electrotherapy.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_manual%20_therapy.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_miscellaneous_therapy.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_speech_language_therapy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:e_prescription/responsive.dart';

QuickTechManualTherapyController manualTherapyController =
    locator.get<QuickTechManualTherapyController>();
PatientInfoController patientInfoController =
    locator.get<PatientInfoController>();
QuickTechMiscellaneousTherapyController miscellaneousTherapyController =
    locator.get<QuickTechMiscellaneousTherapyController>();
QuickTechSpeechLanguageTherapyController speechLanguageTherapyController =
    locator.get<QuickTechSpeechLanguageTherapyController>();
QuickTechElectrotherapyController electrotherapyController =
    locator.get<QuickTechElectrotherapyController>();
QuickTechThemeController themeController =
    locator.get<QuickTechThemeController>();
QuicktechmainPrescriptionControllr prescriptionController =
    locator.get<QuicktechmainPrescriptionControllr>();

// ─── Section definition ───────────────────────────────────────────────────────

class _RxSectionDef {
  final String label;
  final IconData icon;
  final Widget child;
  const _RxSectionDef({
    required this.label,
    required this.icon,
    required this.child,
  });
}

List<_RxSectionDef> _rxSections() => [
      _RxSectionDef(
        label: 'Electrotherapy',
        icon: Icons.electric_bolt_rounded,
        child: customElectrothrerapy(),
      ),
      _RxSectionDef(
        label: 'Manual Therapy',
        icon: Icons.back_hand_rounded,
        child:  CustomManualTherapyInfo(),
      ),
      _RxSectionDef(
        label: 'Miscellaneous Therapy',
        icon: Icons.medical_services_rounded,
        child:  CustomMiscalleneousTherapyInfo(),
      ),
      _RxSectionDef(
        label: 'Speech & Language Therapy',
        icon: Icons.record_voice_over_rounded,
        child:  CustomSpeechLanguageTherapyInfo(),
      ),
    ];

// ─── Header ───────────────────────────────────────────────────────────────────

Widget _buildRxHeader(bool isDay) {
  final Color accent = isDay
      ? QuickTechAppColors.lightmaincolor
      : QuickTechAppColors.darkmaincolor;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          // Accent bar
          Container(
            width: 4.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prescription (Rx)',
                style: myStyle(
                  20.sp,
                  isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor,
                  FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Select therapy types and configure details',
                style: myStyle(
                  11.sp,
                  isDay ? const Color(0xFF6B7280) : Colors.white54,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: accent.withValues(alpha:0.12),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: accent.withValues(alpha:0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.vaccines_rounded, size: 14.sp, color: accent),
                SizedBox(width: 6.w),
                Text(
                  'Rx Plan',
                  style: myStyle(11.sp, accent, FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      // Gradient divider
      Container(
        height: 1.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha:0.5),
              accent.withValues(alpha:0.05),
            ],
          ),
        ),
      ),
    ],
  );
}

// ─── Section card ─────────────────────────────────────────────────────────────

Widget _rxSectionCard({
  required bool isDay,
  required String label,
  required IconData icon,
  required Widget child,
}) {
  final Color accent = isDay
      ? QuickTechAppColors.lightmaincolor
      : QuickTechAppColors.darkmaincolor;
  final Color cardBg = isDay ? Colors.white : const Color(0xFF1E2235);
  final Color borderColor =
      isDay ? const Color(0xFFE5E7EB) : const Color(0xFF2D3348);
  final Color labelColor =
      isDay ? const Color(0xFF374151) : const Color(0xFFD1D5DB);

  return Container(
    margin: EdgeInsets.only(bottom: 14.h),
    decoration: BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(14.r),
      border: Border.all(color: borderColor, width: 1),
      boxShadow: [
        BoxShadow(
          color: isDay
              ? Colors.black.withValues(alpha:0.04)
              : Colors.black.withValues(alpha:0.2),
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label strip
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: accent.withValues(alpha:0.06),
              border: Border(
                bottom: BorderSide(color: accent.withValues(alpha:0.15), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha:0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, size: 14.sp, color: accent),
                ),
                SizedBox(width: 10.w),
                Text(
                  label,
                  style: myStyle(12.sp, labelColor, FontWeight.w600),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: child,
          ),
        ],
      ),
    ),
  );
}

// ─── Mobile layout — single column ───────────────────────────────────────────

Widget _buildRxMobileLayout(BuildContext context) {
  final bool isDay = themeController.isDay.value;
  final Color bg = isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor;

  return Container(
    color: bg,
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          ..._rxSections().map(
            (s) => _rxSectionCard(
              isDay: isDay,
              label: s.label,
              icon: s.icon,
              child: s.child,
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── Tablet / Desktop layout — two columns ────────────────────────────────────

Widget _buildRxDesktopLayout(BuildContext context) {
  final bool isDay = themeController.isDay.value;
  final Color bg = isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor;
  final sections = _rxSections();

  // Split alternately: even index → left, odd index → right
  final List<_RxSectionDef> leftSections = [];
  final List<_RxSectionDef> rightSections = [];
  for (int i = 0; i < sections.length; i++) {
    if (i.isEven) {
      leftSections.add(sections[i]);
    } else {
      rightSections.add(sections[i]);
    }
  }

  return Container(
    color: bg,
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRxHeader(isDay),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column
              Expanded(
                child: Column(
                  children: leftSections
                      .map(
                        (s) => _rxSectionCard(
                          isDay: isDay,
                          label: s.label,
                          icon: s.icon,
                          child: s.child,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(width: 20.w),
              // Right column
              Expanded(
                child: Column(
                  children: rightSections
                      .map(
                        (s) => _rxSectionCard(
                          isDay: isDay,
                          label: s.label,
                          icon: s.icon,
                          child: s.child,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ─── Main widget ──────────────────────────────────────────────────────────────

Widget customRxPart(BuildContext context) {
  return Obx(
    () => Responsive(
      mobile: _buildRxMobileLayout(context),
      tablet: _buildRxDesktopLayout(context),
      desktop: _buildRxDesktopLayout(context),
    ),
  );
}