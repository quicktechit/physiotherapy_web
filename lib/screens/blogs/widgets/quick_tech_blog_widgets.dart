import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_prescription/const/quick_tech_app_colors.dart';

import 'package:e_prescription/const/web_image.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/locator.dart';
import 'package:e_prescription/screens/blogs/blog_details/quick_tech_blog_details.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customBlogCard extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final String time;
  final bool featured;

  const customBlogCard({
    required this.id,
    required this.title,
    required this.content,
    required this.imagePath,
    required this.time,
    this.featured = false,
  });

  @override
  State<customBlogCard> createState() => _customBlogCardState();
}

class _customBlogCardState extends State<customBlogCard> {
  bool _isHovered = false;
  final themeController = locator.get<QuickTechThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDay = themeController.isDay.value;

      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => Get.to(() => QuickTechBlogDetails(id: widget.id)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: isDay ? Colors.white : const Color(0xFF1E2230),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? QuickTechAppColors.lightmaincolor.withValues(alpha: 0.18)
                      : Colors.black.withValues(alpha: isDay ? 0.08 : 0.3),
                  blurRadius: _isHovered ? 24 : 12,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: _isHovered
                    ? QuickTechAppColors.lightmaincolor.withValues(alpha: 0.4)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: widget.featured ? _buildFeatured(isDay) : _buildGrid(isDay),
          ),
        ),
      );
    });
  }

  // Large featured card — horizontal layout on wide screens
  Widget _buildFeatured(bool isDay) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 600;
      if (isWide) {
        return SizedBox(
          height: 300,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                  child: _buildImage(height: double.infinity),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: _buildTextContent(isDay, isFeatured: true),
                ),
              ),
            ],
          ),
        );
      }
      return _buildGrid(isDay);
    });
  }

  // Regular grid card — vertical layout
  Widget _buildGrid(bool isDay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: _buildImage(height: 180),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildTextContent(isDay, isFeatured: false),
        ),
      ],
    );
  }

  Widget _buildImage({required double height}) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: "${Api.baseUrl}${widget.imagePath}",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                WebImage(imageUrl: "${Api.baseUrl}${widget.imagePath}", fit: BoxFit.cover),
          ),
          // Subtle gradient overlay
          if (widget.featured)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                  ],
                ),
              ),
            ),
          // Featured badge
          if (widget.featured)
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: QuickTechAppColors.lightmaincolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'FEATURED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextContent(bool isDay, {required bool isFeatured}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isFeatured) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: QuickTechAppColors.lightmaincolor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'FEATURED',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: QuickTechAppColors.lightmaincolor,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          widget.title,
          style: TextStyle(
            fontSize: isFeatured ? 22 : 16,
            fontWeight: FontWeight.bold,
            color: isDay ? QuickTechAppColors.lightmaintextcolor : QuickTechAppColors.darkmaintextcolor,
            height: 1.3,
          ),
          maxLines: isFeatured ? 3 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        Text(
          widget.content,
          style: TextStyle(
            fontSize: 13,
            color: isDay
                ? QuickTechAppColors.lightmaintextcolor.withValues(alpha: 0.6)
                : QuickTechAppColors.darkmaintextcolor.withValues(alpha: 0.6),
            height: 1.5,
          ),
          maxLines: isFeatured ? 4 : 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Icon(Icons.access_time, size: 13, color: Colors.grey[500]),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                widget.time,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isFeatured)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: QuickTechAppColors.lightmaincolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Read More →',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ],
    );
  }
}