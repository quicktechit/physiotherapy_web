

  import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
Widget SettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: QuickTechAppColors.lightmaincolor,
      ),
      title: Text(
        title,
        style: myStyle(
          16,
          titleColor ?? (themeController.isDay.value ? Colors.black : Colors.white),
          FontWeight.normal,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: myStyle(
                14,
                themeController.isDay.value ? Colors.grey[600]! : Colors.grey[400]!,
                FontWeight.normal,
              ),
            )
          : null,
      trailing: trailing,
    );
  }

