import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/controllers/blog_controller/quick_tech_blog_controller.dart';

import 'package:e_prescription/screens/blogs/widgets/quick_tech_blog_widgets.dart';

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
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isDay.value
            ? const Color(0xFFF4F6FA)
            : QuickTechAppColors.darkScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeController.isDay.value
              ? QuickTechAppColors.lightmaincolor
              : QuickTechAppColors.darkmaincolor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          ),
          title: Text('Blogs', style: myStyle(18, QuickTechAppColors.white, FontWeight.bold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: themeController.toggleTheme,
                icon: Obx(() => Icon(
                  themeController.isDay.value ? Icons.light_mode : Icons.dark_mode,
                  color: themeController.isDay.value ? Colors.yellow : Colors.white,
                )),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : blogController.blogs.isEmpty
                ? const Center(child: Text('No blogs found'))
                : Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Page Header
                            Padding(
                              padding: const EdgeInsets.only(left: 4, bottom: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Latest Articles',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: themeController.isDay.value
                                          ? QuickTechAppColors.lightmaintextcolor
                                          : QuickTechAppColors.darkmaintextcolor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 48,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: QuickTechAppColors.lightmaincolor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Featured post (first blog, large)
                            if (blogController.blogs.isNotEmpty)
                              customBlogCard(
                                id: blogController.blogs[0].id,
                                title: blogController.blogs[0].title,
                                content: blogController.blogs[0].shortDescription,
                                imagePath: blogController.blogs[0].image,
                                time: blogController.blogs[0].createdAt,
                                featured: true,
                              ),

                            if (blogController.blogs.length > 1) ...[
                              const SizedBox(height: 24),
                              // Responsive grid for the rest
                              LayoutBuilder(builder: (context, constraints) {
                                final crossAxisCount = constraints.maxWidth > 700 ? 3 : constraints.maxWidth > 480 ? 2 : 1;
                                final remaining = blogController.blogs.skip(1).toList();
                                final rows = <Widget>[];
                                for (int i = 0; i < remaining.length; i += crossAxisCount) {
                                  final rowBlogs = remaining.sublist(i, (i + crossAxisCount).clamp(0, remaining.length));
                                  rows.add(Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: rowBlogs.map((blog) => Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: rowBlogs.last != blog ? 16 : 0,
                                        ),
                                        child: customBlogCard(
                                          id: blog.id,
                                          title: blog.title,
                                          content: blog.shortDescription,
                                          imagePath: blog.image,
                                          time: blog.createdAt,
                                          featured: false,
                                        ),
                                      ),
                                    )).toList(),
                                  ));
                                  if (i + crossAxisCount < remaining.length) rows.add(const SizedBox(height: 16));
                                }
                                return Column(children: rows);
                              }),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}