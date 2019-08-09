import 'package:flutter/material.dart';
import 'package:test_app_create_spec_ui/src/constants/routing.dart';

class Page {
const Page({this.title, this.icon, this.route});

final String title;
final IconData icon;
final String route;
}

const List<Page> pages = const <Page>[
     const Page(title: 'Home', icon: Icons.home, route: HomeScreenRoute),

];