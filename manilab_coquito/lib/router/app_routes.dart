import 'package:flutter/cupertino.dart';
import '../screens/fabula/fabula_screen.dart';
import '../screens/home/home_screen.dart';
import 'menu_option.dart';

class AppRoutes {
  static const inicialRoute = 'home';
  static final menuOptions = <MenuOption>[
    MenuOption(
      route: 'home',
      name: 'Home',
      screen: const HomeScreen(),
    ),
    MenuOption(
      route: 'fabula',
      name: 'Fabula',
      screen: const FabulaScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  // Get page by default
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
      builder: (context) => const Center(
        child: Text('Application is in maintenance.'),
      ),
    );
  }
}
