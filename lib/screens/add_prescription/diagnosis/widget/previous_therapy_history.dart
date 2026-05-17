import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/previous_therapy_Controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_prescription/locator.dart';

final PreviousTherapyHistoryController therapyDropdownController = locator.get<PreviousTherapyHistoryController>();
final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

Widget PreviousTherapyHIstorySection(bool isDay) {
      therapyDropdownController.fetchTherapyOptions();
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => therapyDropdownController.toggleDropdown('main'),
          child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Previous Therapy History',
                  style: myStyle(
                    15,
                    isDay
                        ? QuickTechAppColors.black2
                        : QuickTechAppColors.whiteOpacity,
                  ),
                ),
                Icon(
                  therapyDropdownController.showDropdowns['main'] == true
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
               
                  color: isDay
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.whiteOpacity,
                ),
              ],
            ),
          ),
        ),
        if (therapyDropdownController.showDropdowns['main'] == true) ...[
          const SizedBox(height: 12),
          _TherapyNestedOption(
            'Electrotherapy',
            'electrotherapy',
            therapyDropdownController.electrotherapyOptions,
            isDay,
            isElectro: true,
          ),
          const SizedBox(height: 5),
          _TherapyNestedOption(
            'Manual Therapy',
            'manual',
            therapyDropdownController.manualTherapyOptions,
            isDay,
          ),
          const SizedBox(height: 5),
          _TherapyNestedOption(
            'Other Therapies',
            'additional',
            therapyDropdownController.additionalTherapyOptions,
            isDay,
          ),
          const SizedBox(height: 16),
          Text(
            'Others:',
            style: myStyle(
              16,
              isDay
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: therapyDropdownController.updateOthers,
            decoration: InputDecoration(
              hintText: 'Enter other therapies',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDay ? Colors.grey : Colors.grey[700]!,
                ),
              ),
              filled: true,
              fillColor: isDay ? Colors.white : Colors.grey[800],
              hintStyle: TextStyle(
                color: isDay ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            style: TextStyle(color: isDay ? Colors.black : Colors.white),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
        ],

    
      ],
    ),
  );
}

class _TherapyNestedOption extends StatelessWidget {
  final String title;
  final String keyName;
  final List<Map<String, dynamic>> options;
  final bool isDay;
  final bool isElectro;

  const _TherapyNestedOption(
    this.title,
    this.keyName,
    this.options,
    this.isDay, {
    this.isElectro = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => therapyDropdownController.toggleDropdown(keyName),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                decoration: BoxDecoration(
                  color: isDay
                      ? QuickTechAppColors.white
                      : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: myStyle(
                        13,
                        isDay
                            ? QuickTechAppColors.lightmaintextcolor
                            : QuickTechAppColors.darkmaintextcolor
                                .withValues(alpha: 0.7),
                      ),
                    ),
                    Icon(
                      therapyDropdownController.showDropdowns[keyName] == true
                          ? Icons.remove
                          : Icons.add,
                      color: isDay
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor
                              .withValues(alpha: 0.7),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            if (therapyDropdownController.showDropdowns[keyName] == true) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  children: options.map((option) {
                    final isSelected = isElectro
                        ? therapyDropdownController.selectedElectrotherapy
                            .any((e) => e['id'] == option['id'])
                        : keyName == 'manual'
                            ? therapyDropdownController.selectedManualTherapy
                                .any((e) => e['id'] == option['id'])
                            : therapyDropdownController
                                .selectedAdditionalTherapies
                                .any((e) => e['id'] == option['id']);

                    return Column(
                      children: [
                        CheckboxListTile(
                          activeColor: QuickTechAppColors.lightmaincolor,
                          title: Text(
                            option['name'],
                            style: myStyle(
                              13,
                              isDay
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor
                                      .withValues(alpha: 0.7),
                            ),
                          ),
                          value: isSelected,
                          onChanged: (value) {
                            if (isElectro) {
                              therapyDropdownController
                                  .toggleElectrotherapyOption(option);
                            } else if (keyName == 'manual') {
                              therapyDropdownController
                                  .toggleManualTherapyOption(option);
                            } else {
                              therapyDropdownController
                                  .toggleAdditionalTherapyOption(option);
                            }
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                        if (isElectro && isSelected)
                          _ElectroTherapyDetails(option, isDay),
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

Widget _ElectroTherapyDetails(Map<String, dynamic> therapy, bool isDay) {
  final id = therapy['id'].toString();
  return Obx(() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: therapyDropdownController.durationControllers[id],
            keyboardType: TextInputType.text,
            onChanged: (value) {
              therapyDropdownController.updateTherapyDetails(
                therapy: id,
                duration: value,
              );
            },
            decoration: InputDecoration(
              labelText: 'Duration',
              labelStyle: myStyle(
                12,
                isDay
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
              ),
              prefixIcon: Icon(
                Icons.timelapse_rounded,
                color: isDay
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
              ),
              filled: true,
              fillColor: isDay
                  ? QuickTechAppColors.white
                  : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDay
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
                ),
              ),
            ),
            style: myStyle(
              12,
              isDay
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: therapyDropdownController.frequencyControllers[id],
            onChanged: (value) {
              therapyDropdownController.updateTherapyDetails(
                therapy: id,
                frequency: value,
              );
            },
            decoration: InputDecoration(
              labelText: 'Frequency',
              labelStyle: myStyle(
                12,
                isDay
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
              ),
              prefixIcon: Icon(
                Icons.access_alarm,
                color: isDay
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
              ),
              filled: true,
              fillColor: isDay
                  ? QuickTechAppColors.white
                  : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDay
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
                ),
              ),
            ),
            style: myStyle(
              12,
              isDay
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Regularity:',
            style: myStyle(
              13,
              isDay
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          Row(
            children: [
              Obx(() {
                return RadioGroup<bool>(
                  groupValue: therapyDropdownController.therapyDetails[id]?['isRegular'],
                  onChanged: (value) {
                    therapyDropdownController.frequencyControllers[id]?.text = 'Regular';

                    therapyDropdownController.updateTherapyDetails(
                      therapy: id,
                      isRegular: value,
                      frequency: 'Regular',
                    );
                  },
                  child: Radio<bool>(
                    value: true,
                  ),
                );
              }),
              Text(
                'Regular',
                style: myStyle(
                  12,
                  isDay
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                ),
              ),
              const SizedBox(width: 20),
             RadioGroup<bool>(
                  groupValue: therapyDropdownController.therapyDetails[id]?['isRegular'],
                  onChanged: (value) {
                    therapyDropdownController.frequencyControllers[id]?.text =
                    'Irregular';

                    therapyDropdownController.updateTherapyDetails(
                      therapy: id,
                      isRegular: value,
                      frequency: 'Irregular',
                    );
                  },
                  child: Radio<bool>(
                    value: false,
                  ),
                ),
              Text(
                'Irregular',
                style: myStyle(
                  12,
                  isDay
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  });
}
