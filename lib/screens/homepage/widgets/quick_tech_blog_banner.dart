
import 'package:e_prescription/const/const.dart';


class QuickTechBlogBanner extends StatefulWidget {
  final QuickTechThemeController themeController;
  const QuickTechBlogBanner({super.key, required this.themeController});

  @override
  State<QuickTechBlogBanner> createState() => _QuickTechBlogBannerState();
}

class _QuickTechBlogBannerState extends State<QuickTechBlogBanner> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDark = !widget.themeController.isDay.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Container(
              width: 4.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: widget.themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Latest Blogs',
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                fontSize: isDesktop ? 22.sp : 18.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        // Blog CTA Card
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: () => Get.toNamed('/blogs'),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              transform:
                  Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
              padding: EdgeInsets.all(isDesktop ? 36.w : 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: isDark
                    ? const Color(0xFF1E293B)
                    : Colors.white,
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _hovered ? 0.1 : 0.05),
                    blurRadius: _hovered ? 24 : 10,
                    offset: Offset(0, _hovered ? 8 : 4),
                  ),
                ],
              ),
              child: isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          child: _buildBlogText(isDark, isDesktop),
                        ),
                        _buildReadBtn(isDesktop),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBlogText(isDark, isDesktop),
                        SizedBox(height: 20.h),
                        _buildReadBtn(isDesktop),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlogText(bool isDark, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A56DB).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            'HEALTH ARTICLES',
            style: TextStyle(
              color: widget.themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
              fontSize: isDesktop ? 10.sp : 9.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          'Stay updated with\nthe latest medical insights',
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            fontSize: isDesktop ? 24.sp : 18.sp,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Explore expert-written articles on healthcare,\nprescription guidelines, and patient wellness.',
          style: TextStyle(
            color: isDark
                ? Colors.white.withValues(alpha: 0.55)
                : const Color(0xFF64748B),
            fontSize: isDesktop ? 13.sp : 11.sp,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildReadBtn(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 28.w : 20.w,
        vertical: isDesktop ? 14.h : 12.h,
      ),
      decoration: BoxDecoration(
        color: widget.themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Read Blogs',
            style: TextStyle(
              color: Colors.white,
              fontSize: isDesktop ? 14.sp : 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_rounded,
              color: Colors.white, size: isDesktop ? 16.sp : 14.sp),
        ],
      ),
    );
  }
}