import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/assessment_controller/assestive_device/quick_tech_assestive_device_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/birth_history/quick_tech_birth_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/differential_diagnosis/quick_tech_differential_diagnosis_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/family_history/quick_tech_family_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/home_advice/quick_tech_home_advice_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/mother_health_condition_during_pregnancy/quick_tech_mother_health_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/muscle_power/quick_tech_muscle_power_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/occupation_history/quick_tech_occupation_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/on_examination/quick_tech_on_examination_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/past_medical_history/quick_tech_past_medical_history_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/patient_info/quick_tech_patient_info_controlle.dart';
import 'package:e_prescription/controllers/assessment_controller/problem_summary/quick_tech_problem_summary_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/range_of_motion/quick_tech_range0f_motion_controller.dart';
import 'package:e_prescription/controllers/assessment_controller/referred_to/quick_tech_referred_to_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_assesment/assestive_device/quick_tech_assestive_device.dart';
import 'package:e_prescription/screens/add_assesment/birth_history/quick_tech_birth_history.dart';
import 'package:e_prescription/screens/add_assesment/differential_diagnosis/quick_tech_differential_diagnosis.dart';
import 'package:e_prescription/screens/add_assesment/family_history/quick_tech_family_history.dart';
import 'package:e_prescription/screens/add_assesment/home_advice/quick_tech_home_advice.dart';
import 'package:e_prescription/screens/add_assesment/mother_health_condition_during_pregnancy/quick_tech_mother_health.dart';
import 'package:e_prescription/screens/add_assesment/muscle_power/quick_tech_muscle_power.dart';
import 'package:e_prescription/screens/add_assesment/occupation_history/quick_tech_occupation_history.dart';
import 'package:e_prescription/screens/add_assesment/on_examination/quick_tech_on_examintion.dart';
import 'package:e_prescription/screens/add_assesment/past_medical_historu/quick_tech_past_medical_history.dart';
import 'package:e_prescription/screens/add_assesment/patient_info/quick_tech_patient_info.dart';
import 'package:e_prescription/screens/add_assesment/problem_summary_goal/quick_tech_problem_summary.dart';
import 'package:e_prescription/screens/add_assesment/range_of_motion/quick_tech_range_of_motion.dart';
import 'package:e_prescription/screens/add_assesment/referred_to/quick_tech_referred_to.dart';
import 'package:e_prescription/screens/add_prescription/quick_tech_add_prescription_form.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drawer.dart';
import 'package:e_prescription/services/quick_tech_patient_draft_storage_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class QuickTechAddAssesmentPage extends StatefulWidget {
  @override
  _QuickTechAddAssesmentPageState createState() =>
      _QuickTechAddAssesmentPageState();
}

class _QuickTechAddAssesmentPageState extends State<QuickTechAddAssesmentPage> with TickerProviderStateMixin {

  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
 final RxList<bool> _tabCompleted = <bool>[false, false, false, false, false, false, false, false, false, false, false, false, false, false].obs;

  final QuickTechPatientInfoController patientInfoController = locator.get<QuickTechPatientInfoController>();
  final QuickTechOccupationHistoryController occupationHistoryController = locator.get<QuickTechOccupationHistoryController>();
  final QuickTechFamilyHistoryController familyHistoryController = locator.get<QuickTechFamilyHistoryController>();
  final QuickTechBirthHistoryController birthHistoryController = locator.get<QuickTechBirthHistoryController>();
  final QuickTechMotherHealthController motherHealthController = locator.get<QuickTechMotherHealthController>();
  final QuickTechPastMedicalHistoryController pastMedicalHistoryController = locator.get<QuickTechPastMedicalHistoryController>();
  final QuickTechOnExaminationController onExaminationController = locator.get<QuickTechOnExaminationController>();
  final QuickTechMusclePowerController musclePowerController = locator.get<QuickTechMusclePowerController>();
  final QuickTechRange0fMotionController range0fMotionController = locator.get<QuickTechRange0fMotionController>();
  final QuickTechProblemSummaryController problemSummaryController = locator.get<QuickTechProblemSummaryController>();
  final QuickTechHomeAdviceController homeAdviceController = locator.get<QuickTechHomeAdviceController>();
  final QuickTechDifferentialDiagnosisController differentialDiagnosisController = locator.get<QuickTechDifferentialDiagnosisController>();
  final QuickTechAssestiveDeviceController assestiveDeviceController = locator.get<QuickTechAssestiveDeviceController>();
  final QuickTechReferredToController referredToController = locator.get<QuickTechReferredToController>();

