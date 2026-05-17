import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/controllers/patient_controller/quick_tech_patient_controller.dart';
import 'package:e_prescription/widgets/quick_tech_custom_text_field.dart';

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
    return Responsive(
      mobile: _MobileLayout(
        searchController: _searchController,
        searchQuery: _searchQuery,
        onSearchChanged: _onSearchChanged,
        onClearSearch: _onClearSearch,
      ),
      tablet: _TabletLayout(
        searchController: _searchController,
        searchQuery: _searchQuery,
        onSearchChanged: _onSearchChanged,
        onClearSearch: _onClearSearch,
      ),
      desktop: _DesktopLayout(
        searchController: _searchController,
        searchQuery: _searchQuery,
        onSearchChanged: _onSearchChanged,
        onClearSearch: _onClearSearch,
      ),
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
    patientController.searchPatients(value);
  }

  void _onClearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
    patientController.searchPatients('');
  }
}

// Mobile Layout
class _MobileLayout extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();

  _MobileLayout({
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: double.infinity,
        width: double.infinity,
        color: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                QuickTechCustomTextField(
                  label: 'Search Patients',
                  hint: 'Search for patients...',
                  icon: Icons.search,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  suffixicon: searchQuery.isNotEmpty ? Icons.close : null,
                  onSuffixIconPressed: searchQuery.isNotEmpty ? onClearSearch : null,
                  onchanged: onSearchChanged,
                ),
                SizedBox(height: 24.h),

                // Search Results Header
                Text(
                  'Search Results',
                  style: myStyle(
                    14.sp,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),

                // Results List
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: patientController.patients.length,
                    itemBuilder: (context, index) {
                      final patient = patientController.patients[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          color: themeController.isDay.value
                              ? QuickTechAppColors.txtfieldcolor
                              : QuickTechAppColors.darktxtfieldcolor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: themeController.isDay.value
                                ? Colors.grey[300]!
                                : Colors.grey[700]!,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          leading: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: themeController.isDay.value
                                ? QuickTechAppColors.lightaccentColor
                                : QuickTechAppColors.darkaccentColor,
                            child: Icon(
                              Icons.person,
                              color: QuickTechAppColors.white,
                              size: 18.sp,
                            ),
                          ),
                          title: Text(
                            patient.name,
                            style: myStyle(
                              12.sp,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaintextcolor
                                  : QuickTechAppColors.darkmaintextcolor,
                              FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'ID: ${patient.id}, Age: ${patient.age}, ${patient.gender}',
                            style: myStyle(
                              10.sp,
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightsecondarytextcolor
                                  : QuickTechAppColors.darksecondarytextcolor,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Tablet Layout
class _TabletLayout extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();

  _TabletLayout({
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: double.infinity,
        width: double.infinity,
        color: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar with better sizing for tablet
                SizedBox(
                  width: double.infinity,
                  child: QuickTechCustomTextField(
                    label: 'Search Patients',
                    hint: 'Search for patients...',
                    icon: Icons.search,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    suffixicon: searchQuery.isNotEmpty ? Icons.close : null,
                    onSuffixIconPressed: searchQuery.isNotEmpty ? onClearSearch : null,
                    onchanged: onSearchChanged,
                  ),
                ),
                SizedBox(height: 28.h),

                // Search Results Header
                Text(
                  'Search Results',
                  style: myStyle(
                    16.sp,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),

                // Results Grid - 2 columns on tablet
                Obx(() {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: patientController.patients.length,
                    itemBuilder: (context, index) {
                      final patient = patientController.patients[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: themeController.isDay.value
                              ? QuickTechAppColors.txtfieldcolor
                              : QuickTechAppColors.darktxtfieldcolor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: themeController.isDay.value
                                ? Colors.grey[300]!
                                : Colors.grey[700]!,
                          ),
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22.r,
                              backgroundColor: themeController.isDay.value
                                  ? QuickTechAppColors.lightaccentColor
                                  : QuickTechAppColors.darkaccentColor,
                              child: Icon(
                                Icons.person,
                                color: QuickTechAppColors.white,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    patient.name,
                                    style: myStyle(
                                      13.sp,
                                      themeController.isDay.value
                                          ? QuickTechAppColors.lightmaintextcolor
                                          : QuickTechAppColors.darkmaintextcolor,
                                      FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'ID: ${patient.id} | Age: ${patient.age}',
                                    style: myStyle(
                                      11.sp,
                                      themeController.isDay.value
                                          ? QuickTechAppColors.lightsecondarytextcolor
                                          : QuickTechAppColors.darksecondarytextcolor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Desktop Layout
class _DesktopLayout extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechPatientController patientController = locator.get<QuickTechPatientController>();

  _DesktopLayout({
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: double.infinity,
        width: double.infinity,
        color: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar - desktop width
                SizedBox(
                  width: 500.w,
                  child: QuickTechCustomTextField(
                    label: 'Search Patients',
                    hint: 'Search for patients...',
                    icon: Icons.search,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    suffixicon: searchQuery.isNotEmpty ? Icons.close : null,
                    onSuffixIconPressed: searchQuery.isNotEmpty ? onClearSearch : null,
                    onchanged: onSearchChanged,
                  ),
                ),
                SizedBox(height: 32.h),

                // Search Results Header
                Text(
                  'Search Results',
                  style: myStyle(
                    18.sp,
                    themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaintextcolor,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),

                // Results Table - 3 columns on desktop
                Obx(() {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 5,
                    ),
                    itemCount: patientController.patients.length,
                    itemBuilder: (context, index) {
                      final patient = patientController.patients[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: themeController.isDay.value
                              ? QuickTechAppColors.txtfieldcolor
                              : QuickTechAppColors.darktxtfieldcolor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: themeController.isDay.value
                                ? Colors.grey[300]!
                                : Colors.grey[700]!,
                          ),
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: themeController.isDay.value
                                  ? QuickTechAppColors.lightaccentColor
                                  : QuickTechAppColors.darkaccentColor,
                              child: Icon(
                                Icons.person,
                                color: QuickTechAppColors.white,
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    patient.name,
                                    style: myStyle(
                                      12.sp,
                                      themeController.isDay.value
                                          ? QuickTechAppColors.lightmaintextcolor
                                          : QuickTechAppColors.darkmaintextcolor,
                                      FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'ID: ${patient.id} | Age: ${patient.age} | ${patient.gender}',
                                    style: myStyle(
                                      10.sp,
                                      themeController.isDay.value
                                          ? QuickTechAppColors.lightsecondarytextcolor
                                          : QuickTechAppColors.darksecondarytextcolor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
