import 'package:flutter/material.dart';
import 'package:frap_test_suite_app_ui/src/widgets/base_app_bar.dart';
import 'package:frap_test_suite_app_ui/src/widgets/popup_menu_widget.dart';
import 'package:frap_test_suite_app_ui/src/screens/post/post_index_screen.dart';

class PostShowScreen extends StatefulWidget {
  PostShowScreen({Key key}) : super(key: key);

  @override
  _PostShowScreenState createState() => _PostShowScreenState();
}

class _PostShowScreenState extends State<PostShowScreen> {
  int _selectedIndex = 1;

  final List<Widget> _widgets = <Widget>[
    PostIndexScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('Post'),
        appBar: AppBar(),
        widgets: <Widget>[
          PopupMenuWidget(),
        ],
      ),
      body: Center(
        child: Text('Post'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Back'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Edit'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}