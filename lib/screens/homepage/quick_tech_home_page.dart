import '../../const/const.dart';

class QuickTechHomePage extends StatefulWidget {
  const QuickTechHomePage({super.key});

  @override
  State<QuickTechHomePage> createState() => _QuickTechHomePageState();
}

class _QuickTechHomePageState extends State<QuickTechHomePage> {
  final themeController = locator
      .get<QuickTechThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context)?60.w:12.w),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              customImageSlider(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(
                          color:
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaincolor.withValues(alpha:
                                    0.3,
                                  )
                                  : QuickTechAppColors.darkmaincolor.withValues(alpha:
                                    0.3,
                                  ),
                          thickness: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Obx(() => customMainButtons(context)),
                    SizedBox(height: 20.h),

                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: customCard(
                          onTap: () {
                            Get.toNamed('/blogs');
                          },
                          title: 'Blogs',
                          lottieAsset: 'assets/animations/blog.json',
                          lottieHeight: 80.h,
                          cardColor:
                              themeController.isDay.value
                                  ? QuickTechAppColors.white
                                  : QuickTechAppColors.bkdarktxtfld,
                          borderRadius: 18,
                          elevation: 4,
                          titleColor:
                              themeController.isDay.value
                                  ? QuickTechAppColors.lightmaincolor
                                  : QuickTechAppColors.white,
                          subtitleColor:
                              themeController.isDay.value
                                  ? QuickTechAppColors.black.withValues(alpha: 0.7)
                                  : QuickTechAppColors.white.withValues(alpha: 0.7),
                          padding: EdgeInsets.all(Responsive.isDesktop(context)?2.w:16.w),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
