import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/quick_tech_on_examination_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
final QuickTechOnExaminationController examinationController = locator.get<QuickTechOnExaminationController>();

Widget OnExaminationDropDown({
  required String label,
  required List<String> items,
  required String? value,
  required Function(String?) onChanged,
  required IconData icon,
  required Widget infoContent,
  required RxBool isExpanded,
  String? dialogTitle,
  String? dialogHint,
  bool? enableOthersOption,
}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: QuickTechCustomDropDown<String?>(
              label: label,
              items: items,
              value: value,
              onChanged: onChanged,
              icon: icon,
              isDay: themeController.isDay.value,
              dialogHint: dialogHint,
              dialogTitle: dialogTitle,
              enableOthersOption: enableOthersOption ?? false,
            ),
          ),
          IconButton(
            onPressed: () => isExpanded.toggle(),
            icon: Icon(
              size: 20,
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
              isExpanded.value
                  ? FontAwesomeIcons.circleInfo
                  : FontAwesomeIcons.circleInfo,
            ),
          ),
        ],
      ),
      Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              isExpanded.value
                  ? OnExaminationInfoCard(infoContent)
                  : const SizedBox.shrink(),
        ),
      ),
    ],
  );
}

Widget OnExaminationTextField({
  required String label,
  required TextEditingController controller,
  required Function(String) onchanged,
  required IconData icon,
  required Widget infoContent,
  required RxBool isExpanded,
}) {
  return Column(
    children: [
      Row(
        children: [
          Flexible(
            child: QuickTechCustomTextField(
              txtcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
              lebelcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
              backcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.bktxtfld
                      : QuickTechAppColors.bkdarktxtfld,
              icon: icon,
              iconcolor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
              label: label,
              controller: controller,
              onchanged: onchanged,
            ),
          ),
          IconButton(
            onPressed: () => isExpanded.toggle(),
            icon: Icon(
              size: 20,
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
              isExpanded.value
                  ? FontAwesomeIcons.circleInfo
                  : FontAwesomeIcons.circleInfo,
            ),
          ),
        ],
      ),
      Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              isExpanded.value
                  ? OnExaminationInfoCard(infoContent)
                  : const SizedBox.shrink(),
        ),
      ),
    ],
  );
}

Widget OnExaminationInfoCard(Widget content) {
  return Card(
    elevation: themeController.isDay.value ? 5 : 2,
    shadowColor:
        themeController.isDay.value
            ? QuickTechAppColors.black
            : QuickTechAppColors.white.withValues(alpha: 0.1),
    color:
        themeController.isDay.value
            ? QuickTechAppColors.bktxtfld
            : QuickTechAppColors.bkdarktxtfld,
    margin: const EdgeInsets.only(top: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(padding: const EdgeInsets.all(14), child: content),
  );
}

Widget OnExaminationInfoItem(String title, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: RichText(
      text: TextSpan(
        style: myStyle(
          11,
          themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor
              : QuickTechAppColors.darkmaintextcolor,
        ),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' $description'),
        ],
      ),
    ),
  );
}
