import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/quick_tech_on_examination_controller.dart';

import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/on_examination/widgets/quick_tech_custom_multiple_chips.dart';
import 'package:e_prescription/screens/add_assesment/on_examination/widgets/quick_tech_on_examination_widgets.dart';
import 'package:e_prescription/screens/add_assesment/on_examination/widgets/reflex/quick_tech_reflex.dart';

import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

Widget OnExamination({String? patientId}) {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechOnExaminationController examinationController = locator.get<QuickTechOnExaminationController>();

  
  examinationController.initializeAllData();
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'On Examination',
          style: myStyle(
            20,
            themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Body Type
        Obx(
          () => OnExaminationDropDown(
            label: 'Body type',
            items: examinationController.bodyTypeOptions,
            value: examinationController.bodyType.value,
            onChanged: (value) => examinationController.updateBodyType(value!),
            icon: Icons.accessibility,
            infoContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  examinationController.bodyTypeList
                      .asMap()
                      .entries
                      .map(
                        (entry) => OnExaminationInfoItem(
                          '${entry.key + 1}. ${entry.value.numericValue}:',
                          entry.value.textValue,
                        ),
                      )
                      .toList(),
            ),
            isExpanded: examinationController.bodyTypeInfoVisible,
          ),
        ),
        const SizedBox(height: 15),

        // Posture
        QuickTechCustomDropDown(
          label: 'Posture',
          items: examinationController.postureOptions,
          value: examinationController.posture.value,
          onChanged: (value) => examinationController.updatePosture(value!),
          // onChanged:
          //     (value) =>
          //         examinationController.updatePosture(value, Get.context),
          icon: Icons.accessibility_new,
          isDay: themeController.isDay.value,
          dialogHint: 'New New Posture',
          dialogTitle: "Add New Posture",
          enableOthersOption: true,
        ),
        const SizedBox(height: 15),

        // Gait
        QuickTechCustomDropDown(
          label: 'Gait',
          items: examinationController.gaitOptions,
          value: examinationController.gait.value,
          onChanged: (value) => examinationController.updateGait(value!),
          icon: Icons.directions_walk,
          isDay: themeController.isDay.value,
        ),
        const SizedBox(height: 15),

        // Activity
        QuickTechCustomDropDown(
          label: 'Activity',
          items: examinationController.activityOptions,
          value: examinationController.activity.value,
          onChanged: (value) => examinationController.updateActivity(value!),
          icon: Icons.fitness_center,
          isDay: themeController.isDay.value,
        ),
        const SizedBox(height: 15),

        // Percussion
        QuickTechCustomDropDown(
          label: 'Percussion',
          items: examinationController.percussionOptions,
          value: examinationController.percussion.value,
          onChanged: (value) => examinationController.updatePercussion(value!),
          icon: Icons.music_note,
          isDay: themeController.isDay.value,
     
        ),

        const SizedBox(height: 15),

        // Temperature
        QuickTechCustomDropDown(
          label: 'Temperature',
          items: examinationController.temperatureOption,
          value: examinationController.temperature.value,
          onChanged: examinationController.updateTemperature,
          icon: Icons.thermostat,
          isDay: themeController.isDay.value,
          dialogTitle: 'Add Temperature(°C)',
          dialogHint: 'Enter Temperature(°C)',
          enableOthersOption: true,
        ),

        /* QuickTechCustomTextField(
          txtcolor: themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor
              : QuickTechAppColors.darkmaintextcolor,
          lebelcolor: themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: )(0.7)
              : QuickTechAppColors.darkmaintextcolor.withValues(alpha: )(0.7),
          backcolor: themeController.isDay.value
              ? QuickTechAppColors.bktxtfld
              : QuickTechAppColors.bkdarktxtfld,
          icon: Icons.thermostat,
          iconcolor: themeController.isDay.value
              ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: )(0.7)
              : QuickTechAppColors.darkmaintextcolor.withValues(alpha: )(0.7),
          label: 'Temperature (°C)',
          controller: examinationController.temperatureController,
          onchanged: (value) => examinationController.updateTemperature(value),
        ),*/
        const SizedBox(height: 15),

        // Pulse
        QuickTechCustomDropDown(
          label: 'Pulse (bpm)',
          items: examinationController.pulseOptions,
          value: examinationController.pulse.value,
          onChanged: examinationController.updatePulse,
          icon: Icons.thermostat,
          isDay: themeController.isDay.value,
          dialogTitle: 'Add Pulse(bpm)',
          dialogHint: 'Enter Pulse(bpm)',
          enableOthersOption: true,
        ),
        /* OnExaminationTextField(
          label: 'Pulse (bpm)',
          controller: examinationController.pulseController,
          onchanged: (value) => examinationController.updatePulse(value),
          icon: Icons.favorite,
          infoContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnExaminationInfoItem('1-2 yr:', '98-140 beat/min'),
              OnExaminationInfoItem('3-5 yrs:', '80-120 beat/min'),
              OnExaminationInfoItem('6-7 yrs:', '75-118 beat/min'),
              OnExaminationInfoItem('Teens:', '60-100 beat/min'),
              OnExaminationInfoItem('Adult:', '72 beat/min'),
            ],
          ),
          isExpanded: examinationController.pulseInfoVisible,
        )*/
        const SizedBox(height: 15),

        // Blood Pressure
        QuickTechCustomTextField(
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          lebelcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          icon: Icons.local_hospital,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          label: 'Blood Pressure (mmHg)',
          controller: examinationController.bloodPressureController,
          onchanged:
              (value) => examinationController.updateBloodPressure(value),
        ),

        const SizedBox(height: 15),

        // Inflammatory Signs
        Obx(
          () => customMultipleChip(
            label: 'Inflammatory Signs',
            items: examinationController.inflammatorySignOptions,
            selectedItems: examinationController.inflammatorySign.value,
            onSelectionChanged: (selectedValues) {
              examinationController.updateInflammatorySigns(selectedValues);
            },
          ),
        ),
        const SizedBox(height: 15),

        // Reflex
        ReflexSelection(),

        const SizedBox(height: 15),

        // Sensory
        OnExaminationDropDown(
          label: 'Sensory',
          items: examinationController.sensoryGradeOptions,
          value: examinationController.sensory.value,
          onChanged: examinationController.updateSensory,
          icon: FontAwesomeIcons.eyeLowVision,
          infoContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                examinationController.sensoryGradeList
                    .map(
                      (grade) => OnExaminationInfoItem(
                        '${grade.numericValue}:',
                        grade.textValue,
                      ),
                    )
                    .toList(),
          ),
          isExpanded: examinationController.sensoryInfoVisible,
          dialogHint: 'Enter Sensory',
          dialogTitle: 'Add Sensory',
          enableOthersOption: true,
        ),
        const SizedBox(height: 15),

        // Motor
        // Motor
        Obx(
          () => OnExaminationDropDown(
            label: 'Motor',
            items: examinationController.motorGradeOptions,
            value: examinationController.motor.value,
            onChanged: (value) => examinationController.updateMotor(value!),
            icon: FontAwesomeIcons.personRunning,
            infoContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  examinationController.motorGradeList
                      .map(
                        (grade) => OnExaminationInfoItem(
                          '${grade.numericValue}:',
                          grade.textValue,
                        ),
                      )
                      .toList(),
            ),
            isExpanded: examinationController.motorINfoVisible,
          ),
        ),
        const SizedBox(height: 15),

        // Muscle Tone
       Obx(() =>  OnExaminationDropDown(
          label: 'Muscle Tone',
          items: examinationController.muscleToneOptions,
          value: examinationController.muscleTone.value,
          onChanged: (value) => examinationController.updateMuscleTone(value!),
          icon: FontAwesomeIcons.dumbbell,
          infoContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
              examinationController.muscleToneList.map((grade) => OnExaminationInfoItem(
                '${grade.numericValue}:',
                grade.textValue,
              )).toList(),
            
          ),
          dialogHint: 'Enter Muscle Tone',
          dialogTitle: 'Add Muscle Tone',
          enableOthersOption: true,
          isExpanded: examinationController.muscleToneInfoVisible,
        ),),
        const SizedBox(height: 15),

        // Spasticity
        OnExaminationDropDown(
          dialogHint: 'Enter Spasticity',
          dialogTitle: 'Add Spasticity',
          enableOthersOption: true,
          label: 'Spasticity',
          items: examinationController.spasticityOptions,
          value: examinationController.spasticity.value,
          onChanged:(value) =>  examinationController.updateSpasticity(value),
          icon: FontAwesomeIcons.personWalking,
          infoContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            examinationController.spasticityList.map((grade) => OnExaminationInfoItem(
                '${grade.numericValue}:',
                grade.textValue,
              )).toList(),
          ),
          isExpanded: examinationController.spasticityINfoVisible,
        ),

        const SizedBox(height: 15),

        // Bowel bladder control
        OnExaminationDropDown(
          label: 'Bowel bladder control',
          items: examinationController.bowelBladderControlOptions,
          value: examinationController.bowelBladderControl.value,
          onChanged:
              (value) =>
                  examinationController.updateBowelBladderControl(value!),
          icon: FontAwesomeIcons.toilet,
          infoContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
              examinationController.bowelBladderControlList.map((grade) => OnExaminationInfoItem(
                '${grade.numericValue}:',
                grade.textValue,
              )).toList(),
          ),
          isExpanded: examinationController.bowelControlInfoVisible,
        ),
        const SizedBox(height: 15),

        // Any limb or organ absence
        QuickTechCustomTextField(
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          lebelcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          icon: FontAwesomeIcons.bedPulse,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          label: 'Any limb or organ absence',
          controller: examinationController.limborganabsenseController,
          onchanged:
              (value) => examinationController.updateLimbOrOrganAbsence(value),
        ),
        const SizedBox(height: 15),

        // Balancing or co ordination
        QuickTechCustomTextField(
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          lebelcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          icon: FontAwesomeIcons.scaleBalanced,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          label: 'Balancing or coordination',
          controller: examinationController.balancingCoordinatingController,
          onchanged:
              (value) => examinationController.updateBalancingCondition(value),
        ),
        const SizedBox(height: 15),

        // Others
        QuickTechCustomTextField(
          txtcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
          lebelcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          backcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.bktxtfld
                  : QuickTechAppColors.bkdarktxtfld,
          icon: Icons.note_add,
          iconcolor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                  : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
          label: 'Other findings',
          controller: examinationController.othersController,
          onchanged: (value) => examinationController.updateOthers(value),
        ),
        const SizedBox(height: 30),
      
      ],
    ),
  );
}
