import 'dart:convert';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';
import 'package:http/http.dart' as http;
import 'package:e_prescription/controllers/assessment_controller/on_examination/reflex/quick_tech_reflex_controller.dart';

// Inflammatory Sign Model
class InflammatorySignModel {
  final int id;
  final String name;

  InflammatorySignModel({required this.id, required this.name});

  factory InflammatorySignModel.fromJson(Map<String, dynamic> json) {
    return InflammatorySignModel(id: json['id'], name: json['name']);
  }
}

/// MODELS
/// Pulse MOdel

class PulseModel {
  final int id;
  final String numericValue;
  final String textValue;
  PulseModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });
  factory PulseModel.fromJson(Map<String, dynamic> json) {
    return PulseModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Percussion Option Model
class PercussionOptionModel {
  final int id;
  final String numericValue;
  final String textValue;

  PercussionOptionModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory PercussionOptionModel.fromJson(Map<String, dynamic> json) {
    return PercussionOptionModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Sensory Grade Model
class SensoryGradeModel {
  final int id;
  final String numericValue;
  final String textValue;

  SensoryGradeModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory SensoryGradeModel.fromJson(Map<String, dynamic> json) {
    return SensoryGradeModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Posture Model
class PostureModel {
  final int id;
  final String name;

  PostureModel({required this.id, required this.name});

  factory PostureModel.fromJson(Map<String, dynamic> json) {
    return PostureModel(id: json['id'], name: json['name']);
  }
}

// Gait Model
class GaitModel {
  final int id;
  final String name;

  GaitModel({required this.id, required this.name});

  factory GaitModel.fromJson(Map<String, dynamic> json) {
    return GaitModel(id: json['id'], name: json['name']);
  }
}

// Body Type Model
class BodyTypeModel {
  final int id;
  final String numericValue;
  final String textValue;

  BodyTypeModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory BodyTypeModel.fromJson(Map<String, dynamic> json) {
    return BodyTypeModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Motor Grade Model
class MotorGradeModel {
  final int id;
  final String numericValue;
  final String textValue;

  MotorGradeModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory MotorGradeModel.fromJson(Map<String, dynamic> json) {
    return MotorGradeModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Muscle Tone Model
class MuscleToneModel {
  final int id;
  final String numericValue;
  final String textValue;

  MuscleToneModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory MuscleToneModel.fromJson(Map<String, dynamic> json) {
    return MuscleToneModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Spasticity Model
class SpasticityModel {
  final int id;
  final String numericValue;
  final String textValue;

  SpasticityModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory SpasticityModel.fromJson(Map<String, dynamic> json) {
    return SpasticityModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

// Bowel/Bladder Control Model
class BowelBladderModel {
  final int id;
  final String numericValue;
  final String textValue;

  BowelBladderModel({
    required this.id,
    required this.numericValue,
    required this.textValue,
  });

  factory BowelBladderModel.fromJson(Map<String, dynamic> json) {
    return BowelBladderModel(
      id: json['id'],
      numericValue: json['numeric_value'],
      textValue: json['text_value'],
    );
  }
}

/// CONTROLLER
class QuickTechOnExaminationController extends GetxController {
  var token=QuickTechAuthStorageService.getToken();
  // Prevent duplicate fetches
  bool _dataFetched = false;
  // ...existing code...
  // -----------------------------
  // TEXT CONTROLLERS
  // -----------------------------
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController reflexController = TextEditingController();
  final TextEditingController limborganabsenseController =
      TextEditingController();
  final TextEditingController balancingCoordinatingController =
      TextEditingController();
  final TextEditingController othersController = TextEditingController();

  // -----------------------------
  // OBSERVABLES - VISIBILITY
  // -----------------------------
  var bodyTypeInfoVisible = false.obs;
  var pulseInfoVisible = false.obs;
  var reflexInfoVisible = false.obs;
  var sensoryInfoVisible = false.obs;
  var motorINfoVisible = false.obs;
  var muscleToneInfoVisible = false.obs;
  var spasticityINfoVisible = false.obs;
  var bowelControlInfoVisible = false.obs;

  // -----------------------------
  // OBSERVABLES - VALUES
  // -----------------------------
  var bodyType = Rx<String?>(null);
  var posture = Rx<String?>(null);
  var gait = Rx<String?>(null);
  var activity = Rx<String?>(null);
  var percussion = Rx<String?>(null);
  var temperature = Rx<String?>(null);
  var pulse = Rx<String?>(null);
  var bloodPressure = Rx<String?>(null);
  var inflammatorySign = Rx<List<String>>([]);

  var sensory = Rx<String?>(null);
  var motor = Rx<String?>(null);
  var muscleTone = Rx<String?>(null);
  var spasticity = Rx<String?>(null);
  var bowelBladderControl = Rx<String?>(null);
  var limbOrOrganAbsence = Rx<String?>(null);
  var balancingCondition = Rx<String?>(null);
  var others = Rx<String?>(null);
  var reflex = Rx<Map<String, String>?>(null);

  // -----------------------------
  // LISTS AND OPTIONS
  // -----------------------------
  var temperatureOption = ['Normal (98 F/37 C)'].obs;
  var bodyTypeList = <BodyTypeModel>[].obs;
  var bodyTypeOptions = <String>[].obs;
  var postureList = <PostureModel>[].obs;
  var postureOptions = <String>[].obs;
  var gaitList = <GaitModel>[].obs;
  var gaitOptions = <String>[].obs;

  var activityOptions =
      ['Bed ridden', 'Slow activity', 'Mild', 'Moderate', 'No activity'].obs;

  // Inflammatory Signs
  var inflammatorySignOptionList = <InflammatorySignModel>[].obs;
  var inflammatorySignOptions = <String>[].obs;
  var isInflammatorySignLoading = false.obs;

  var muscleGradeOptions = ['0', '1+', '2+', '3+', '4+'].obs;

  // Sensory
  var sensoryGradeList = <SensoryGradeModel>[].obs;
  var sensoryGradeOptions = <String>[].obs;
  var isSensoryGradeLoading = false.obs;

  // Motor
  var motorGradeList = <MotorGradeModel>[].obs;
  var motorGradeOptions = <String>[].obs;
  var isMotorGradeLoading = false.obs;

  // Muscle Tone
  var muscleToneList = <MuscleToneModel>[].obs;
  var muscleToneOptions = <String>[].obs;
  var isMuscleToneLoading = false.obs;

  // Spasticity
  var spasticityList = <SpasticityModel>[].obs;
  var spasticityOptions = <String>[].obs;
  var isSpasticityLoading = false.obs;

  // Bowel/Bladder
  var bowelBladderControlList = <BowelBladderModel>[].obs;
  var bowelBladderControlOptions = <String>[].obs;
  var isBowelBladderControlLoading = false.obs;

  // Body type, posture, gait loading
  var isBodyTypeLoading = false.obs;
  var isPostureLoading = false.obs;
  var isGaitLoading = false.obs;
  // Percussion
  var percussionOptionList = <PercussionOptionModel>[].obs;
  var percussionOptions = <String>[].obs;
  var isPercussionLoading = false.obs;
  //Pulse
  var pulseOptionList = <PulseModel>[].obs;
  var isPulseLoading = false.obs;
  var pulseOptions = <String>[].obs;
  // -----------------------------
  // VISIBILITY TOGGLE FUNCTIONS
  // -----------------------------
  void toggleBodyTypeInfoVisibility() =>
      bodyTypeInfoVisible.value = !bodyTypeInfoVisible.value;
  void togglePulseInfoVisibility() =>
      pulseInfoVisible.value = !pulseInfoVisible.value;
  void toggleReflexInfoVisibility() =>
      reflexInfoVisible.value = !reflexInfoVisible.value;
  void toggleSensoryInfoVisibility() =>
      sensoryInfoVisible.value = !sensoryInfoVisible.value;
  void toggleMotoInfoVisibility() =>
      motorINfoVisible.value = !motorINfoVisible.value;
  void togglemuscleToneInfoVisibility() =>
      muscleToneInfoVisible.value = !muscleToneInfoVisible.value;
  void togglespasticityInfoVisibility() =>
      spasticityINfoVisible.value = !spasticityINfoVisible.value;
  void togglebowelControlInfoVisibility() =>
      bowelControlInfoVisible.value = !bowelControlInfoVisible.value;

  // -----------------------------
  // CHECK NULL FUNCTIONS
  // -----------------------------
  bool isOnExaminationnull() {
    return (bodyType.value?.isNotEmpty ?? false) ||
        (posture.value?.isNotEmpty ?? false) ||
        (gait.value?.isNotEmpty ?? false) ||
        (activity.value?.isNotEmpty ?? false) ||
        (percussion.value?.isNotEmpty ?? false) ||
        (temperature.value?.isNotEmpty ?? false) ||
        (pulse.value?.isNotEmpty ?? false) ||
        (bloodPressure.value?.isNotEmpty ?? false) ||
        (inflammatorySign.value.isNotEmpty) ||
        (reflex.value?.isNotEmpty ?? false) ||
        (sensory.value?.isNotEmpty ?? false) ||
        (motor.value?.isNotEmpty ?? false) ||
        (muscleTone.value?.isNotEmpty ?? false) ||
        (spasticity.value?.isNotEmpty ?? false) ||
        (bowelBladderControl.value?.isNotEmpty ?? false) ||
        (limbOrOrganAbsence.value?.isNotEmpty ?? false) ||
        (balancingCondition.value?.isNotEmpty ?? false) ||
        (others.value?.isNotEmpty ?? false);
  }

  bool isOnExaminationNull() {
    return bodyType.value != null && bodyType.value!.isNotEmpty ||
        posture.value != null && posture.value!.isNotEmpty ||
        gait.value != null && gait.value!.isNotEmpty ||
        activity.value != null && activity.value!.isNotEmpty ||
        percussion.value != null && percussion.value!.isNotEmpty ||
        temperature.value != null && temperature.value!.isNotEmpty ||
        pulse.value != null && pulse.value!.isNotEmpty ||
        bloodPressure.value != null && bloodPressure.value!.isNotEmpty ||
        inflammatorySign.value.isNotEmpty ||
        reflex.value != null && reflex.value!.isNotEmpty ||
        sensory.value != null && sensory.value!.isNotEmpty ||
        motor.value != null && motor.value!.isNotEmpty ||
        muscleTone.value != null && muscleTone.value!.isNotEmpty ||
        spasticity.value != null && spasticity.value!.isNotEmpty ||
        bowelBladderControl.value != null &&
            bowelBladderControl.value!.isNotEmpty ||
        limbOrOrganAbsence.value != null &&
            limbOrOrganAbsence.value!.isNotEmpty ||
        balancingCondition.value != null &&
            balancingCondition.value!.isNotEmpty ||
        others.value != null && others.value!.isNotEmpty;
  }

  /// Standardized: returns true when section has data to display
  bool hasData() => isOnExaminationNull();

  // -----------------------------
  // UPDATE FUNCTIONS
  // -----------------------------
  void updateBodyType(String type) => bodyType.value = type;

  void updatePosture(String? type) {
    if (type != null) {
      posture.value = type;
      if (!postureOptions.contains(type)) postureOptions.add(type);
    }
  }

  void updateGait(String type) {
    gait.value = type;
    if (!gaitOptions.contains(type)) gaitOptions.add(type);
  }

  void updateActivity(String type) => activity.value = type;
  void updatePercussion(String type) => percussion.value = type;

  void updateTemperature(String? temp) {
    if (temp != null) {
      temperature.value = temp;
      temperatureController.text = temp;
      if (!temperatureOption.contains(temp)) temperatureOption.add(temp);
    }
  }

  void updatePulse(String? rate) {
    if (rate != null) {
      pulse.value = rate;
      pulseController.text = rate;
      if (!pulseOptions.contains(rate)) pulseOptions.add(rate);
    }
  }

  void updateBloodPressure(String pressure) {
    bloodPressure.value = pressure;
    // do NOT set bloodPressureController.text — it resets cursor on web
  }

  void updateInflammatorySigns(List<String> signs) =>
      inflammatorySign.value = signs;

  void updateReflex(RxMap<String, List<String>> selectedReflexes) {
    var reflexMap = <String, String>{};
    selectedReflexes.forEach((title, options) {
      reflexMap[title] = options.join(", ");
    });
    reflex.value = reflexMap;
    reflexController.text = reflexMap.toString();
  }

  void updateSensory(String? grade) {
    if (sensory.value != grade) sensory.value = grade;
    if (grade != null && !sensoryGradeOptions.contains(grade))
      sensoryGradeOptions.add(grade);
  }

  void updateMotor(String grade) => motor.value = grade;

  void updateMuscleTone(String? type) {
    if (type != null) {
      muscleTone.value = type;
      if (!muscleToneOptions.contains(type)) muscleToneOptions.add(type);
    }
  }

  void updateSpasticity(String? grade) {
    if (grade != null) {
      spasticity.value = grade;
      if (!spasticityOptions.contains(grade)) spasticityOptions.add(grade);
    }
  }

  void updateBowelBladderControl(String type) =>
      bowelBladderControl.value = type;

  void updateLimbOrOrganAbsence(String info) {
    limbOrOrganAbsence.value = info;
    // do NOT set limborganabsenseController.text — it resets cursor on web
  }

  void updateBalancingCondition(String condition) {
    balancingCondition.value = condition;
    // do NOT set balancingCoordinatingController.text — it resets cursor on web
  }

  void updateOthers(String info) {
    others.value = info;
    // do NOT set othersController.text — it resets cursor on web
  }

  // -----------------------------
  // FETCH FUNCTIONS
  // -----------------------------
  Future<void> fetchSensoryGrades() async {
    isSensoryGradeLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${Api.getSensoryAsses}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['sensory_grades'] != null) {
          List<SensoryGradeModel> grades =
              (data['sensory_grades'] as List)
                  .map((e) => SensoryGradeModel.fromJson(e))
                  .toList();
          sensoryGradeList.assignAll(grades);
          sensoryGradeOptions.assignAll(grades.map((e) => e.numericValue));
        }
      }
    } catch (e) {
      // handle error
    } finally {
      isSensoryGradeLoading.value = false;
    }
  }

  Future<void> fetchMotorGrades() async {
    isMotorGradeLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${Api.getMotorAsses}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final grades = data['motor_grades'] as List;
        motorGradeList.value =
            grades.map((e) => MotorGradeModel.fromJson(e)).toList();
        motorGradeOptions.value =
            motorGradeList.map((e) => e.numericValue).toList();
      }
    } catch (e) {
    } finally {
      isMotorGradeLoading.value = false;
    }
  }

  Future<void> fetchMuscleTone() async {
    isMuscleToneLoading.value = true;
    try {
      final response = await http.get(Uri.parse("${Api.getMuscleToneAsses}"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final grades = data['muscle_tone_grades'] as List;
        muscleToneList.value =
            grades.map((e) => MuscleToneModel.fromJson(e)).toList();
        muscleToneOptions.value =
            muscleToneList.map((e) => e.numericValue).toList();
      }
    } catch (e) {
    } finally {
      isMuscleToneLoading.value = false;
    }
  }

  Future<void> fetchSpasticity() async {
    isSpasticityLoading.value = true;
    try {
      final response = await http.get(Uri.parse("${Api.getSpasticityAsses}"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final grades = data['spasticity_grades'] as List;
        spasticityList.value =
            grades.map((e) => SpasticityModel.fromJson(e)).toList();
        spasticityOptions.value =
            spasticityList.map((e) => e.numericValue).toList();
      }
    } catch (e) {
    } finally {
      isSpasticityLoading.value = false;
    }
  }

  Future<void> fetchBowelBladder() async {
    isBowelBladderControlLoading.value = true;
    try {
      final response = await http.get(Uri.parse("${Api.getBowelBladderAsses}"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final grades = data['bowel_bladder_grades'] as List;
        bowelBladderControlList.value =
            grades.map((e) => BowelBladderModel.fromJson(e)).toList();
        bowelBladderControlOptions.value =
            bowelBladderControlList.map((e) => e.numericValue).toList();
      }
    } catch (e) {
    } finally {
      isBowelBladderControlLoading.value = false;
    }
  }

  Future<void> fetchBodyTypes() async {
    isBodyTypeLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${Api.getBodyTypeAsses}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['body_types'] != null) {
          List<BodyTypeModel> types =
              (data['body_types'] as List)
                  .map((e) => BodyTypeModel.fromJson(e))
                  .toList();
          bodyTypeList.assignAll(types);
          bodyTypeOptions.assignAll(types.map((e) => e.numericValue));
        }
      }
    } catch (e) {
    } finally {
      isBodyTypeLoading.value = false;
    }
  }

  Future<void> fetchPostures() async {
    isPostureLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${Api.getPostureAsses}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['postures'] != null) {
          List<PostureModel> postures =
              (data['postures'] as List)
                  .map((e) => PostureModel.fromJson(e))
                  .toList();
          postureList.assignAll(postures);
          postureOptions.assignAll(postures.map((e) => e.name));
        }
      }
    } catch (e) {
    } finally {
      isPostureLoading.value = false;
    }
  }

  Future<void> fetchGaits() async {
    isGaitLoading.value = true;
    try {
      final response = await http.get(Uri.parse('${Api.getGaitAsses}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['gaits'] != null) {
          List<GaitModel> gaits =
              (data['gaits'] as List)
                  .map((e) => GaitModel.fromJson(e))
                  .toList();
          gaitList.assignAll(gaits);
          gaitOptions.assignAll(gaits.map((e) => e.name));
        }
      }
    } catch (e) {
    } finally {
      isGaitLoading.value = false;
    }
  }

  // Fetch percussion options
  Future<void> fetchPercussionOptions() async {
    isPercussionLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          '${Api.baseUrl}/api/percussion/options',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['percussion_options'] != null) {
          List<PercussionOptionModel> options =
              (data['percussion_options'] as List)
                  .map((e) => PercussionOptionModel.fromJson(e))
                  .toList();
          percussionOptionList.assignAll(options);
          percussionOptions.assignAll(options.map((e) => e.numericValue));
        }
      }
    } catch (e) {
      // handle error
    } finally {
      isPercussionLoading.value = false;
    }
  }

  // Fetch Pulse options
  Future<void> fetchPulseOptions() async {
    isPulseLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          '${Api.baseUrl}/api/pulse/options',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['pulse_options'] != null) {
          List<PulseModel> options =
              (data['pulse_options'] as List)
                  .map((e) => PulseModel.fromJson(e))
                  .toList();
          pulseOptionList.assignAll(options);
          pulseOptions.assignAll(options.map((e) => e.numericValue));
        }
      }
    } catch (e) {
      // handle error
    } finally {
      isPulseLoading.value = false;
    }
  }

  // Fetch inflammatory signs
  Future<void> fetchInflammatorySigns() async {
    isInflammatorySignLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          '${Api.baseUrl}/api/inflammatory-sign/all',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['inflammatory_signs'] != null) {
          List<InflammatorySignModel> options =
              (data['inflammatory_signs'] as List)
                  .map((e) => InflammatorySignModel.fromJson(e))
                  .toList();
          inflammatorySignOptionList.assignAll(options);
          inflammatorySignOptions.assignAll(options.map((e) => e.name));
        }
      }
    } catch (e) {
      // handle error
    } finally {
      isInflammatorySignLoading.value = false;
    }
  }

  // -----------------------------
  // INITIALIZATION
  // -----------------------------
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchBodyTypes();
  //   fetchPostures();
  //   fetchGaits();
  //   fetchSensoryGrades();
  //   fetchMotorGrades();
  //   fetchMuscleTone();
  //   fetchSpasticity();
  //   fetchBowelBladder();
  //   fetchPercussionOptions();
  //   fetchPulseOptions();
  //   fetchInflammatorySigns();
  // }

  /// Initialize all data fetching including reflexes
  Future<void> initializeAllData() async {
    if (_dataFetched) return;
    _dataFetched = true;
    
   final reflexController = locator.get<QuickTechReflexController>();
    
    // Stagger all API calls to prevent rate limiting
    await reflexController.fetchAllReflexes();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await reflexController.fetchReflexGrades();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchBodyTypes();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchPostures();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchGaits();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchSensoryGrades();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchMotorGrades();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchMuscleTone();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchSpasticity();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchBowelBladder();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchPercussionOptions();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchPulseOptions();
    await Future.delayed(const Duration(milliseconds: 300));
    
    await fetchInflammatorySigns();
  }

  // -----------------------------
  // UTILITY FUNCTIONS
  // -----------------------------
  void clearForm() {
    bodyType.value = null;
    posture.value = null;
    gait.value = null;
    activity.value = null;
    percussion.value = null;
    temperature.value = null;
    pulse.value = null;
    bloodPressure.value = null;
    inflammatorySign.value = [];
    reflex.value = null;
    sensory.value = null;
    motor.value = null;
    muscleTone.value = null;
    spasticity.value = null;
    bowelBladderControl.value = null;
    limbOrOrganAbsence.value = null;
    balancingCondition.value = null;
    others.value = null;
  }
  

  /// Store On Examination Data (including reflexes)
  Future<int> storeOnExamination({
    required int patientId,
    required String date,
  }) async {
    final url =
        '${Api.baseUrl}/api/on-examination/store';
    final Map<String, dynamic> body = {
      'patient_id': patientId,
      'date': date,
      'body_type': bodyType.value,
      'posture': posture.value,
      'gait': gait.value,
      'activity': activity.value,
      'percussion': percussion.value,
      'temperature': temperature.value,
      'pulse': pulse.value,
      'blood_pressure': bloodPressureController.text,
      'inflammatory_signs': inflammatorySign.value,
      'sensory': sensory.value,
      'motor': motor.value,
      'muscle_tone': muscleTone.value,
      'spasticity': spasticity.value,
      'bowel_bladder_control': bowelBladderControl.value,
      'organ_absence': limbOrOrganAbsence.value,
      'co_ordination': balancingCondition.value,
      'other_findings': others.value,
      // Reflexes: collect all selected reflex subcategory IDs
      'reflexSubcategoryIds': _getSelectedReflexSubcategoryIds(),
    };

    try {
      final response = await retryRequest(() => http.post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${token}',
            },
            body: jsonEncode(body),
          ));
      print('On-examination status: ${response.statusCode}');
      print('On-examination response: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print('Error storing on-examination data: $e');
      return 500;
    }
  }

  /// Helper to get selected reflex subcategory IDs from the reflex controller
  List<int> _getSelectedReflexSubcategoryIds() {
    final reflexController = locator.get<QuickTechReflexController>();
    final ids = <int>[];
    for (final tendon in reflexController.reflexList) {
      final tendonName = tendon.name ?? '';
      final selected = reflexController.selectedOptions[tendonName];
      if (selected != null && selected.isNotEmpty) {
        final subcategories = tendon.reflexSubcategories ?? [];
        for (final option in selected) {
          final subcat = subcategories.firstWhereOrNull(
            (sub) => sub.textValue == option,
          );
          if (subcat != null && subcat.id != null) {
            ids.add(subcat.id!);
          }
        }
      }
    }
    return ids;
  }

  void printSelectedItems() {
    print('Selected On Examination Data:');
    print('Body Type: ${bodyType.value}');
    print('Posture: ${posture.value}');
    print('Gait: ${gait.value}');
    print('Activity: ${activity.value}');
    print('Percussion: ${percussion.value}');
    print('Temperature: ${temperature.value}');
    print('Pulse: ${pulse.value}');
    print('Blood Pressure: ${bloodPressure.value}');
    print('Inflammatory Signs: ${inflammatorySign.value}');
    print('Reflex: ${reflex.value}');
    print('Sensory: ${sensory.value}');
    print('Motor: ${motor.value}');
    print('Muscle Tone: ${muscleTone.value}');
    print('Spasticity: ${spasticity.value}');
    print('Bowel/Bladder Control: ${bowelBladderControl.value}');
    print('Limb/Organ Absence: ${limbOrOrganAbsence.value}');
    print('Balancing Condition: ${balancingCondition.value}');
    print('Others: ${others.value}');
  }
}
