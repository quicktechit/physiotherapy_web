import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added ScreenUtil import

// ─────────────────────────────────────────────
// 1. Section Header
// ─────────────────────────────────────────────
Widget assessmentHeader({
  required Color mainColor,
  required String title,
  required IconData icon,
}) =>
    Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w), // Responsive padding
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r), // Responsive radius
          ),
          child: Icon(icon, color: mainColor, size: 22.sp), // Responsive icon size
        ),
        SizedBox(width: 12.w), // Responsive width
        Text(title, style: myStyle(18.sp, mainColor, FontWeight.bold)), // Responsive font size
      ],
    );

// ─────────────────────────────────────────────
// 2. Section Card
// ─────────────────────────────────────────────
Widget assessmentCard({
  required Color color,
  required String title,
  required IconData icon,
  required Widget child,
}) =>
    Container(
      padding: EdgeInsets.all(18.w), // Responsive padding
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14.r), // Responsive radius
        border: Border.all(color: color.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r, // Responsive blur radius
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 18.sp), // Responsive icon size
            SizedBox(width: 8.w), // Responsive width
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp, // Responsive font size
              ),
            ),
          ]),
          SizedBox(height: 14.h), // Responsive height
          child,
        ],
      ),
    );

// ─────────────────────────────────────────────
// 3. Responsive Grid Builder
// ─────────────────────────────────────────────
Widget assessmentGrid({required List<Widget> fields, required int cols}) {
  final rows = <Widget>[];
  for (int i = 0; i < fields.length; i += cols) {
    final rowChildren = <Widget>[];
    for (int j = 0; j < cols; j++) {
      final idx = i + j;
      rowChildren.add(
          Expanded(child: idx < fields.length ? fields[idx] : const SizedBox()));
      if (j < cols - 1) rowChildren.add(SizedBox(width: 14.w)); // Responsive width
    }
    rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowChildren));
    rows.add(SizedBox(height: 12.h)); // Responsive height
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
}

// ─────────────────────────────────────────────
// 4. Guide Item (desktop info panel)
// ─────────────────────────────────────────────
Widget assessmentGuideItem({
  required Color color,
  required IconData icon,
  required String title,
  required String description,
}) =>
    Padding(
      padding: EdgeInsets.only(bottom: 14.h), // Responsive bottom padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18.sp), // Responsive icon size
          SizedBox(width: 10.w), // Responsive width
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp, // Responsive font size
                    color: color,
                  ),
                ),
                SizedBox(height: 2.h), // Responsive height
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp, // Responsive font size
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

// ─────────────────────────────────────────────
// 5. Dropdown shorthand
// ─────────────────────────────────────────────
Widget assessmentDropdown({
  required String label,
  required List items,
  required dynamic value,
  required Function(dynamic) onChanged,
  required IconData icon,
  required bool isDay,
  bool enableOthers = false,
  String? dialogTitle,
  String? dialogHint,
}) =>
    QuickTechCustomDropDown(
      label: label,
      items: items,
      value: value,
      onChanged: onChanged,
      icon: icon,
      isDay: isDay,
      enableOthersOption: enableOthers,
      dialogTitle: dialogTitle,
      dialogHint: dialogHint,
    );

// ─────────────────────────────────────────────
// 6. Guide data model
// ─────────────────────────────────────────────
class AssessmentGuide {
  final IconData icon;
  final String title;
  final String description;

  const AssessmentGuide({
    required this.icon,
    required this.title,
    required this.description,
  });
}