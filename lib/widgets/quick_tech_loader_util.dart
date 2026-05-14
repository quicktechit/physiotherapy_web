
import 'package:e_prescription/const/quick_tech_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';



class LoaderUtils {
  Widget showLoading() {
    return SizedBox(
      height: 100.h,
      width: 200.w,
      child:  Center(
        child: SpinKitChasingDots(color: QuickTechAppColors.lightmaincolor),
      ),
    );
  }

  showGetLoading() {
    Get.isDialogOpen ?? false
        ? const Offstage()
        : Get.dialog(
         Center(
          child: SpinKitChasingDots(color: QuickTechAppColors.lightaccentColor),
        ),
        barrierDismissible: false);
  }

  hideGetLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
