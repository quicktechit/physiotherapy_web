import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/assestive_device/quick_tech_assestive_device_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class AssestiveDeviceDropdown extends StatelessWidget {
  const AssestiveDeviceDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    final QuickTechAssestiveDeviceController assestiveDeviceController = locator.get<QuickTechAssestiveDeviceController>();

    return Obx(() {
      final isDay = themeController.isDay.value;
      final txtColor = isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor;
      final bgColor = isDay ? QuickTechAppColors.white : QuickTechAppColors.bkdarktxtfld;
      final iconLabelColor = txtColor.withValues(alpha:0.8);

      return Column(
        children: [
          // Dropdown Toggle Button
          OutlinedButton(
            onPressed: assestiveDeviceController.toggleassestiveDeviceDropdown,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Taller button for better UX
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: isDay ? QuickTechAppColors.bktxtfld : QuickTechAppColors.bkdarktxtfld,
              side: BorderSide(
                color: isDay ? Colors.grey.shade300 : Colors.grey.shade800,
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search or Select Assistive Device',
                  style: myStyle(15, txtColor.withValues(alpha:0.8)),
                ),
                Icon(
                  assestiveDeviceController.isAssestiveDeviceDropdownOpen.value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: txtColor,
                  size: 24,
                ),
              ],
            ),
          ),

          // Expanded Card Content
          if (assestiveDeviceController.isAssestiveDeviceDropdownOpen.value)
            Card(
              color: bgColor,
              elevation: isDay ? 4 : 0,
              margin: const EdgeInsets.only(top: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: isDay ? Colors.transparent : Colors.grey.shade800),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Search Field
                    QuickTechCustomTextField(
                      lebelcolor: iconLabelColor,
                      label: 'Type to search...',
                      controller: assestiveDeviceController.assestiveDeviceSearchController,
                      onchanged: (value) => assestiveDeviceController.assestiveDeviceText.value = value,
                      backcolor: isDay ? QuickTechAppColors.bktxtfld : QuickTechAppColors.darktxtfieldcolor,
                      icon: Icons.search,
                      iconcolor: iconLabelColor,
                      txtcolor: txtColor,
                    ),
                    const SizedBox(height: 8),

                    // Filtered List
                    Container(
                      constraints: const BoxConstraints(maxHeight: 220),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: assestiveDeviceController.filteredassestiveDevice.map((device) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              title: Text(
                                device,
                                style: myStyle(14, txtColor),
                              ),
                              trailing: Icon(Icons.add_circle_outline, color: txtColor.withValues(alpha:0.5), size: 20),
                              onTap: () {
                                assestiveDeviceController.addsuggestiveDevice(device);
                                assestiveDeviceController.assestiveDeviceText.value = '';
                                assestiveDeviceController.assestiveDeviceSearchController.clear();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // Add Custom Device Option
                    Obx(() {
                      if (assestiveDeviceController.assestiveDeviceText.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              final newDevice = assestiveDeviceController.assestiveDeviceText.value;
                              if (newDevice.isNotEmpty) {
                                assestiveDeviceController.addsuggestiveDevice(newDevice);
                                assestiveDeviceController.isAssestiveDeviceDropdownOpen.value = false;
                                assestiveDeviceController.assestiveDeviceText.value = '';
                                assestiveDeviceController.assestiveDeviceSearchController.clear();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDay ? QuickTechAppColors.lightmaincolor.withValues(alpha:0.1) : QuickTechAppColors.darkmaincolor.withValues(alpha:0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add, color: isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor, size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Add Custom: "${assestiveDeviceController.assestiveDeviceText.value}"',
                                      style: myStyle(14, isDay ? QuickTechAppColors.lightmaincolor : QuickTechAppColors.darkmaincolor, FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}