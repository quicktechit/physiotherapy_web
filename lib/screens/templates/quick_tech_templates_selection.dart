// lib/views/template_page.dart
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/template_controller/quick_tech_template_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/templates/widgets/quick_tech_image_view.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class QuickTechTemplatesSelection extends StatefulWidget {
  QuickTechTemplatesSelection({super.key});

  @override
  State<QuickTechTemplatesSelection> createState() =>
      _QuickTechTemplatesSelectionState();
}

class _QuickTechTemplatesSelectionState
    extends State<QuickTechTemplatesSelection> {
  final QuickTechTemplateController techTemplateController = locator.get<QuickTechTemplateController>();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

  var userToken = QuickTechAuthStorageService.getToken();

  @override
  void initState() {
    super.initState();
    techTemplateController.fetchUserPackageTemplates(userToken!);
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
                  ? QuickTechAppColors.lightScaffoldColor
                  : QuickTechAppColors.darkScaffoldColor,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed('/mainhome');
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
            ),
          ),
          title: Text(
            'Select a Template',
            style: myStyle(
              20,
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaintextcolor
                  : QuickTechAppColors.darkmaintextcolor,
              FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(() {
            if (techTemplateController.templates.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }


            WidgetsBinding.instance.addPostFrameCallback((_) {
              techTemplateController.loadSavedTemplate();
            });

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              itemCount: techTemplateController.templates.length,
              itemBuilder: (context, index) {
                final template = techTemplateController.templates[index];
                return Obx(() {
                  final isSelected = techTemplateController.selectedTemplate.value == index;
                  return GestureDetector(
                    onTap: () => techTemplateController.selectTemplate(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: themeController.isDay.value
                            ? Colors.white
                            : QuickTechAppColors.lightmaincolor.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: isSelected
                              ? QuickTechAppColors.lightmaincolor
                              : Colors.grey.shade300,
                          width: isSelected ? 3.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.2),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: template.image != null && template.image!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      '${Api.baseUrl}${template.image}',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/prescription.png',
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Template ${index + 1}',
                            style: myStyle(
                              18,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor,
                              FontWeight.bold,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.preview,
                                  color: themeController.isDay.value
                                      ? QuickTechAppColors.lightmaintextcolor
                                      : QuickTechAppColors.darkmaintextcolor,
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => customImageView(
                                      template.image != null && template.image!.isNotEmpty
                                          ? '${Api.baseUrl}${template.image}'
                                          : 'assets/images/prescription.png',
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            );
          }),
        ),

        floatingActionButton: Obx(
          () => FloatingActionButton(
            onPressed:
                techTemplateController.selectedTemplate.value == -1
                    ? null
                    : () async {
                      await techTemplateController.saveTemplate();
                      Get.offNamed('/mainhome');
                    },
            backgroundColor:
                techTemplateController.selectedTemplate.value == -1
                    ? Colors.grey
                    : QuickTechAppColors.lightmaincolor,
            child: const Icon(Icons.check, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
