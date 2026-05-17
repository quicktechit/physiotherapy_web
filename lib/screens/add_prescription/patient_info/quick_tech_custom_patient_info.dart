import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:intl/intl.dart';


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
          QuickTechCustomTextField(
            label: 'Patient Name',
            icon: Icons.person_outline,
            controller: patientInfoController.patientNameController,
            keyboardType: TextInputType.name,
            onchanged: (value) => patientInfoController.patientName.value = value,
          ),
          SizedBox(height: 16),
          QuickTechCustomTextField(
            label: 'Age',
            icon: Icons.cake_outlined,
            controller: patientInfoController.ageController,
            keyboardType: TextInputType.number,
            onchanged: (value) => patientInfoController.age.value = value,
          ),
          SizedBox(height: 16),
          QuickTechCustomTextField(
            label: 'Phone',
            icon: Icons.phone,
            controller: patientInfoController.phoneController,
            keyboardType: TextInputType.phone,
            onchanged: (value) => patientInfoController.phone.value = value,
          ),
          SizedBox(height: 28),
          Obx(
            () => QuickTechCustomDropDown<String>(
              label: 'Gender',
              items: ['Male', 'Female', 'Other'],
              value: patientInfoController.gender.value.isEmpty
                  ? null
                  : patientInfoController.gender.value,
              onChanged: (value) => patientInfoController.gender.value = value ?? '',
              icon: Icons.transgender,
              isDay: themeController.isDay.value,
              iconColor: themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
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
                        onPrimary: Colors.white,
                        surface:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightScaffoldColor
                                : QuickTechAppColors.darkScaffoldColor,
                        onSurface:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor
                                : QuickTechAppColors.darkmaintextcolor,
                      ),
                      dialogTheme: DialogThemeData(
                          backgroundColor: themeController.isDay.value
                              ? Colors.white
                              : QuickTechAppColors.black),
                    ),
                    child: child!,
                  );
                },
              );
              if (selectedDate != null) {
                String formattedDate = DateFormat('d-M-yyyy').format(selectedDate);
                patientInfoController.date.value = selectedDate;
                patientInfoController.dateContoller.text = formattedDate;
              }
            },
            child: AbsorbPointer(
              child: QuickTechCustomTextField(
                label: 'Date',
                icon: Icons.calendar_today,
                controller: patientInfoController.dateContoller,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
