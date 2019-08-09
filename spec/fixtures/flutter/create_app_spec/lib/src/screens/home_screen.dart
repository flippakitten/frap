import 'package:flutter/material.dart';
import 'package:test_app_create_spec_ui/src/widgets/base_app_bar.dart';
import 'package:test_app_create_spec_ui/src/widgets/popup_menu_widget.dart';

class HomeScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('test_app_create_spec'),
        appBar: AppBar(),
        widgets: <Widget>[
          PopupMenuWidget(),
        ],
      ),
      body: Center(
        child: Text('test_app_create_spec'),
      ),
    );
  }
}