import 'package:e_prescription/const/const.dart';

import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';

class QuickTechSearchPage extends StatefulWidget {
  const QuickTechSearchPage({super.key});

  @override
  State<QuickTechSearchPage> createState() => _QuickTechSearchPageState();
}

class _QuickTechSearchPageState extends State<QuickTechSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar

                Container(
                  decoration: BoxDecoration(
                    color:
                        themeController.isDay.value
                            ? QuickTechAppColors.bktxtfld
                            : QuickTechAppColors.bkdarktxtfld,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2.w,
                        blurRadius: 8.r,
                        offset: Offset(0, 3.h),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for patients...',
                      hintStyle: myStyle(
                       Responsive.isDesktop(context)?4.sp: 12.sp,
                        themeController.isDay.value
                            ? QuickTechAppColors.lightsecondarytextcolor
                            : QuickTechAppColors.darksecondarytextcolor,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color:
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaincolor
                                : QuickTechAppColors.darkmaintextcolor,
                        size: Responsive.isDesktop(context)?20.sp:  24.sp,
                      ),
                      suffixIcon:
                          _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                    size:  Responsive.isDesktop(context)?32.sp:22.sp,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchQuery = '';
                                      _searchController.clear();
                                    });
                                    patientController.searchPatients('');
                                  },
                                )
                              : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 20.w,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      patientController.searchPatients(value);
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                ...[
                  Text(
                    'Search Results',
                    style: myStyle(
                      Responsive.isDesktop(context)?16.sp: 14.sp,
                      themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor
                          : QuickTechAppColors.darkmaintextcolor,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: patientController.patients.length,
                      itemBuilder: (context, index) {
                        final patient = patientController.patients[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 22.r,
                            backgroundColor:
                                themeController.isDay.value
                                    ? QuickTechAppColors.lightaccentColor
                                    : QuickTechAppColors.darkaccentColor,
                            child: Icon(
                              Icons.person,
                              color: QuickTechAppColors.white,
                              size:  Responsive.isDesktop(context)?20.sp: 22.sp,
                            ),
                          ),
                          title: Text(
                            patient.name,
                            style: myStyle(
                              Responsive.isDesktop(context)?16.sp: 14.sp,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor,
                            ),
                          ),
                          subtitle: Text(
                            'ID: ${patient.id}, Age: ${patient.age}, Gender: ${patient.gender}',
                            style: myStyle(
                              Responsive.isDesktop(context)?14.sp: 12.sp,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor,
                            ),
                          ),
                          onTap: () {},
                        );
                      },
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
