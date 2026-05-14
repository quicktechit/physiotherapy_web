import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';

import 'package:e_prescription/screens/patient_records/widgets/quick_tech_patient_card.dart';
import 'package:e_prescription/widgets/quick_tech_custom_spinner.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickTechPatientRecords extends StatefulWidget {
  final bool isAppBarVisible;

  QuickTechPatientRecords({required this.isAppBarVisible});

  @override
  State<QuickTechPatientRecords> createState() => _QuickTechPatientRecordsState();
}

class _QuickTechPatientRecordsState extends State<QuickTechPatientRecords> {
  final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

  @override
  void initState() {
    super.initState();
    patientController.fetchPatients();
  }
  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        appBar:
            widget.isAppBarVisible
                ? AppBar(
                  backgroundColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                  elevation: 4,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Patient Records',
                    style: myStyle(
                      18,
                      QuickTechAppColors.white,
                      FontWeight.bold,
                    ),
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
                )
                : null,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      themeController.isDay.value
                          ? QuickTechAppColors.bktxtfld
                          : QuickTechAppColors.bkdarktxtfld,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: patientController.searchPatientController,
                  decoration: InputDecoration(
                    hintText: 'Search for patients...',
                    hintStyle: myStyle(
                      14,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightsecondarytextcolor
                          : QuickTechAppColors.darksecondarytextcolor,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaintextcolor,
                    ),

                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                  onChanged: (value) {
                    patientController.searchPatients(value);
                  },
                ),
              ),
         
            ),
            Expanded(
              child: Obx(() {
                if (patientController.isPatientsLoading.value) {
                  return Center(
                    child: CustomSpinner(),
                  );
                }
                if (patientController.patients.isEmpty) {
                  return Center(
                    child: Text(
                      'No patients found.',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                  itemCount: patientController.patients.length,
                  itemBuilder: (context, index) {
                    final patient = patientController.patients[index];
                      return Dismissible(
                        key: Key(patient.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        onDismissed: (direction) async {
                          final patientId = patient.id;
                          final success = await patientController.deletePatient(patientId);
                          if (success) {
                            patientController.removePatient(index);
                           
                          } else {
                          
                            patientController.patients.insert(index, patient);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete patient')), 
                            );
                          }
                        },
                        child: customPatientCard(patient: patient),
                      );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
