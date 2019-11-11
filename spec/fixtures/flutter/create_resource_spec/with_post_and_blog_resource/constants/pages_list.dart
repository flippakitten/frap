import 'package:flutter/material.dart';
import 'package:frap_test_suite_app_0_3_0_ui/src/constants/routing.dart';

class Page {
const Page({this.title, this.icon, this.route});

final String title;
final IconData icon;
final String route;
}

const List<Page> pages = const <Page>[
  const Page(title: 'Blogs', icon: Icons.home, route: BlogIndexScreenRoute),
  const Page(title: 'Posts', icon: Icons.home, route: PostIndexScreenRoute),
  const Page(title: 'Home', icon: Icons.home, route: HomeScreenRoute),
];