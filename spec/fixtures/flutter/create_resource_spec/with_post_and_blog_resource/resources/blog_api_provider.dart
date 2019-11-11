import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frap_test_suite_app_0_3_0_ui/src/models/blogs.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/constants/app_constants.dart';

class BlogApiProvider {
  Future<Blogs> fetchAllBlogs() async {
    final response =
    await http.get("${RootUrl}/blogs");

    if (response.statusCode == 200) {
      return Blogs.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Blogs');
    }
  }
}