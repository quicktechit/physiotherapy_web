// widgets/home_hero_section.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/web_image.dart';
import 'package:e_prescription/controllers/home_controller/image_slider_controller/quick_tech_image_slider_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../responsive.dart';

final QuickTechImageSliderController sliderController =
    Get.put(QuickTechImageSliderController());

class QuickTechImageSlider extends StatelessWidget {
  final QuickTechThemeController themeController;
  const QuickTechImageSlider({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Stack(
      children: [
        // Slider
        Obx(() {
          if (sliderController.imgList.isEmpty) {
            return Container(
              height: isDesktop ? 480.h : 220.h,
              color: themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: Colors.white),
            );
          }

          return CarouselSlider.builder(
            itemCount: sliderController.imgList.length,
            itemBuilder: (context, index, realIdx) {
              final imgSrc = sliderController.imgList[index];
              return imgSrc.startsWith('http')
                  ? (kIsWeb
                      ? WebImage(imageUrl: imgSrc, fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: imgSrc,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                  : Image.asset(imgSrc,
                      fit: BoxFit.cover, width: double.infinity);
            },
            options: CarouselOptions(
              height: isDesktop ? 480.h : 220.h,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 900),
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              onPageChanged: (i, _) =>
                  sliderController.currentIndex.value = i,
            ),
          );
        }),

        // Dark overlay gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xCC000000),
                  Color(0x55000000),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Hero text overlay
        Positioned(
          left: isDesktop ? 80.w : 24.w,
          bottom: isDesktop ? 80.h : 30.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'e-Prescription System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 13.sp : 10.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'Smart Healthcare\nManagement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 42.sp : 22.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Manage patients, prescriptions & assessments\nfrom one powerful dashboard.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: isDesktop ? 14.sp : 11.sp,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 28.h),
              Row(
                children: [
                  _HeroButton(
                    label: 'Get Started',
                    isPrimary: true,
                    onTap: () => Get.toNamed('/addassessment'),
                    isDesktop: isDesktop,
                  ),
                  SizedBox(width: 14.w),
                  _HeroButton(
                    label: 'View Blogs',
                    isPrimary: false,
                    onTap: () => Get.toNamed('/blogs'),
                    isDesktop: isDesktop,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Dot indicators
        Positioned(
          bottom: isDesktop ? 30.h : 12.h,
          right: isDesktop ? 80.w : 24.w,
          child: Obx(() => Row(
                children: List.generate(
                  sliderController.imgList.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: sliderController.currentIndex.value == i
                        ? 24.w
                        : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: sliderController.currentIndex.value == i
                          ? themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;
  final bool isDesktop;
  const _HeroButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
    required this.isDesktop,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isDesktop ? 28.w : 18.w,
            vertical: widget.isDesktop ? 14.h : 10.h,
          ),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hovered
                    ? QuickTechAppColors.lightmaincolor
                    : QuickTechAppColors.lightmaincolor)
                : Colors.white.withValues(alpha: _hovered ? 0.2 : 0.12),
            borderRadius: BorderRadius.circular(10.r),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: Colors.white.withValues(alpha: 0.7),
                    width: 1.5,
                  ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.isDesktop ? 14.sp : 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}