import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/models/patient_model.dart';
import 'package:e_prescription/screens/patient_records/patient_details/quick_tech_patients_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Widget customPatientCard({required Patient patient}) {
  final themeController = locator
      .get<QuickTechThemeController>();
  return Obx(
    () => Card(
      color:
          themeController.isDay.value
              ? QuickTechAppColors.bktxtfld
              : QuickTechAppColors.bkdarktxtfld,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.black.withValues(alpha: 0.15)
                      : QuickTechAppColors.whiteOpacity.withValues(alpha: 0.02),
              blurRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),

        child: ListTile(onTap: () {
          Get.to(()=> QuickTechPatientsDetails(patient: patient));
        },
          leading: CircleAvatar(
            radius: 22,
            backgroundColor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightaccentColor
                    : QuickTechAppColors.darkaccentColor,
            child: Icon(
              patient.gender == 'Male'
                  ? FontAwesomeIcons.person
                  : FontAwesomeIcons.personDress,
              color: Colors.white,
            ),
          ),
          title: Text(
            patient.name,
            style: myStyle(
              14,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gender: ${patient.gender}',
                style: myStyle(
                  10,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                ),
              ),
              Text(
                'Age: ${patient.age}',
                style: myStyle(
                  10,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),

          trailing: Column(
            children: [
              Text(
                "ID:${patient.id}",
                style: myStyle(
                  12,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                  FontWeight.bold,
                ),
              ),
              Text(
                patient.date.toString().split(' ')[0],
                style: myStyle(
                  10,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
