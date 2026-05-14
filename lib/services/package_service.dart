import 'package:e_prescription/models/package_model.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'package:e_prescription/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PackageService {
  final String baseUrl = '${Api.baseUrl}/api';

  // Get all available packages
  Future<AllPackagesResponse> getAllPackages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/package/all'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return AllPackagesResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load packages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching packages: $e');
      throw Exception('Error fetching packages: $e');
      
    }
  }

  // Subscribe to a package (optionally with payment proof)
  Future<SubscribePackageResponse> subscribePackage(
    int packageId, {
    String? bkashNumber,
    String? transactionId,
    String? screenshotPath,
  }) async {
    try {
      final token = await QuickTechAuthStorageService.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Use MultipartRequest for consistency with API format
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/subscribe/package'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['package_id'] = packageId.toString();

      // Add payment fields if provided
      if (bkashNumber != null && bkashNumber.isNotEmpty) {
        request.fields['bkash_number'] = bkashNumber;
      }
      if (transactionId != null && transactionId.isNotEmpty) {
        request.fields['transaction_id'] = transactionId;
      }

      // Add screenshot if provided
      if (screenshotPath != null && screenshotPath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('screenshot', screenshotPath),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      print('📥 Subscribe response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SubscribePackageResponse.fromJson(jsonDecode(response.body));
      } else {
        // Try to parse error message from response
        String errorMessage = 'Failed to subscribe to package';
        try {
          final errorBody = jsonDecode(response.body);
          if (errorBody is Map && errorBody.containsKey('message')) {
            errorMessage = errorBody['message'] ?? errorMessage;
          }
        } catch (parseError) {
          // If JSON parsing fails, use status code in message
          errorMessage = '${response.statusCode}: ${response.reasonPhrase ?? 'Unknown error'}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('❌ Error subscribing to package: $e');
      rethrow;
    }
  }

  // Get user's current package
  Future<UserPackageResponse> getUserPackage() async {
    try {
      final token = await QuickTechAuthStorageService.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/package'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return UserPackageResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user package: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user package: $e');
    }
  }


}
