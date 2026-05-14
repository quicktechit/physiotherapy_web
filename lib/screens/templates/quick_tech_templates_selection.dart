
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:e_prescription/const/web_image.dart';
import 'package:e_prescription/controllers/template_controller/quick_tech_template_controller.dart';
import 'package:e_prescription/controllers/theme_controller/quick_tech_theme_controller.dart';
import 'package:e_prescription/screens/add_prescription/rx_info/custom_RX_part/quick_tech_electrotherapy.dart';
import 'package:e_prescription/screens/templates/widgets/quick_tech_image_view.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_prescription/locator.dart';

class QuickTechTemplatesSelection extends StatefulWidget {
  const QuickTechTemplatesSelection({super.key});

  @override
  State<QuickTechTemplatesSelection> createState() =>
      _QuickTechTemplatesSelectionState();
}

class _QuickTechTemplatesSelectionState
    extends State<QuickTechTemplatesSelection> {
  final QuickTechTemplateController techTemplateController =
      locator.get<QuickTechTemplateController>();
  final QuickTechThemeController themeController =
      locator.get<QuickTechThemeController>();

  var userToken = QuickTechAuthStorageService.getToken();

  @override
  void initState() {
    super.initState();
    techTemplateController.fetchUserPackageTemplates(userToken!);
    // Load saved template after templates are fetched
    Future.delayed(const Duration(milliseconds: 500), () {
      techTemplateController.loadSavedTemplate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isDesktop = screenW > 900;
    final crossCount = isDesktop ? 4 : 2;

    return Obx(
      () {
        final isDark = !themeController.isDay.value;
        final bg = isDark
            ? const Color(0xFF0F172A)
            : const Color(0xFFF1F5F9);

        return Scaffold(
          backgroundColor: bg,
          body: Column(
            children: [
              // ── Top Bar ──
              _TopBar(
                isDark: isDark,
                isDesktop: isDesktop,
                onBack: () => Get.offAllNamed('/mainhome'),
              ),

              // ── Body ──
              Expanded(
                child: Obx(() {
                  if (techTemplateController.templates.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: themeController.isDay.value
                  ? QuickTechAppColors.lightmaincolor
                  : QuickTechAppColors.darkmaincolor,
                        strokeWidth: 2.5,
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.fromLTRB(
                      isDesktop ? 40 : 16,
                      24,
                      isDesktop ? 40 : 16,
                      120,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: isDesktop ? 0.72 : 0.68,
                    ),
                    itemCount: techTemplateController.templates.length,
                    itemBuilder: (context, index) {
                      final template =
                          techTemplateController.templates[index];
                      final imgUrl = template.image != null &&
                              template.image!.isNotEmpty
                          ? '${Api.baseUrl}${template.image!.startsWith('/') ? '' : '/'}${template.image}'
                          : null;

                      return Obx(() {
                        final isSelected =
                            techTemplateController.selectedTemplate.value ==
                                index;
                        return _TemplateCard(
                          index: index,
                          imgUrl: imgUrl,
                          isSelected: isSelected,
                          isDark: isDark,
                          isDesktop: isDesktop,
                          onTap: () =>
                              techTemplateController.selectTemplate(index),
                          onPreview: () {
                            Get.off(
                              () => customImageView(
                                imgUrl ?? 'assets/images/prescription.png',
                              ),
                            );
                          },
                        );
                      });
                    },
                  );
                }),
              ),
            ],
          ),

          // ── FAB ──
          floatingActionButton: Obx(
            () {
              final hasSelection =
                  techTemplateController.selectedTemplate.value != -1;
              return _SaveButton(
                enabled: hasSelection,
                isDesktop: isDesktop,
                onTap: hasSelection
                    ? () async {
                        await techTemplateController.saveTemplate();
                        Get.offNamed('/mainhome');
                      }
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}

// ── Top Bar ──────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final bool isDark;
  final bool isDesktop;
  final VoidCallback onBack;

  const _TopBar({
    required this.isDark,
    required this.isDesktop,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _NavBtn(onTap: onBack, isDark: isDark),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Template',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                  fontSize: isDesktop ? 20 : 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Choose the layout for your prescriptions',
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.45)
                      : const Color(0xFF94A3B8),
                  fontSize: isDesktop ? 12 : 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavBtn extends StatefulWidget {
  final VoidCallback onTap;
  final bool isDark;
  const _NavBtn({required this.onTap, required this.isDark});

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovered
                ? (widget.isDark
                    ? QuickTechAppColors.darkmaincolor.withValues(alpha: 0.1)
                    : QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1))
                : (widget.isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : const Color(0xFFF1F5F9)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
            size: 20,
          ),
        ),
      ),
    );
  }
}

// ── Template Card ─────────────────────────────────────────
class _TemplateCard extends StatefulWidget {
  final int index;
  final String? imgUrl;
  final bool isSelected;
  final bool isDark;
  final bool isDesktop;
  final VoidCallback onTap;
  final VoidCallback onPreview;

  const _TemplateCard({
    required this.index,
    required this.imgUrl,
    required this.isSelected,
    required this.isDark,
    required this.isDesktop,
    required this.onTap,
    required this.onPreview,
  });

  @override
  State<_TemplateCard> createState() => _TemplateCardState();
}

class _TemplateCardState extends State<_TemplateCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDark
        ? const Color(0xFF1E293B)
        : Colors.white;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform:
              Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSelected
                  ? QuickTechAppColors.lightmaincolor
                  : (_hovered
                      ? QuickTechAppColors.lightmaincolor.withValues(alpha: 0.4)
                      : Colors.transparent),
              width: widget.isSelected ? 2.5 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isSelected
                    ? (widget.isDark
                        ? QuickTechAppColors.darkmaincolor.withValues(alpha: 0.2)
                        : QuickTechAppColors.lightmaincolor.withValues(alpha: 0.2))
                    : Colors.black.withValues(
                        alpha: _hovered ? 0.12 : 0.06),
                blurRadius: _hovered ? 20 : 10,
                offset: Offset(0, _hovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image area
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14)),
                      child: widget.imgUrl != null
                          ? (kIsWeb
                              ? WebImage(
                                  imageUrl: widget.imgUrl!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.imgUrl!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, progress) {
                                    if (progress == null) return child;
                                    return Container(
                                      color: widget.isDark
                                          ? const Color(0xFF334155)
                                          : const Color(0xFFF1F5F9),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: widget.isDark
                                              ? QuickTechAppColors.darkmaincolor
                                              : QuickTechAppColors.lightmaincolor,
                                          value: progress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? progress
                                                      .cumulativeBytesLoaded /
                                                  progress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (_, __, ___) =>
                                      _ImgPlaceholder(
                                          isDark: widget.isDark),
                                ))
                          : Image.asset(
                              'assets/images/prescription.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),

                    // Selected badge
                    if (widget.isSelected)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: widget.isDark
                                ? QuickTechAppColors.darkmaincolor
                                : QuickTechAppColors.lightmaincolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_rounded,
                                  color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'Selected',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Preview button
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _PreviewBtn(
                        onTap: widget.onPreview,
                      ),
                    ),
                  ],
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: widget.isDark
                            ? QuickTechAppColors.darkmaincolor.withValues(alpha: 0.1)
                            : QuickTechAppColors.lightmaincolor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.description_rounded,
                        color: widget.isDark
                            ? QuickTechAppColors.darkmaincolor
                            : QuickTechAppColors.lightmaincolor,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Template ${widget.index + 1}',
                      style: TextStyle(
                        color: widget.isDark
                            ? Colors.white
                            : const Color(0xFF0F172A),
                        fontSize: widget.isDesktop ? 14 : 13,
                        fontWeight: FontWeight.w700,
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

class _ImgPlaceholder extends StatelessWidget {
  final bool isDark;
  const _ImgPlaceholder({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported_rounded,
              color: isDark ? Colors.white24 : Colors.black26, size: 36),
          const SizedBox(height: 8),
          Text(
            'Preview unavailable',
            style: TextStyle(
              color: isDark ? Colors.white24 : Colors.black26,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewBtn extends StatefulWidget {
  final VoidCallback onTap;
  const _PreviewBtn({required this.onTap});

  @override
  State<_PreviewBtn> createState() => _PreviewBtnState();
}

class _PreviewBtnState extends State<_PreviewBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.black.withValues(alpha: 0.7)
                : Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.zoom_in_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}

// ── Save Button ────────────────────────────────────────────
class _SaveButton extends StatefulWidget {
  final bool enabled;
  final bool isDesktop;
  final VoidCallback? onTap;

  const _SaveButton({
    required this.enabled,
    required this.isDesktop,
    required this.onTap,
  });

  @override
  State<_SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<_SaveButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isDesktop ? 32 : 24,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: widget.enabled
                ? (_hovered
                    ? (themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaincolor)
                    : (themeController.isDay.value
                        ? QuickTechAppColors.lightmaincolor
                        : QuickTechAppColors.darkmaincolor))
                : const Color(0xFF94A3B8),
            borderRadius: BorderRadius.circular(14),
            boxShadow: widget.enabled
                ? [
                    BoxShadow(
                      color: themeController.isDay.value
                          ? QuickTechAppColors.lightmaincolor.withValues(alpha: _hovered ? 0.5 : 0.3)
                          : QuickTechAppColors.darkmaincolor.withValues(alpha: _hovered ? 0.5 : 0.3),
                      blurRadius: _hovered ? 20 : 10,
                      offset: Offset(0, _hovered ? 8 : 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'Use This Template',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.isDesktop ? 15 : 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}