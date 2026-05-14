import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/profile/profile_update/quick_tech_profile_update.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:e_prescription/widgets/quick_tech_custom_button.dart';

import 'package:e_prescription/widgets/quick_tech_custom_divider.dart';
import 'package:e_prescription/widgets/quick_tech_custom_listtile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:e_prescription/controllers/profile_controller/quick_tech_profile_controller.dart';

class QuickTechProfilePage extends StatefulWidget {
  final bool isAppBarVisible;
  QuickTechProfilePage({super.key, required this.isAppBarVisible});

  @override
  State<QuickTechProfilePage> createState() => _QuickTechProfilePageState();
}

class _QuickTechProfilePageState extends State<QuickTechProfilePage> {
  final themeController = locator
      .get<QuickTechThemeController>();
  final profileController = locator
      .get<QuickTechProfileController>();

  @override
  void initState() {
    super.initState();
    // Fetch profile when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchProfile();
    });
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
            widget.isAppBarVisible == true
                ? AppBar(
                  bottomOpacity: 4,
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
                    'Profile',
                    style: myStyle(
                      18,
                      QuickTechAppColors.white,
                      FontWeight.bold,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/profileupdate');
                      },
                      icon: Icon(
                        FontAwesomeIcons.penToSquare,
                        color: QuickTechAppColors.white,
                      ),
                    ),
                  ],
                )
                : null,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Obx(() {
            if (profileController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (profileController.error.isNotEmpty) {
              return Center(child: Text(profileController.error.value));
            }
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              themeController.isDay.value
                                  ? Colors.black.withValues(alpha: 0.2)
                                  : Colors.grey.withValues(alpha: 0.5),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: QuickTechAppColors.lightmaincolor,
                        width: 1,
                      ),
                    ),
                    child:
                        profileController.profilePhoto.value.isNotEmpty
                            ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                "${Api.baseUrl}/${profileController.profilePhoto.value}",
                              ),
                            )
                            : CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: QuickTechAppColors.lightmaincolor,
                              ),
                              backgroundColor:
                                  themeController.isDay.value
                                      ? QuickTechAppColors.lightScaffoldColor
                                      : QuickTechAppColors.darkScaffoldColor,
                            ),
                  ),
                  SizedBox(height: 15),
                  CustomDivider(themeController: themeController),
                  SizedBox(height: 15),
                  
                  // English Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  customListtile(
                    profileController.centerName.value.isNotEmpty
                        ? profileController.centerName.value
                        : 'No Center Name',
                    FontAwesomeIcons.building,
                    () {},
                  ),
                  customListtile(
                    profileController.centerAddress.value.isNotEmpty
                        ? profileController.centerAddress.value
                        : 'No Center Address',
                    FontAwesomeIcons.mapLocationDot,
                    () {},
                  ),
                  customListtile(
                    profileController.name.value.isNotEmpty
                        ? profileController.name.value
                        : 'No Name',
                    FontAwesomeIcons.user,
                    () {},
                  ),
                  customListtile(
                    profileController.therapyCenter.value.isNotEmpty
                        ? profileController.therapyCenter.value
                        : 'No Therapy Center',
                    FontAwesomeIcons.scaleBalanced,
                    () {},
                  ),
                  customListtile(
                    profileController.designation.value.isNotEmpty
                        ? profileController.designation.value
                        : 'No Designation',
                    FontAwesomeIcons.userDoctor,
                    () {},
                  ),
                  customListtile(
                    profileController.address.value.isNotEmpty
                        ? profileController.address.value
                        : 'No Clinic Address',
                    FontAwesomeIcons.locationArrow,
                    () {},
                  ),
                  
                  SizedBox(height: 10),
                  CustomDivider(themeController: themeController),
                  SizedBox(height: 10),
                  
                  // Bengali Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  customListtile(
                    profileController.bnFirstName.value.isNotEmpty
                        ? profileController.bnFirstName.value
                        : 'নাম নেই',
                    FontAwesomeIcons.user,
                    () {},
                  ),
                  customListtile(
                    profileController.bnTherapyCenter.value.isNotEmpty
                        ? profileController.bnTherapyCenter.value
                        : 'থেরাপি সেন্টার নেই',
                    FontAwesomeIcons.houseChimneyMedical,
                    () {},
                  ),
                  customListtile(
                    profileController.bnDesignation.value.isNotEmpty
                        ? profileController.bnDesignation.value
                        : 'পদবী নেই',
                    FontAwesomeIcons.userDoctor,
                    () {},
                  ),
                  customListtile(
                    profileController.bnClinicAddress.value.isNotEmpty
                        ? profileController.bnClinicAddress.value
                        : 'ঠিকানা নেই',
                    FontAwesomeIcons.locationArrow,
                    () {},
                  ),
                  SizedBox(height: 20),
                  widget.isAppBarVisible == true
                      ? SizedBox()
                      : QuickTechCustomButton(
                        onTab: () {
                        Get.to(()=>QuickTechProfileUpdatePage());},
                        color:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaincolor
                                : QuickTechAppColors.darkmaincolor,
                        title: 'Update Profile',
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
