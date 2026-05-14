import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/homepage/quick_tech_home_page.dart';
import 'package:e_prescription/screens/patient_records/quick_tech_patient_records.dart';
import 'package:e_prescription/screens/add_prescription/quick_tech_add_prescription_form.dart';
import 'package:e_prescription/screens/profile/quick_tech_profile_page.dart';
import 'package:e_prescription/screens/search_page/quick_tech_search_page.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../responsive.dart';

class QuickTechMainHome extends StatefulWidget {
  const QuickTechMainHome({super.key});

  @override
  State<QuickTechMainHome> createState() => _QuickTechMainHomeState();
}

class _QuickTechMainHomeState extends State<QuickTechMainHome>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fabController;
  late Animation<double> _fabScaleAnimation;
  late Animation<double> _fabRotationAnimation;
 final themeController = locator
      .get<QuickTechThemeController>();

  final _iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.group_rounded,
    Icons.person,
  ];

  final _pageList = [
    QuickTechHomePage(),
    QuickTechSearchPage(),
   QuickTechPatientRecords(isAppBarVisible: false,),
QuickTechProfilePage(isAppBarVisible: false,)
   // QuickTechSettings(isAppBarVisible: false),
  ];

  @override
  void initState() {
    super.initState();


    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   try {
    //     final user = QuickTechAuthStorageService.getUser();
    //     final token = QuickTechAuthStorageService.getToken();
    //     print('Logged in user: [${user?.firstName ?? ''}]');
    //     print('Access token: [${token}]');
    //   } catch (e) {
    //     print('Error printing user/token: $e');
    //   }
    // });

    _fabController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _fabScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeInOut),
    );
    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _fabRotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.1416,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  /*void _animateFab() {
    if (_fabController.isAnimating) {
      _fabController.stop();
    }
    _fabController.forward(from: 0.0);
  }*/

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
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          leading: Builder(
            builder:
                (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Opens the drawer
                  },
                  icon: Icon(Icons.menu, color: Colors.white),
                ),
          ),
          title: Text(
            'E-Prescription',
            style: myStyle(Responsive.isDesktop(context)?6.sp: 16.sp, QuickTechAppColors.white, FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: themeController.toggleTheme,
              icon: Obx(
                () => Icon(
                  themeController.isDay.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color:
                      themeController.isDay.value
                          ? Colors.yellow
                          : Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: customDrawer(context),
        body: _pageList[_currentIndex],
        floatingActionButton: ScaleTransition(
          scale: _fabScaleAnimation,
          child: RotationTransition(
            turns: _fabRotationAnimation,
            child: FloatingActionButton(
              onPressed: () {
                print('Main Action');
              //  _animateFab();
                Get.to(()=>QuickTechPrescriptionForm());
              },
              backgroundColor:
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaincolor
                      : QuickTechAppColors.darkmaincolor,
              foregroundColor: Colors.white,
              elevation: 10,
              shape: CircleBorder(),
              child:  Icon(Icons.add, size: 30.sp),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: _iconList,
          activeIndex: _currentIndex,
          gapLocation: GapLocation.center,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          onTap: (index) => setState(() => _currentIndex = index),
          activeColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          inactiveColor: Colors.grey,
          splashColor: const Color(0xFF6A11CB),
          splashSpeedInMilliseconds: 300,
          height: 60,
          elevation: 10,
          iconSize: 30,
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightScaffoldColor
                  : QuickTechAppColors.darkScaffoldColor,
        ),
      ),
    );
  }
}
