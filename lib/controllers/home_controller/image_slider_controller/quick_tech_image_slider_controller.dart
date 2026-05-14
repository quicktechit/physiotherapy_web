import 'package:e_prescription/const/const.dart';
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
      final response = await retryRequest(
            () => http.get(Uri.parse(Api.sliderApi)),
        maxAttempts: 3,
        initialDelay: const Duration(seconds: 1),
      );

      // Full API response print
      debugPrint('========== SLIDER API RESPONSE ==========');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
      debugPrint('========================================');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parsed JSON print
        debugPrint('Parsed JSON: $data');

        final List<dynamic> services = data['service'] ?? [];

        debugPrint('Service Count: ${services.length}');
        debugPrint('Services: $services');

        final List<String> urls = services
            .map<String>((s) {
          final photo = s['slider_photo'];

          debugPrint('Slider Photo Raw: $photo');

          if (photo == null || photo.toString().isEmpty) {
            return '';
          }

          final photoStr = photo.toString();

          // Ensure full URL
          final fullUrl = photoStr.startsWith('http')
              ? photoStr
              : Api.baseUrl +
              (photoStr.startsWith('/') ? photoStr : '/$photoStr');

          debugPrint('Generated Full URL: $fullUrl');

          return fullUrl;
        })
            .where((u) => u.isNotEmpty)
            .toList();

        debugPrint('Final URL List: $urls');
        debugPrint('Total Valid URLs: ${urls.length}');

        if (urls.isNotEmpty) {
          imgList.assignAll(urls);

          // Reset index if out of bounds
          if (currentIndex.value >= imgList.length) {
            currentIndex.value = 0;
          }

          debugPrint('Images assigned successfully.');
          debugPrint('imgList: ${imgList.toList()}');
          return;
        }

        debugPrint('No valid image URLs found in the response.');
      } else {
        debugPrint('API Error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching slider images: $e');
      debugPrint('StackTrace: $stackTrace');
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
