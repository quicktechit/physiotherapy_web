import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/patient_info/quick_tech_patient_info_controlle.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';

import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';

import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget generalInfoPage() {
    final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
    final QuickTechPatientInfoController patientInfoCOntroller = locator.get<QuickTechPatientInfoController>();
  
  print("Patient ID:${patientInfoCOntroller.currentPatientId}");
    return Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                  
          Text(
            'ID:${patientInfoCOntroller.currentPatientId!=null?patientInfoCOntroller.currentPatientId:""}',
            style: myStyle(
              17,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
       
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.person,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: 'Patient Name',
            controller: patientInfoCOntroller.patientNameController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged:
                (value) => patientInfoCOntroller.updatePatientName(value),
          ),
          SizedBox(height: 10),
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.person,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Father's Name",
            controller: patientInfoCOntroller.fatherNameController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged: (value) => patientInfoCOntroller.updateFatherName(value),
          ),
          SizedBox(height: 10),
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.person,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Mother's Name",
            controller: patientInfoCOntroller.motherNameController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged: (value) => patientInfoCOntroller.updateMotherName(value),
          ),
          SizedBox(height: 10),
                 QuickTechCustomTextField(keyboardType: TextInputType.phone,
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.phone,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Phone Number",
            controller: patientInfoCOntroller.phoneController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged: (value) => patientInfoCOntroller.updatePhoneNumber(value),
          ),
          SizedBox(height: 10,),
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.person,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Spouse Name",
            controller: patientInfoCOntroller.spouseNameController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged: (value) => patientInfoCOntroller.updateSpouseName(value),
          ),
          SizedBox(height: 10),
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.cake,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Age",
            controller: patientInfoCOntroller.ageController,
            onchanged: (value) {
              patientInfoCOntroller.updateAge(int.tryParse(value) ?? 0);
            },
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
          ),
          SizedBox(height: 10), // Sex
          QuickTechCustomDropDown<String?>(
            label: "Sex",
            items: patientInfoCOntroller.sexOptions,
            value: patientInfoCOntroller.sex.value,
            onChanged: (value) => patientInfoCOntroller.updateSex(value!),
            icon: Icons.accessibility,
            isDay: themeController.isDay.value,
          ),
          SizedBox(height: 10),
          //Occupation
          QuickTechCustomDropDown<String?>(
            label: "Occupation",
            items: patientInfoCOntroller.occupationOptions,
            value: patientInfoCOntroller.occupation.value,
            onChanged: patientInfoCOntroller.updateOccupation,
            icon: FontAwesomeIcons.briefcase,
            isDay: themeController.isDay.value,
            enableOthersOption: true,
            dialogTitle: "Add New Occupation",
            dialogHint: "Enter New Occupation",
          ),
          SizedBox(height: 10),
          // Marital Status
          QuickTechCustomDropDown<String?>(
            label: "Marrital Status",
            items: patientInfoCOntroller.maritalStatusOptions,
            value: patientInfoCOntroller.maritalStatus.value,
            onChanged:
                (value) => patientInfoCOntroller.updateMaritalStatus(value!),
            icon: Icons.favorite,
            isDay: themeController.isDay.value,
          ),
          SizedBox(height: 10),

          // Blood Group
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.bloodtype,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Blood Group",
            controller: patientInfoCOntroller.bloodGroupController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged: (value) => patientInfoCOntroller.updateBloodGroup(value),
          ),
          SizedBox(height: 10),

          // Guardian Name
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.person,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Guardian Name",
            controller: patientInfoCOntroller.guardianNameController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged:
                (value) => patientInfoCOntroller.updateGuardianName(value),
          ),
          SizedBox(height: 10),
          // Voter ID
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.fingerprint,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Voter ID",
            controller: patientInfoCOntroller.voterIDController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged: (value) => patientInfoCOntroller.updateVoterID(value),
          ),
          SizedBox(height: 10),
          // Birth Date
          // In generalInfoPage() replace the existing birth date TextField with this:
          GestureDetector(
            onTap: () => patientInfoCOntroller.selectDateOfBirth(Get.context!),
            child: AbsorbPointer(
              child: QuickTechCustomTextField(
                lebelcolor:
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                        : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                txtcolor:
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor
                        : QuickTechAppColors.darkmaintextcolor,
                icon: Icons.cake,
                iconcolor:
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                        : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                label: "Date of Birth",
                controller: patientInfoCOntroller.birthDateController,
                height: 50,
                backcolor:
                    themeController.isDay.value
                        ? QuickTechAppColors.bktxtfld
                        : QuickTechAppColors.darktxtfieldcolor,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Birth registration no
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: Icons.view_comfortable_outlined,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Birth registration no",
            controller: patientInfoCOntroller.birthRegistrationNoController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged:
                (value) =>
                    patientInfoCOntroller.updateBirthRegistrationNo(value),
          ),
          SizedBox(height: 10),
          // Disability ID no
          QuickTechCustomTextField(
            lebelcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            txtcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
            icon: FontAwesomeIcons.wheelchairMove,
            iconcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                    : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
            label: "Disability ID no",
            controller: patientInfoCOntroller.disabilityIDController,
            height: 50,
            backcolor:
                themeController.isDay.value
                    ? QuickTechAppColors.bktxtfld
                    : QuickTechAppColors.darktxtfieldcolor,
            onchanged:
                (value) => patientInfoCOntroller.updateDisabilityID(value),
          ),
          SizedBox(height: 10),
          // Education of Patient
          QuickTechCustomDropDown<String?>(
            label: "Education of Patient",
            items: patientInfoCOntroller.educationOptions,
            value: patientInfoCOntroller.educationOfPatient.value,
            onChanged:
                (value) =>
                    patientInfoCOntroller.updateEducationOfPatient(value!),
            icon: Icons.school,
            isDay: themeController.isDay.value,
          ),
          SizedBox(height: 10),
          // Education of Parents
          QuickTechCustomDropDown<String?>(
            label: "Education of Guardian",
            items: patientInfoCOntroller.educationOptions,
            value: patientInfoCOntroller.educationOfGuardian.value,
            onChanged:
                (value) =>
                    patientInfoCOntroller.updateEducationOfGuardian(value!),
            icon: FontAwesomeIcons.graduationCap,
            isDay: themeController.isDay.value,
          ),
          SizedBox(height: 10),
   
        ],
      ),
    ),
  );
}
