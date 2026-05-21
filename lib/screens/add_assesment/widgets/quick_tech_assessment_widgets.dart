
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: mainColor.withValues(alpha:0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: mainColor, size: 22),
        ),
        const SizedBox(width: 12),
        Text(title, style: myStyle(18, mainColor, FontWeight.bold)),
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.03),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha:0.18)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha:0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ]),
          const SizedBox(height: 14),
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
      if (j < cols - 1) rowChildren.add(const SizedBox(width: 14));
    }
    rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowChildren));
    rows.add(const SizedBox(height: 12));
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
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: color)),
                const SizedBox(height: 2),
                Text(description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
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