import 'package:flutter/material.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/screens/blog/blog_index_screen.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/screens/blog/blog_show_screen.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/screens/post/post_index_screen.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/screens/post/post_show_screen.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/animations/slide_right_route.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/constants/routing.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/screens/home_screen.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/screens/undefined_route_screen.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case BlogIndexScreenRoute:
      return SlideRightRoute(widget:BlogIndexScreen());
    case BlogShowScreenRoute:
      return SlideRightRoute(widget:BlogShowScreen());
    case PostIndexScreenRoute:
      return SlideRightRoute(widget:PostIndexScreen());
    case PostShowScreenRoute:
      return SlideRightRoute(widget:PostShowScreen());
    case HomeScreenRoute:
      return SlideRightRoute(widget:HomeScreen());
    default:
      return SlideRightRoute(widget:UndefinedRouteScreen());
  }
}