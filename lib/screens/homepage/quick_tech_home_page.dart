// quick_tech_home_page.dart
import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/controllers/profile_controller/quick_tech_profile_controller.dart';
import 'package:e_prescription/screens/homepage/widgets/quick_tech_blog_banner.dart';


class QuickTechHomePage extends StatefulWidget {
  const QuickTechHomePage({super.key});

  @override
  State<QuickTechHomePage> createState() => _QuickTechHomePageState();
}

class _QuickTechHomePageState extends State<QuickTechHomePage> {
  final themeController = locator.get<QuickTechThemeController>();
  final ScrollController _scrollController = ScrollController();
final profileController=locator.get<QuickTechProfileController>();
void initState() {
    profileController.fetchProfile();
  super.initState();}
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Obx(
      () => Container(
        color: themeController.isDay.value
            ? const Color(0xFFF5F7FA)
            : const Color(0xFF0F172A),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // ── Hero / Slider Section ──
              QuickTechImageSlider(themeController: themeController),

             

              // ── Action Cards Grid ──
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 80.w : 20.w,
                  vertical: 48.h,
                ),
                child: QuickTechCustomMainButtons(themeController: themeController),
              ),

              // ── Blog Banner ──
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 80.w : 20.w,
                ),
                child: QuickTechBlogBanner(themeController: themeController),
              ),

              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}