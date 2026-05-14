import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/screens/add_assesment/on_examination/widgets/quick_tech_on_examination_widgets.dart';
import 'package:flutter/material.dart';

class customMultipleChip extends StatelessWidget {
  final String label;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  customMultipleChip({
    required this.label,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: myStyle(
            16,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
            FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 10.0,
          children:
              items.map((item) {
                return FilterChip(
                  backgroundColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.bktxtfld
                          : QuickTechAppColors.darktxtfieldcolor,
                  label: Text(
                    item,
                    style: myStyle(
                      12,
                     selectedItems.contains(item)? QuickTechAppColors.lightmaintextcolor
                          : themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                      FontWeight.normal,
                    ),
                  ),
                  selected: selectedItems.contains(item),
                  onSelected: (bool selected) {
                    List<String> updatedSelectedItems = List.from(
                      selectedItems,
                    );
                    if (selected) {
                      updatedSelectedItems.add(item);
                    } else {
                      updatedSelectedItems.remove(item);
                    }
                    onSelectionChanged(updatedSelectedItems);
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}
