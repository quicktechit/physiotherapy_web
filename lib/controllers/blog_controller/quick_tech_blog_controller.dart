import 'dart:convert';
import 'package:e_prescription/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:e_prescription/models/blogs.dart';

class QuickTechBlogController extends GetxController {
  RxList<Blog> blogs = <Blog>[].obs;

  Future<void> fetchBlogs() async {
    final response = await http.get(Uri.parse('${Api.baseUrl}/api/blogs/all'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      blogs.value = (data['blogs'] as List).map((e) => Blog.fromJson(e)).toList();
    }
  }

  Future<Blog?> fetchBlogDetails(int id) async {
    final response = await http.get(Uri.parse('${Api.baseUrl}/api/blog/details/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Blog.fromJson(data['blog']);
    }
    return null;
  }
}
