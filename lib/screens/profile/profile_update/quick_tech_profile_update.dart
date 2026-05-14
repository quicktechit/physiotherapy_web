import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/profile_controller/quick_tech_profile_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';
import 'package:e_prescription/widgets/quick_tech_custom_divider.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'dart:io';

class QuickTechProfileUpdatePage extends StatefulWidget {
  QuickTechProfileUpdatePage({super.key});
  
  @override
  State<QuickTechProfileUpdatePage> createState() => _QuickTechProfileUpdatePageState();
}

class _QuickTechProfileUpdatePageState extends State<QuickTechProfileUpdatePage> {
  final themeController = locator.get<QuickTechThemeController>();
  final profileController = locator.get<QuickTechProfileController>();
  
  // English fields
  final TextEditingController centerNameController = TextEditingController();
  final TextEditingController centerAddressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController therapyCenterController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  
  // Bengali fields
  final TextEditingController bnFirstNameController = TextEditingController();
  final TextEditingController bnTherapyCenterController = TextEditingController();
  final TextEditingController bnDesignationController = TextEditingController();
  final TextEditingController bnClinicAddressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  bool _isNewImageSelected = false;
  String? _localImagePath;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with existing values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // English fields
      centerNameController.text = profileController.centerName.value;
      centerAddressController.text = profileController.centerAddress.value;
      nameController.text = profileController.name.value;
      therapyCenterController.text = profileController.therapyCenter.value;
      designationController.text = profileController.designation.value;
      addressController.text = profileController.address.value;
      
      // Bengali fields
      bnFirstNameController.text = profileController.bnFirstName.value;
      bnTherapyCenterController.text = profileController.bnTherapyCenter.value;
      bnDesignationController.text = profileController.bnDesignation.value;
      bnClinicAddressController.text = profileController.bnClinicAddress.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          bottomOpacity: 4,
          backgroundColor: themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          title: Text(
            'Update Profile',
            style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image Section
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        _isNewImageSelected = true;
                        _localImagePath = pickedFile.path;
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              QuickTechAppColors.lightmaincolor.withValues(alpha: 0.8),
                              QuickTechAppColors.darkmaincolor.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: themeController.isDay.value
                                  ? Colors.black.withValues(alpha: 0.2)
                                  : Colors.grey.withValues(alpha: 0.5),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: QuickTechAppColors.white,
                            width: 4,
                          ),
                        ),
                        child: ProfileImage(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: QuickTechAppColors.lightmaincolor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tap to change photo',
                  style: TextStyle(
                    fontSize: 12,
                    color: themeController.isDay.value
                        ? Colors.grey[600]
                        : Colors.grey[400],
                  ),
                ),
                SizedBox(height: 20),
                CustomDivider(themeController: themeController),
                SizedBox(height: 20),

                // English Section Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'English Information',
                      style: myStyle(16, 
                        themeController.isDay.value 
                          ? QuickTechAppColors.lightmaintextcolor 
                          : QuickTechAppColors.darkmaintextcolor, 
                        FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                customTxtField(
                  label: 'Center Name',
                  controller: centerNameController,
                  icon: FontAwesomeIcons.building,
                  onChanged: (value) {
                    profileController.centerName.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'Center Address',
                  controller: centerAddressController,
                  icon: FontAwesomeIcons.mapLocationDot,
                  onChanged: (value) {
                    profileController.centerAddress.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'Doctor Name',
                  controller: nameController,
                  icon: FontAwesomeIcons.user,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    profileController.name.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'Therapy Center Name',
                  controller: therapyCenterController,
                  icon: FontAwesomeIcons.scaleBalanced,
                  onChanged: (value) {
                    profileController.therapyCenter.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'Designation',
                  controller: designationController,
                  icon: FontAwesomeIcons.userDoctor,
                  onChanged: (value) {
                    profileController.designation.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'Clinic Address',
                  controller: addressController,
                  icon: FontAwesomeIcons.locationArrow,
                  onChanged: (value) {
                    profileController.address.value = value;
                  },
                ),
                SizedBox(height: 30),
                
                CustomDivider(themeController: themeController),
                SizedBox(height: 20),
                
                // Bengali Section Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'বাংলা তথ্য (Bengali Information)',
                      style: myStyle(16, 
                        themeController.isDay.value 
                          ? QuickTechAppColors.lightmaintextcolor 
                          : QuickTechAppColors.darkmaintextcolor, 
                        FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                customTxtField(
                  label: 'ডাক্তারের নাম (Doctor Name in Bengali)',
                  controller: bnFirstNameController,
                  icon: FontAwesomeIcons.user,
                  onChanged: (value) {
                    profileController.bnFirstName.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'থেরাপি সেন্টার (Therapy Center in Bengali)',
                  controller: bnTherapyCenterController,
                  icon: FontAwesomeIcons.houseChimneyMedical,
                  onChanged: (value) {
                    profileController.bnTherapyCenter.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'পদবী (Designation in Bengali)',
                  controller: bnDesignationController,
                  icon: FontAwesomeIcons.userDoctor,
                  onChanged: (value) {
                    profileController.bnDesignation.value = value;
                  },
                ),
                SizedBox(height: 20),

                customTxtField(
                  label: 'ক্লিনিক ঠিকানা (Clinic Address in Bengali)',
                  controller: bnClinicAddressController,
                  icon: FontAwesomeIcons.locationArrow,
                  onChanged: (value) {
                    profileController.bnClinicAddress.value = value;
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Obx(() => QuickTechCustomButton(
            onTab: () {
              profileController.saveProfile(
                isNewImage: _isNewImageSelected, 
                localImagePath: _localImagePath
              );
            },
            color: themeController.isDay.value
                ? QuickTechAppColors.lightmaincolor
                : QuickTechAppColors.darkmaincolor,
            title: profileController.isLoading.value ? 'Updating...' : 'Update Profile',
            height: 50,
            width: double.infinity,
          )),
        ),
      ),
    );
  }

  Widget ProfileImage() {

    if (_localImagePath != null && File(_localImagePath!).existsSync()) {
      return CircleAvatar(
        backgroundImage: FileImage(File(_localImagePath!)),
      );
    }
    
    else if (profileController.profilePhoto.value.isNotEmpty) {
    
      String imageUrl = profileController.profilePhoto.value;
      
      if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
        return CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        );
      } else {
       
        return CircleAvatar(
          backgroundImage: NetworkImage('${Api.baseUrl}$imageUrl'),
        );
      }
    }
    
    else {
      return CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Icon(
          Icons.person,
          size: 60,
          color: Colors.grey[600],
        ),
      );
    }
  }

  Widget customTxtField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: QuickTechCustomTextField(
        label: label,
        controller: controller,
        onchanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.text,
        icon: icon,
        backcolor: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        height: 50,
        iconcolor: themeController.isDay.value
            ? QuickTechAppColors.lightmaintextcolor
            : QuickTechAppColors.darkmaintextcolor,
        txtcolor: themeController.isDay.value
            ? QuickTechAppColors.lightmaintextcolor
            : QuickTechAppColors.darkmaintextcolor,
      ),
    );
  }
}