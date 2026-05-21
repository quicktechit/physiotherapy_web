import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/past_medical_history/quick_tech_past_medical_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/quick_tech_assessment_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart';
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class PastMedicalHistory extends StatelessWidget {
  PastMedicalHistory({Key? key}) : super(key: key) {
    // Fetch histories inside the constructor so it only runs once upon creation,
    // rather than on every reactive rebuild.
    final pastMedicalHistoryController = locator.get<QuickTechPastMedicalHistoryController>();
    pastMedicalHistoryController.fetchMedicalHistories();
  }

  @override
  Widget build(BuildContext context) {
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    final QuickTechPastMedicalHistoryController pastMedicalHistoryController = locator.get<QuickTechPastMedicalHistoryController>();
    final QuickTechAssessmentController assessmentController = locator.get<QuickTechAssessmentController>();

    return Obx(() {
      if (pastMedicalHistoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final isDay = themeController.isDay.value;
      final mainColor = isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor;
      final textColor = isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor;

  final List<Widget> fields = pastMedicalHistoryController.medicalHistories
          .where((item) => item.name != 'Others')
          .map<Widget>((item) {           // <--- ADD <Widget> HERE
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: mainColor,
          title: Text(
            item.name,
            style: myStyle(15, textColor),
          ),
          value: pastMedicalHistoryController.selectedMedicalHistories[item.id] ?? false,
          onChanged: (value) {
            pastMedicalHistoryController.updateMedicalHistory(item.id, value!);
          },
        );
      }).toList();

      // 2. Add 'Others' button at the end of the grid
      fields.add(
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.add_circle_outline, color: mainColor),
          title: Text(
            'Add Others',
            style: myStyle(15, textColor),
          ),
          onTap: () {
            assessmentController.showOthersDialog(
              context,
              label: 'Past Medical History',
              onChanged: (value) {
                pastMedicalHistoryController.addOtherItem(value);
              },
            );
          },
        ),
      );

      // 3. Extracted Selected Items Widget
      Widget selectedItemsSection() {
        final selectedItems = pastMedicalHistoryController.getSelectedItems();
        if (selectedItems.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Divider(color: mainColor.withValues(alpha:0.2)),
            const SizedBox(height: 12),
            Text(
              'Selected:',
              style: myStyle(16, mainColor, FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Changed from a vertical list to a responsive Wrap with Chips
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedItems.map((name) => Chip(
                label: Text(
                  name,
                  style: myStyle(14, isDay ? Colors.black87 : Colors.white),
                ),
                backgroundColor: mainColor.withValues(alpha:0.1),
                side: BorderSide(color: mainColor.withValues(alpha:0.3)),
              )).toList(),
            ),
          ],
        );
      }

      // Mobile Layout
      Widget mobile() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            assessmentHeader(
              mainColor: mainColor,
              title: 'Past Medical History',
              icon: Icons.history,
            ),
            const SizedBox(height: 16),
            assessmentGrid(fields: fields, cols: 1),
            selectedItemsSection(),
          ],
        ),
      );

      // Tablet Layout
      Widget tablet() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            assessmentHeader(
              mainColor: mainColor,
              title: 'Past Medical History',
              icon: Icons.history,
            ),
            const SizedBox(height: 20),
            assessmentCard(
              color: mainColor,
              title: 'History Options',
              icon: Icons.history,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  assessmentGrid(fields: fields, cols: 2),
                  selectedItemsSection(),
                ],
              ),
            ),
          ],
        ),
      );

      // Desktop Layout
      Widget desktop() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            assessmentHeader(
              mainColor: mainColor,
              title: 'Past Medical History',
              icon: Icons.history,
            ),
            const SizedBox(height: 24),
            assessmentCard(
              color: mainColor,
              title: 'History Options',
              icon: Icons.history,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  assessmentGrid(fields: fields, cols: 3),
                  selectedItemsSection(),
                ],
              ),
            ),
          ],
        ),
      );

      return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
    });
  }
}