import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/main_diagnosis_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/assestive_device_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/cheif_complain_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/diagnosis_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/disability_types_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/drug_history_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/on_examination_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/optimized_advice_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/primary_medical_history_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/radiological_findings_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/referred_to_widget.dart';
import 'package:e_prescription/screens/add_prescription/diagnosis/widget/previous_therapy_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_prescription/responsive.dart';
import 'package:e_prescription/locator.dart';

final QuickTechThemeController themeController =
    locator.get<QuickTechThemeController>();
final MainDiagnosisController mainDiagnosisController =
    locator.get<MainDiagnosisController>();

Widget customDiagnosisInfo(BuildContext context) {
  return Responsive(
    mobile: _buildMobileLayout(context),
    tablet: _buildTabletDesktopLayout(context),
    desktop: _buildTabletDesktopLayout(context),
  );
}

// ─── Shared Header ────────────────────────────────────────────────────────────

Widget _buildHeader(BuildContext context) {
  final bool isDay = themeController.isDay.value;
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
                'Diagnosis Information',
                style: myStyle(
                  20.sp,
                  isDay
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
                  FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Fill in all relevant clinical details below',
                style: myStyle(
                  11.sp,
                  isDay
                      ? const Color(0xFF6B7280)
                      : Colors.white54,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Step badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: accent.withValues(alpha:0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.medical_information_rounded,
                    size: 14.sp, color: accent),
                SizedBox(width: 6.w),
                Text(
                  'Clinical Data',
                  style: myStyle(11.sp, accent, FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      // Divider with gradient feel
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

// ─── Section Card Wrapper ─────────────────────────────────────────────────────

Widget _sectionCard({
  required BuildContext context,
  required String label,
  required IconData icon,
  required Widget child,
  Color? accentOverride,
}) {
  final bool isDay = themeController.isDay.value;
  final Color accent = accentOverride ??
      (isDay
          ? QuickTechAppColors.lightmaincolor
          : QuickTechAppColors.darkmaincolor);
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
          // Card top label strip
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: accent.withValues(alpha:0.06),
              border: Border(
                bottom: BorderSide(
                    color: accent.withValues(alpha:0.15), width: 1),
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
                  style: myStyle(
                      12.sp, labelColor, FontWeight.w600),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 14.h),
            child: child,
          ),
        ],
      ),
    ),
  );
}

// ─── Section definitions (label + icon + widget) ─────────────────────────────

List<_SectionDef> _allSections(bool isDay) => [
      _SectionDef(
        label: 'Chief Complaint',
        icon: Icons.record_voice_over_rounded,
        child: const ChiefComplaintSection(),
      ),
      _SectionDef(
        label: 'On Examination',
        icon: Icons.search_rounded,
        child: const OnExaminationSection(),
      ),
      _SectionDef(
        label: 'Radiological Findings',
        icon: Icons.image_search_rounded,
        child: const RadiologicalFindingsSection(),
      ),
      _SectionDef(
        label: 'Primary Medical History',
        icon: Icons.history_rounded,
        child: const PrimaryMedicalHistorySection(),
      ),
      _SectionDef(
        label: 'Drug History',
        icon: Icons.medication_rounded,
        child: const DrugHistorySection(),
      ),
      _SectionDef(
        label: 'Previous Therapy History',
        icon: Icons.healing_rounded,
        child: PreviousTherapyHIstorySection(isDay),
      ),
      _SectionDef(
        label: 'Advice',
        icon: Icons.tips_and_updates_rounded,
        child: AdviceSection(isDay),
      ),
      _SectionDef(
        label: 'Assistive Device',
        icon: Icons.accessibility_new_rounded,
        child: const AssestiveDeviceSection(),
      ),
      _SectionDef(
        label: 'Referred To',
        icon: Icons.send_rounded,
        child: const ReferredToSection(),
      ),
      _SectionDef(
        label: 'Disability Types',
        icon: Icons.personal_injury_rounded,
        child: const DisabilityTypesSection(),
      ),
      _SectionDef(
        label: 'Diagnosis',
        icon: Icons.fact_check_rounded,
        child: const DiagnosisSection(),
      ),
    ];

class _SectionDef {
  final String label;
  final IconData icon;
  final Widget child;
  const _SectionDef(
      {required this.label, required this.icon, required this.child});
}

// ─── Mobile Layout — single column ───────────────────────────────────────────

Widget _buildMobileLayout(BuildContext context) {
  final bool isDay = themeController.isDay.value;
  final Color bg =
      isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor;

  return Container(
    color: bg,
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          ..._allSections(isDay).map(
            (s) => _sectionCard(
              context: context,
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

// ─── Tablet / Desktop Layout — two columns ────────────────────────────────────

Widget _buildTabletDesktopLayout(BuildContext context) {
  final bool isDay = themeController.isDay.value;
  final Color bg =
      isDay ? QuickTechAppColors.lightScaffoldColor : QuickTechAppColors.darkScaffoldColor;
  final sections = _allSections(isDay);

  // Split sections alternately into left & right columns
  final List<_SectionDef> leftSections = [];
  final List<_SectionDef> rightSections = [];
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
          _buildHeader(context),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column
              Expanded(
                child: Column(
                  children: leftSections
                      .map((s) => _sectionCard(
                            context: context,
                            label: s.label,
                            icon: s.icon,
                            child: s.child,
                          ))
                      .toList(),
                ),
              ),
              SizedBox(width: 20.w),
              // Right column
              Expanded(
                child: Column(
                  children: rightSections
                      .map((s) => _sectionCard(
                            context: context,
                            label: s.label,
                            icon: s.icon,
                            child: s.child,
                          ))
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