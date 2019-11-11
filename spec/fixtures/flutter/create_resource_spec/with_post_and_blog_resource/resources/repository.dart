import 'dart:async';
import 'package:frap_test_suite_app_0_3_0_ui/src/resources/blog_api_provider.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/models/blogs.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/resources/post_api_provider.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/models/posts.dart';

class Repository {
  final blogApiProvider = BlogApiProvider();
  Future<Blogs> fetchAllBlogs() => blogApiProvider.fetchAllBlogs();

  final postApiProvider = PostApiProvider();
  Future<Posts> fetchAllPosts() => postApiProvider.fetchAllPosts();

}