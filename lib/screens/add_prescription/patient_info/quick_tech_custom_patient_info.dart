import 'package:e_prescription/const/const.dart';



import 'package:intl/intl.dart';

import '../widgets/quick_tech_prescription_widgets.dart';


final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

Widget customPatientInfo() {
 final PatientInfoController patientInfoController = locator.get<PatientInfoController>();
  return Card(
    color:
        themeController.isDay.value
            ? QuickTechAppColors.bktxtfld
            : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.7),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Information',
            style: myStyle(
              20,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => Text(
              'ID: ${patientInfoController.patientId.value > 0 ? patientInfoController.patientId.value : ''}',
              style: myStyle(
                17,
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
                FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          customTextField(onchanged: (value) => patientInfoController.patientName.value = value,

            'Patient Name',
            patientInfoController.patientName,
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 16),
          customTextField(onchanged: (value) => patientInfoController.age.value = value,
            'Age',
            patientInfoController.age,
            icon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          customTextField(onchanged: (value) => patientInfoController.phone.value = value,
            'Phone',
            patientInfoController.phone,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 12 + 16),
          Obx(
            () => DropdownButtonFormField<String>(onChanged: (value) => patientInfoController.gender.value = value ?? '',
              initialValue:
                  patientInfoController.gender.value.isEmpty
                      ? null
                      : patientInfoController.gender.value,
              decoration: InputDecoration(
                labelStyle: myStyle(
                  14,
                  themeController.isDay.value
                      ? QuickTechAppColors.black2
                      : QuickTechAppColors.whiteOpacity,
                ),
                labelText: 'Gender',
                prefixIcon: Icon(
                  Icons.transgender,
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaintextcolor
                          : QuickTechAppColors.darkmaintextcolor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaincolor
                            : QuickTechAppColors.darkmaincolor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                fillColor:
                    themeController.isDay.value
                        ? QuickTechAppColors.white
                        : QuickTechAppColors.bkdarktxtfld,
                filled: true,
              ),
              dropdownColor:
                  themeController.isDay.value
                      ? QuickTechAppColors.white
                      : QuickTechAppColors.bkdarktxtfld,
              items:
                  ['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: myStyle(
                          16,
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaintextcolor
                              : QuickTechAppColors.darkmaintextcolor,
                        ),
                      ),
                    );
                  }).toList(),
  
              style: TextStyle(fontSize: 16),
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 16),

          GestureDetector(
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaincolor
                                : QuickTechAppColors.darkmaincolor,
                        onPrimary: Colors.white, // Header text color
                        surface:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightScaffoldColor
                                : QuickTechAppColors.darkScaffoldColor,
                        onSurface:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor
                                : QuickTechAppColors.darkmaintextcolor,
                      ), dialogTheme: DialogThemeData(backgroundColor: themeController.isDay.value
                              ? Colors.white
                              : QuickTechAppColors.black),
                    ),
                    child: child!,
                  );
                },
              );
              if (selectedDate != null) {
                String formattedDate = DateFormat(
                  'd-M-yyyy',
                ).format(selectedDate);
                patientInfoController.date.value = selectedDate;
                patientInfoController.dateContoller.text = formattedDate;
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                style: myStyle(
                  14,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                ),
                controller: patientInfoController.dateContoller,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color:
                        themeController.isDay.value
                            ? QuickTechAppColors.black2
                            : QuickTechAppColors.whiteOpacity,
                  ),
                  labelText: 'Date ',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color:
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor
                            : QuickTechAppColors.darkmaintextcolor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaincolor,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                  fillColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.white
                          : QuickTechAppColors.bkdarktxtfld,
                  filled: true,
                ),
              ),
            ),
          ),
          // SizedBox(height: 20),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     final user = QuickTechAuthStorageService.getUser();
          //     patientInfoController.updatePatientInfo(user!.id!);
          //   },
          //   icon: Icon(Icons.save, color: QuickTechAppColors.white),
          //   label: Text(
          //     "Generate Patient ID",
          //     style: myStyle(14, QuickTechAppColors.white, FontWeight.bold),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor:
          //         themeController.isDay.value
          //             ? QuickTechAppColors.lightmaincolor
          //             : QuickTechAppColors.darkmaincolor,
          //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
