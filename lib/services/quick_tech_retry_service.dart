import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' show Response;

Future<T> retryRequest<T>(
  Future<T> Function() fn, {
  int maxAttempts = 3,
  Duration initialDelay = const Duration(seconds: 1),
}) async {
  int attempt = 0;
  Duration delay = initialDelay;

  while (true) {
    try {
      final result = await fn();

      int? statusCode;
      if (result is http.Response) {
        statusCode = result.statusCode;
      } else if (result is Response) {
        statusCode = result.statusCode;
      }

    if (statusCode == 429) {
  print("Rate limit hit. Not retrying immediately.");
  return result; // DO NOT retry 429
}

      return result;
    } catch (e) {
      attempt++;
      if (attempt >= maxAttempts) rethrow;
      await Future.delayed(delay);
      delay *= 2;
      continue;
    }
  }
}
