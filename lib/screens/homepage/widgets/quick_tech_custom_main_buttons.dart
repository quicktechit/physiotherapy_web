import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/screens/add_prescription/quick_tech_add_prescription_form.dart';

class QuickTechCustomMainButtons extends StatelessWidget {
  final QuickTechThemeController themeController;
  const QuickTechCustomMainButtons({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = !themeController.isDay.value;

    final actions = [
      ActionCardData(
        title: 'Add Patient',
        subtitle: 'Register new patient records quickly',
        lottie: 'assets/animations/addpatient.json',
        gradient:  [QuickTechAppColors.lightmaincolor, QuickTechAppColors.lightmaincolor],
        onTap: () => Get.toNamed('/addassessment'),
        isWide: true,
      ),
      ActionCardData(
        title: 'Add Prescription',
        subtitle: 'Create & manage prescriptions',
        lottie: 'assets/animations/prescription.json',
        gradient: isDark
            ? [const Color(0xFF1E293B), const Color(0xFF334155)]
            : [Colors.white, Colors.white],
        textColor: isDark ? Colors.white : QuickTechAppColors.lightmaincolor,
        subtitleColor: isDark
            ? Colors.white.withValues(alpha: 0.6)
            : const Color(0xFF64748B),
        hasBorder: !isDark,
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.off(() => QuickTechPrescriptionForm());
          });
        },
        isWide: false,
      ),
      ActionCardData(
        title: 'Add Assessment',
        subtitle: 'Log clinical assessments',
        lottie: 'assets/animations/assessment.json',
        gradient:  [QuickTechAppColors.lightmaincolor, QuickTechAppColors.lightmaincolor],
        onTap: () => Get.toNamed('/addassessment'),
        isWide: false,
      ),
      ActionCardData(
        title: 'Patient List',
        subtitle: 'View and manage patient records',
        lottie: 'assets/animations/patientrecords.json',
       gradient: isDark
            ? [const Color(0xFF1E293B), const Color(0xFF334155)]
            : [Colors.white, Colors.white],
        textColor: isDark ? Colors.white : QuickTechAppColors.lightmaincolor,
        subtitleColor: isDark
            ? Colors.white.withValues(alpha: 0.6)
            : const Color(0xFF64748B),
        hasBorder: !isDark,
        onTap: () => Get.toNamed('/patientrecords'),
        isWide: false,
      ),
    ];

    if (isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(isDark: isDark, label: 'Quick Actions'),
          SizedBox(height: 28.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    ActionCard(data: actions[0], isDesktop: true),
                    SizedBox(height: 20.h),
                    ActionCard(data: actions[3], isDesktop: true),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    ActionCard(data: actions[1], isDesktop: true),
                    SizedBox(height: 20.h),
                    ActionCard(data: actions[2], isDesktop: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(isDark: isDark, label: 'Quick Actions'),
        SizedBox(height: 20.h),
         Row(
          children: [
            Expanded(child: ActionCard(data: actions[0], isDesktop: false)),
            SizedBox(width: 16.w),
            Expanded(child: ActionCard(data: actions[3], isDesktop: false)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(child: ActionCard(data: actions[1], isDesktop: false)),
            SizedBox(width: 16.w),
            Expanded(child: ActionCard(data: actions[2], isDesktop: false)),
          ],
        ),
      ],
    );
  }
}