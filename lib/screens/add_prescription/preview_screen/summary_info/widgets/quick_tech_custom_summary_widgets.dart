import 'package:e_prescription/controllers/prescription_controller/diagnosis_controller/previous_therapy_Controller.dart';
import 'package:flutter/material.dart';
import 'package:e_prescription/controllers/prescription_controller/prescription_rx_controller/quick_tech_electrotherapy_controller.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';

Widget customElectrotherapySection({
  required QuickTechElectrotherapyController electrotherapyController,
  required Color textColor,
  required Color accentColor,
}) {
  // Only show therapies with at least one selected parameter
  final selectedTherapies = electrotherapyController.selectedParameters.entries
      .where((entry) =>
          entry.value.isNotEmpty &&
          entry.value.values.any((v) => v != null && v.toString().isNotEmpty))
      .toList();

  if (selectedTherapies.isEmpty) return SizedBox();

  // Helper to format parameter display name
  String _formatParamKey(String key) {
    // Skip internal fields
    if (key == 'Area IDs') return ''; // Skip, we show Area Names instead
    if (key == 'Area Names') return 'Area';
    if (key == 'Pulse Duration/Ratio') return 'Pulse Duration';
    return key;
  }

  // Helper to format value display
  String _formatValue(dynamic value) {
    if (value == null) return 'Not selected';
    if (value is List) return value.join(', ');
    return value.toString();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Electrotherapy',
        style: myStyle(15, accentColor, FontWeight.bold),
      ),
      SizedBox(height: 8),
      ...selectedTherapies.map((entry) {
        // Filter out empty/null parameters and internal fields
        final filteredParams = entry.value.entries
            .where((p) {
              final formattedKey = _formatParamKey(p.key);
              return formattedKey.isNotEmpty &&
                  p.value != null &&
                  p.value.toString().isNotEmpty;
            })
            .toList();

        if (filteredParams.isEmpty) return SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key, // Therapy name (e.g., "UST", "SWD")
                style: myStyle(13, accentColor, FontWeight.w700),
              ),
              SizedBox(height: 4),
              ...filteredParams.map((param) {
                final displayKey = _formatParamKey(param.key);
                final displayValue = _formatValue(param.value);
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 2),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$displayKey: ',
                          style: myStyle(12, textColor, FontWeight.w500),
                        ),
                        TextSpan(
                          text: displayValue,
                          style: myStyle(12, textColor.withValues(alpha: 0.85)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }).toList(),
      Divider(color: accentColor.withValues(alpha: 0.2)),
    ],
  );
}
Widget customSection({
  required String title,
  required List<String> items,
  required Map<String, List<String>> subItemsMap,
  required Color textColor,
  required Color accentColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: myStyle(16, accentColor, FontWeight.w600),
      ),
      Divider(color: accentColor.withValues(alpha: 0.2)),
      ...items.map((item) {
        var subItems = subItemsMap[item] ?? [];
        return Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '• $item',
                  style: myStyle(14, textColor, FontWeight.w600),
                ),
                if (subItems.isNotEmpty)
                  TextSpan(
                    text: ': ${subItems.join(', ')}',
                    style: myStyle(14, textColor.withValues(alpha: 0.9)),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    ],
  );
}

Widget customSectionList({
  required String title,
  required List<String> items,
  required Color textColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: myStyle(16, QuickTechAppColors.lightmaincolor, FontWeight.w600),
      ),
      Divider(color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.2)),
      SizedBox(height: 8),
      ...items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            '• $item',
            style: myStyle(14, textColor),
          ),
        );
      }).toList(),
    ],
  );
}


Widget customTherapyHIstory({
  required PreviousTherapyHistoryController therapyController,
  required Color textColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Previous Therapy History',
        style: myStyle(14, QuickTechAppColors.lightmaincolor, FontWeight.w600),
      ),
      Divider(color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.2)),
      SizedBox(height: 8),
      
      // Electrotherapy Section
      if (therapyController.selectedElectrotherapy.isNotEmpty)
        customTherapyDetails(
          'Electrotherapy',
          therapyController.selectedElectrotherapy,
          therapyController.therapyDetails,
          textColor,
        ),
      
      // Manual Therapy Section
      if (therapyController.selectedManualTherapy.isNotEmpty) ...[
        SizedBox(height: 12),
        customTherapyDetails(
          'Manual Therapy',
          therapyController.selectedManualTherapy,
          therapyController.therapyDetails,
          textColor,
        ),
      ],
      
      // Additional Therapies Section
      if (therapyController.selectedAdditionalTherapies.isNotEmpty) ...[
        SizedBox(height: 12),
        customTherapyDetails(
          'Other Therapies',
          therapyController.selectedAdditionalTherapies,
          therapyController.therapyDetails,
          textColor,
        ),
      ],
      
      if (therapyController.othersDetails.value.isNotEmpty) ...[
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Others:',
              style: myStyle(14, textColor, FontWeight.w600),
            ),
            SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: textColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: textColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Text(
                therapyController.othersDetails.value,
                style: myStyle(14, textColor),
              ),
            ),
          ],
        ),
      ],
    ],
  );
}

Widget customTherapyDetails(
  String title,
  List<Map<String, dynamic>> selectedTherapies,
  Map<String, Map<String, dynamic>> therapyDetails,
  Color textColor,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: myStyle(12, QuickTechAppColors.lightmaincolor, FontWeight.bold),
      ),
      ...selectedTherapies.map((therapy) {
        final id = therapy['id'].toString();
        final details = therapyDetails[id] ?? {};
        return Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ${therapy['name']}',
                style: myStyle(11, textColor),
              ),
              if (details.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customElectrotherapyDetails('Duration', details['duration'], textColor),
                      customElectrotherapyDetails('Frequency', details['frequency'], textColor),
                      customElectrotherapyDetails(
                        'Regular', 
                        details['isRegular'] != null 
                            ? (details['isRegular'] ? 'Yes' : 'No') 
                            : 'N/A', 
                        textColor
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}


Widget customElectrotherapyDetails(String label, dynamic value, Color textColor) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: myStyle(13, textColor.withValues(alpha: 0.8), FontWeight.w500),
          ),
          TextSpan(
            text: value?.toString() ?? 'N/A',
            style: myStyle(13, textColor),
          ),
        ],
      ),
    ),
  );
}

Widget customRow(String label, String value, Color textColor) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: myStyle(14, textColor, FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(
            value.isNotEmpty ? value : '',
            style: myStyle(14, textColor.withValues(alpha: 0.9)),
          ),
        ),
      ],
    ),
  );
}
Widget customTherapyLIst(
  String title,
  List<String> selectedTherapies,
  Color textColor,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: myStyle(14, QuickTechAppColors.lightmaincolor, FontWeight.w500),
      ),
      SizedBox(height: 8),
      ...selectedTherapies.map((therapy) {
        return Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            '• $therapy',
            style: myStyle(14, textColor),
          ),
        );
      }).toList(),
    ],
  );
}
