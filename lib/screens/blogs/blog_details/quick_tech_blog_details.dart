import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
class QuickTechBlogDetails extends StatefulWidget {
  final int id;
  const QuickTechBlogDetails({required this.id});

  @override
  State<QuickTechBlogDetails> createState() => _QuickTechBlogDetailsState();
}

class _QuickTechBlogDetailsState extends State<QuickTechBlogDetails> {
  final themeController = locator.get<QuickTechThemeController>();
  bool isLoading = true;
  Map<String, dynamic>? blogData;

  @override
  void initState() {
    super.initState();
    fetchBlogDetails();
  }

  Future<void> fetchBlogDetails() async {
    final response = await http.get(Uri.parse('${Api.baseUrl}/api/blog/details/${widget.id}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        blogData = data['blog'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: themeController.isDay.value
          ? QuickTechAppColors.lightScaffoldColor
          : QuickTechAppColors.darkScaffoldColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: QuickTechAppColors.white),
        ),
        title: Text('Blog Details', style: myStyle(18, QuickTechAppColors.white, FontWeight.bold)),
        backgroundColor: themeController.isDay.value
            ? QuickTechAppColors.lightmaincolor
            : QuickTechAppColors.darkmaincolor,
        elevation: 4,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : blogData == null
              ? Center(child: Text('Blog not found'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${Api.baseUrl}${blogData!['image']}',
                            fit: BoxFit.cover,
                            height: 250,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 250,
                              color: Colors.grey[300],
                              child: Center(child: Icon(Icons.broken_image)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          blogData!['title'] ?? '',
                          style: myStyle(
                            24,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor
                                : QuickTechAppColors.darkmaintextcolor,
                            FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          blogData!['short_description'] ?? '',
                          style: myStyle(
                            16,
                            themeController.isDay.value
                                ? QuickTechAppColors.lightmaintextcolor
                                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.7),
                            FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Display long_description as HTML
                        Container(
                          child: Html(
                            data: blogData!['long_description'] ?? '',
                            style: {
                              "body": Style(
                                fontSize: FontSize(16),
                                color: themeController.isDay.value
                                    ? QuickTechAppColors.lightmaintextcolor
                                    : QuickTechAppColors.darkmaintextcolor,
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    ));
  }
}
