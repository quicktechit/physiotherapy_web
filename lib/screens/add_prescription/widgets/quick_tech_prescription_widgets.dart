
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
final QuickTechThemeController themeController=locator.get<QuickTechThemeController>();
Widget customTextField(
  String label,
  RxString rxString, {
  IconData? icon,
  TextInputType? keyboardType,
  int maxLines = 1,
  ValueChanged<String>? onchanged,
}) {
  return Obx(() {
    return QuickTechCustomTextField(
      label: label,
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: rxString.value,
          selection: TextSelection.collapsed(offset: rxString.value.length),
        ),
      ),
      onchanged: onchanged ?? (value) => rxString.value = value,
      icon: icon,
      keyboardType: keyboardType,
      maxline: maxLines,
      backcolor:
          themeController.isDay.value
              ? QuickTechAppColors.white
              : QuickTechAppColors.bkdarktxtfld,
      height:  50,

      lebelcolor:
          themeController.isDay.value
              ? QuickTechAppColors.black2
              : QuickTechAppColors.whiteOpacity,
      txtcolor:
          themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor
              : QuickTechAppColors.darkmaintextcolor,
      iconcolor:
          themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor
              : QuickTechAppColors.darkmaintextcolor,
    );
  });
}
