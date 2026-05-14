import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_prescription/utils/api.dart';
import 'package:e_prescription/services/quick_tech_retry_service.dart';

class QuickTechImageSliderController extends GetxController {
  var currentIndex = 0.obs;

  final RxList<String> imgList = <String>[].obs;

  Timer? _timer;

  QuickTechImageSliderController() {
    _init();
  }

  Future<void> _init() async {
    await fetchSliderImages();
    _startAutoSlide();
  }

  Future<void> fetchSliderImages() async {
    try {
      final response = await retryRequest(() => http.get(Uri.parse(Api.sliderApi)), maxAttempts: 3, initialDelay: Duration(seconds: 1));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> services = data['service'] ?? [];
        final List<String> urls = services.map<String>((s) {
          final photo = s['slider_photo'] ?? '';
          if (photo == null) return '';
          final photoStr = photo.toString();
          // Ensure full URL
          if (photoStr.startsWith('http')) return photoStr;
          return Api.baseUrl + (photoStr.startsWith('/') ? photoStr : '/'+photoStr);
        }).where((u) => u.isNotEmpty).toList();

        if (urls.isNotEmpty) {
          imgList.assignAll(urls);
          // Reset index if out of bounds
          if (currentIndex.value >= imgList.length) currentIndex.value = 0;
          return;
        }
      }
    } catch (e) {
      print('Error fetching slider images: $e');
    }

   
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (imgList.isEmpty) return;
      if (currentIndex.value >= imgList.length - 1) {
        currentIndex.value = 0;
      } else {
        currentIndex.value++;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
