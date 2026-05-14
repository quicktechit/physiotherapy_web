import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/profile/profile_update/quick_tech_profile_update.dart';
import 'package:e_prescription/screens/settings/widgets/quick_tech_settings_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class QuickTechSettings extends StatelessWidget {
  QuickTechSettings({super.key, required this.isAppBarVisible});
  final bool isAppBarVisible;
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  
  // Mock user data - in a real app, this would come from authentication
  final String doctorName = "Dr. Sarah Johnson";
  final String specialization = "Cardiologist";
  final String hospital = "City General Hospital";
  final String email = "s.johnson@citygeneral.org";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        appBar: isAppBarVisible
            ? AppBar(
                backgroundColor: themeController.isDay.value
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
                  'Settings',
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
                        color: themeController.isDay.value
                            ? Colors.yellow
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : null,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              
              // App Settings Section
              Text(
                'App Settings',
                style: myStyle(
                  16,
                  themeController.isDay.value
                      ? QuickTechAppColors.darkmaincolor
                      : QuickTechAppColors.lightmaincolor,
                  FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: themeController.isDay.value
                    ? Colors.white
                    : QuickTechAppColors.bkdarktxtfld,
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.color_lens_outlined,
                      title: 'App Theme',
                      trailing: Obx(
                        () => Switch(
                          value: !themeController.isDay.value,
                          onChanged: (value) {
                            themeController.toggleTheme();
                          },
                          activeThumbColor: QuickTechAppColors.lightmaincolor,
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
              SizedBox(height: 24),
              
           
    
              
        
              Text(
                'Account',
                style: myStyle(
                  16,
                  themeController.isDay.value
                      ? QuickTechAppColors.darkmaincolor
                      : QuickTechAppColors.lightmaincolor,
                  FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: themeController.isDay.value
                    ? Colors.white
                    : QuickTechAppColors.bkdarktxtfld,
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: themeController.isDay.value
                            ? Colors.grey[600]
                            : Colors.grey[400],
                      ),
                      onTap: () {
                        Get.to(() => QuickTechProfileUpdatePage());
                      },
                    ),
                 
                  ],
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}