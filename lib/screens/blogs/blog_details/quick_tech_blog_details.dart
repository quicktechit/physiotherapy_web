import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/const/web_image.dart';
import 'package:e_prescription/utils/api.dart';
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
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/api/blog/details/${widget.id}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        blogData = data['blog'];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDay = themeController.isDay.value;
      return Scaffold(
        backgroundColor:
            isDay
                ? const Color(0xFFF4F6FA)
                : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              isDay
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Blog Details',
            style: myStyle(18, QuickTechAppColors.white, FontWeight.bold),
          ),
        ),
        body:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : blogData == null
                ? const Center(child: Text('Blog not found'))
                : Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Hero Image — full width, no constraint
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 380,
                              child: CachedNetworkImage(
                                imageUrl: "${Api.baseUrl}${blogData!['image']}",
                                fit: BoxFit.cover,
                                errorWidget:
                                    (context, url, error) => WebImage(
                                      imageUrl:
                                          "${Api.baseUrl}${blogData!['image']}",
                                      fit: BoxFit.cover,
                                    ),
                              ),
                              // Image.network(
                              //   '${Api.baseUrl}${blogData!['image']}',
                              //   fit: BoxFit.cover,
                              //   errorBuilder: (context, error, stackTrace) => Container(
                              //     height: 380,
                              //     color: Colors.grey[300],
                              //     child: const Center(child: Icon(Icons.broken_image, size: 48)),
                              //   ),
                              // ),
                            ),
                            // Gradient overlay at bottom of hero
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 160,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      (isDay
                                              ? const Color(0xFFF4F6FA)
                                              : QuickTechAppColors
                                                  .darkScaffoldColor)
                                          .withValues(alpha: 0.95),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Article Content Card
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 780),
                            child: Transform.translate(
                              offset: const Offset(0, -40),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                padding: const EdgeInsets.all(36),
                                decoration: BoxDecoration(
                                  color:
                                      isDay
                                          ? Colors.white
                                          : const Color(0xFF1E2230),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: isDay ? 0.08 : 0.3,
                                      ),
                                      blurRadius: 32,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    Text(
                                      blogData!['title'] ?? '',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            isDay
                                                ? QuickTechAppColors
                                                    .lightmaintextcolor
                                                : QuickTechAppColors
                                                    .darkmaintextcolor,
                                        height: 1.35,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Divider accent
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color:
                                                QuickTechAppColors
                                                    .lightmaincolor,
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 12,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: QuickTechAppColors
                                                .lightmaincolor
                                                .withValues(alpha: 0.4),
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    // Short description
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: QuickTechAppColors.lightmaincolor
                                            .withValues(alpha: 0.07),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: QuickTechAppColors
                                              .lightmaincolor
                                              .withValues(alpha: 0.2),
                                        ),
                                      ),
                                      child: Text(
                                        blogData!['short_description'] ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          color:
                                              isDay
                                                  ? QuickTechAppColors
                                                      .lightmaintextcolor
                                                      .withValues(alpha: 0.75)
                                                  : QuickTechAppColors
                                                      .darkmaintextcolor
                                                      .withValues(alpha: 0.75),
                                          height: 1.6,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 28),

                                    // Long description HTML
                                    Html(
                                      data: blogData!['long_description'] ?? '',
                                      style: {
                                        "body": Style(
                                          fontSize: FontSize(15.5),
                                          lineHeight: const LineHeight(1.75),
                                          color:
                                              isDay
                                                  ? QuickTechAppColors
                                                      .lightmaintextcolor
                                                  : QuickTechAppColors
                                                      .darkmaintextcolor,
                                        ),
                                        "h1": Style(
                                          fontSize: FontSize(24),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        "h2": Style(
                                          fontSize: FontSize(20),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        "h3": Style(
                                          fontSize: FontSize(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        "p": Style(
                                          margin: Margins.only(bottom: 16),
                                        ),
                                        "a": Style(
                                          color:
                                              QuickTechAppColors.lightmaincolor,
                                          textDecoration: TextDecoration.none,
                                        ),
                                        "blockquote": Style(
                                          padding: HtmlPaddings.only(left: 16),
                                          border: const Border(
                                            left: BorderSide(
                                              color: Color(0xFF4CAF50),
                                              width: 4,
                                            ),
                                          ),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Footer meta
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: Colors.grey[500],
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          blogData!['created_at'] ?? '',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
      );
    });
  }
}
