import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/screens/blogs/blog_details/quick_tech_blog_details.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:e_prescription/widgets/quick_tech_custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customBlogCard extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final String time;

  const customBlogCard({
    required this.id,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => QuickTechBlogDetails(id: id));
      },
      child: Card(
        color:
            themeController.isDay.value
                ? QuickTechAppColors.lightScaffoldColor
                : QuickTechAppColors.darkScaffoldColor,
        margin: const EdgeInsets.all(10),
        elevation: 5,
        shadowColor:
            themeController.isDay.value
                ? QuickTechAppColors.lightmaintextcolor
                : QuickTechAppColors.darkmaintextcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                "${Api.baseUrl}$imagePath",
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: myStyle(
                  20,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor
                      : QuickTechAppColors.darkmaintextcolor,
                  FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                content,
                style: myStyle(
                  14,
                  themeController.isDay.value
                      ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.7)
                      : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                  FontWeight.normal,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: QuickTechAppColors.grey,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${time}     ",
                    style: myStyle(
                      12,
                      QuickTechAppColors.grey,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
