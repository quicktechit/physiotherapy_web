import 'package:flutter/material.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';

final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

/// Reusable dialog widget for adding multiple items
/// Example usage:
/// ```dart
/// showAddMultipleItemsDialog(
///   context: context,
///   title: 'Add Multiple Chief Complaints',
///   hintText: 'Enter complaint name',
///   onItemsAdded: (items) {
///     for (var item in items) {
///       prescrptionController.addComplaint(item);
///     }
///   },
/// );
/// ```
void showAddMultipleItemsDialog({
  required BuildContext context,
  required String title,
  required String hintText,
  required Function(List<String>) onItemsAdded,
  String addButtonLabel = 'Add Item',
  String addAllButtonLabel = 'Add All',
}) {
  final TextEditingController itemController = TextEditingController();
  final List<String> tempItems = [];

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.white
            : QuickTechAppColors.darktxtfieldcolor,
        title: Text(
          title,
          style: myStyle(
            16,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
            FontWeight.bold,
          ),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Instructions
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Type item name and tap Add or press Enter',
                      style: myStyle(
                        11,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                            : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                        FontWeight.w400,
                      ),
                    ),
                  ),

                  // Input field with Enter key support
                  TextField(
                    controller: itemController,
                    style: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                    ),
                    onSubmitted: (value) {
                      // Add item when Enter is pressed
                      final text = itemController.text.trim();
                      if (text.isNotEmpty && !tempItems.contains(text)) {
                        setState(() {
                          tempItems.add(text);
                        });
                        itemController.clear();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: myStyle(
                        12,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.5)
                            : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaincolor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: QuickTechAppColors.lightmaincolor,
                          ),
                          tooltip: 'Add item (or press Enter)',
                          onPressed: () {
                            final text = itemController.text.trim();
                            if (text.isNotEmpty && !tempItems.contains(text)) {
                              setState(() {
                                tempItems.add(text);
                              });
                              itemController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Display added items as chips
                  if (tempItems.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Added Items (${tempItems.length})',
                              style: myStyle(
                                12,
                                themeController.isDay.value
                                    ? QuickTechAppColors.lightmaintextcolor
                                    : QuickTechAppColors.darkmaintextcolor,
                                FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  tempItems.clear();
                                });
                              },
                              label: Text(
                                'Clear All',
                                style: myStyle(
                                  11,
                                  Colors.red,
                                  FontWeight.w500,
                                ),
                              ),
                              icon: Icon(
                                Icons.clear_all,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: tempItems.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return Chip(
                              avatar: CircleAvatar(
                                backgroundColor: QuickTechAppColors.lightmaincolor,
                                radius: 10,
                                child: Text(
                                  '${index + 1}',
                                  style: myStyle(
                                    10,
                                    QuickTechAppColors.white,
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                              backgroundColor: themeController.isDay.value
                                  ? QuickTechAppColors.whiteOpacity
                                  : QuickTechAppColors.darktxtfieldcolor,
                              label: Text(
                                item,
                                style: myStyle(
                                  12,
                                  themeController.isDay.value
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.darkmaintextcolor,
                                ),
                              ),
                              deleteIcon: Icon(
                                Icons.close,
                                size: 16,
                                color: themeController.isDay.value
                                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.6)
                                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.6),
                              ),
                              onDeleted: () {
                                setState(() {
                                  tempItems.removeAt(index);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'No items added yet',
                        style: myStyle(
                          12,
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.5)
                              : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                          FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: myStyle(
                14,
                Colors.red,
                FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed:  () {
                    onItemsAdded(tempItems);
                    Navigator.pop(dialogContext);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: QuickTechAppColors.lightmaincolor,
              disabledBackgroundColor: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.5),
            ),
            icon: Icon(
              Icons.check_circle,
              color: QuickTechAppColors.white,
            ),
            label: Text(
              addAllButtonLabel,
              style: myStyle(
                14,
                QuickTechAppColors.white,
                FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
