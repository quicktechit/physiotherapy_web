import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/blog_controller/quick_tech_blog_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/models/blogs.dart';

import 'package:e_prescription/screens/blogs/widgets/quick_tech_blog_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QuickTechBlogs extends StatefulWidget {
  const QuickTechBlogs({super.key});

  @override
  State<QuickTechBlogs> createState() => _QuickTechBlogsState();
}

class _QuickTechBlogsState extends State<QuickTechBlogs> {
  final QuickTechThemeController themeController = locator.get<QuickTechThemeController>();
  final QuickTechBlogController blogController = locator.get<QuickTechBlogController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    blogController.fetchBlogs().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.lightScaffoldColor
            : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          backgroundColor: themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: QuickTechAppColors.white,
            ),
          ),
          title: Text(
            'Blogs',
            style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: themeController.toggleTheme,
              icon: Obx(
                () => Icon(
                  themeController.isDay.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: themeController.isDay.value ? Colors.yellow : Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : blogController.blogs.isEmpty
                ? Center(child: Text('No blogs found'))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: blogController.blogs.length,
                    itemBuilder: (context, index) {
                      Blog blog = blogController.blogs[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context)?50.w:8.w),
                        child: customBlogCard(id: blog.id,
                          title: blog.title,
                          content: blog.shortDescription,
                          imagePath: blog.image,

                          time: blog.createdAt,
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
