import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/assessment_controller/birth_history/quick_tech_birth_history_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/widgets/quick_tech_assessment_widgets.dart';
import 'package:e_prescription/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget BirthHistory() {
  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();
  final QuickTechBirthHistoryController c =
      locator.get<QuickTechBirthHistoryController>();

  return Obx(() {
    final isDay = themeController.isDay.value;
    final mainColor =
        isDay
            ? QuickTechAppColors.lightmaincolor
            : QuickTechAppColors.darkmaincolor;

    final fields = [
      assessmentDropdown(
        label: 'Birth injury',
        items: c.birthInjuryOptions,
        value: c.birthInjury.value,
        onChanged: (v) => c.updateBirthInjury(v!),
        icon: Icons.healing,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Birth weight',
        items: c.birthWeightOptions,
        value: c.birthWeight.value,
        onChanged: c.updateBirthWeight,
        icon: Icons.scale,
        isDay: isDay,
        enableOthers: true,
        dialogTitle: "Add Weight",
        dialogHint: "Enter Weight",
      ),
      assessmentDropdown(
        label: 'Any complication during delivery',
        items: c.complicationOptions,
        value: c.complication.value,
        onChanged: (v) => c.updateComplication(v!),
        icon: Icons.warning,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Pregnancy maturity',
        items: c.pregnancyMaturityOptions,
        value: c.pregnancyMaturity.value,
        onChanged: (v) => c.updatePregnancyMaturity(v!),
        icon: Icons.today,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Delivery type',
        items: c.deliveryTypeOptions,
        value: c.deliveryType.value,
        onChanged: (v) => c.updateDeliveryType(v!),
        icon: Icons.delivery_dining,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Delivery place',
        items: c.deliveryPlaceOptions,
        value: c.deliveryPlace.value,
        onChanged: (v) => c.updateDeliveryPlace(v!),
        icon: Icons.local_hospital,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'No of labor',
        items: ['1', '2', '3', '4', '5'].obs,
        value: c.noOfLabor.value,
        onChanged: (v) => c.updateNoOfLabor(v!),
        icon: Icons.numbers,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'Duration of labor (in hours)',
        items: c.laborDurationOptions,
        value: c.laborDuration.value,
        onChanged: c.updateLaborDuration,
        icon: Icons.timer,
        isDay: isDay,
        enableOthers: true,
        dialogTitle: "Add Duration in Labour(Hours)",
        dialogHint: "Enter Duration in Labour(Hours)",
      ),
      assessmentDropdown(
        label: 'Child position',
        items: c.childPositionOptions,
        value: c.childPosition.value,
        onChanged: (v) => c.updateChildPosition(v!),
        icon: Icons.accessibility,
        isDay: isDay,
      ),
      assessmentDropdown(
        label: 'After birth problem',
        items: c.afterBirthProblemOptions,
        value: c.afterBirthProblem.value,
        onChanged: c.updateAfterBirthProblem,
        icon: Icons.health_and_safety,
        isDay: isDay,
        enableOthers: true,
        dialogTitle: "Add After Birth Problem",
        dialogHint: "Enter After Birth Problem",
      ),
    ];

    // Mobile
    Widget mobile() => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assessmentHeader(
            mainColor: mainColor,
            title: 'Birth History',
            icon: Icons.child_care,
          ),
          const SizedBox(height: 16),
          assessmentGrid(fields: fields, cols: 1),
        ],
      ),
    );

    // Tablet
    Widget tablet() => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assessmentHeader(
            mainColor: mainColor,
            title: 'Birth History',
            icon: Icons.child_care,
          ),
          const SizedBox(height: 20),
          assessmentCard(
            color: mainColor,
            title: 'Birth Details',
            icon: Icons.child_care,
            child: assessmentGrid(fields: fields, cols: 2),
          ),
        ],
      ),
    );

    // Desktop
    Widget desktop() => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          assessmentHeader(
            mainColor: mainColor,
            title: 'Birth History',
            icon: Icons.child_care,
          ),
          const SizedBox(height: 24),
          assessmentCard(
            color: mainColor,
            title: 'Birth Details',
            icon: Icons.child_care,
            child: assessmentGrid(fields: fields, cols: 2),
          ),
        ],
      ),
    );

    return Responsive(mobile: mobile(), tablet: tablet(), desktop: desktop());
  });
}
