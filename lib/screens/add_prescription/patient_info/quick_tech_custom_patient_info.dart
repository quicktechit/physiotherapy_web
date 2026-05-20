
import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drop_down.dart';
import 'package:intl/intl.dart';

Widget customPatientInfo(BuildContext context) {
  final PatientInfoController patientInfoController = locator.get<PatientInfoController>();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();

  // ==========================================
  // 1. PRE-BUILD WIDGETS (To avoid duplication)
  // ==========================================
  
  Widget nameField = QuickTechCustomTextField(
    label: 'Patient Name',
    icon: Icons.person_outline,
    controller: patientInfoController.patientNameController,
    keyboardType: TextInputType.name,
    onchanged: (value) => patientInfoController.patientName.value = value,
  );

  Widget ageField = QuickTechCustomTextField(
    label: 'Age',
    icon: Icons.cake_outlined,
    controller: patientInfoController.ageController,
    keyboardType: TextInputType.number,
    onchanged: (value) => patientInfoController.age.value = value,
  );

  Widget phoneField = QuickTechCustomTextField(
    label: 'Phone',
    icon: Icons.phone,
    controller: patientInfoController.phoneController,
    keyboardType: TextInputType.phone,
    onchanged: (value) => patientInfoController.phone.value = value,
  );

  Widget genderField = Obx(
    () => QuickTechCustomDropDown<String>(
      label: 'Gender',
      items: const ['Male', 'Female', 'Other'],
      value: patientInfoController.gender.value.isEmpty
          ? null
          : patientInfoController.gender.value,
      onChanged: (value) => patientInfoController.gender.value = value ?? '',
      icon: Icons.transgender,
      isDay: themeController.isDay.value,
      iconColor: themeController.isDay.value
          ? QuickTechAppColors.lightmaincolor
          : QuickTechAppColors.darkmaincolor,
    ),
  );

  Widget dateField = GestureDetector(
    onTap: () async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: themeController.isDay.value
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.darkmaincolor,
                onPrimary: Colors.white,
                surface: themeController.isDay.value
                    ? QuickTechAppColors.lightScaffoldColor
                    : QuickTechAppColors.darkScaffoldColor,
                onSurface: themeController.isDay.value
                    ? QuickTechAppColors.lightmaintextcolor
                    : QuickTechAppColors.darkmaintextcolor,
              ),
              dialogTheme: DialogThemeData(
                backgroundColor: themeController.isDay.value
                    ? Colors.white
                    : QuickTechAppColors.black,
              ),
            ),
            child: child!,
          );
        },
      );
      if (selectedDate != null) {
        String formattedDate = DateFormat('d-M-yyyy').format(selectedDate);
        patientInfoController.date.value = selectedDate;
        patientInfoController.dateContoller.text = formattedDate;
      }
    },
    child: AbsorbPointer(
      child: QuickTechCustomTextField(
        label: 'Date',
        icon: Icons.calendar_today,
        controller: patientInfoController.dateContoller,
      ),
    ),
  );

  // ==========================================
  // 2. DEFINE 3 RESPONSIVE LAYOUTS
  // ==========================================
  
  // 1. Mobile (< 850px): Everything stacks vertically (1 Column)
  Widget mobileLayout = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      nameField,
      SizedBox(height: 16.h),
      ageField,
      SizedBox(height: 16.h),
      phoneField,
      SizedBox(height: 16.h),
      genderField,
      SizedBox(height: 16.h),
      dateField,
    ],
  );

  // 2. Tablet (850px - 1099px): Fields group into pairs (2 Columns)
  Widget tabletLayout = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      nameField,
      SizedBox(height: 20.h),
      Row(
        children: [
          Expanded(child: ageField),
          SizedBox(width: 16.w),
          Expanded(child: phoneField),
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        children: [
          Expanded(child: genderField),
          SizedBox(width: 16.w),
          Expanded(child: dateField),
        ],
      ),
    ],
  );

  // 3. Desktop (>= 1100px): Wide layout with specific flex ratios (3 Columns)
  Widget desktopLayout = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(flex: 2, child: nameField),
          SizedBox(width: 16.w),
          Expanded(flex: 1, child: ageField),
          SizedBox(width: 16.w),
          Expanded(flex: 2, child: phoneField),
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        children: [
          Expanded(flex: 2, child: genderField),
          SizedBox(width: 16.w),
          Expanded(flex: 2, child: dateField),
          SizedBox(width: 16.w),
          Expanded(flex: 1, child: const SizedBox.shrink()), // Empty space to keep uniform grid alignment
        ],
      ),
    ],
  );


  
  return Obx(() {
    final isDay = themeController.isDay.value;
    final mainColor = isDay
        ? QuickTechAppColors.lightmaincolor
        : QuickTechAppColors.darkmaincolor;

    return Card(
      color: isDay
          ? QuickTechAppColors.bktxtfld
          : QuickTechAppColors.bkdarktxtfld.withValues(alpha: 0.7),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.05), 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER SECTION (With Overflow Fix) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: mainColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.medical_information_outlined,
                          color: mainColor,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Patient Information',
                          style: myStyle(20.sp, mainColor, FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: mainColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    'ID: ${patientInfoController.patientId.value > 0 ? patientInfoController.patientId.value : 'New'}',
                    style: myStyle(15.sp, mainColor, FontWeight.bold),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.withValues(alpha: 0.2), thickness: 1.5.h),
            SizedBox(height: 20.h),

          
            Responsive(
              mobile: mobileLayout,
              tablet: tabletLayout,   
              desktop: desktopLayout, 
            ),
          ],
        ),
      ),
    );
  });
}
