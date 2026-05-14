import 'dart:io';
import 'package:e_prescription/const/const.dart';
import 'package:e_prescription/controllers/package_controller/quick_tech_package_controller.dart';
import 'package:image_picker/image_picker.dart';

class QuickTechPackages extends StatefulWidget {
  const QuickTechPackages({super.key});

  @override
  State<QuickTechPackages> createState() => _QuickTechPackagesState();
}

class _QuickTechPackagesState extends State<QuickTechPackages> {
  final controller = locator.get<QuickTechPackageController>();
  late final themeController = locator.get<QuickTechThemeController>();
  Worker? _paymentProofWorker;
@override
void initState() {
  super.initState();
  
  _paymentProofWorker = ever(controller.paymentProofTargetPackageId, (int? id) {
    if (id != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showPaymentProofDialog(id, !themeController.isDay.value);
          controller.paymentProofTargetPackageId.value = null;
        }
      });
    }
  });

  // Sequential load — userPackage আগে, তারপর allPackages
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await controller.fetchUserPackage();
    await controller.fetchAllPackages();
  });
}

  @override
  void dispose() {
    _paymentProofWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = !themeController.isDay.value;
      return Scaffold(
        backgroundColor:
            isDarkMode
                ? QuickTechAppColors.darkScaffoldColor
                : QuickTechAppColors.lightScaffoldColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              isDarkMode
                  ? QuickTechAppColors.darkmaincolor
                  : QuickTechAppColors.lightmaincolor,
          title: Text(
            'Subscription Plans',
            style: myStyle( Responsive.isDesktop(context)?5.sp: 20.sp, QuickTechAppColors.white, FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Obx(() {
                  final currentPackage =
                      controller.getCurrentSubscribedPackage();
                  if (currentPackage != null) {
                    return _buildCurrentSubscriptionCard(
                      currentPackage,
                      isDarkMode,
                    );
                  }
                  return const SizedBox.shrink();
                }),
                // Available Packages
                Obx(() {
                  if (controller.isLoading.value || controller.isLoadingUserPackage.value) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48.h),
                        child: CircularProgressIndicator(
                          color:
                              isDarkMode
                                  ? QuickTechAppColors.darkmaincolor
                                  : QuickTechAppColors.lightmaincolor,
                        ),
                      ),
                    );
                  }

                  if (controller.allPackages.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box,
                              size: Responsive.isDesktop(context)?40.sp: 64.sp,
                              color:
                                  isDarkMode
                                      ? QuickTechAppColors
                                          .darksecondarytextcolor
                                      : Colors.grey[400],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No packages available',
                              style: myStyle(
                                Responsive.isDesktop(context)?8.sp: 16.sp,
                                isDarkMode
                                    ? QuickTechAppColors.darksecondarytextcolor
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal:  16.w),
                    itemCount: controller.allPackages.length,
                    itemBuilder: (context, index) {
                      final package = controller.allPackages[index];
                      return _buildPackageCard(package, isDarkMode);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCurrentSubscriptionCard(
    dynamic currentPackage,
    bool isDarkMode,
  ) {
    final mainColor =
        isDarkMode
            ? QuickTechAppColors.darkmaincolor
            : QuickTechAppColors.lightmaincolor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal:  16.w,vertical: 5.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mainColor, mainColor.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: mainColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: QuickTechAppColors.white,
                size: Responsive.isDesktop(context)?6.sp: 20.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Current Plan',
                style: myStyle(
                  Responsive.isDesktop(context)?5.sp: 14.sp,
                  QuickTechAppColors.white.withValues(alpha: 0.7),
                  FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            currentPackage.type ?? 'Premium',
            style: myStyle(Responsive.isDesktop(context)?6.sp: 24.sp, QuickTechAppColors.white, FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            currentPackage.title ?? 'Subscription Plan',
            style: myStyle(Responsive.isDesktop(context)?4.sp: 12.sp, QuickTechAppColors.white.withValues(alpha: 0.7)),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Remaining Prescriptions',
                  controller.getRemainingPrescriptions().toString(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatItem(
                  'Time Remaining',
                  controller.getTimeRemaining(),
                ),
              ),
            ],
          ),
          controller.userPackage.value?.packageOrder.paymentMessage!=null?
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Obx(
                () => Text(
                  controller.userPackage.value?.packageOrder.paymentMessage ??
                      '',
                  style: myStyle(
                    Responsive.isDesktop(context)?8.sp: 14.sp,
                    QuickTechAppColors.lightmaincolor,
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ):SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: myStyle(Responsive.isDesktop(context)?4.sp: 10.sp, QuickTechAppColors.white.withValues(alpha: 0.7)),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: myStyle(Responsive.isDesktop(context)?4.sp:10.sp, QuickTechAppColors.white, FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPackageCard(dynamic package, bool isDarkMode) {
    final isSubscribed = controller.isPackageSubscribed(package.id);
    final isPending =
        controller.hasPendingPayment.value &&
        controller.pendingPaymentPackageId.value == package.id;
    final mainColor =
        isDarkMode
            ? QuickTechAppColors.darkmaincolor
            : QuickTechAppColors.lightmaincolor;
    final cardBgColor =
        isDarkMode
            ? QuickTechAppColors.darktxtfieldcolor
            : QuickTechAppColors.txtfieldcolor;

    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      elevation: isSubscribed ? 8 : 4,
      color: cardBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side:
            isSubscribed
                ? BorderSide(color: mainColor, width: 2.w)
                : isPending
                ? BorderSide(color: Colors.orange, width: 2.w)
                : BorderSide.none,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient:
              isSubscribed
                  ? LinearGradient(
                    colors: [
                      mainColor.withValues(alpha: 0.1),
                      mainColor.withValues(alpha: 0.05),
                    ],
                  )
                  : isPending
                  ? LinearGradient(
                    colors: [
                      Colors.orange.withValues(alpha: 0.07),
                      Colors.orange.withValues(alpha: 0.03),
                    ],
                  )
                  : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:  16.w,vertical: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: myStyle(Responsive.isDesktop(context)?4.sp: 18.sp, mainColor, FontWeight.bold),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          package.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: myStyle(
                            Responsive.isDesktop(context)?5.sp: 12.sp,
                            isDarkMode
                                ? QuickTechAppColors.darksecondarytextcolor
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isSubscribed)
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: QuickTechAppColors.white,
                            size: Responsive.isDesktop(context)?4.sp: 14.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Active',
                            style: myStyle(
                              Responsive.isDesktop(context)?3.sp: 10.sp,
                              QuickTechAppColors.white,
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (isPending)
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Pending',
                            style: myStyle(
                              10.sp,
                              Colors.white,
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              // Package details
              _buildDetailRow(
                'Prescriptions',
                '${package.maximumPrescription} per plan',
                Icons.description,
                isDarkMode,
                mainColor,
              ),
              SizedBox(height: 8.h),
              _buildDetailRow(
                'Duration',
                '${package.dayDuration} days',
                Icons.calendar_today,
                isDarkMode,
                mainColor,
              ),
              SizedBox(height: 8.h),
              _buildDetailRow(
                'Price',
                package.price == '0.00' ? 'Free' : '\$${package.price}',
                Icons.attach_money,
                isDarkMode,
                mainColor,
              ),
              SizedBox(height: 16.h),
              // Subscribe / Pending / Subscribed button area
              if (isSubscribed)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: mainColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: mainColor),
                  ),
                  child: Center(
                    child: Text(
                      'Currently Subscribed',
                      style: myStyle(Responsive.isDesktop(context)?4.sp: 14.sp, mainColor, FontWeight.bold),
                    ),
                  ),
                )
              else if (isPending)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.orange,
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Payment Pending Approval',
                            style: myStyle(
                              13.sp,
                              Colors.orange,
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Admin will review and activate your plan',
                        style: myStyle(
                          10.sp,
                          isDarkMode
                              ? QuickTechAppColors.darksecondarytextcolor
                              : Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        controller.isSubscribing.value
                            ? null
                            : () {
                                // Check if there's a pending payment message
                                if (controller.userPackage.value?.packageOrder.paymentMessage != null ) {
                                  Get.snackbar(
                                    'Payment Status',
                                    controller.userPackage.value!.packageOrder.paymentMessage!,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.orange,
                                    colorText: Colors.white,
                                    duration: const Duration(seconds: 3),
                                  );
                                } else {
                                  // No payment message, proceed to payment proof dialog
                                  _showPaymentProofDialog(package.id, isDarkMode);
                                }
                              },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      disabledBackgroundColor: Colors.grey[400],
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child:
                        controller.isSubscribing.value
                            ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  QuickTechAppColors.white,
                                ),
                              ),
                            )
                            : Text(
                              'Subscribe Now',
                              style: myStyle(
                                Responsive.isDesktop(context)?4.sp: 14.sp,
                                QuickTechAppColors.white,
                                FontWeight.bold,
                              ),
                            ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    bool isDarkMode,
    Color mainColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: mainColor, size:Responsive.isDesktop(context)?8.sp: 16.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: myStyle(
                Responsive.isDesktop(context)?4.sp:  11.sp,
                isDarkMode
                    ? QuickTechAppColors.darksecondarytextcolor
                    : Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: myStyle(
                Responsive.isDesktop(context)?4.sp: 13.sp,
                isDarkMode
                    ? QuickTechAppColors.darkmaintextcolor
                    : Colors.grey[800],
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Payment Proof Dialog ────────────────────────────────────────────────
  void _showPaymentProofDialog(int packageId, bool isDarkMode) {
    final bkashCtrl = TextEditingController();
    final txnCtrl = TextEditingController();
    XFile? pickedImage;
    final formKey = GlobalKey<FormState>();
    final mainColor =
        isDarkMode
            ? QuickTechAppColors.darkmaincolor
            : QuickTechAppColors.lightmaincolor;
    final bgColor =
        isDarkMode
            ? QuickTechAppColors.darkScaffoldColor
            : QuickTechAppColors.lightScaffoldColor;
    final textColor =
        isDarkMode
            ? QuickTechAppColors.darkmaintextcolor
            : QuickTechAppColors.lightmaintextcolor;
    final fieldColor =
        isDarkMode
            ? QuickTechAppColors.darktxtfieldcolor
            : QuickTechAppColors.txtfieldcolor;

    Get.dialog(
      barrierDismissible: false,
      StatefulBuilder(
        builder:
            (context, setDialogState) => Dialog(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Gradient header ────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [mainColor, mainColor.withValues(alpha: 0.75)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.payment,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Complete Your Subscription',
                            style: myStyle(
                              16.sp,
                              Colors.white,
                              FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Submit your bKash payment details',
                            style: myStyle(
                              11.sp,
                              Colors.white.withValues(alpha: 0.85),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // ── Form body ──────────────────────────────────────────
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20.w),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Error message (if any)
                              Obx(
                                () =>
                                    controller.paymentProofError.value.isEmpty
                                        ? SizedBox.shrink()
                                        : Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10.w),
                                          margin: EdgeInsets.only(bottom: 12.h),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                              255,
                                              244,
                                              67,
                                              54,
                                            ).withValues(alpha: 0.1),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                255,
                                                244,
                                                67,
                                                54,
                                              ),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.error_outline,
                                                color: const Color.fromARGB(
                                                  255,
                                                  244,
                                                  67,
                                                  54,
                                                ),
                                                size: 16.sp,
                                              ),
                                              SizedBox(width: 8.w),
                                              Expanded(
                                                child: Text(
                                                  controller
                                                      .paymentProofError
                                                      .value,
                                                  style: myStyle(
                                                    11.sp,
                                                    const Color.fromARGB(
                                                      255,
                                                      244,
                                                      67,
                                                      54,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                              ),
                              // bKash number
                              Text(
                                'bKash Number *',
                                style: myStyle(
                                  12.sp,
                                  textColor,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              TextFormField(
                                controller: bkashCtrl,
                                keyboardType: TextInputType.phone,
                                style: myStyle(13.sp, textColor),
                                decoration: InputDecoration(
                                  hintText: '01XXXXXXXXX',
                                  hintStyle: myStyle(
                                    12.sp,
                                    isDarkMode ? Colors.grey : Colors.grey[400],
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    color: const Color(0xFFE2136E),
                                    size: 20.sp,
                                  ),
                                  filled: true,
                                  fillColor: fieldColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 12.w,
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty)
                                    return 'bKash number is required';
                                  if (v.trim().length < 11)
                                    return 'Enter a valid number';
                                  return null;
                                },
                              ),
                              SizedBox(height: 14.h),
                              // Transaction ID
                              Text(
                                'Transaction ID *',
                                style: myStyle(
                                  12.sp,
                                  textColor,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              TextFormField(
                                controller: txnCtrl,
                                style: myStyle(13.sp, textColor),
                                decoration: InputDecoration(
                                  hintText: 'e.g. 8N7HRJ2ETK',
                                  hintStyle: myStyle(
                                    12.sp,
                                    isDarkMode ? Colors.grey : Colors.grey[400],
                                  ),
                                  prefixIcon: Icon(
                                    Icons.receipt_long,
                                    color: mainColor,
                                    size: 20.sp,
                                  ),
                                  filled: true,
                                  fillColor: fieldColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 12.w,
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty)
                                    return 'Transaction ID is required';
                                  return null;
                                },
                              ),
                              SizedBox(height: 14.h),
                              // Screenshot (optional)
                              Text(
                                'Screenshot (Optional)',
                                style: myStyle(
                                  12.sp,
                                  textColor,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              GestureDetector(
                                onTap: () async {
                                  final img = await ImagePicker().pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (img != null) {
                                    setDialogState(() => pickedImage = img);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: pickedImage != null ? null : 76.h,
                                  decoration: BoxDecoration(
                                    color: fieldColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: mainColor.withValues(alpha: 0.45),
                                      width: 1.5,
                                    ),
                                  ),
                                  child:
                                      pickedImage != null
                                          ? Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(9.r),
                                                child: Image.file(
                                                  File(pickedImage!.path),
                                                  width: double.infinity,
                                                  height: 120.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 6.h,
                                                right: 6.w,
                                                child: GestureDetector(
                                                  onTap:
                                                      () => setDialogState(
                                                        () =>
                                                            pickedImage = null,
                                                      ),
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                      4.w,
                                                    ),
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.black54,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                          : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                color: mainColor.withValues(alpha:
                                                  0.6,
                                                ),
                                                size: 26.sp,
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                'Tap to add screenshot',
                                                style: myStyle(
                                                  11.sp,
                                                  isDarkMode
                                                      ? QuickTechAppColors
                                                          .darksecondarytextcolor
                                                      : Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                ),
                              ),
                              SizedBox(height: 22.h),
                              // Action buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => Get.back(),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: mainColor),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: myStyle(
                                          13.sp,
                                          mainColor,
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    flex: 2,
                                    child: Obx(
                                      () => ElevatedButton(
                                        onPressed:
                                            controller.isSubmittingProof.value
                                                ? null
                                                : () async {
                                                  if (!formKey.currentState!
                                                      .validate()) {
                                                    return;
                                                  }
                                                  // Call subscribe with payment details
                                                  await controller
                                                      .subscribeToPackage(
                                                        packageId,
                                                        bkashNumber:
                                                            bkashCtrl.text,
                                                        transactionId:
                                                            txnCtrl.text,
                                                        screenshotPath:
                                                            pickedImage?.path,
                                                      );
                                                  // Check result and close only if successful
                                                  if (mounted) {
                                                    if (controller
                                                        .paymentProofError
                                                        .value
                                                        .isEmpty) {
                                                      // Success - show snackbar then close immediately
                                                      Get.back();
                                                      Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100),
                                                        () {
                                                          Get.snackbar(
                                                            'Success',
                                                            'Payment submitted! Awaiting admin verification.',
                                                            snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM,
                                                            backgroundColor:
                                                                Colors.green,
                                                            colorText:
                                                                Colors.white,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }
                                                },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor,
                                          disabledBackgroundColor:
                                              Colors.grey[400],
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                        ),
                                        child:
                                            controller.isSubmittingProof.value
                                                ? SizedBox(
                                                  height: 18.h,
                                                  width: 18.w,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                          Colors.white,
                                                        ),
                                                  ),
                                                )
                                                : Text(
                                                  'Submit',
                                                  style: myStyle(
                                                    13.sp,
                                                    Colors.white,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }


}
