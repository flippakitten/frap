import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frap_test_suite_app_ui/src/models/posts.dart';
import 'package:frap_test_suite_app_ui/src/constants/app_constants.dart';

class PostApiProvider {
  Future<Posts> fetchAllPosts() async {
    final response =
    await http.get("${RootUrl}/posts");

    if (response.statusCode == 200) {
      return Posts.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Posts');
    }
  }
}