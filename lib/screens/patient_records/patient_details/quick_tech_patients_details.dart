import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/patient_records/patient_details/widgets/quick_tech_patient_details_widgets.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:e_prescription/models/patient_model.dart';
import 'package:get/get.dart';

class QuickTechPatientsDetails extends StatefulWidget {
  final Patient patient;
  QuickTechPatientsDetails({required this.patient});

  @override
  State<QuickTechPatientsDetails> createState() =>
      _QuickTechPatientsDetailsState();
}

class _QuickTechPatientsDetailsState extends State<QuickTechPatientsDetails>
    with SingleTickerProviderStateMixin {
  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();
  final QuickTechPatientController patientController =
      locator.get<QuickTechPatientController>();

  @override
  void initState() {
    super.initState();
    final bearerToken = QuickTechAuthStorageService.getToken();
    if (bearerToken != null) {
      patientController.fetchPrescriptions(widget.patient.id, bearerToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          ),
          title: Text(
            'Patient Details',
            style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: themeController.toggleTheme,
              icon: Obx(
                () => Icon(
                  themeController.isDay.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color:
                      themeController.isDay.value
                          ? Colors.yellow
                          : Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightScaffoldColor
                          : QuickTechAppColors.darkScaffoldColor.withValues(alpha:
                            0.7,
                          ),
                  shadowColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.black
                          : QuickTechAppColors.whiteOpacity.withValues(alpha: 0.4),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        customDetilsTile('Name:', widget.patient.name),
                        SizedBox(height: 8),
                        customDetilsTile('Gender:', widget.patient.gender),
                        SizedBox(height: 8),
                        customDetilsTile('Age:', widget.patient.age.toString()),
                        SizedBox(height: 8),
                        customDetilsTile(
                          'Patient ID:',
                          widget.patient.id.toString(),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Assessment and Prescriptions',
                      style: myStyle(
                        16,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightmaintextcolor
                            : QuickTechAppColors.darkmaintextcolor,
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(() {
                      if (patientController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (patientController.error.isNotEmpty) {
                        return Text(
                          'Error: ${patientController.error.value}',
                          style: myStyle(
                            14,
                            Colors.red,
                            FontWeight.normal,
                          ),
                        );
                      } else if (patientController.prescriptions.isNotEmpty) {
                        return Column(
                          children: patientController.prescriptions.map((
                            prescription,
                          ) {
                            return customPrescriptionListItem(
                              context,
                              widget.patient.id,
                              prescription,
                            );
                          }).toList(),
                        );
                      } else {
                        return Text(
                          'No prescriptions found.',
                          style: myStyle(
                            14,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor
                                : QuickTechAppColors.darkmaintextcolor,
                            FontWeight.normal,
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
