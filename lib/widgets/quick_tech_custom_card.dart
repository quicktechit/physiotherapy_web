
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import '../../../responsive.dart';



class SectionHeader extends StatelessWidget {
  final bool isDark;
  final String label;
  const SectionHeader({required this.isDark, required this.label});

  @override
  Widget build(BuildContext context) {
    final themeController= locator.get<QuickTechThemeController>();
    final isDesktop = Responsive.isDesktop(context);
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            fontSize: isDesktop ? 22.sp : 18.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

class ActionCardData {
  final String title;
  final String subtitle;
  final String lottie;
  final List<Color> gradient;
  final Color textColor;
  final Color subtitleColor;
  final bool hasBorder;
  final VoidCallback onTap;
  final bool isWide;

  ActionCardData({
    required this.title,
    required this.subtitle,
    required this.lottie,
    required this.gradient,
    this.textColor = Colors.white,
    this.subtitleColor = const Color(0xCCFFFFFF),
    this.hasBorder = false,
    required this.onTap,
    required this.isWide,
  });
}

class ActionCard extends StatefulWidget {
  final ActionCardData data;
  final bool isDesktop;
  const ActionCard({required this.data, required this.isDesktop});

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final isDesktop = widget.isDesktop;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: d.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: d.gradient,
            ),
            border: d.hasBorder
                ? Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.5,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: d.gradient.first.withValues(alpha: _hovered ? 0.4 : 0.2),
                blurRadius: _hovered ? 28 : 14,
                offset: Offset(0, _hovered ? 12 : 6),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 28.w : 20.w),
            child: isDesktop && d.isWide
                ? Row(
                    children: [
                      Expanded(
                        child: CardText(data: d, isDesktop: isDesktop),
                      ),
                      SizedBox(
                        width: 160.w,
                        height: 120.h,
                        child: Lottie.asset(d.lottie, fit: BoxFit.contain),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: isDesktop ? 90.h : 70.h,
                        child: Center(
                          child: Lottie.asset(d.lottie, fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CardText(data: d, isDesktop: isDesktop),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CardText extends StatelessWidget {
  final ActionCardData data;
  final bool isDesktop;
  const CardText({required this.data, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.title,
          style: TextStyle(
            color: data.textColor,
            fontSize: isDesktop ? 20.sp : 15.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          data.subtitle,
          style: TextStyle(
            color: data.subtitleColor,
            fontSize: isDesktop ? 13.sp : 11.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Click here',
              style: TextStyle(
                color: data.textColor,
                fontSize: isDesktop ? 13.sp : 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.arrow_forward_rounded,
                color: data.textColor,
                size: isDesktop ? 16.sp : 14.sp),
          ],
        ),
      ],
    );
  }
}
