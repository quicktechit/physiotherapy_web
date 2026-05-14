import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/optimized_advice_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_prescription/locator.dart';

final OptimizedAdviceController optimizedAdviceController = locator.get<OptimizedAdviceController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

Widget AdviceSection(bool isDay) {
      optimizedAdviceController.fetchAdviceOptions();
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.white
                        : QuickTechAppColors.darktxtfieldcolor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                ),
              ),
          child: Column(
            children: [
              InkWell(
                onTap: () => optimizedAdviceController.toggleDropdown('main'),
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Advice',
                      style: myStyle(
                        16,
                        isDay
                            ? QuickTechAppColors.black2
                            : QuickTechAppColors.whiteOpacity,
                      ),
                    ),
                    Icon(
                      optimizedAdviceController.showDropdowns['main'] == true
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
              
                      color: isDay
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.whiteOpacity,
                    ),
                  ],
                ),
              ),
              if (optimizedAdviceController.showDropdowns['main'] == true) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _OptimizedNestedOption(
                        'X ray of',
                        'xray',
                        optimizedAdviceController.xrayOptions,
                        optimizedAdviceController.hasSideOptions,
                        isDay,
                      ),
                      const SizedBox(height: 12),
                      _OptimizedNestedOption(
                        'MRI of',
                        'mri',
                        optimizedAdviceController.mriOptions,
                        optimizedAdviceController.hasSideOptions,
                        isDay,
                      ),
                      const SizedBox(height: 12),
                      _OptimizedNestedOption(
                        'CT scan of',
                        'ctscan',
                        optimizedAdviceController.ctScanOptions,
                        optimizedAdviceController.hasSideOptions,
                        isDay,
                      ),
                      const SizedBox(height: 12),
                      _OptimizedNestedOption(
                        'Hematology & Serology',
                        'hematology',
                        optimizedAdviceController.hematologyOptions,
                        optimizedAdviceController.hasSideOptions,
                        isDay,
                      ),
                      const SizedBox(height: 12),
                      _OptimizedNestedOption(
                        'Other Tests',
                        'others',
                        optimizedAdviceController.othersOptions,
                        optimizedAdviceController.hasSideOptions,
                        isDay,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

      ],
    ),
  );
}

class _OptimizedNestedOption extends StatelessWidget {
  final String title;
  final String keyName;
  final List<String> options;
  final List<String> hasSideOptions;
  final bool isDay;

  const _OptimizedNestedOption(this.title, this.keyName, this.options, this.hasSideOptions, this.isDay);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        InkWell(
          onTap: () => optimizedAdviceController.toggleDropdown(keyName),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: myStyle(
                    13,
                    isDay
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                  ),
                ),
                Icon(
                  optimizedAdviceController.showDropdowns[keyName] == true ? Icons.remove : Icons.add,
                  size: 20,
                  color: isDay
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
        if (optimizedAdviceController.showDropdowns[keyName] == true)
          ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: options.map((option) {
                  final hasSide = hasSideOptions.contains(option);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            final value = !optimizedAdviceController.isTestSelected(option);
                            if (value) {
                              if (hasSide) {
                                optimizedAdviceController.showSideOptionsFor(option);
                              } else {
                                optimizedAdviceController.addTest(option);
                              }
                            } else {
                              optimizedAdviceController.removeTestWithSides(option);
                            }
                          },
                          child: Row(
                            children: [
                              Obx(() => Checkbox(
                                value: optimizedAdviceController.isTestSelected(option),
                                onChanged: (value) {
                                  if (value == true) {
                                    if (hasSide) {
                                      optimizedAdviceController.showSideOptionsFor(option);
                                    } else {
                                      optimizedAdviceController.addTest(option);
                                    }
                                  } else {
                                    optimizedAdviceController.removeTestWithSides(option);
                                  }
                                },
                                activeColor: isDay
                                    ? QuickTechAppColors.lightmaincolor
                                    : QuickTechAppColors.darkmaincolor,
                              )),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  option,
                                  style: myStyle(
                                    14,
                                    isDay
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (hasSide && optimizedAdviceController.shouldShowSideOptions(option))
                        Padding(
                          padding: const EdgeInsets.only(left: 40, top: 8),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  optimizedAdviceController.toggleSide(option, 'Lt');
                                },
                                child: Row(
                                  children: [
                                    Obx(() {
                                      return RadioGroup<bool>(
                                        groupValue: optimizedAdviceController.isSideSelected(option, 'Lt'),
                                        onChanged: (value) {
                                          optimizedAdviceController.toggleSide(option, 'Lt');
                                        },
                                        child: Radio<bool>(
                                          value: true,
                                          activeColor: isDay
                                              ? QuickTechAppColors.lightmaincolor
                                              : QuickTechAppColors.darkmaincolor,
                                        ),
                                      );
                                    }),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Left (Lt)',
                                      style: myStyle(
                                        13,
                                        isDay
                                            ? QuickTechAppColors.lightmaintextcolor
                                            : QuickTechAppColors.darkmaintextcolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  optimizedAdviceController.toggleSide(option, 'Rt');
                                },
                                child: Row(
                                  children: [
                                    Obx(() {
                                      return RadioGroup<bool>(
                                        groupValue: optimizedAdviceController.isSideSelected(option, 'Rt'),
                                        onChanged: (value) {
                                          optimizedAdviceController.toggleSide(option, 'Rt');
                                        },
                                        child: Radio<bool>(
                                          value: true,
                                          activeColor: isDay
                                              ? QuickTechAppColors.lightmaincolor
                                              : QuickTechAppColors.darkmaincolor,
                                        ),
                                      );
                                    }),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Right (Rt)',
                                      style: myStyle(
                                        13,
                                        isDay
                                            ? QuickTechAppColors.lightmaintextcolor
                                            : QuickTechAppColors.darkmaintextcolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
      ],
    ));
  }
}
