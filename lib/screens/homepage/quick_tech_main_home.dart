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
import 'package:get/get.dart';

import '../../responsive.dart';

// ─── Nav destination definitions shared between bottom bar and rail ──────────
const _navIcons = <IconData>[
  Icons.home_rounded,
  Icons.search_rounded,
  Icons.group_rounded,
  Icons.person_rounded,
];


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
  final themeController = locator.get<QuickTechThemeController>();

  // Pages must match the order of _navIcons / _navLabels defined above
  final _pageList = [
    QuickTechHomePage(),
    QuickTechSearchPage(),
    QuickTechPatientRecords(isAppBarVisible: false),
    QuickTechProfilePage(isAppBarVisible: false),
  ];

  @override
  void initState() {
    super.initState();

    _fabController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    // Scale animation - smooth scale up and down
    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // Rotation animation - full 360 rotation
    _fabRotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.1416,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    try {
      _fabController.dispose();
    } catch (e) {
      print('Error disposing FAB controller: $e');
    }
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
    final isDesktop = Responsive.isDesktop(context);

    return Obx(
      () => Scaffold(
        backgroundColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,

        // ── AppBar: shown on all platforms (menu icon for drawer) ────────
        appBar: AppBar(
          backgroundColor:
              themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          leading: Builder(
            builder:
                (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),
          ),
          title: Text(
            'E-Prescription',
            style: myStyle(16, QuickTechAppColors.white, FontWeight.bold),
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

        // ── Drawer: enabled on all platforms (mobile + desktop) ────────────
        drawer: customDrawer(context),

        // ── Body: unified layout (drawer works on all platforms) ──────────
        body: _pageList[_currentIndex],

        // ── FAB: mobile only (drawer available on all platforms now) ────────
        floatingActionButton:
            isDesktop
                ? null
                : ScaleTransition(
                  scale: _fabScaleAnimation,
                  child: RotationTransition(
                    turns: _fabRotationAnimation,
                    child: FloatingActionButton(
                      onPressed:
                          () =>
                              WidgetsBinding.instance.addPostFrameCallback((_) {

                              Get.toNamed('/prescriptionform');
                              }),
                      backgroundColor:
                          themeController.isDay.value
                              ? QuickTechAppColors.lightmaincolor
                              : QuickTechAppColors.darkmaincolor,
                      foregroundColor: Colors.white,
                      elevation: 10,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.add, size: 28),
                    ),
                  ),
                ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // ── Bottom nav: mobile only ────────────────────────────────────────
        bottomNavigationBar:
            isDesktop
                ? null
                : AnimatedBottomNavigationBar(
                  icons: _navIcons,
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
                  iconSize: 28,
                  backgroundColor:
                      themeController.isDay.value
                          ? QuickTechAppColors.lightScaffoldColor
                          : QuickTechAppColors.darkScaffoldColor,
                ),
      ),
    );
  }
}
