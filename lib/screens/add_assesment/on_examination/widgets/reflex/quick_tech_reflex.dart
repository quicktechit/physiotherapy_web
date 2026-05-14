import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/reflex/quick_tech_reflex_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/add_assesment/on_examination/widgets/quick_tech_on_examination_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Widget ReflexSelection() {
  
  final QuickTechReflexController reflexController = locator.get<QuickTechReflexController>();
  final RxBool isInfoExpanded = false.obs;
//  reflexController.fetchAllReflexes();
//  reflexController.fetchReflexGrades();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.bktxtfld
                        : QuickTechAppColors.bkdarktxtfld,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.black.withValues(alpha: 0.7)
                          : QuickTechAppColors.grey.withValues(alpha: 0.3),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              
              child: Obx(() {
                if (reflexController.isLoadingReflexes.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (reflexController.reflexesError.isNotEmpty) {
                  return Text(
                    reflexController.reflexesError.value,
                    style: TextStyle(color: Colors.red),
                  );
                }
                final displayValue = reflexController.selectedCategory.value;
                final showHint = displayValue.isEmpty;
                return DropdownButton<String>(
                  dropdownColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.bktxtfld
                          : QuickTechAppColors.bkdarktxtfld,
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: showHint
                      ? Text(
                          "Select Reflex",
                          style: myStyle(
                            15,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                          ),
                        )
                      : null,
                  value: showHint ? null : displayValue,
                  items: reflexController.reflexCategories
                      .where((category) => category.isNotEmpty)
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: myStyle(
                              15,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      reflexController.setCategory(value);
                    }
                  },
                );
              }),
            ),
          ),
          Obx(
            () => IconButton(
              onPressed: () async {
                if (!isInfoExpanded.value) {
                  // Only fetch if not already expanded
                  await reflexController.fetchReflexGrades();
                }
                isInfoExpanded.toggle();
              },
              icon: Icon(
                size: 20,
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                        : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                isInfoExpanded.value
                    ? FontAwesomeIcons.circleInfo
                    : FontAwesomeIcons.circleInfo,
              ),
            ),
          ),
        ],
      ),

      Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              isInfoExpanded.value
                  ? OnExaminationInfoCard(
                    Obx(() {
                      if (reflexController.isLoadingGrades.value) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (reflexController.gradesError.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            reflexController.gradesError.value,
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (reflexController.reflexGrades.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reflex Grading Scale:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeController.isDay.value
                                        ? QuickTechAppColors.lightmaintextcolor
                                        : QuickTechAppColors.darkmaintextcolor,
                              ),
                            ),
                            SizedBox(height: 10),
                            ...reflexController.reflexGrades.map(
                              (grade) => OnExaminationInfoItem(
                                (grade.numericValue ?? '') + ':',
                                grade.textValue ?? '',
                              ),
                            ),
                            SizedBox(height: 10),
                            OnExaminationInfoItem(
                              "Note:",
                              "Reflexes should be compared bilaterally for symmetry in response.",
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "No reflex grades available.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }
                    }),
                  )
                  : const SizedBox.shrink(),
        ),
      ),

      Obx(
        () => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reflexController.reflexList.length,
          itemBuilder: (context, index) {
            final reflex = reflexController.reflexList[index];
            final reflexName = reflex.name ?? '';
            final subcategories = reflex.reflexSubcategories ?? [];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.bktxtfld
                        : QuickTechAppColors.bkdarktxtfld,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  tilePadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    reflexName,
                    style: myStyle(
                      13,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                    ),
                  ),
                  children: [
                    ...subcategories.map((option) {
                      final optionValue = option.numericValue ?? '';
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 16),
                          title: Text(
                              optionValue,
                            style: myStyle(
                              13,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor,
                            ),
                          ),
                          leading: Obx(
                            () => Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              activeColor:
                                  themeController.isDay.value
                                      ? QuickTechAppColors.lightmaincolor
                                      : QuickTechAppColors.darkmaincolor,
                              value: reflexController.isOptionSelected(
                                reflexName,
                                optionValue,
                              ),
                              onChanged: (bool? selected) {
                                if (selected != null) {
                                  reflexController.updateSelectedOption(
                                    reflexName,
                                    optionValue,
                                  );
                                }
                              },
                            ),
                          ),
                          onTap: () {
                            reflexController.updateSelectedOption(
                              reflexName,
                              optionValue,
                            );
                          },
                        ),
                      );
                    }).toList(),
                    Obx(() {
                      final selected =
                          reflexController.selectedOptions[reflexName];
                      return selected != null && selected.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 8.0,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: selected.map((option) {
                                    return InputChip(
                                      label: Text(option),
                                      labelStyle: myStyle(
                                        13,
                                        QuickTechAppColors.white,
                                      ),
                                      backgroundColor:
                                          QuickTechAppColors.lightmaincolor,
                                      deleteIcon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      onDeleted: () {
                                        reflexController.updateSelectedOption(
                                          reflexName,
                                          option,
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      Obx(() {
        final allSelected =
            reflexController.selectedOptions.values
                .expand((options) => options)
                .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              if (allSelected.isEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        themeController.isDay.value
                            ? Colors.grey.shade100
                            : Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color:
                            themeController.isDay.value
                                ? Colors.grey.shade600
                                : Colors.grey.shade400,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "No Reflex selected yet",
                        style: myStyle(
                          13,
                          themeController.isDay.value
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                )
              else
                SizedBox(),
            ],
          ),
        );
      }),
    ],
  );
}
