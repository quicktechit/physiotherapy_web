import 'package:e_prescription/const/quick_tech_styles.dart';
import 'package:flutter/material.dart';

class QuickTechCustomButton extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final Color color;
  final VoidCallback? onTab;

  const QuickTechCustomButton({
    super.key,
    this.width,
    required this.onTab,
    this.title,
    this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Opacity(
        opacity: onTab == null ? 0.5 : 1.0,
        child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: Offset(0, 2),spreadRadius: 2
            ),
          ],
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            title ?? "Let's Go",
            style: myStyle(16, Colors.white, FontWeight.w600),
          ),
        ),
      ),
    ),
  );
  }
}