  late TabController _tabController;
  DateTime _lastSaveTime = DateTime.fromMillisecondsSinceEpoch(0);
  static const int _saveDebounceMs = 2000;
  final RxBool _isSaving = false.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 14, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Clear all assessment data across all controllers
  void _clearAllAssessmentData() {
    patientInfoController.clearPatientInfo();
    occupationHistoryController.clearOccupationHistory();
    familyHistoryController.clearFamilyHistory();
    birthHistoryController.clearBirthHistory();
    motherHealthController.clearMotherHealth();
    pastMedicalHistoryController.clearPastMedicalHistory();
    onExaminationController.clearForm();
    musclePowerController.clearMusclePower();
    range0fMotionController.clearRangeOfMotion();
    problemSummaryController.clearProblemSummary();
    homeAdviceController.clearHomeAdvice();
    differentialDiagnosisController.clearDifferentialDiagnosis();
    assestiveDeviceController.clearAssestiveDevice();
    referredToController.clearReferredTo();
  }

  /// Handle save action for the current tab
  Future<void> _handleSaveAction() async {
    if (_isSaving.value) return;

    final now = DateTime.now();
    if (now.difference(_lastSaveTime).inMilliseconds < _saveDebounceMs) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait before saving again'),
          backgroundColor: Colors.orange,
          duration: Duration(milliseconds: 1500),
        ),
      );
      return;
    }
    _lastSaveTime = now;

    final currentIndex = _tabController.index;
    int status = 500;
    String sectionName = '';
    int nextTabIndex = currentIndex + 1;

    // --- Resolve section meta BEFORE setting _isSaving ---
    switch (currentIndex) {
      case 0:  sectionName = 'Patient Info';                              nextTabIndex = 1;  break;
      case 1:  sectionName = 'Occupation History';                        nextTabIndex = 2;  break;
      case 2:  sectionName = 'Family History';                            nextTabIndex = 3;  break;
      case 3:  sectionName = 'Birth History';                             nextTabIndex = 4;  break;
      case 4:  sectionName = 'Mother Health Condition';                   nextTabIndex = 5;  break;
      case 5:  sectionName = 'Past Medical History';                      nextTabIndex = 6;  break;
      case 6:  sectionName = 'On Examination';                            nextTabIndex = 7;  break;
      case 7:  sectionName = 'Muscle Power';                              nextTabIndex = 8;  break;
      case 8:  sectionName = 'Range of Motion';                           nextTabIndex = 9;  break;
      case 9:  sectionName = 'Problem Summary & Goals';                   nextTabIndex = 10; break;
      case 10: sectionName = 'Home Advice';                               nextTabIndex = 11; break;
      case 11: sectionName = 'Differential Diagnosis';                    nextTabIndex = 12; break;
      case 12: sectionName = 'Assistive Device';                          nextTabIndex = 13; break;
      case 13: sectionName = 'Referred To';                               nextTabIndex = 13; break;
      default: return;
    }

    // --- Validate patient ID for all tabs except Patient Info ---
    if (currentIndex > 0 && !_validatePatientId()) return;

    // --- Validate data presence for all tabs except Patient Info ---
    if (currentIndex > 0) {
      final bool hasData = switch (currentIndex) {
        1  => occupationHistoryController.hasData(),
        2  => familyHistoryController.hasData(),
        3  => birthHistoryController.hasData(),
        4  => motherHealthController.hasData(),
        5  => pastMedicalHistoryController.hasData(),
        6  => onExaminationController.hasData(),
        7  => musclePowerController.hasData(),
        8  => range0fMotionController.hasData(),
        9  => problemSummaryController.hasData(),
        10 => homeAdviceController.hasData(),
        11 => differentialDiagnosisController.hasData(),
        12 => assestiveDeviceController.hasData(),
        13 => referredToController.hasData(),
        _  => false,
      };

      if (!hasData) {
        _showValidationErrorDialog(sectionName);
        return; // _isSaving was never set — no cleanup needed
      }
    }

    _isSaving.value = true;

    try {
      const timeout = Duration(seconds: 20);
      final pid = patientInfoController.currentPatientId;

      status = await switch (currentIndex) {
        0 => patientInfoController.postPatientInfo().timeout(timeout, onTimeout: () => 408),
        1 => occupationHistoryController.storeOccupationHistory(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        2 => familyHistoryController.storeFamilyHistory(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        3 => birthHistoryController.storeBirthHistory(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        4 => motherHealthController.storeMotherHealthCondition(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        5 => pastMedicalHistoryController.storePastMedicalHistory(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        6 => onExaminationController.storeOnExamination(date: DateTime.now().toString(), patientId: pid!).timeout(timeout, onTimeout: () => 408),
        7 => musclePowerController.submitMusclePowerData(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        8 => range0fMotionController.submitRangeOfMotionData(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        9 => problemSummaryController.storeSummaryAdvice(pid!).timeout(timeout, onTimeout: () => 408),
        10 => homeAdviceController.storeHomeAdvice(patientId: pid!).timeout(timeout, onTimeout: () => 408),
        11 => differentialDiagnosisController.storeAssessmentDiagnosis().timeout(timeout, onTimeout: () => 408),
        12 => assestiveDeviceController.storeAssestiveDeviceData().timeout(timeout, onTimeout: () => 408),
        13 => referredToController.storeReferredTo(pid!).timeout(timeout, onTimeout: () => 408),
        _  => Future.value(500),
      };

      // Save draft after successful Patient Info save
      if (currentIndex == 0 && (status == 200 || status == 201)) {
        await QuickTechPatientDraftStorageService.saveDraft(
          name: patientInfoController.patientNameController.text,
          phone: patientInfoController.phoneController.text,
        );
      }
    } catch (e, stack) {
      debugPrint('[$sectionName] Save error: $e\n$stack');
      status = 500;
    } finally {
      _isSaving.value = false;
    }

    if (status == 200 || status == 201) {
      _tabCompleted[currentIndex] = true;
      if (currentIndex == 13) {
        _showPrescriptionConfirmDialog();
      } else {
        _showSavedDialog(sectionName, nextTabIndex);
      }
    } else {
      _showErrorDialog(sectionName, status);
    }
  }

  /// Validate patient ID before saving other sections
  bool _validatePatientId() {
    if (patientInfoController.currentPatientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please save patient info first.'),
          backgroundColor: Colors.red,
        ),
      );
      _tabController.animateTo(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            _clearAllAssessmentData();
          }
        },
        child: Scaffold(
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightScaffoldColor
                  : QuickTechAppColors.darkScaffoldColor,
          appBar: AppBar(
            leading: Builder(
              builder:
                  (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, color: Colors.white),
                  ),
            ),
            backgroundColor:
                themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
            elevation: 4,
            title: Text(
              'Add Assessment',
              style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
            ),
            actions: [
              // IconButton(
              //   icon: Icon(FontAwesomeIcons.filePdf, color: QuickTechAppColors.white),
              //   onPressed: () {
              //   Get.toNamed('/assessmentPdf');
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.preview, color: QuickTechAppColors.white),
                onPressed: () {
                  Get.toNamed('/assessmentpreview');
                },
              ),
              IconButton(
                icon: Icon(
                  themeController.isDay.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color:
                      themeController.isDay.value ? Colors.yellow : Colors.white,
                ),
                onPressed: themeController.toggleTheme,
              ),
            ],
          ),
          drawer: customDrawer(context),
          body: Column(
            children: [
              Obx(() => Container(
                color:
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaincolor,
                child: TabBar(
                  physics: BouncingScrollPhysics(),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: List.generate(14, (i) {
                    final tabNames = [
                      'Patient Info',
                      'Occupation History',
                      'Family History',
                      'Birth History',
                      'Mother health condition during pregnancy',
                      'Past medical history',
                      'On Examination',
                      'Muscle power',
                      'Range of motion',
                      'Problem summary, Goal and plan',
                      'Home advice',
                      'Differential Diagnosis',
                      'Advice for assistive device',
                      'Referred to',
                    ];
                    return Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tabNames[i],
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                          SizedBox(width: 4),
                          if (_tabCompleted[i])
                            Icon(Icons.check_circle, color: Colors.white, size: 18),
                        ],
                      ),
                    );
                  }),
                  dividerColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                  indicatorColor: QuickTechAppColors.white,
                  labelStyle: myStyle(
                    14,
                    QuickTechAppColors.white,
                    FontWeight.bold,
                  ),
                  unselectedLabelStyle: myStyle(
                    14,
                    QuickTechAppColors.white.withValues(alpha: 0.6),
                    FontWeight.normal,
                  ),
                ),
              )),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: generalInfoPage(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: OccupationHistory(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: FamilyHistory(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: BirthHistory(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: MotherHealthCondition(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: PastMedicalHistory(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: OnExamination(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: MusclePower(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: RangeofMotion(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: ProblemSummary(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: HomeAdvice(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: DifferentialDiagnosis(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: AssestiveDevice(),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: ReferredTo(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Obx(() => Row(
              children: [
                Expanded(child: QuickTechCustomButton(
                  title: 'Save',
                  onTab: _isSaving.value ? null : () => _handleSaveAction(),
                  color: themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
                  height: 50,
                  width: double.infinity,
                )),
                SizedBox(width: 12),

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaincolor,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _isSaving.value ? null : _showPrescriptionConfirmDialog,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_forward, color: Colors.white),
                        SizedBox(width: 6),
                        Text('Proceed', style: myStyle(14, Colors.white, FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (mounted) {
                int nextIndex = (_tabController.index + 1) % _tabController.length;
                _tabController.animateTo(nextIndex);
              }
            },
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  } void _showErrorDialog(String sectionName, int statusCode) {
    print('Save failed for $sectionName — HTTP $statusCode');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Expanded(child: Text('Save Failed')),
            ],
          ),
          content: Text(
            'Failed to save $sectionName.\nStatus code: $statusCode\nCheck the console log for details.',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showSavedDialog(String sectionName, int nextTabIndex) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 28),
                  SizedBox(width: 8),
                  Text('Saved!'),
                ],
              ),
              content: Text('$sectionName has been saved successfully.'),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: QuickTechAppColors.lightmaincolor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Go to Next'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _tabController.animateTo(nextTabIndex);
                  },
                ),
              ],
            );
          },
        );
      }  void _showValidationErrorDialog(String sectionName) {
    print('Validation failed for $sectionName — no data entered');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 8),
              Expanded(child: Text('No Data')),
            ],
          ),
          content: Text(
            'Please select or enter at least 1 item for $sectionName before saving.',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Show confirmation dialog to proceed to prescription form
  void _showPrescriptionConfirmDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Expanded(child: Text('Assessment Complete!')),
            ],
          ),
          content: Text(
            'All assessment data has been saved successfully.\n\nWould you like to proceed to generate a prescription?',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Stay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: QuickTechAppColors.lightmaincolor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Continue to Prescription'),
                onPressed: () {
                Navigator.of(context).pop();
                _clearAllAssessmentData();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.off(() => QuickTechPrescriptionForm());
                });
              },
            ),
          ],
        );
      },
    );
  }
}
