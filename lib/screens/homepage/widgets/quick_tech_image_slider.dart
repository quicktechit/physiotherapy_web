import 'package:e_prescription/controllers/home_controller/image_slider_controller/quick_tech_image_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../responsive.dart';
final QuickTechImageSliderController sliderController=QuickTechImageSliderController();
Widget customImageSlider() {
  return Obx(() {
    if (sliderController.imgList.isEmpty) {
      return Container(
        height: 170,
        alignment: Alignment.center,
        child: Text(
          'No images available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return CarouselSlider.builder(
      itemCount: sliderController.imgList.length,
      itemBuilder: (BuildContext context, int index, int realIdx) {
        final imgSrc = sliderController.imgList[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: Offset(0, 5),
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: imgSrc.startsWith('http')
                ? Image.network(
                    imgSrc,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height:Responsive.isDesktop(context)?200.h.sp: 170.h,
                        color: Colors.grey.shade200,
                        child: Center(
                            child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                              : null,
                        )),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                    ),
                  )
                : Image.asset(
                    imgSrc,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
        );
      },
      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: sliderController.currentIndex.value,
        onPageChanged: (index, reason) {
          sliderController.currentIndex.value = index;
        },
      ),
    );
  });
}
