import 'package:flutter/material.dart';
import 'package:test_app_create_spec_ui/src/screens/undefined_route_screen.dart';
import 'package:test_app_create_spec_ui/src/screens/home_screen.dart';
import 'package:test_app_create_spec_ui/src/config/router.dart' as router;
import 'package:test_app_create_spec_ui/src/constants/routing.dart';

class App extends StatelessWidget {
  static const String _title = 'test_app_create_spec_ui';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData.light(),
      home: HomeScreen(),
      initialRoute: HomeScreenRoute,
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedRouteScreen(
            name: settings.name,
          )
      ),
    );
  }
}
